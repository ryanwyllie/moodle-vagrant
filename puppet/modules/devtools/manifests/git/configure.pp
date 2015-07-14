class devtools::git::configure (
	$user = $moodle::params::user,
	$name,
	$email,
) inherits moodle::params {
	require git

	git::config { 'user.name':
		value => $name,
		user => $user,
	}

	git::config { 'user.email':
		value => $email,
		user => $user,
	}
}
