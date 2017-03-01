execute "pkg_update" do
  command node['kea']['pkg_update_command']
  action :run
end

package node['kea']['pkg_names'] do
  action :upgrade
end

node['kea']['instances'].each do |name, v|
  kea name do
    deploy_path ::File.join(Chef::Config[:file_cache_path], 'kea', name)
    git_repo v['git_repo']
    git_branch v['git_branch']
    template_variables v['template_variables']
    action :deploy
  end
end
