include_recipe 'ruby_build'

ruby_build_ruby node['ruby']['version'] do
  prefix_path '/usr/local/'
  environment(
    'RUBY_CONFIGURE_OPTS' => '--with-openssl-dir=/etc/ssl/'
  )
  action :install # change to 'resinstall' if ruby version was updated on project and run rg-ruby cookbook.
end

gem_package 'bundler' do
  options '--no-ri --no-rdoc'
  action :upgrade
end
