class monit::base {

  package {"monit":
    ensure => present
  }

  service {"monit":
    ensure  => running,
    require => Package["monit"]
  }

  # Monit doesn't start when monitrc.d/ is empty
  monit::config{"default":
    ensure  => present,
    content => "",
  }
}
