include_recipe 'monit'

monit_config 'postgresql' do
  source 'postgresql.conf.erb'
  variables(
    version: node['postgresql']['defaults']['server']['version']
  )
end
