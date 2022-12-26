packages = %w(
  build-essential
  htop
  mc
  most
  zsh
)

packages.each do |package|
  package package do
    action :install
  end
end

apt_repository 'yarn' do
  uri 'https://dl.yarnpkg.com/debian/'
  distribution ''
  components %w(stable main)
  key 'https://dl.yarnpkg.com/debian/pubkey.gpg'
end

apt_package 'yarn' do
  action :install
end
