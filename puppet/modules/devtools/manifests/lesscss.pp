class devtools::lesscss (
	$package_ensure = $moodle::params::package_ensure,
) inherits moodle::params {
	require 'nodejs'

	package { 'recess':
		ensure   => $package_ensure,
		provider => 'npm',
	}
}
