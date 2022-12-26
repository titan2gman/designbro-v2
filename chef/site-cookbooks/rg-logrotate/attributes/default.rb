default['project']['user'] = 'deployer'
default['project']['group'] = 'www-data'
default['project']['root'] = File.join('/home', node['project']['user'], node['domain'])
