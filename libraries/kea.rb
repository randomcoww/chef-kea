module KeaDhcp4
  CONFIG_PATH ||= '/etc/kea/kea-dhcp4.conf'
end

module KeaDhcp6
  CONFIG_PATH ||= '/etc/kea/kea-dhcp6.conf'
end

module KeaDhcpDdns
  CONFIG_PATH ||= '/etc/kea/kea-dhcp-ddns.conf'
end
