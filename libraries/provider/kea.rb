class Chef
  class Provider
    class Kea < Chef::Provider
      provides :kea, os: "linux"

      def load_current_resource
        @current_resource = Chef::Resource::Kea.new(new_resource.name)
        current_resource
      end

      def action_deploy
        converge_by("Deploy kea: #{new_resource.name}") do
          kea_config.run_action(:create)
          if kea_config.updated_by_last_action?
            kea_service.run_action(:restart)
          end
        end
      end

      private

      def config_path
        new_resource.config_path
      end

      def service_name
        new_resource.service_name
      end

      def kea_config
        @kea_config ||= Chef::Resource::File.new(config_path, run_context).tap do |r|
          r.content new_resource.config.to_json
          r.notifies :restart, kea_service
        end
      end

      def kea_service
        @kea_service ||= Chef::Resource::Service.new(service_name, run_context).tap do |r|
          r.provider Chef::Provider::Service::Systemd
        end
      end
    end
  end
end
