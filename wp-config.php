<?php

if ( file_exists( dirname( __FILE__ ) . '/config.php' ) ) {
	require "config.php";
} elseif ( file_exists( dirname( __FILE__ ) . '/local-config.json' ) ) {

	$env_config = json_decode( file_get_contents( dirname( __FILE__ ) . '/local-config.json' ), true );
	$db_data    = $env_config['mysql'];

	/** The name of the database for WordPress */
	define( 'DB_NAME', $db_data['database'] );

	/** MySQL database username */
	define( 'DB_USER', $db_data['username'] );

	/** MySQL database password */
	define( 'DB_PASSWORD', $db_data['password'] );

	/** MySQL hostname */
	define( 'DB_HOST', $db_data['host'] );

	/** The Database Collate type. Don't change this if in doubt. */
	define( 'DB_COLLATE', '' );

	define( 'WP_HOME', 'http://127.0.0.1:' . $env_config['server']['port'] );
} else {
	die( "local-config.json or config.php is Not Exsist!" );
}

require_once dirname( __FILE__ ) . '/salt.php';

$table_prefix = "wp_";


define( 'WP_SITEURL', WP_HOME . '/wp' );
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/wp-content' );
define( 'WP_CONTENT_URL', WP_HOME . '/wp-content' );

define( 'JETPACK_DEV_DEBUG', true );
define( 'WP_DEBUG', true );


/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
