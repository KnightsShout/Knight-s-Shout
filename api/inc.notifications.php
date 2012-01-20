<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Notifications
{
        private $m;
        private $db;
        private $hasFriendRequests = 0;
        public $friendRequests = array();
        private $hasMessages = 0;
        public $messages = array();
        private $hasNotifications = 0;
        private $hasNotificationsOther = 0;
        public $notifications = array();
        public $notificationsOther = array();
        
        function Notifications ($m)
        {
                $this->m = $m;
                /**
                 * create a new instance of the
                 * database class
                 */
                $this->db = new Database ();
                $this->_define ();
                
                if ($this->m->isSecure ())
                {
                        #echo 'is - ';
                        if (isset ($_GET['release_notif_id']))
                        {
                                #echo ' step - ';
                                if (preg_match ('/[,]/i', $_GET['release_notif_id']))
                                {
                                        $data = explode (',', $_GET['release_notif_id']);
                                        foreach ($data as $id)
                                                $this->releaseNotification (intval ($id));
                                }
                                elseif ($_GET['release_notif_id'] == 'flush')
                                {
                                        $this->releaseNotifications ();
                                }
                                else
                                {
                                        $id = intval ($_GET['release_notif_id']);
                                        $this->releaseNotification ($id);
                                }
                        }
                }
                else
                {
                        #echo 'insecure. ' . KS_SECURE_KEY;
                }
        }
        
        function update_all ()
        {
                $this->_hasFriendRequests ();
                $this->_hasNotifications ();
                
                return 1;
        }
        
        function _hasFriendRequests ()
        {
                $this->hasFriendRequests = $this->db->doQuery ("SELECT * FROM FRIENDSHIPS LEFT OUTER JOIN MEMBERS ON (strRequester = strAccountID) WHERE strAsked = '%s' AND nStatus = 1", $_SESSION['strAccount']);
                $this->friendRequests = array();
                while ($this->friendRequests[] = $this->db->doRead ())
                        continue;
        }
        
        function hasFriendRequests ()
        {
                return $this->hasFriendRequests;
        }
        
        function hasMessages ()
        {
                return $this->hasMessages;
        }
        
        function _hasNotifications ()
        {
                $this->hasNotifications = $this->db->doQuery ("SELECT * FROM NOTIFICATIONS WHERE strAccountID = '%s' AND nStatus = 1 ORDER BY NOTIFICATIONS DESC", $_SESSION['strAccount']);
                $this->notifications = array();
                while ($this->notifications[] = $this->db->doRead ())
                        continue;
                $this->_loadNotificationsOther ();
                #$this->releaseNotifications ();
        }
        
        function _loadNotificationsOther ($max = 10, $min = 1)
        {
                $this->hasNotificationsOther = $this->db->doQuery ("SELECT * FROM NOTIFICATIONS WHERE strAccountID = '%s' AND nStatus = 2 ORDER BY NOTIFICATIONS DESC LIMIT $max", $_SESSION['strAccount']);
                while ($this->notificationsOther[] = $this->db->doRead ())
                        continue;
        }
        
        function hasNotifications ()
        {
                return $this->hasNotifications;
        }
        
        function hasNotificationsOther ()
        {
                return $this->hasNotificationsOther;
        }
        
        function releaseNotification ($id)
        {
                $this->db->doQuery ("UPDATE NOTIFICATIONS SET nStatus = 2 WHERE strAccountID = '%s' AND NOTIFICATIONS = %u", $_SESSION['strAccount'], $id);
        }
        
        function releaseNotifications ()
        {
                $this->db->doQuery ("UPDATE NOTIFICATIONS SET nStatus = 2 WHERE strAccountID = '%s'", $_SESSION['strAccount']);
        }
        
        function parseNotification ($notification)
        {
                return '<div class="user-notification">' . $this->_parseNotification ($notification) . '</div>';
        }
        
        function _parseNotification ($notification)
        {
                $id = $notification['NOTIFICATIONS'];
                $account = $notification['strAccountID'];
                $type = $notification['nType'];
                $data = $notification['data'];
                $status = $notification['nStatus'];
                $time = $notification['nTime'];
                
                $notification = '';
                
                switch ($type)
                {
                        case NOTIFICATION_T_WELCOME: {
                                $notification = ___('notifications_t_welcome', array ($id, KS_SECURE_KEY, $id));
                        } break;
                        case NOTIFICATION_T_MADE_FRIENDS: {
                                $data = explode (',', $data, 3);
                                $notification = ___('notifications_t_made_friends', array (strtolower ($data[0]), $id, KS_SECURE_KEY, $data[1], $data[0]));
                        } break;
                }
                
                return $notification;
        }
        
        function addNotification ($type, $data, $account = null, $time = null)
        {
                if ($account === null)
                        $account = $_SESSION['strAccount'];
                if ($time === null)
                        $time = time ();
                
                $this->db->doQuery ("INSERT INTO NOTIFICATIONS (strAccountID, nType, data, nStatus, nTime) VALUES ('%s', %u, '%s', 1, %u)", $account, $type, $data, $time);
        }
        
        private function _define ()
        {
                define ('NOTIFICATION_T_WELCOME', 1);
                define ('NOTIFICATION_T_MADE_FRIENDS', 2);
        }
        
        function __destruct ()
        {
                
        }
}
?>