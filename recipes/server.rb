#
# Cookbook:: nginx_app
# Recipe:: server
#
# Copyright:: 2018, Nghiem Ba Hieu, All Rights Reserved.
include_recipe 'php_fpm::default'
include_recipe 'nginx::default'

directory '/etc/nginx/ssl' do
  mode 0o770
  owner 'root'
  group 'root'
  action :create
end

template '/etc/nginx/fastcgi_params' do
  source 'fastcgi_params.erb'
  mode 0o644
  owner 'root'
  group 'root'
end
