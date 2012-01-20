<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Feeds
{
        private $m;
        private $db;
        private $_db;
        
        function Feeds ($m)
        {
                $this->m = $m;
                $this->db = $m->database;
                /**
                 * pull a new db connection so we don't interrupt with any pre-existing queries
                 */
                $this->_db = new Database ();
                $this->_define ();
        }
        
        function loadFeed ($account, $max = 25)
        {
                return $this->db->doQuery ("SELECT * FROM FEEDS WHERE strAccount = '%s' ORDER BY FEED DESC LIMIT $max", $account);
        }
        
        function parseFeed ($feed)
        {
                return '<div class="user-feed">&nbsp;<img src="' . TPL . 'img/feed/' . $feed['nType'] . '.png" width="12px" height="12px" alt="" />&nbsp;&nbsp;' . $this->_parseFeed ($feed) . '</div>';
        }
        
        function _parseFeed ($feed)
        {
                $time = $feed['nTime'];
                $account = $feed['strAccount'];
                $type = $feed['nType'];
                $data = $feed['data'];
                $strMessage = $feed['strMessage'];
                
                $feed = '';
                
                switch ($type)
                {
                        case FEED_T_JOINED: {
                                $feed = ___('feed_signed_up', array ($account));
                        } break;
                        case FEED_T_FRIEND_REQUEST: {
                                $data = explode (',', $data, 2);
                                $feed = ___('feed_friends_x_with_y', array ($data[0], strtolower ($data[1]), $data[1]));
                        } break;
                        case FEED_T_CREATED_SERVER: {
                                $server = $data;
                                $serverc = strtolower ($server);
                                $feed = ___('feed_created_server', array ($account, $serverc, $server));
                        } break;
                }
                
                return $feed;
        }
        
        function addFeed ($type, $data, $account = null, $time = null, $strMessage = null)
        {
                if ($account === null)
                        $account = $_SESSION['strAccount'];
                if ($time === null)
                        $time = time ();
                
                $this->_db->doQuery ("INSERT INTO FEEDS (nTime, strAccount, nType, data, strMessage) VALUES (%u, '%s', %u, '%s', '%s')", $time, $account, $type, $data, $strMessage);
        }
        
        function removeFeed ($id, $user)
        {
                $this->_db->doQuery ("DELETE FROM FEEDS WHERE FEED = %u AND strAccount = '%s'", $id, $user);
        }
        
        function _removeFeed ($type, $data, $account = null, $time = null, $strMessage = null)
        {
                
                if ($account === null)
                        $account = $_SESSION['strAccount'];
                if ($time === null)
                        $time = time ();
                
                $this->_db->doQuery ("DELETE FROM FEEDS WHERE strAccount = '%s' AND nType = %u AND data = '%s' AND strMessage = '%s'", $account, $type, $data, $message);
        }
        
        private function _define ()
        {
                /**
                 * definitions
                 */
                define ('FEED_T_JOINED', 1);
                define ('FEED_T_FRIEND_REQUEST', 2);
                define ('FEED_T_COMMENT', 3);
                define ('FEED_T_PLAYING', 4);
                define ('FEED_T_CREATED_SERVER', 5);
                define ('FEED_T_CREATED_PHOTO_ALBUM', 6);
                define ('FEED_T_UPLOADED_PHOTO', 7);
        }
}
?>