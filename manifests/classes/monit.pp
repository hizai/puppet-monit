/*

= Class: monit
Include this class to install monit service on your node.

Requires:
- None

Examples:

  include monit
  monit::config { "script-task":
    ensure => present,
    source => "puppet:///modules/monit/script-task.conf",
  }

  include monit
  monit::config { "script-task":
    ensure => present,
    content => "monit/script-task.conf.erb",
    template => true,
  }

*/


class monit {
  case $operatingsystem {
    "Debian","Ubuntu": { include monit::debian }
    "Centos","RedHat","Amazon","Linux": { include monit::redhat }
    default: { fail "Unknown $operatingsystem" }
  }
}
