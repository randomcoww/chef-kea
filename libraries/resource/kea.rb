class Chef
  class Resource
    class Kea < Chef::Resource
      resource_name :kea

      default_action :deploy
      allowed_actions :deploy

      property :service_name, String
      property :config_path, String

      def config(arg = nil)
        set_or_return(
          :config,
          arg,
          :kind_of => [ Hash ])
      end

      def provider
        {
          'Dhcp4' => Chef::Provider::Kea::Dhcp4Server,
          'Dhcp6' => Chef::Provider::Kea::Dhcp6Server,
          'DhcpDdns' => Chef::Provider::Kea::DhcpDdnsServer
        }.each do |k, v|
          return v if config.has_key?(k)
        end
        Chef::Provider::Kea
      end
    end
  end
end
