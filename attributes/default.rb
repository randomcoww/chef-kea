node.default['kea']['pkg_update_command'] = "apt-get update -qqy"
node.default['kea']['pkg_names'] = ['git', 'kea-dhcp4-server', 'kea-dhcp6-server', 'kea-dhcp-ddns-server']
node.default['kea']['instances']['test'] = {
  'config' => {
    "Dhcp4" => {
      "valid-lifetime" => 4000,
      "renew-timer" => 1000,
      "rebind-timer" => 2000,
      "interfaces-config" => {
        "interfaces" => [ "docker0" ]
      },
      "lease-database" => {
        "type" => "memfile",
        "persist" => true,
        "name" => "/var/kea/dhcp4.leases"
      },
      "subnet4" => [
        {
          "subnet" => "172.17.22.0/24",
          "pools" => [
            {
             "pool" => "172.17.22.22-172.17.22.32"
            }
          ]
        }
      ]
    },
    "DhcpDdns" => {
      "ip-address" => "127.0.0.1",
      "port" => 53001,
      "dns-server-timeout" => 100,
      "ncr-protocol" => "UDP",
      "ncr-format" => "JSON",
      "tsig-keys" => [],
      "forward-ddns" => {
        "ddns-domains" => []
      },
      "reverse-ddns" => {
        "ddns-domains" => []
      }
    }
  }
}
