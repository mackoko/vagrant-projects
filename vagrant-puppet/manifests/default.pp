# execute apt-get update
exec { 'apt-update':
	command => '/usr/bin/apt-get update',
}

# install mongodb
package { 'mongodb':
	require => Exec['apt-update'],
	ensure => installed,
}

# run the service
service { 'mongodb':
	ensure => running,
	require => Package['mongodb'],
}

# install redis-server
#package { 'redis-server':
#	require => Exec['apt-update'],
#	ensure => latest,
#}

# run the service
#service { 'redis-server':
#	ensure => running,
#	require => Package['redis-server'],
#}

# create dir
#file { "/home/vagrant/my-projects":
#	ensure => "directory",
#	owner => "vagrant",
#	group => "vagrant",
#	mode => 750,	
#}