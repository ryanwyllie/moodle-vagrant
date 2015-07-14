class moodle::database::postgresql (
	$postgres_password = 'postgres',
) {
	class { 'postgresql::server':
        postgres_password => $postgres_password,
		require => Exec['apt-update']
    }
}
