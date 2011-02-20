node default {

     package { "emacs23-nox" : ensure => present }

}

node 'argentina.thirdsectordesign.org' {

     package { "emacs23-nox" : ensure => present }

}