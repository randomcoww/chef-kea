class ChefKea
  class Resource
    class MysqlSeed < Chef::Resource
      require 'open-uri'

      resource_name :kea_mysql_seed

      default_action :create
      allowed_actions :create

      property :options, Hash
      property :url, String
      property :queries, String, default: lazy { open(url).read }
      property :client, Object, default: lazy {
          MysqlHelper::Wrapper.client(options)
        }
    end
  end
end
