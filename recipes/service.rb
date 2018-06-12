#
# Cookbook:: nginx_app
# Recipe:: service
#
# Copyright:: 2018, Nghiem Ba Hieu, All Rights Reserved.
service_name = node['nginx']['service'] || 'nginx'
service 'nginx_service' do
  service_name service_name
  action :nothing
end
