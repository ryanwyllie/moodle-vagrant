class devtools::mdk::configure (
	$directory_ensure = $moodle::params::directory_ensure,
	$user = $moodle::params::user,
	$user_home_dir = $moodle::params::user_home_dir,
	$pgsql_user = '',
	$pgsql_password = '',
	$mysql_user = '',
	$mysql_password = '',
	$host_ip,
	$github_username,
	$tracker_username,
) inherits moodle::params {
	require devtools::mdk

	if ($pgsql_user == '' or $pgsql_password == '') and ($mysql_user == '' or $mysql_password == '') {
		fail("Must provide at least one set of database credentials")
	}

	file { "mdk conf dir":
		path => "${user_home_dir}/.moodle-sdk",
		ensure => $directory_ensure,
		owner => $user
	}

	file { "mdk config":
        path => "${user_home_dir}/.moodle-sdk/config.json",
        content => template('devtools/mdk/config.json.erb'),
        owner => $user,
        ensure => $ensure,
		require => File['mdk conf dir'],
    }

	file { "www dir":
		path => "${user_home_dir}/www",
		owner => $user,
		ensure => $directory_ensure
	}

	file { "moodles dir":
		path => "${user_home_dir}/moodles",
		owner => $user,
		ensure => $directory_ensure
	}

	file { "/var/www/m":
		ensure => link,
		target => "${user_home_dir}/www",
		owner => $user,
	}
}
