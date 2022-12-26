name 'setup'

description 'Basic setup'

run_list 'recipe[rg-setup]',
         'recipe[rg-monit]',
         'recipe[rg-monit::sshd]'
