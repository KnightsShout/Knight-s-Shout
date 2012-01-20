<?php
/**
 * @todo Add a Query Cacher. Possibly memcached? Or an own system? Preferably memcached -> we need a root that supports the PECL php plugin!
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Database extends Main
{
        private $conn = 0;
        private $result = 0;
        private $query = 0;
        private $host = null;
        private $user = null;
        private $pass = null;
        private $db = null;
        
        function Database ($host = null, $user = null, $pass = null, $db = null)
        {
                if ($host === null)
                {
                        $this->host = MYSQL_HOST;
                        $this->user = MYSQL_USER;
                        $this->pass = MYSQL_PASS;
                        $this->db = MYSQL_DB;
                }
                else
                {
                        $this->host = $host;
                        $this->user = $user;
                        $this->pass = $pass;
                        $this->db = $db;
                }
        }
        
        function doConnect ()
        {
                if ($this->conn)
                        return 1;
                $this->conn = mysql_pconnect ($this->host, $this->user, $this->pass);
                if (!$this->conn)
                        return 0;
                mysql_select_db ($this->db, $this->conn);
                return 1;
        }
        
        /**
         * Note that we do no longer use ?s as placeholder for content.
         * You will now have to use the sprintf placeholders (%s, %d etc).
         * Hence, be careful about the datatypes you pass, as it might cause an error if you put
         * a wrong datatype.
         */
        function doQuery ()
        {
                $args = func_get_args ();
                
                if (sizeof ($args) < 1)
                        return 0;
                
                if (!$this->conn)
                        if (!$this->doConnect ())
                                return 0;
                
                $query = $args[0];
                array_shift ($args);
                
                if (sizeof ($args) > 0)
                {
                        $valids = array();
                        
                        foreach ($args as $arg)
                                $valids[] = mysql_real_escape_string ($arg, $this->conn);
                        
                        $query = vsprintf ($query, $valids);
                }
                
                if (!$this->query = mysql_query ($query, $this->conn))
                        return 0;
                
                return @mysql_affected_rows ($this->query) == false ? @mysql_num_rows ($this->query) : @mysql_affected_rows ($this->query);
        }
        
        function doRead ()
        {
                return @mysql_fetch_assoc ($this->query);
        }
        
        function doFreeResult ()
        {
                mysql_free_result ($this->query);
        }
}
?>