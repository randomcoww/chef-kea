class ChefKea
  class Resource
    class Dhcp4Config < ChefKea::Resource::Config
      resource_name :kea_dhcp4_config

      property :path, String, desired_state: false,
                              default: lazy { KeaDhcp4::CONFIG_PATH }

    end
  end
end
