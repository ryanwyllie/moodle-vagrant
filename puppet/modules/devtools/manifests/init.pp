class devtools {
	include devtools::vim
	include devtools::bash
	include devtools::mdk
	include git

	class { 'java':
		distribution => 'jre',
	}
}
