# rubocop:disable Metrics/BlockLength

encrypted_data = Chef::EncryptedDataBagItem.load('configs', node.environment)

config   = node['project']
deployer = config['user']

root_path   = config['root']
shared_path = File.join(root_path, 'shared')
bundle_path = File.join(shared_path, 'vendor', 'bundle')
config_path = File.join(shared_path, 'config')
ssh_path    = File.join(shared_path, '.ssh')

puma_state_file  = File.join(shared_path, 'tmp', 'pids', 'puma.state')
maintenance_file = File.join(shared_path, 'tmp', 'maintenance')

# SSH -----------------------------------------------------------------------------------------------------------------

ssh_key_file     = File.join(ssh_path, deployer)
ssh_wrapper_file = File.join(ssh_path, 'wrap-ssh4git.sh')

directory ssh_path do
  owner deployer
  group deployer
  recursive true
end

cookbook_file ssh_key_file do
  source 'key'
  owner deployer
  group deployer
  mode 0o600
end

file ssh_wrapper_file do
  content "#!/bin/bash\n/usr/bin/env ssh -o \"StrictHostKeyChecking=no\" -i \"#{ssh_key_file}\" $1 $2"
  owner deployer
  group deployer
  mode 0o755
end

# DIRECTORIES ---------------------------------------------------------------------------------------------------------

%w(config log public/system public/uploads repo tmp/cache tmp/pids tmp/sockets node_modules).each do |dir|
  directory File.join(shared_path, dir) do
    owner deployer
    group deployer
    mode 0o755
    recursive true
  end
end

# CONFIG FILES --------------------------------------------------------------------------------------------------------

file File.join(config_path, '.env') do
  content encrypted_data['application'].reduce('') { |result, pair| result + "#{pair.first}=#{pair.last}\n" }

  sensitive true
  owner deployer
  group deployer
  mode 0o644
end

template File.join(config_path, 'database.yml') do
  source File.join(node.environment, 'database.yml.erb')
  variables(
    environment: node.environment,
    database:    encrypted_data['database']['name'],
    user:        encrypted_data['database']['user'],
    password:    encrypted_data['database']['password'],

    host:        encrypted_data['database']['host'],
    port:        encrypted_data['database']['port']
  )
  sensitive true
  owner deployer
  group deployer
  mode 0o644
end

template File.join(config_path, 'sidekiq.yml') do
  variables(
    environment: node.environment
  )
  sensitive true
  owner deployer
  group deployer
  mode 0o644
end

template File.join(shared_path, 'puma.rb') do
  source File.join(node.environment, 'puma.rb.erb')
  variables(
    environment:  node.environment,
    project_root: root_path
  )
  owner deployer
  group deployer
  mode 0o644
end

# DEPLOYMENT ----------------------------------------------------------------------------------------------------------

timestamped_deploy node['domain'] do
  ssh_wrapper ssh_wrapper_file
  repository config['repository']
  branch config['branch']
  repository_cache 'repo'
  deploy_to config['root']
  user deployer
  group deployer

  environment(
    'RAILS_ENV' => node.environment
  )

  create_dirs_before_symlink %w(tmp public)

  symlinks(
    'config/.env'            => '.env',

    'config/database.yml'    => 'config/database.yml',
    'config/newrelic.yml'    => 'config/newrelic.yml',
    'config/sidekiq.yml'     => 'config/sidekiq.yml',

    'log'  => 'log',

    'public/system'  => 'public/system',
    'public/uploads' => 'public/uploads',

    'tmp/pids'    => 'tmp/pids',
    'tmp/cache'   => 'tmp/cache',
    'tmp/sockets' => 'tmp/sockets',

    'node_modules' => 'node_modules'
  )

  symlink_before_migrate(
    'config/.env' => '.env',

    'config/database.yml' => 'config/database.yml'
  )

  before_migrate do
    file maintenance_file do
      owner deployer
      group deployer
      action :create
    end

    execute 'bundle install' do
      command "bundle install --without development test --deployment --path #{bundle_path}"
      cwd release_path
      user deployer
      group deployer
    end

    execute 'sudo monit stop sidekiq'
  end

  migration_command 'bundle exec rails db:migrate --trace'
  migrate true

  before_restart do
    execute "cd #{release_path} && yarn install"

    execute "build rails assets" do
      environment(
        'RAILS_ENV' => node.environment
      )

      command "bundle exec rails assets:precompile"
      cwd new_resource.current_path

      user deployer
      group deployer
    end

    execute "build frontend" do
      environment(
        'RAILS_ENV' => node.environment
      )

      command "bundle exec rails webpack:compile"
      cwd new_resource.current_path

      user deployer
      group deployer
    end
  end

  restart_command "bundle exec pumactl -S #{puma_state_file} restart" if File.exist? puma_state_file

  after_restart do
    file maintenance_file do
      action :delete
    end

    execute 'sudo monit start sidekiq'
  end

  action :deploy
end
