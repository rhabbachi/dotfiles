<?php
/*
Set some useful development environment variables
*/

//$conf array are drupal variables that cannot be overridden by db settings.
$conf['file_directory_temp'] = "sites/default/files/tmp";
$conf['file_directory_path'] = "sites/default/files";

$conf['file_public_path'] = "sites/default/files/public";
$conf['file_private_path'] = "sites/default/files/private";
$conf['file_temporary_path'] = "sites/default/files/tmp";

# turn off caching & aggregation
$conf['cache'] = FALSE;
$conf['block_cache'] = FALSE;
$conf['preprocess_css'] = FALSE;
$conf['preprocess_js'] = FALSE;

# toggle module settings
//$conf['apachesolr_default_environment'] = "solr";
//$conf['apachesolr_read_only'] = 1;
# $conf['apc_enable'] = FALSE;

# enable developer modules
$conf['devel_enable'] = TRUE;
$conf['devel_themer_enable'] = TRUE;

# Increase some php variables
ini_set('memory_limit', '512M');
ini_set('realpath_cache_size', '24M');
ini_set('upload_max_filesize', '10M');
ini_set('max_input_vars', '1000');
//ini_set('post_max_size', '10M');

# display all error messages
//$conf['error_level'] = 2;
//ini_set('display_errors', TRUE);
//ini_set('display_startup_errors', TRUE);

# Mandrill
$conf['mandrill_api_key'] = 'eRvS_swm1JwZwXvB28hsBA';
# intercept emails using Devel
$conf['mail_system'] = array(
	//'default-system' => 'DevelMailLog',
	'default-system' => 'MandrillMailSystem',
);

// Uncomment the following to disable Secure Pages
$conf['securepages_enable'] = FALSE;

// Whether the Environment Indicator should use the settings.php variables for
// the indicator. On your production environment, you should probably set this
// to FALSE.
$conf['environment_indicator_overwrite'] = TRUE;

// The text that will be displayed on the indicator.
$conf['environment_indicator_overwritten_name'] = 'localhost';

/**
 *  * Reroute Email module:
 *   *
 *    * To override specific variables and ensure that email rerouting is
 *    enabled or
 *     * disabled, change the values below accordingly for your site.
 *      */
// Enable email rerouting.
$conf['reroute_email_enable'] = 1;
// Space, comma, or semicolon-delimited list of email addresses to pass
// through. Every destination email address which is not on this list will be
// rerouted to the first address on the list.
$conf['reroute_email_address'] = "riadh+rerouted@angrycactus.biz";
// Enable inserting a message into the email body when the mail is being
// rerouted.
$conf['reroute_email_enable_message'] = 1;

// admin_menu
//$conf['admin_menu_position_fixed'] = 0;
$conf['admin_menu_components'] =  array (
  'admin_menu.icon' => true,
  'admin_menu.menu' => true,
  'admin_menu.search' => false,
  'admin_menu.users' => true,
  'admin_menu.account' => true,
  'shortcut.links' => false,
);

// module_filter
$conf['module_filter_use_switch'] = 0;

// Omega
$conf['omega_toggle_extension_development'] = 1;

// Environment Indicator
$conf['environment_indicator_overwrite'] = TRUE;
$conf['environment_indicator_overwritten_name'] = 'Localhost';
$conf['environment_indicator_overwritten_color'] = '#088A08';
$conf['environment_indicator_overwritten_text_color'] = '#ffffff';
$conf['environment_indicator_overwritten_position'] = 'bottom';
$conf['environment_indicator_overwritten_fixed'] = TRUE;
