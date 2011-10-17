class jenkins_slave {

    jenkinsuser { "jenkins":
      ensure => present,
    }

    slavecirepo { "openstack-ci":
      ensure => present,
      require => [ Package[git], Jenkinsuser[jenkins] ],
    }

    devstackrepo { "devstack":
      ensure => present,
      require => [ Package[git], Jenkinsuser[jenkins] ],
    }

    cron { "updateci":
      user => jenkins,
      minute => "*/15",
      command => "cd /home/jenkins/openstack-ci && /usr/bin/git pull -q origin master",
      require => [ Jenkinsuser[jenkins] ],
    }

    file { 'aptsources':
      name => '/etc/apt/sources.list',
      owner => 'root',
      group => 'root',
      mode => 644,
      ensure => 'present',
      source => [
         "puppet:///modules/jenkins_slave/sources.list",
       ],
    }

    file { 'profilerubygems':
      name => '/etc/profile.d/rubygems.sh',
      owner => 'root',
      group => 'root',
      mode => 644,
      ensure => 'present',
      source => [
         "puppet:///modules/jenkins_slave/rubygems.sh",
       ],
    }

    package { "openjdk-6-jre":
        ensure => latest
          }
    
    package { "cdbs":
        ensure => latest
          }

    package { "devscripts":
        ensure => latest
          }
    
    package { "python-sphinx":
        ensure => latest
          }
    
    package { "graphviz":
        ensure => latest
          }
    
    package { "pep8":
        ensure => latest
          }
    
    package { "pylint":
        ensure => latest
          }
    
    package { "python-dev":
         ensure => latest
           }

    package { "python-pip":
        ensure => latest,
        require => Package[python-dev]
          }

    package { "python-coverage":
        ensure => latest,
        require => [Apt::Ppa["ppa:nova-core/trunk"],
                    Package[python-nose]]
          }

    package { "python-nose":
        ensure => latest,
        require => Apt::Ppa["ppa:nova-core/trunk"],
          }

    package { "python-nosexcover":
        ensure => latest,
        require => [Apt::Ppa["ppa:nova-core/trunk"],
                    Package[python-coverage]]
          }

    package { "python-unittest2":
        ensure => latest,
        require => Apt::Ppa["ppa:nova-core/trunk"],
          }
}
