module KeaDhcp4
  require 'ipaddr'
  include MysqlHelper

  CONFIG_PATH ||= '/etc/kea/kea-dhcp4.conf'

  class Leases

    def self.mysql_leases(opts)
      result = {}

      client = MysqlHelper::Client.new(opts)
      client.query(%Q{SELECT hostname,address FROM lease4 WHERE client_id IS NOT NULL AND hostname!="" AND state=0 ORDER BY hostname}).each do |e|
        result[e['hostname'].split('.').first] = IPAddr.new(e['address'], Socket::AF_INET).to_s
      end

      return result
    end
  end
end

module KeaDhcp6
  CONFIG_PATH ||= '/etc/kea/kea-dhcp6.conf'
end

module KeaDhcpDdns
  CONFIG_PATH ||= '/etc/kea/kea-dhcp-ddns.conf'
end
