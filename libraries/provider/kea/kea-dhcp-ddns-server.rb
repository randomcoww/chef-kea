class Chef
  class Provider
    class Kea
      class DhcpDdnsServer < Chef::Provider::Kea
        provides :kea_dhcp_ddns_server, os: "linux"

        def config_path
          '/etc/kea/kea-dhcp-ddns.conf'
        end

        def service_name
          'kea-dhcp-ddns-server'
        end
      end
    end
  end
end
