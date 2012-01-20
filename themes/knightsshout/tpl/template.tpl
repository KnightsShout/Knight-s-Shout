<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
                <title><?php __(Template::$title); ?></title>
                <!--[if IE]>
                        <script type="text/javascript">
                        /**
                         * IE does only cause problems, hence we'll kick it out.
                         */
                        window.location = '/ie';
                        </script>
                <![endif]-->
                <link rel="icon" href="<?php t(); ?>img/favicon.png" type="image/png" />
                <link type="text/css" rel="stylesheet" href="<?php t(); ?>css/style.css" />
                <link type="text/css" rel="stylesheet" href="<?php t(); ?>css/style_pp.css" />
                <link type="text/css" rel="stylesheet" href="<?php t(); ?>css/tipsy.css" />
                <!--
                <script type="text/javascript" src="/js?container=jquery-1.5.2.min,jquery.cycle.all.min,jquery.tipsy,ks-1.0" /></script>
                -->
                <script type="text/javascript" src="<?php t(); ?>js/jquery-1.5.2.min.js"></script>
                <script type="text/javascript" src="<?php t(); ?>js/jquery.cycle.all.min.js"></script>
                <script type="text/javascript" src="<?php t(); ?>js/jquery.tipsy.js"></script>
                <script type="text/javascript" src="<?php t(); ?>js/ks-1.0.js"></script>
                <script type="text/javascript">
                $().ready(function(){
                        KS.lang = {
                                register_server_name: "<?php __('register_server_name'); ?>",
                                register_add_server: "<?php __('register_add_server'); ?>",
                                register_remove_server: "<?php __('register_remove_server'); ?>",
                                register_server_char_name: "<?php __('register_server_char_name'); ?>",
                                register_server_char_nation: "<?php __('register_server_char_nation'); ?>",
                                register_server_char_class: "<?php __('register_server_char_class'); ?>",
                                glob_loading: "<img src='<?php t(); ?>img/ajax-loader.gif' alt='' />&nbsp;<?php __('glob_loading'); ?>",
                                glob_elmo: "<?php __('glob_elmo'); ?>",
                                glob_karus: "<?php __('glob_karus'); ?>",
                                glob_class_warrior: "<?php __('glob_class_warrior'); ?>",
                                glob_class_rogue: "<?php __('glob_class_rogue'); ?>",
                                glob_class_mage: "<?php __('glob_class_mage'); ?>",
                                glob_class_priest: "<?php __('glob_class_priest'); ?>"
                        };
                        KS.logged_in = false;
                        KS.secure_key = "<?php echo KS_SECURE_KEY; ?>";
                        
                        $("#login-callback").hide();
                        $("#formLogin").submit(function(){
                                var strNick = document.getElementById("account-id-l").value;
                                var strPass = document.getElementById("account-pw-l").value;
                                var data = $("#formLogin").serialize();
                                
                                if (strNick.length < 4 || strPass.length < 4)
                                        return false;
                                
                                $("#login-callback").html('&nbsp;&nbsp;<img src="<?php t(); ?>img/ajax-loader-2.gif" alt="" />').show();
                                $("input").attr('disabled', 'true');
                                
                                $.ajax({
                                        url: "/ajax/login",
                                        type: "post",
                                        data: data,
                                        dataType: "json",
                                        success:
                                                function(obj)
                                                {
                                                        if (obj.response == "fail")
                                                        {
                                                                window.location = '/static/login_failure';
                                                        }
                                                        else
                                                        {
                                                                window.location = '/home';
                                                        }
                                                },
                                        failure:
                                                function(error)
                                                {
                                                        alert (error);
                                                },
                                        complete:
                                                function()
                                                {
                                                        $('input').attr('disabled', 'false');
                                                }
                                });
                                
                                return false;
                        });
                        
                        /*
                        var w = intval($("#container").css('height'));
                        var x = intval(KS.browser.height);
                        var y = intval($("#sub").css('height'));
                        var z = intval($("#main").css('height'));
                        if(x > w){
                                var f = (x - (y + z));
                                $("#footer").css({'height': f});
                        }
                        */
                        $("#container-top").css({'width': intval(KS.browser.width)});
                        $(window).resize(function(){
                                $("#container-top").css({'width': intval(KS.browser.width)});
                        });
                });
                </script>
        </head>
        <?php
        /**
         * flush the ob_stream, so that the client will already start loading
         * js and css
         */
        ob_flush ();
        ?>
        <body>
                <noscript>
                        <meta http-equiv="refresh" content="0;url=/static/no_script">
                </noscript>
                <div align="center" id="container">
                        <div id="container-top" align="center">
                                <div id="sub" align="center">
                                        <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                        <td colspan="2" style="height: 53px;"></td>
                                                </tr>
                                                <tr>
                                                        <td style="width: 500px;" align="center">
                                                                <a href="/" title="Knight's Shout Home"><img src="<?php t(); ?>img/font-logo.png" alt="KNIGHT'S SHOUT" /></a>
                                                        </td>
                                                        <td style="width: 500px;" align="center">
                                                                <form action="/login" id="formLogin" name="formLogin" method="post">
                                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                                                <tr>
                                                                                        <td style="width: 130px;" align="left">
                                                                                                <?php __('account_id'); ?><br />
                                                                                                <input type="text" id="account-id-l" name="account-id-l" maxlength="55" /><br />
                                                                                                &nbsp;
                                                                                        </td>
                                                                                        <td style="width: 40px;"></td>
                                                                                        <td style="width: 130px;" align="left">
                                                                                                <?php __('account_pw'); ?><br />
                                                                                                <input type="password" id="account-pw-l" name="account-pw-l" maxlength="35" /><br />
                                                                                                <a href="/forgot_pw" title="Recover lost password!"><i><?php __('account_lost_pw'); ?></i></a>
                                                                                        </td>
                                                                                        <td style="width: 20px;"></td>
                                                                                        <td style="width: 130px;" align="left" valign="middle">
                                                                                                &nbsp;<br />
                                                                                                <input type="submit" value="<?php __('account_login'); ?>" class="button-special" /><span id="login-callback"></span><br />
                                                                                                &nbsp;
                                                                                        </td>
                                                                                </tr>
                                                                        </table>
                                                                </form>
                                                        </td>
                                                </tr>
                                        </table>
                                </div>
                                <div id="main" align="center" valign="top">
                                        <?php $main->template->page->doInitPage($main); ?>
                                        <div style="height: 5px;"></div>
                                </div>
                                <div id="footer" align="center">
                                        <div id="footer-sub" align="center">
                                                <i><a href="javascript:;" id="lang"><?php @__('footer_select_language', array ((string) $main->template->langs[$_SESSION['strLang']])); ?></a></i><br />
                                                <script type="text/javascript">
                                                $().ready(function(){
                                                        $("#lang").click(function(){
                                                                var attr = new Array(0, null, '/ajax/translate?overview=1', null);
                                                                KS.doPopup(attr);
                                                        });
                                                });
                                                </script>
                                                <b>Knight's Shout</b> &copy; <?php echo date("o"); ?> - <?php __('home_all_rights'); ?> &mdash; <?php __('home_developed_by'); ?><br />
                                                <a href="/">Index</a> &mdash; <a href="/blog">Blog</a>
                                        </div>
                                </div>
                                <script type="text/javascript">
                                $().ready(function(){
                                        /*var ch = intval($("#container-top").css('height')) + intval($("#main").css('height')) + intval($("#footer").css('height'));*/
                                        /*var ch = $('#container-top').height();
                                        var h = intval(KS.browser.height) - ch;
                                        if (h > 0)
                                        {
                                                $("#footer").css({'height': h, 'background': '#181515'});
                                        }
                                        else
                                        {
                                                $("#footer").css('background', '#181515');
                                        }*/
                                        $('body').css({'background': '#181515'});
                                });
                                </script>
                        </div>
                </div>
                <?php
                /**
                 * flush the ob_stream, so that the client will already start loading
                 */
                ob_flush ();
                $main->js_pipe->JsPipeRTInit ();
                ?>
        </body>
</html>
<?php
ob_end_flush ();
?>