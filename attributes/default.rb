default['nginx']['default_site_enabled'] = false
default['nginx']['conf_template'] = 'nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'nginx_app'

if node['platform_family'] == 'debian'
  default['nginx_app']['user'] = 'www-data'
  default['nginx_app']['group'] = 'www-data'
end

default['nginx_app']['config_dir'] = '/etc/nginx'
default['nginx_app']['log_dir'] = '/var/log/nginx'
