class moodle::database::mssql (
	$ensure = $moodle::params::ensure,
	$package_ensure = $moodle::params::package_ensure
) inherits moodle::params {
	# See https://imalabya.wordpress.com/2014/11/24/connecting-to-a-microsoft-sql-server-database-from-php-in-ubuntu/

	$packages = [
		'freetds-common',
		'freetds-bin',
		'unixodbc',
		'php5-sybase'
	]

	package { $packages:
        ensure => $package_ensure,
        require => Exec['apt-update'],
		notify => Service["apache2"]
    }
}
