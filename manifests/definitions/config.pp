exec { 'monit-restart-all':
  command => "monit restart all",
  path => "/usr/local/bin:/bin:/usr/bin",
  refreshonly => true
}

define monit::config($ensure, $content = false, $source = false, $template = true) {

  case $operatingsystem {
    "Centos","RedHat","Linux": {
      $filename = "/etc/monit.d/puppet-${name}.conf"
    }
    "Debian","Ubuntu": {
      $filename = "/etc/monit/monitrc.d/puppet-${name}.conf"
    }
  }

  case $ensure {
    present: {
      if $source {
        file {$filename:
          ensure => present,
          source => $source,
          owner  => root,
          group  => root,
          mode   => 600,
          notify => Service["monit"],
          notify => Exec["monit-restart-all"],
          require => [ Package["monit"], Exec["monit-restart-all"] ]
        }
      } else {
        if $content
        {
          if $template
          {
            file { $filename:
              ensure  => present,
              content => template($content),
              owner   => root,
              group   => root,
              mode    => 600,
              notify  => Service["monit"],
              notify => Exec["monit-restart-all"],
              require => [ Package["monit"], Exec["monit-restart-all"] ]
            }
          }
          else
          {
            file { $filename:
              ensure  => present,
              content => $content,
              owner   => root,
              group   => root,
              mode    => 600,
              notify  => Service["monit"],
              require => Package["monit"],
            }
          }
        }
        else
        {
          file {$filename:
            ensure => present,
            owner   => root,
            group   => root,
            mode    => 600,
            notify  => Service["monit"],
            require => Package["monit"],
          }
        }
      }
    }

    absent: {
      file {"/etc/monit/monitrc.d/puppet-${name}.conf":
        ensure => absent,
        notify  => Service["monit"],
        require => Package["monit"],
      }
    }
  }
}
