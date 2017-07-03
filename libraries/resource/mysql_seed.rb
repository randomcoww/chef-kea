class ChefKea
  class Resource
    class MysqlSeed < Chef::Resource
      require 'open-uri'

      resource_name :kea_mysql_seed

      default_action :create
      allowed_actions :create

      property :timeout
      property :options, Hash
      property :url, String
      property :queries, Array, default: lazy { parse_source }

      private

      def parse_source
        lines = []
        open(url).each_line do |e|
          ## remove comments
          e.gsub!(/\s*#.*?$/, '')
          e.gsub!(/\s*--.*?$/, '')

          e.chomp!
          e.strip!
          next if e.empty?

          e.gsub!('INNODB', 'NDBCLUSTER')
          lines << e
        end

        return lines.join(' ').split(';')
      end
    end
  end
end
