class moodle::packages (
	$package_ensure = $moodle::params::package_ensure
) inherits moodle::params {
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
    ]

    package { $packages:
        ensure => $package_ensure,
        require => Exec['apt-update']
    }
}
