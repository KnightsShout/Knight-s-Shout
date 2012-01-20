<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Blog extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_blog';
        static $tpl_file = TPL_SUBFILE;
        private $pipe = null;
        static $jsp = array();
        static $jspc = 0;
        static $q = null;
        private $main;
        
        function Blog ()
        {
                /* if (!LOGGED_IN){ header ('Location: /home'); exit; }*/
                if (@$_GET[0] == 'new_post' && LOGGED_IN !== 2)
                {
                        header ((!LOGGED_IN ? 'Location: /login?continue=' . url_continue () : 'Location: /blog'));
                        exit;
                }
                if (@$_GET[0] == 'search' && (strlen (preg_replace ('/[^a-z0-9%]/i', '', (isset ($_GET['q']) ? $_GET['q'] : @$_POST['q']))) < 1 || (!isset ($_GET['q']) && !isset ($_POST['q']))))
                {
                        header ('Location: /blog');
                        exit;
                }
        }
        
        function doInitPage ($main)
        {
                $this->main = $main;
                
                $trigger = @$_GET[0];
                $data = !empty ($_GET[0]) ? explode (":", $_GET[0]) : array (0 => 0, 1 => 0);
                
                if ($trigger == "new_post")
                {
                        if ($_GET['use_ajax'])
                        {
                                $category = intval (@$_POST['post-category']);
                                $title = htmlspecialchars (@$_POST['post-title']);
                                $content = htmlspecialchars (@$_POST['post-content']);
                                $response = array("response" => "success");
                                
                                if ($category < 1 || $category > 3 || strlen ($title) < 4 || strlen ($title) > 60 || strlen ($content) < 10 || strlen ($content) > 20000)
                                        $response["response"] = "fail";
                                else
                                        $main->database->doQuery ("INSERT INTO BLOG_POSTS (nCategory, strTitle, strContent, strAuthor, nTime, strDate) VALUES (%u, '%s', '%s', '%s', %u, '%s')", $category, $title, $content, $_SESSION['strAccount'], time (), date ("l, d. F o"));
                                
                                echo json_encode ($response);
                        }
                        else
                        {
                                Template::load ('blog_new_post');
                        }
                }
                elseif (!$data[0])
                {
                        Template::load ('blog');
                }
                elseif ($data[0] == 'remove')
                {
                        if (LOGGED_IN != 2)
                                die ();
                                
                        $id = intval ($data[1]);
                        
                        if (!$id || $id < 1)
                                die ();
                        $main->database->doQuery ('DELETE FROM BLOG_POSTS WHERE nID = %u', $id);
                        
                        echo json_encode (array ('rsp' => 'done'));
                }
                elseif ($data[0] == 'edit')
                {
                        if (LOGGED_IN != 2)
                                die ();
                        
                        $id = intval ($data[1]);
                        
                        if (!$id || $id < 1)
                                die ();
                        
                        $main->database->doQuery ('SELECT * FROM BLOG_POSTS WHERE nID = %u', $id);
                        $row = $main->database->doRead ();
                        $row['strTitle'] = urlencode (str_replace (array ("\'", '\"'), array ("'", '"'), htmlspecialchars_decode ($row['strTitle'])));
                        $row['strContent'] = urlencode (str_replace (array ("\'", '\"'), array ("'", '"'), htmlspecialchars_decode ($row['strContent'])));
                        
                        echo json_encode ($row);
                }
                elseif ($data[0] == 'update' && $_GET['use_ajax'])
                {
                        if (LOGGED_IN != 2)
                                die ();
                        
                        $id = intval ($data[1]);
                        $title = htmlspecialchars (@$_POST['blog-title']);
                        $content = htmlspecialchars (@$_POST['post-content']);
                        
                        if (strlen ($title) < 4 || strlen ($title) > 60 || strlen ($content) < 10 || strlen ($content) > 20000)
                                die ();
                        
                        $main->database->doQuery ("UPDATE BLOG_POSTS SET strTitle = '%s', strContent = '%s', strAuthor = '%s' WHERE nID = %u", $title, $content, $_SESSION['strAccount'], $id);
                        
                        header ('Location: /blog');
                        exit;
                }
                elseif ($_GET[0] == 'search')
                {
                        $this->pipe = array('search');
                        
                        Template::load ('blog_search');
                }
                else
                {
                        $id = intval (substr ($_GET[0], 0, strpos ($_GET[0], '-')));
                        
                        if ($id < 1)
                        {
                                Template::load ('blog');
                        }
                        else
                        {
                                if (!$main->database->doQuery ("SELECT * FROM BLOG_POSTS WHERE nID = %u", $id))
                                        Template::load ('blog_article_error');
                                else
                                        Template::load ('blog_article');
                        }
                }
        }
        
        function doAddPipe()
        {
                if ($this->pipe == null)
                        return;
                
                if ($this->pipe[0] == 'search')
                        $this->pipeSearch ();
        }
        
        function pipeSearch ()
        {
                /*
                $js = $this->main->js_pipe->jsify ('<div id="none">hello</div>', array (1, '#frmNewPostCallback'));
                $this->main->js_pipe->flush ();
                */
                
                
                $q = str_replace (' ', '%', preg_replace ('/[^a-z0-9\- ]/i', ' ', urldecode ($_GET['q'])));
                
                self::$q = str_replace ('%', ' ', $q);
                
                $this->main->database->doQuery ("SELECT * FROM BLOG_POSTS WHERE strTitle LIKE '%%%s%%' OR strContent LIKE '%%%s%%'", (string) $q, (string) $q);
                while (self::$jsp = $this->main->database->doRead ())
                {
                        self::$jspc++;
                        self::$jsp['strTitle'] = str_ireplace ($q, '<u>' . $q . '</u>', self::$jsp['strTitle']);
                        self::$jsp['strContent'] = str_ireplace ($q, '<u>' . $q . '</u>', self::$jsp['strContent']);
                        Template::load ('blog_search_piping');
                        $this->main->js_pipe->flush ();
                }
                
                Template::load ('blog_search_piped');
        }
}
?>