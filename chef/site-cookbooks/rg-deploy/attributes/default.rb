default['project']['user']       = 'deployer'
default['project']['repository'] = 'git@github.com:designbro/designbro.git'
default['project']['root']       = File.join('/home', default['project']['user'], node['domain'])
