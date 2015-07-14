class devtools::bash (
	$ensure = $moodle::params::ensure,
	$package_ensure = $moodle::params::package_ensure,
	$user_home_dir = $moodle::params::user_home_dir
) inherits moodle::params {

	file { "user bashrc":
        path => "${user_home_dir}/.bashrc",
        content => template('devtools/bashrc.erb'),
        owner => $user,
        ensure => $ensure,
    }

    file { "user bash_profile":
        path => "${user_home_dir}/.bash_profile",
        content => "source ~/.bashrc",
        owner => $user,
        ensure => $ensure,
    }

    file { "git-prompt":
        path => "${user_home_dir}/.git-prompt.sh",
        content => template('devtools/git-prompt.sh.erb'),
        owner => $user,
        ensure => $ensure,
    }
}
