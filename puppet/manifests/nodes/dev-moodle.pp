node "dev-moodle" {
	include moodle
	include moodle::webserver::apache
	include devtools

	$pgsql_password = 'postgres'

	class { 'moodle::database::postgresql':
		postgres_password => $pgsql_password,
	}

	/*
	# Uncomment this block if you'd like puppet to configure
	# your MDK install. This will write the MDK config for you,
	# otherwise you'll need to run 'mdk init' before checking 
	# out any Moodle instances.

	# This is the default postgres user
	$pgsql_user = 'postgres'
	# Your github username, used to check out your Moodle repo
	$github_username = ''
	# Your username for the Moodle tracker
	$tracker_username = ''

	class { 'devtools::mdk::configure':
		pgsql_user => $pgsql_user,
		pgsql_password => $pgsql_password,
		host_ip => $ipaddress_eth1,
		github_username => $github_username,
		tracker_username => $tracker_username,
	}
	*/

	/*
	# Uncomment this block if you'd like puppet to configure you
	# git install. Otherwise you can set your name and email manually
	# when you do your first commit

	# The name for your git config (e.g. John Smith)
	$git_name = ''
	# The email for your git config (e.g. john@moodle.com)
	$git_email = ''

	class { 'devtools::git::configure':
		name => $git_name,
		email => $git_email,
	}
	*/
}
