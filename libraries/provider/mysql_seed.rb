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
        converge_by("Seed MySQL for Kea: #{new_resource}") do
          run_provision
        end if !mysql_client.nil?
      end

      private

      def run_provision
        new_resource.queries.each do |e|
          begin
            mysql_client.query(e)
          rescue Mysql2::Error
            return
          end
        end
      end

      def mysql_client
        @mysql_client ||= MysqlHelper::Client.new(new_resource.options)
      end
    end
  end
end
