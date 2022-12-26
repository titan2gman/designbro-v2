include_recipe 'imagemagick::devel'

directory '/etc/ImageMagick' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/ImageMagick/policy.xml' do
  user 'root'
  group 'root'
  mode '0644'
end
