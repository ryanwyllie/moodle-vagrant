class moodle::packages (
	$package_ensure = $moodle::params::package_ensure
) inherits moodle::params {

	/*	
	exec { "add php7 repo" :
        command => 'add-apt-repository ppa:ondrej/php-7.0',
    } -> */
	exec { "apt-update" :
        command => '/usr/bin/apt-get -y update',
    }

	$packages = [
        'php5',
        'php5-pspell',
        'php5-curl',
        'php5-gd',
        'php5-intl',
        'php5-xmlrpc',
        'php5-ldap',
        'php5-pgsql',
		'ghostscript',
    ]

	/*
    $packages = [
        'php7.0',
        'php7.0-pspell',
        'php7.0-curl',
        'php7.0-gd',
        'php7.0-intl',
        #'php7.0-xmlrpc',
        'php7.0-ldap',
        'php7.0-pgsql',
        'ghostscript',
    ]
	*/

    package { $packages:
        ensure => $package_ensure,
        #require => Exec['add php7 repo', 'apt-update']
        require => Exec['apt-update']
    }
}
