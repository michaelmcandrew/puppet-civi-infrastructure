node default {

  package { ["emacs23-nox", "git-core", "php-elisp"] : ensure => present } # really necessary at this high level? if so, also add php-elisp
  
  # TODO work out how to properly implement monitoring
  
}

node webserver inherits default {

  include apache, php, mysql, postfix
  
  # set /etc/aliases to be root: michaelmcandrew@thirdsectordesign.org and subscribe newaliases or somin
  
  # package { "drush" : ensure => present } # need to replace this with actually downloading the latest drush and setting it up according to drush installation instructions in the drush readme
  
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
  # need to create fstab that mounts /dev/sdf on /backup ?? really?? - maybe need to get more sophisticated
  # need to add access to mysql from remote hosts as specified by Rob Stead (/etc/mysql/my.cnf don't bind to localhost and add access access for specific users from specific IPs)
}
node 'bolivia.thirdsectordesign.org' inherits webserver {
  # need to create fstab that mounts /dev/sdf on /backup
}

node 'brazil.thirdsectordesign.org' inherits webserver {
  # need to create fstab that mounts /dev/sdf on /backup
  # redirect all postfix mail to NULL
}




