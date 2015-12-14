class moodle::database::postgresql (
	$postgres_password = 'postgres',
) {

	class { 'postgresql::client': }

	class { 'postgresql::server':
        postgres_password => $postgres_password,
		require => Exec['apt-update']
    }
}
