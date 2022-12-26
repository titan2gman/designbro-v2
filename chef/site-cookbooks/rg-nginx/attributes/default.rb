# To obtain the checksum, you can download the file and check it locally.
# $ shasum -a 256 nginx-1.11.13.tar.gz

include_attribute 'nginx::source'

default['nginx']['source']['version']  = '1.13.0'
default['nginx']['source']['checksum'] = '79f52ab6550f854e14439369808105b5780079769d7b8db3856be03c683605d7'
default['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{default['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['prefix']   = "/opt/nginx-#{default['nginx']['source']['version']}"

default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{default['nginx']['source']['prefix']}
  --conf-path=#{default['nginx']['dir']}/nginx.conf
  --sbin-path=#{default['nginx']['source']['sbin_path']}
)

default['nginx']['source']['modules'] = %w(
  nginx::http_gzip_static_module
  nginx::http_ssl_module
)

default['nginx']['configure_flags'] = %w(
  --with-debug
)

default['nginx']['default_site_enabled'] = false
