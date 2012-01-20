<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class pNotifications extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file = 'json';
        
        function pNotifications ()
        {
                if (!$_GET['use_ajax'])
                {
                        header ('Location: /home?_re=notifications_1');
                        exit;
                }
                if (!LOGGED_IN)
                {
                        exit;
                }
        }
        
        function doInitPage ($main)
        {
                if (@$_GET[0] == 'friends')
                {
                        $main->notifications->_hasFriendRequests ();
                        if ($main->notifications->hasFriendRequests ())
                        {
                                Template::load ('notifications_friend_requests');
                        }
                        else
                        {
                                Template::load ('notifications_friend_requests_none');
                        }
                }
                elseif (@$_GET[0] == 'other')
                {
                        $main->notifications->_hasNotifications ();
                        if ($main->notifications->hasNotifications ())
                        {
                                Template::load ('notifications_other');
                        }
                        else
                        {
                                Template::load ('notifications_other_none');
                        }
                }
        }
}
?>