logrotate_app 'rails_log' do
  path "#{node['project']['root']}/current/log/*.log"
  options ['missingok', 'compress', 'delaycompress', 'notifempty','copytruncate']
  frequency 'daily'
  rotate 30 # 30 means that you will have 30 files with logs of the last 30 days
  create "644 #{node['project']['user']} #{node['project']['group']}"
end
