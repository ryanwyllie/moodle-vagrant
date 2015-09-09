class devtools::git::configure (
	$user = $moodle::params::user,
	$editor = 'vim',
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

	git::config { 'core.editor':
		value => $editor,
		user => $user,
	}
}
