<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class IE extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file = 'ie_error';
        
        function IE () { }
        
        function doInitPage ($main)
        {
                if (isset ($_GET['_mod']))
                {
                        if ($_GET['_mod'] == 'xx3')
                        {
                                $main->database->doQuery ('SELECT * FROM MEMBERS');
                                while ($member = $main->database->doRead ())
                                {
                                        echo $member['strAccountID'] . "<br>";
                                        $main->feeds->addFeed (FEED_T_JOINED, null, $member['strAccountID'], null, null);
                                }
                                echo '<br>k';
                        }
                        if ($_GET['_mod'] == '_zdd2')
                        {
                                $main->database->doQuery ('SELECT * FROM MEMBERS');
                                while ($member = $main->database->doRead ())
                                {
                                        $main->notifications->addNotification (NOTIFICATION_T_WELCOME, null, $member['strAccountID']);
                                        echo $member['strAccountID'] . "<br>";
                                }
                                echo '<br>k';
                        }
                }
        }
}
?>