class moodle::database::postgresql (
	$postgres_password = 'postgres',
) {

	class { 'postgresql::client':
		notify => Service["apache2"],
		require => Exec['apt-update']
	}

	class { 'postgresql::server':
        postgres_password => $postgres_password,
		require => Exec['apt-update']
    }
}
