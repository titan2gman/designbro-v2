firewall 'default'

firewall_rule 'ssh' do
  port 22
end

firewall_rule 'web server http' do
  port 80
end

firewall_rule 'web server https' do
  port 443
end

firewall_rule 'redis' do
  port 6379
end

firewall_rule 'monit' do
  port 2812
end
