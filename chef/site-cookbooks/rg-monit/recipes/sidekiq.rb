include_recipe 'monit'

monit_config 'sidekiq' do
  source 'sidekiq.conf.erb'
  variables(
    project_root: node['project']['root']
  )
end
