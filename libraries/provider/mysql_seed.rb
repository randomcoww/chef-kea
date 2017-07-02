class ChefKea
  class Provider
    class Config < Chef::Provider
      include MysqlCluster

      provides :kea_mysql_seed, os: "linux"

      def load_current_resource
        @current_resource = ChefKea::Resource::MysqlSeed.new(new_resource.name)
        current_resource
      end

      def action_create
        converge_by("Seed MySQL for Kea: #{new_resource}") do
          new_resource.queries.each do |e|
            mysql_client.query(e, true)
          end
        end
      end

      private

      def mysql_client
        @mysql_client ||= MysqlHelper::Client.new(new_resource.timeout, new_resource.options)
      end
    end
  end
end
