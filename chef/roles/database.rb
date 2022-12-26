name 'database'

description 'Database server'

run_list 'recipe[rg-postgresql]',
         'recipe[rg-monit::postgresql]'
