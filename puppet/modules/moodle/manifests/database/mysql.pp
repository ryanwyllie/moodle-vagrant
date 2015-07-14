class moodle::database::mysql {
	class { 'mysql::server' :
        create_root_user => true,
        root_password => 'root',
        override_options => {
            mysqld => {
                default_storage_engine => 'innodb',
                innodb_file_per_table => '1',
                innodb_file_format => 'Barracuda',
            },
        },
    }

    class { 'mysql::client' : }

    class { 'mysql::bindings':
        php_enable => true,
    }
}
