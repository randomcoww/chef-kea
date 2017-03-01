module KeaMethods

  def kea_load_configs_from_path(template_variables)
    ::Dir.chdir(release_path)
    ::Dir.entries(release_path).each do |f|
      next unless ::File.file?(f)

      if ::File.extname(f) == '.erb'
        f = kea_resolve_template(f, template_variables)
      end

      if ::File.extname(f) == '.conf'
        begin
          JSON.parse(::File.read(f)).each_pair do |service, config|
            if kea_service_maps.has_key?(service)
              kea_service_maps[service][:config] ||= { service => config }.to_json
            end
          end
        rescue
        end
      end
    end

    kea_service_maps.each_pair do |service, params|
      if params[:config].nil?
        kea_config(nil, params[:config_path], :delete)
        kea_service(params[:name], :stop)
      else
        kea_config(params[:config], params[:config_path], :create)
        kea_service(params[:name], :restart)
      end
    end
  end

  private

  def kea_service_maps
    @kea_service_maps ||= {
      "Dhcp4" => {
        name: "kea-dhcp4-server",
        config_path: "/etc/kea/kea-dhcp4.conf"
      },
      "Dhcp6" => {
        name: "kea-dhcp6-server",
        config_path: "/etc/kea/kea-dhcp6.conf"
      },
      "DhcpDdns" => {
        name: "kea-dhcp-ddns-server",
        config_path: "/etc/kea/kea-dhcp-ddns.conf"
      }
    }
  end

  def kea_config(config, path, action)
    Chef::Resource::File.new(path, run_context).tap do |r|
      r.content config
    end.run_action(action)
  end

  def kea_resolve_template(t, template_variables)
    f = ::File.basename(t, '.erb')
    Chef::Resource::Template.new(f, run_context).tap do |r|
      r.source t
      r.path f
      r.local true
      r.variables template_variables
    end.run_action(:create_if_missing)
    f
  end

  def kea_service(service_name, action)
    Chef::Resource::Service.new(service_name, run_context).tap do |r|
      r.provider Chef::Provider::Service::Systemd
    end.run_action(action)
  end
end
