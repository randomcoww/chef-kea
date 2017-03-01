class Chef
  class Provider
    class Kea
      class Dhcp4Server < Chef::Provider::Kea
        provides :kea_dhcp4_server, os: "linux"

        def config_path
          '/etc/kea/kea-dhcp4.conf'
        end

        def service_name
          'kea-dhcp4-server'
        end
      end
    end
  end
end
