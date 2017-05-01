## rewrite this to include mysql dependency and restart
systemd_unit "kea-dhcp4-server.service" do
  content ({
    'Unit' => {
      'Description' => 'ISC KEA IPv4 DHCP daemon',
      'After' => [
        'mysql.service',
        'network-online.target',
        'time-sync.target'
      ],
    },
    'Service' => {
      'Restart' => 'always',
      'RestartSec' => 5,
      "ExecStart" => '/usr/sbin/kea-dhcp4 -c /etc/kea/kea-dhcp4.conf'
    },
    'Install' => {
      'WantedBy' => 'multi-user.target'
    }
  })
  action [:create]
end

service 'kea-dhcp4-server' do
  action [:enable, :start]
end
