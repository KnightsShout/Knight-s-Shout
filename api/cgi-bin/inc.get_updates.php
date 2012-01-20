<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Get_Updates extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file = 'json';
        
        function Get_Updates ()
        {
                if (!$_GET['use_ajax'])
                        exit;
        }
        
        function doInitPage ($main)
        {
                if (!LOGGED_IN)
                {
                        $r = @isset ($_GET['r']) ? $_GET['r'] : '';
                        ?>
                        <script type="text/javascript">
                        var attr = new Array(1, '<script type="text/javascript">window.location="/login?continue=<?php echo $r; ?>";<' + '/script>', null, null);
                        KS.doPopup(attr);
                        </script>
                        <?php
                }
                else
                {
                        $main->notifications->update_all ();
                        $friend_requests = $main->notifications->hasFriendRequests ();
                        ?>
                        <script type="text/javascript">
                        try {
                                KS.hasFriendRequests(<?php echo $friend_requests; ?>);
                        <?php
                        $notifications = $main->notifications->hasNotifications ()
                        ?>
                                KS.hasNotifications(<?php echo $notifications; ?>);
                        } catch(e) {
                                try {
                                        console.log("[KS COMET][#'pUpdate'/x] Failed notifying user.");
                                } catch(e) {}
                        }
                        </script>
                        <?php
                }
        }
}
?>