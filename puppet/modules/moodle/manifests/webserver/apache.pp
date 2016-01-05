class moodle::webserver::apache {
	include apache

}
class {'apache':
    default_vhost => false,
}
apache::vhost {'mydefault':
    default_vhost => true,
    port => 80,
    ssl => false,
    docroot => '/var/www/html',

    directories => [
	{
	    'path' => '/',
	    'options' => 'FollowSymLinks Indexes',
	    'allowoverride' => 'None',
	    'provider' => 'files',
	},
    ],

}
