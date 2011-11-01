class monit::base {

  package {"monit":
    ensure => present
  }

  service {"monit":
    ensure  => running,
    require => Package["monit"],
  }

  exec { 'monit-restart-all':
    command => "monit restart all",
    path => "/usr/local/bin:/bin:/usr/bin",
    subscribe => Service["monit"],
    refreshonly => true
  }

  # Monit doesn't start when monitrc.d/ is empty
  monit::config{"default":
    ensure  => present,
    content => "",
  }
}
