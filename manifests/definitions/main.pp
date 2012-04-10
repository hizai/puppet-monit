define monit::main($ensure, $source = false) {

  case $operatingsystem {
    "Centos","RedHat","Amazon","Linux": {
      $filename = "/etc/monit.conf"
      if !$source {
        $source = "puppet:///modules/monit/monit.conf"
      }
    }
    "Debian","Ubuntu": {
      $filename = "/etc/monit/monitrc"
      if !$source {
        $source = "puppet:///modules/monit/monitrc"
      }
    }
  }

  case $ensure {
    present: {
      if $source {
        file { $filename:
          ensure => present,
          source => $source,
          owner  => root,
          group  => root,
          mode   => 600,
          notify => Service["monit"],
          require => Package["monit"],
        }
      }
    }
  }

}
