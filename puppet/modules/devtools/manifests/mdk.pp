class devtools::mdk (
	$package_ensure = $moodle::params::package_ensure,
	$directory_ensure = $moodle::params::directory_ensure,
	$user = $moodle::params::user,
	$user_home_dir = $moodle::params::user_home_dir,
) inherits moodle::params {
	require git

	$packages = [
        'python-pip',
        'libmysqlclient-dev',
        'libpq-dev',
        'python-dev'
    ]

    package { $packages:
        ensure => $package_ensure,
        require => Exec['apt-update']
    }

	# The default version of the requests package isn't
	# a high enough version to work with MDK
	exec { 'pip install --upgrade requests':
        require => Package['python-pip'],
		# Don't update if we've already got at version 2.7.0 (or higher)
		unless => "pip show requests | grep Version | sed -re 's/(\.|Version: )//g' | xargs test 270 -le"
    }

	$mdk_path = '/opt/moodle-sdk'

	exec { 'install mdk':
		command => "git clone git://github.com/FMCorz/mdk.git ${mdk_path}",
		creates => $mdk_path
	}

	exec { "pip install -r ${mdk_path}/requirements.txt":
		require => [Exec['install mdk'], Package[$packages]]
	}

	exec { "chmod +x ${mdk_path}/mdk.py":
		require => Exec['install mdk'],
		unless => "test -x ${mdk_path}/mdk.py"
	}

	file { '/usr/local/bin/mdk':
		ensure => link,
		target => "${mdk_path}/mdk.py",
		require => Exec['install mdk']
	}
}
