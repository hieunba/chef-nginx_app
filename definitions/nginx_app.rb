define :nginx_app, template: 'site.erb', enable: true do
  include_recipe 'nginx_app::service'

  application = params[:deploy]

  if application[:application_type] == 'nodejs'
    template_source = 'site_nodejs.erb'
  else
    template_source = params[:template]
  end

  nginx_conf_dir = node['nginx_app']['config_dir'] || '/etc/nginx'
  nginx_ssl_dir = "#{nginx_conf_dir}/ssl"

  template "#{nginx_conf_dir}/sites-available/#{params[:name]}" do
    Chef::Log.debug("Populating nginx site configuration for #{params[:name]}")
    source template_source
    mode 0o644
    owner 'root'
    group 'root'
    cookbook params[:cookbook] if params[:cookbook]
    variables(
      application: application,
      domains: params[:domains],
      application_rules: "#{application[:absolute_document_root]}/app.rules",
      application_tpl: "#{application[:absolute_document_root]}/tpl",
      application_webhooks: "#{application[:absolute_document_root]}/webhooks",
      environment: params[:environment] || 'production',
      params: params
    )
    notifies :reload, 'service[nginx_service]', :delayed
  end

  if application[:enable_ssl]

    template "#{nginx_ssl_dir}/#{params[:name]}.crt" do
      mode 0o600
      source 'ssl.key.erb'
      cookbook 'nginx_app'
      variables key: application[:ssl_configuration][:certificate]
      sensitive true
    end

    template "#{nginx_ssl_dir}/#{params[:name]}.key" do
      mode 0o600
      source 'ssl.key.erb'
      cookbook 'nginx_app'
      variables key: application[:ssl_configuration][:private_key]
      sensitive true
    end

    template "#{nginx_ssl_dir}/#{params[:name]}.ca" do
      mode 0o600
      source 'ssl.key.erb'
      cookbook 'nginx_app'
      variables key: application[:ssl_configuration][:chain]
      sensitive true
      not_if { application[:ssl_configuration][:chain].nil? }
    end
  end

  link "#{nginx_conf_dir}/sites-enabled/#{params[:name]}.conf" do
    to "#{nginx_conf_dir}/sites-available/#{params[:name]}"
    notifies :reload, 'service[nginx_service]', :delayed
    only_if 'nginx -t'
  end

end
