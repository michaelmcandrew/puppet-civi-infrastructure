node basenode {
  
  $my_project = "civi-infrastructure"
	$debug = "yes"

# Activates usage of Extended Classes
	$monitor = "yes"
	$monitor_type = ["munin"]
	$backup = "no"
	$firewall = "no"

# Puppet Master - required
  $puppet_server = "chile.thirdsectordesign.org"

# Network settings
  $domain = "thirdsectordesign.org"

# Local root mail is forwarded to $root_email - CHANGE IT!
  $root_email = "michaelmcandrew@thirdsectordesign.org"

# Time settings
  $timezone = "Europe/London"
  $ntp_server = "3.ie.pool.ntp.org"

# Aptitude
  $update = "yes"   # Auto Update packages (yes|no)

# Munin central server (chile)
  $munin_server = "46.137.110.35"
  
  include nagios
  include munin
  
  package { "emacs-23-nox": ensure => installed }
  package { "php-elisp": ensure => installed }

}

### chile.thirdsectordesign.org ###

node 'chile.thirdsectordesign.org' inherits basenode {

# Access lists for Puppetmaster access (can be an array)
	$puppet_allow = [ "colombia.thirdsectordesign.org" ]

	include general
	include puppet
	include ssh::auth::keymaster
	include monitor::server
	include monitor::server::nagios
	include nagios

}

node webserver inherits basenode {
  include general
	include apache
	include mysql
	include php
	include postfix
  
}

node 'argentina.thirdsectordesign.org' inherits webserver {
}

node 'brazil.thirdsectordesign.org' inherits webserver {	
}

node 'bolivia.thirdsectordesign.org' inherits basenode {

	include general
	include backup

}

node 'colombia.thirdsectordesign.org' inherits basenode {

	include general
	include backup

}