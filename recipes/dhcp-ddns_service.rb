systemd_resource_dropin "10-restart.conf" do
  service "kea-dhcp-ddns-server.service"
  config ({
    'Service' => {
      'Restart' => 'always',
      'RestartSec' => 5,
    }
  })
  action [:create]
  # notifies :restart, "service[kea-dhcp4-server]", :delayed
end

service 'kea-dhcp-ddns-server' do
  action [:enable, :start]
end
