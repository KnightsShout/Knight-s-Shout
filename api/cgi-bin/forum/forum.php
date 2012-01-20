<?php
if (!defined ('FORUM') || FORUM != 'load-forum-zz345%')
        die ("Don't access the forum directly.");

class KSForum
{
        private $db;
        private $config;
        
        function KSForum ($config)
        {
                $this->config = $config;
                define ('FORUM_PATH', $this->config['forum_base']);
                define ('FORUM_CGI', $this->config['forum_base'] . 'cgi-bin/');
                
                $this->db = new Database ($this->config['mysql']['host'], $this->config['mysql']['user'], $this->config['mysql']['pass'], $this->config['mysql']['db']);
        }
}
?>