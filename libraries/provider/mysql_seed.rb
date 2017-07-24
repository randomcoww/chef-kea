class ChefKea
  class Provider
    class Config < Chef::Provider
      include MysqlHelper

      provides :kea_mysql_seed, os: "linux"

      def load_current_resource
        @current_resource = ChefKea::Resource::MysqlSeed.new(new_resource.name)
        current_resource
      end

      def action_create
        if !new_resource.client.nil?
          converge_by("Seed MySQL for Kea: #{new_resource}") do
            begin
              new_resource.client.query(new_resource.queries)
            rescue Mysql2::Error => e
              if e.message =~ / already exists$/
                Chef::Log.info(e.message)
              else
                raise e
              end
            end
          end
        end
      end
    end
  end
end
