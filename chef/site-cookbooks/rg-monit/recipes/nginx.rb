include_recipe 'monit'

monit_config 'nginx' do
  source 'nginx.conf.erb'
end
