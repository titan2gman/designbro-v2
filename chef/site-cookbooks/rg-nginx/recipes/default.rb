include_recipe 'nginx::source'

nginx_dir = node['nginx']['dir']

# SSL -----------------------------------------------------------------------------------------------------------------

directory "#{nginx_dir}/ssl" do
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file "#{nginx_dir}/ssl/ssl-bundle.chained.crt" do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

cookbook_file "#{nginx_dir}/ssl/ssl-private.key" do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

cookbook_file "#{nginx_dir}/ssl/dhparam.pem" do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

cookbook_file "#{nginx_dir}/ssl/ssl.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# HOST ----------------------------------------------------------------------------------------------------------------

template "#{nginx_dir}/sites-available/#{node.domain}" do
  source node.environment == 'production' ? 'production.erb' : 'staging.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    ip: node[:ipaddress],
    domain: node[:domain],
    project_dir: node['project']['root']
  )
  notifies :restart, 'service[nginx]', :delayed
end

nginx_site node.domain do
  enable true
end
