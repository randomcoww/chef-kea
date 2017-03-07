class ChefKea
  class Resource
    class DhcpDdnsConfig < ChefKea::Resource::Config
      resource_name :kea_dhcp_ddns_config

      property :path, String, desired_state: false,
                              default: lazy { KeaDhcpDdns::CONFIG_PATH }
                              
      end
    end
  end
end
