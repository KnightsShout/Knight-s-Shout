<?php
/**
 * @todo Finish the billing settings. Read about paying methods and their apis.
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

$conf = array (
                'pages'         => array (
                        'home'          => './api/cgi-bin/inc.home.php',
                        'ie'            => './api/cgi-bin/inc.ie.php',
                        'register'      => './api/cgi-bin/inc.register.php',
                        'login'         => './api/cgi-bin/inc.login.php',
                        'logout'        => './api/cgi-bin/inc.logout.php',
                        's'             => './api/cgi-bin/inc.static.php',
                        'static'        => './api/cgi-bin/inc.static.php',
                        'blog'          => './api/cgi-bin/inc.blog.php',
                        'js'            => './api/cgi-bin/inc.js_container.php'
                ),
                'template'      => array (
                        'title'         => 'Knight\'s Shout',
                        'theme'         => 'knightsshout',
                        'main_file'     => 'template',
                        'sub_file'      => 'template_members'
                ),
                'session'       => array (
                        'lifetime'      => (3 * 24 * 60 * 60),
                        'path'          => '/',
                        'domain'        => 'beta.knightsshout.com',
                        'secure'        => false,
                        'httpd_only'    => false
                ),
                'database'      => array (
                        'host'          => 'localhost',
                        'db'            => 'your',
                        'user'          => 'info',
                        'pass'          => 'kspw'
                ),
                'account'       => array (
                        'register'      => true,
                        'hashing'       => array (
                                'type'          => 'md5',
                                'seed'          => 'your%sseed'
                        )
                ),
                'billing'       => array (
                        'paypal'        => array (
                                
                        ),
                        'daopay'        => array (
                                
                        )
                ),
                'social_net'    => array (
                        'facebook' => 'http://www.facebook.com/KnightsShout',
                        'twitter' => 'http://twitter.com/KnightsShout'
                ),
                'translation'   => array (
                        'languages'     => array (
                                'en'    =>      'English (Global)',
                                //'us'    =>      'English (American)',
                                //'de'    =>      'Deutsch (Hochdeutsch)',
                                //'de-ch' =>      'Deutsch (Switzerdutch)',
                                //'nl'    =>      'Nederlands'
                        )
                ),
                'reCAPTCHA'     => array (
                        'privatekey' => 'recaptcha',
                        'publickey' => 'recaptcha'
                )
);
?>