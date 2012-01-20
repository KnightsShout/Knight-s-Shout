<?php
/**
 * (C)KNIGHT'S SHOUT
 * ---
 * @version 1.0
 * @author Fabian Schneider <Fabi.Schn@googlemail.com>
 * ---
 * @todo Set the error_reporting to 0 as soon as we go officially live.
 */

function compress ($buffer)
{
	return preg_replace('#(?ix)(?>[^\S ]\s*|\s{2,})(?=(?:(?:[^<]++|<(?!/?(?:textarea|pre)\b))*+)(?:<(?>textarea|pre)\b|\z))#', ' ', $buffer);
}

if (ob_get_level () == 0)
	ob_start ('compress');

/**
 * E_ALL ^ E_NOTICE for production
 * 0 for official use
 */
error_reporting (E_ALL ^ E_NOTICE);

define ('KS_VALID_KEY', 'shared_version_on_snoxd');

class Main
{
	public $session;
	public $database;
	public $template;
	public $rewrite;
	public $js_pipe;
	public $feeds;
	public $conf;
	public $misc = array ();
	private $isSecure = false;
	
	function Main () { }
	
	function __init ()
	{
		require_once ('./api/inc.functions.php');
		$this->misc['render']['start_time'] = rtime ();
		
		require_once ('./conf/inc.main.php');
		$this->conf = $conf;
		$this->uri_patterns = $conf['mod_rewrite'];
		
		require_once ('./api/inc.session.php');
		$this->session = new Session ();
		$this->session->doInit ();
		define ('LOGGED_IN', $this->session->status);
		
		require_once ('./api/inc.def.php');
		require_once ('./api/inc.database.php');
		$this->database = new Database ();
		
		require_once ('./api/inc.mod_rewrite.php');
		$this->rewrite = new Rewrite ($this->conf);
		
		require_once ('./api/inc.js_pipe.php');
		$this->js_pipe = new JsPipe ($this);
		
		require_once ('./api/inc.feeds.php');
		$this->feeds = new Feeds ($this);
		
		if (!@isset ($_SESSION['ks_secure_key']))
		{
			$this->setSecureKey ();
		}
		else
		{
			define ('KS_SECURE_KEY', $_SESSION['ks_secure_key']);
		}
		$this->test ();
		
		require_once ('./api/inc.notifications.php');
		$this->notifications = new Notifications ($this);
		
		
		require_once ('./api/inc.template.php');
		$this->template = new Template ($this);
		
		
		$this->template->doStartOutput ($this);
	}
	
	public function setSecureKey ()
	{
		unset ($_SESSION['ks_secure_key']);
		$_SESSION['ks_secure_key'] = doMkRString (32);
	}
	
	private function test ()
	{
		if (@isset ($_POST['ks_secure_key']) || @isset ($_GET['ks_secure_key']))
		{
			$key = 0;
			
			if (@isset ($_POST['ks_secure_key']))
			{
				$key = $_POST['ks_secure_key'];
			}
			else
			{
				$key = $_GET['ks_secure_key'];
			}
			
			if ($key != $_SESSION['ks_secure_key'] && $key !== null)
			{
				$this->isSecure = false;
				header ('Location: /s/secure_key?_re=invalid_secure_key');
				exit;
			}
			
			$this->isSecure = true;
		}
		else
		{
			$this->isSecure = false;
		}
	}
	
	public function testSecureKey ($key)
	{
		return $_SESSION['ks_secure_key'] == $key;
	}
	
	public function isSecure ()
	{
		return $this->isSecure;
	}
	
	public function isHttpSecure ()
	{
		return $_SERVER['HTTPS'] == 'on';
	}
	
	public function goHttpSecure ()
	{
		if (ob_get_level () == 0)
		{
			$_SERVER['HTTPS'] = 'on';
			header ('Location: ' . url_continue ());
			exit;
		}
		else
		{
			return 0;
		}
	}
	
	static function get ()
	{
		return $this;
	}
}

$main = new Main ();
$main->__init ();
?>