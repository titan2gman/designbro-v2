include_recipe 'monit'

monit_config 'redis' do
  source 'redis.conf.erb'
end
