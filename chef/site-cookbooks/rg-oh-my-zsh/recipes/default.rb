include_recipe 'git'

search(:users, 'shell:*zsh AND NOT action:remove').map(&:id).each do |user|
  git "/home/#{user}/.oh-my-zsh" do
    repository 'https://github.com/robbyrussell/oh-my-zsh.git'
    reference 'master'
    user user
    group user
    action :checkout
  end

  template "/home/#{user}/.zshrc" do
    source 'zshrc.erb'
    owner user
    group user
    mode '0644'
  end
end
