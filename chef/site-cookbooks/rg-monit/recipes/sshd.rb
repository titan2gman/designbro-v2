include_recipe 'monit'

monit_config 'sshd' do
  source 'sshd.conf.erb'
end
