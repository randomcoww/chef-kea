class ChefKea
  class Resource
    class Dhcp6Config < ChefKea::Resource::Config
      resource_name :kea_dhcp6_config

      def path
        KeaDhcp6::CONFIG_PATH
      end
    end
  end
end
