class Chef
  class Provider
    class Kea
      class Dhcp6Server < Chef::Provider::Kea
        provides :kea_dhcp6_server, os: "linux"

        def config_path
          '/etc/kea/kea-dhcp6.conf'
        end

        def service_name
          'kea-dhcp6-server'
        end
      end
    end
  end
end
