class orchestra {
    package { ipmitool: ensure => present }
    package { ubuntu-orchestra-server: ensure => present }
    exec { cobbler-sync:
      command => "/usr/bin/cobbler sync",
      logoutput => true,
      onlyif => "/bin/false",
      subscribe => [
        File["/etc/cobbler/dnsmasq.template"],
        File["/var/lib/cobbler/snippets/openstack_module_blacklist"],
        File["/var/lib/cobbler/snippets/openstack_cloud_init"],
        File["/var/lib/cobbler/snippets/openstack_network_sleep"],
        File["/var/lib/cobbler/kickstarts/openstack-test.preseed"],
	],
    }
    file { "/etc/cobbler/dnsmasq.template":
      owner => 'root',
      group => 'root',
      mode => 444,
      ensure => 'present',
      source =>  "puppet:///modules/orchestra/dnsmasq.template",
      replace => 'true',
      require => Package["ubuntu-orchestra-server"],
    }
    file { "/var/lib/cobbler/snippets/openstack_module_blacklist":
      owner => 'root',
      group => 'root',
      mode => 444,
      ensure => 'present',
      source =>  "puppet:///modules/orchestra/openstack_module_blacklist",
      replace => 'true',
      require => Package["ubuntu-orchestra-server"],
    }
    file { "/var/lib/cobbler/snippets/openstack_cloud_init":
      owner => 'root',
      group => 'root',
      mode => 444,
      ensure => 'present',
      source =>  "puppet:///modules/orchestra/openstack_cloud_init",
      replace => 'true',
      require => Package["ubuntu-orchestra-server"],
    }
    file { "/var/lib/cobbler/snippets/openstack_network_sleep":
      owner => 'root',
      group => 'root',
      mode => 444,
      ensure => 'present',
      source =>  "puppet:///modules/orchestra/openstack_network_sleep",
      replace => 'true',
      require => Package["ubuntu-orchestra-server"],
    }
    file { "/var/lib/cobbler/kickstarts/openstack-test.preseed":
      owner => 'root',
      group => 'root',
      mode => 444,
      ensure => 'present',
      source =>  "puppet:///modules/orchestra/openstack-test.preseed",
      replace => 'true',
      require => Package["ubuntu-orchestra-server"],
    }

}
