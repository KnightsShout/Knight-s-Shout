<?php
if (!defined ('FORUM') || FORUM != 'load-forum-zz345%')
        die ("Don't access the forum directly.");

class Authentication {
        private $access_token = 0;
        private $access_special = array();
        
        function Authentication ($authority)
        {
                
        }
        
        function has_access ($token)
        {
                return $token > $this->access_token;
        }
        
        function access_token ()
        {
                return intval ($this->access_token);
        }
}
?>