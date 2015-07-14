class devtools::vim (
	$ensure = $moodle::params::ensure,
	$directory_ensure = $moodle::params::directory_ensure,
	$package_ensure = $moodle::params::package_ensure,
	$user = $moodle::params::user,
	$user_home_dir = $moodle::params::user_home_dir
) inherits moodle::params {
	require git

	package { ['vim']:
        ensure => $package_ensure,
        require => Exec['apt-update']
    }

	file { "user vimrc":
		path => "${user_home_dir}/.vimrc",
		content => template('devtools/vimrc.erb'),
		owner => $user,
		ensure => $ensure,
	}

	file { "vim folder":
		path => "${user_home_dir}/.vim/",
		owner => $user,
		ensure => $directory_ensure
	}

	file { "vim autoload folder":
        path => "${user_home_dir}/.vim/autoload/",
		owner => $user,
        ensure => $directory_ensure,
		require => File['vim folder'],
    }

	file { "vim bundle folder":
        path => "${user_home_dir}/.vim/bundle/",
		owner => $user,
        ensure => $directory_ensure,
		require => File['vim folder'],
    }

	exec { "git clone git://github.com/tpope/vim-sensible.git":
		cwd => "${user_home_dir}/.vim/bundle/",
		user => $user,
		creates => "${user_home_dir}/.vim/bundle/vim-sensible/",
		require => File['vim bundle folder'],
	}

	exec { "git clone https://github.com/StanAngeloff/php.vim.git":
		cwd => "${user_home_dir}/.vim/bundle/",
		user => $user,
		creates => "${user_home_dir}/.vim/bundle/php.vim/",
		require => File['vim bundle folder'],
	}

	exec { 'install pathogen':
		command => "curl -LSso ${user_home_dir}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim",
		creates => "${user_home_dir}/.vim/autoload/pathogen.vim",
	}
}
