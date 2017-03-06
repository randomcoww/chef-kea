class ChefKea
  class Resource
    class DhcpDdnsConfig < ChefKea::Resource::Config
      resource_name :kea_dhcp_ddns_config

      def path
        KeaDhcpDdns::CONFIG_PATH
      end
    end
  end
end
