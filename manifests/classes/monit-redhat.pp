class monit::redhat inherits monit::base {

  file {"/etc/monit.d":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 700,
    require => Package["monit"],
  }

}
