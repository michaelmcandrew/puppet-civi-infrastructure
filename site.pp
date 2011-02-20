node default {

     package { "emacs23-nox" : ensure => present }

}

node webserver inherits default {

    include apache, php, mysql
    package { "php-apc" : ensure => present }
    package { "php5-gd" : ensure => present }
    
    # need to work out how to include mod_ssl and mod_rewrite
    # 
    # could be like this: https://github.com/puppet-modules/puppet-apache/raw/master/manifests/init.pp
    # 
    # or maybe there is the 42 way of doing it

}

node 'argentina.thirdsectordesign.org' inherits webserver {
}



