class monit::debian inherits monit::base {

  file {"/etc/default/monit":
    ensure => present,
    source => "puppet:///modules/monit/monit.default",
    require => Package["monit"],
  }

  file {"/etc/monit/monitrc.d":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 700,
    require => Package["monit"],
  }

}
