define devstackrepo($ensure = present) {
  $repo_there = "test -d /home/jenkins/devstack"
  case $ensure {
    present: {
      exec { "Clone devstack git repo":
        path        => "/usr/sbin:/usr/bin:/sbin:/bin",
        environment => "HOME=/home/jenkins",
        command     => "sudo -H -u jenkins -i git clone git://github.com/jeblair/devstack.git /home/jenkins/devstack",
        user        => "root",
        group       => "root",
        unless      => "$repo_there",
        logoutput   => on_failure,
      }
      exec { "Update devstack git repo":
        path        => "/usr/sbin:/usr/bin:/sbin:/bin",
        environment => "HOME=/home/jenkins",
        command     => "sudo -H -u jenkins -i bash -c 'cd /home/jenkins/devstack && git pull'",
        user        => "root",
        group       => "root",
        onlyif      => "$repo_there",
        logoutput   => on_failure,
      }
    }
    absent:  {
      exec { "Remove OpenStack git repo":
        path    => "/usr/sbin:/usr/bin:/sbin:/bin",
        environment => "HOME=/root",
        command => "rm -rf /home/jenkins/devstack",
        user    => "root",
        group   => "root",
        onlyif  => "$repo_there",
      }
    }
    default: {
      fail "Invalid 'ensure' value '$ensure' for devstackrepo"
    }
  }
}
