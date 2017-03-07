class ChefKea
  class Resource
    class Config < Chef::Resource
      resource_name :kea_config

      default_action :create
      allowed_actions :create, :delete

      property :exists, [TrueClass, FalseClass]
      property :config, Hash
      property :content, String, default: lazy { to_conf }
      property :path, String

      def provider
        ChefKea::Provider::Config
      end

      private

      def to_conf
        JSON.pretty_generate(config)
      end
    end
  end
end
