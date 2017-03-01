node.default['kea']['pkg_update_command'] = "apt-get update -qqy"
node.default['kea']['pkg_names'] = ['git', 'kea-dhcp4-server', 'kea-dhcp6-server', 'kea-dhcp-ddns-server']
node.default['kea']['instances']['test'] = {
  'git_repo' => 'https://github.com/randomcoww/kea-config.git',
  'git_branch' => 'test',
  'template_variables' => {
    'interface' => 'docker0',
    'subnet' => '172.17.22.0/24',
    'pool' => '172.17.22.22-172.17.22.32',
    'ddns_ip' => '127.0.0.1'
  }
}
