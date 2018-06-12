name 'nginx_app'
maintainer 'Nghiem Ba Hieu'
maintainer_email 'hi3unb@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures nginx_app'
long_description 'Installs/Configures nginx_app'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports 'ubuntu', '>= 16.04'

depends 'nginx', '~> 8.1.2'
depends 'php_fpm', '>= 0.0.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/nginx_app/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/nginx_app'
