class monit::redhat inherits monit::base {

  file { "/etc/monit.conf":
    ensure => present,
    source => "puppet:///modules/monit/monit.conf",
    owner  => root,
    group  => root,
    mode   => 600,
    require => Package["monit"],
  }

  file {"/etc/monit.d":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 700,
    require => Package["monit"],
  }

}
