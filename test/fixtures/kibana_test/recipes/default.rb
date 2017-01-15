
include_recipe 'elasticsearch::default'

elasticsearch_user 'elasticsearch' do
  action :nothing
end

elasticsearch_install 'elasticsearch' do
  type "package"
  version "5.1.2"
  action :install
end

include_recipe 'kibana_lwrp::install'

elasticsearch_service 'elasticsearch' do
  action :start
end
