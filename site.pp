node default {

  $puppet_server = "chile.thirdsectordesign.org" # not sure if necessary

  package { "emacs23-nox" : ensure => present } # really necessary at this high level?
  package { "git-core" : ensure => present } # really necessary at this high level?
  
  # TODO work out how to properly implement monitoring
  $monitor = "yes" 
  $monitor_type = ["munin"]
  $munin_server = "10.234.35.165"

  $debug = "no" # not sure if this is actually making any difference
}

node webserver inherits default {

  include apache, php, mysql, postfix
  
  package { "drush" : ensure => present }
  
  package { "php-apc" : ensure => present }
  package { "php5-gd" : ensure => present }
  package { "php5-curl" : ensure => present }
  # i think that the above php modules can be enabled using the php::module { mysql : } syntax below
  
  php::module { mysql : }
  # TODO need to work out how to include mod_ssl and mod_rewrite
  # could be like this: https://github.com/puppet-modules/puppet-apache/raw/master/manifests/init.pp
  # or maybe there is the 42 way of doing it
  
  # TODO need to also download the civihosting scripts to handle cron (or switch to aegir!)
  
  # TODO need to ensure that backups (inc. remote backups) are happening (currently can be handled with civihosting scripts)

}

node 'argentina.thirdsectordesign.org' inherits webserver {
}

node 'chile.thirdsectordesign.org' inherits default {
  include munin
  $munin_server_local = "yes"
  
}



