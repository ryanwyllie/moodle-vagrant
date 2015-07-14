class moodle {
	require moodle::packages

	# This is required for the unit tests to work correctly
	exec { 'locale-gen en_AU.UTF-8': 
		unless => "locale -a | grep -i 'en_AU.utf8'"
	}
}
