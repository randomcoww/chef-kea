systemd_resource_dropin "10-mysql.conf" do
  service "kea-dhcp4-server.service"
  config ({
    'Unit' => {
      'After' => [
        'mysql.service'
      ]
    },
    'Service' => {
      'Restart' => 'always',
      'RestartSec' => 5,
    }
  })
  action [:create]
end

service 'kea-dhcp4-server' do
  action [:enable, :start]
end
