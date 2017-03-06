class ChefKea
  class Provider
    class Config < Chef::Provider
      provides :kea_config, os: "linux"

      def load_current_resource
        @current_resource = ChefKea::Resource::Config.new(new_resource.name)

        current_resource.exists(::File.exist?(new_resource.path))

        if current_resource.exists
          current_resource.content(::File.read(new_resource.path).chomp)
        else
          current_resource.content('')
        end

        current_resource
      end

      def action_create
        converge_by("Create Kea config: #{new_resource}") do
          kea_config.run_action(:create)
        end if !current_resource.exists || current_resource.content != new_resource.content
      end

      def action_delete
        converge_by("Delete Kea config: #{new_resource}") do
          kea_config.run_action(:delete)
        end if current_resource.exists
      end

      private

      def kea_config
        @kea_config ||= Chef::Resource::File.new(config_path, run_context).tap do |r|
          r.content new_resource.config
        end
      end
    end
  end
end