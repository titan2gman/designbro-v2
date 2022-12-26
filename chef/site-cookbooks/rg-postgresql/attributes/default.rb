default['postgresql']['client']['version'] = '9.6'
default['postgresql']['defaults']['server']['version'] = '9.6'

default['postgresql']['user']['name'] = 'deployer'
default['postgresql']['user']['encrypted_password'] = 'md5f62fee1b43f48bd0c1bf9b7d5b22f270' # the password is "deployer"

# How to generate password for PostgreSQL:
#
# $ md5 -qs '1q2w3e4r5t6y'
#
# Don't forget about 'md5' in the beginning of the line

default['postgresql']['database']['name'] = 'designbro'
