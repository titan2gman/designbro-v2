users = search(:users, 'groups:sudo').map(&:id)

node.override['authorization']['sudo']['passwordless'] = true
node.override['authorization']['sudo']['groups'] = %w(wheel sysadmin).concat(users)
node.override['authorization']['sudo']['users'] = users

include_recipe 'sudo'
