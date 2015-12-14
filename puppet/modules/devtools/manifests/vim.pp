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

	file { "vim after folder":
        path => "${user_home_dir}/.vim/after/",
		owner => $user,
        ensure => $directory_ensure,
		require => File['vim folder'],
    }

	file { "vim ftplugin folder":
        path => "${user_home_dir}/.vim/after/ftplugin/",
		owner => $user,
        ensure => $directory_ensure,
		require => File['vim after folder'],
    }

	file { "vim cucumber":
        path => "${user_home_dir}/.vim/after/ftplugin/cucumber.vim",
		owner => $user,
        ensure => $ensure,
		content => template('devtools/cucumber.vim.erb'),
		require => File['vim ftplugin folder'],
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

	exec { "git clone git://github.com/shawncplus/phpcomplete.vim.git":
		cwd => "${user_home_dir}/.vim/bundle/",
		user => $user,
		creates => "${user_home_dir}/.vim/bundle/phpcomplete.vim/",
		require => File['vim bundle folder'],
	}

	exec { "git clone git://github.com/ervandew/supertab.git":
		cwd => "${user_home_dir}/.vim/bundle/",
		user => $user,
		creates => "${user_home_dir}/.vim/bundle/supertab/",
		require => File['vim bundle folder'],
	}

	/*
	exec { "git clone git@github.com:2072/PHP-Indenting-for-VIm.git":
		cwd => "${user_home_dir}/.vim/bundle/",
		user => $user,
		creates => "${user_home_dir}/.vim/bundle/PHP-Indenting-for-VIm/",
		require => File['vim bundle folder'],
	}
	*/

	exec { "git clone git://github.com/mustache/vim-mustache-handlebars.git":
		cwd => "${user_home_dir}/.vim/bundle/",
		user => $user,
		creates => "${user_home_dir}/.vim/bundle/vim-mustache-handlebars/",
		require => File['vim bundle folder'],
	}

	exec { 'install pathogen':
		command => "curl -LSso ${user_home_dir}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim",
		creates => "${user_home_dir}/.vim/autoload/pathogen.vim",
	}
}
