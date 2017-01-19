# apparently some distros of Ubuntu don't have good SSL trust stores by default.
execute 'update-ca-certificates -f && update-ca-certificates -f' do
  only_if 'which update-ca-certificates'
end

include_recipe 'apt::default'
include_recipe 'java::default'


elasticsearch_user 'elasticsearch' do
  action :nothing
end

elasticsearch_install 'elasticsearch' do
  type "package"
  version "5.1.2"
  action :install
end

elasticsearch_configure 'elasticsearch' do
  logging(action: 'INFO')
  configuration(
    'network.host' => '0.0.0.0'
  )

  action :manage
  instance_name 'elasticsearch'
end

include_recipe 'kibana_lwrp::install'

elasticsearch_service 'elasticsearch' do
  action :start
end
