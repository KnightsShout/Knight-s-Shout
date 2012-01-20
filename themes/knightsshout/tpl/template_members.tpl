<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
                <title><?php
                if (is_array (Template::$title))
                {
                        __(Template::$title[0], Template::$title[1]);
                }
                else
                {
                        __(Template::$title);
                }
                ?></title>
                <!--[if IE]>
                        <script type="text/javascript">
                        /**
                         * IE does only cause problems, hence we'll kick it out.
                         */
                        window.location = '/ie';
                        </script>
                <![endif]-->
                <link rel="icon" href="<?php t(); ?>img/favicon.png" type="image/png" />
                <link type="text/css" rel="stylesheet" href="<?php t(); ?>css/style_members.css" />
                <link type="text/css" rel="stylesheet" href="<?php t(); ?>css/style_pp.css" />
                <link type="text/css" rel="stylesheet" href="<?php t(); ?>css/tipsy.css" />
                
                <script type="text/javascript" src="<?php t(); ?>js/jquery-1.5.2.min.js"></script>
                <script type="text/javascript" src="<?php t(); ?>js/jquery.cycle.all.min.js"></script>
                <script type="text/javascript" src="<?php t(); ?>js/jquery.tipsy.js"></script>
                <script type="text/javascript" src="<?php t(); ?>js/ks-1.0.js"></script>
                
                <!--<script type="text/javascript" src="/resources/release/js/161220111520.js"></script>-->
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
                        KS.logged_in = true;
                        KS.secure_key = "<?php echo KS_SECURE_KEY; ?>";
                });
                
                <?php
                if (LOGGED_IN)
                {
                ?>$().ready(function(){
                        ks_comet.watch('/ajax/get_updates?r=<?php echo url_continue (); ?>', 'get', null, 'pUpdate', 1500);
                });
                <?php
                /**
                   * this is deprecated for now.
                   *var pCOMET = new COMET({"isPulled": false, "_url": "/ajax/comet?a=get_updates&t=<?php echo time(); ?>&_comet=1", "_method": "post", "_data": null, "_callback": function(c){}});
                pCOMET.disconnect(true);*/
                /*
                if (!pCOMET.watch())
                {
                        pCOMET.disconnect(true);
                        alert ('[COMET could not be initialized.] Try refreshing the Page.');
                }
                */
                }
                ?>$().ready(function(){
                        ks_url.start();
                        ks_anchors.start();
                });</script>
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
                <div id="container-header" align="center">
                        <div id="header" align="left">
                                <table cellpadding="0" cellspacing="0" align="center">
                                        <tr>
                                                <td width="250px" align="center">
                                                        <div style="height: 5px;"></div>
                                                        <a href="/"><img src="<?php t(); ?>img/font-logo.png" alt="Home" height="36px" width="240px" /></a>
                                                </td>
                                                <?php
                                                if (LOGGED_IN)
                                                {
                                                ?>
                                                <td width="140px" valign="middle" align="center">
                                                        <div style="padding-top: 5px;">
                                                                <a href="/user/<?php echo strtolower ($_SESSION['strAccount']); ?>" class="rollovertipsy" title="<?php __('logged_in_as', array($_SESSION['strAccount'])); ?>"><img src="<?php echo $_SESSION['strAvatar']; ?>" width="15px" height="15px" alt="" style="border: 1px solid #000;" /></a>
                                                                <a href="javascript:;" id="friend-requests-btn" class="rollovertipsy" title="<?php __('tip_friend_requests'); ?>"><img src="<?php t(); ?>img/requests.png" id="friend-requests-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" /></a>
                                                                <a href="/messenger/inbox" id="messages-requests-btn" class="rollovertipsy" title="<?php __('tip_messages'); ?>"><img src="<?php t(); ?>img/messages.png" id="friend-messages-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" /></a>
                                                                <a href="javascript:;" id="note-requests-btn" class="rollovertipsy" title="<?php __('tip_notifications'); ?>"><img src="<?php t(); ?>img/notifications.png" id="note-messages-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" /></a>
                                                                <script type="text/javascript">
                                                                $().ready(function(){
                                                                        $("#friend-requests-btn").click(function(){
                                                                                
                                                                                var attr = new Array(0, null, '/ajax/notifications/friends', null);
                                                                                KS.doPopup(attr);
                                                                                
                                                                                /*
                                                                                Popupify.doPopup({type: Popupify.as_ajax, ajax: {
                                                                                        url: '/ajax/notifications/friends',
                                                                                        success: function(rsp){
                                                                                                Popupify.doPopup({type: Popupify.as_html, html: rsp});
                                                                                        }
                                                                                }});
                                                                                */
                                                                        });
                                                                        $("#note-requests-btn").click(function(){
                                                                                
                                                                                var attr = new Array(0, null, '/ajax/notifications/other', null);
                                                                                KS.doPopup(attr);
                                                                                
                                                                                /*
                                                                                Popupify.doPopup({type: Popupify.as_ajax, ajax: {
                                                                                        url: '/ajax/notifications/other',
                                                                                        success: function(rsp){
                                                                                                Popupify.doPopup({type: Popupify.as_html, html: rsp});
                                                                                        }
                                                                                }});
                                                                                */
                                                                        });
                                                                });
                                                                </script>
                                                        </div>
                                                </td>
                                                <td width="260px" align="center">
                                                        <div style="height: 5px;"></div>
                                                        <form id="formSearch" name="formSearch" method="get" action="/search">
                                                                <input type="text" maxlength="21" id="q" name="q" value="<?php __('search_val'); ?>" onfocus="if(this.value=='<?php __('search_val'); ?>')this.value='';" onblur="if(this.value=='')this.value='<?php __('search_val'); ?>';" autocomplete="off" /><input type="submit" class="search-submit" value="" />
                                                                <div id="search-result"><div id="search-result-cnt"></div><div id="search-result-ldd"><div id="search-result-ld"></div></div></div>
                                                        </form>
                                                        <script type="text/javascript">
                                                        var bShow = false;
                                                        $().ready(function(){
                                                                $("#search-result").hide();
                                                                $("#search-result-ld").hide();
                                                                $("#search-result-ldd").html("<img src='<?php t(); ?>img/ajax-loader-3.gif' alt='' />");
                                                                $("#q").keyup(function(event){
                                                                        bShow = true;
                                                                        var q = document.getElementById("q").value;
                                                                        
                                                                        if (q == '')
                                                                        {
                                                                                $("#search-result").hide();
                                                                                $("#search-result-cnt").html("");
                                                                                bShow = false;
                                                                                return false;
                                                                        }
                                                                        
                                                                        /*
                                                                        if (q.length < 3)
                                                                        {
                                                                                return false;
                                                                        }
                                                                        */
                                                                        
                                                                        var data = $("#formSearch").serialize();
                                                                        $("#search-result-ld").show();
                                                                        $("#search-result").show();
                                                                        
                                                                        $.ajax({
                                                                                url: "/ajax/search",
                                                                                method: "get",
                                                                                data: data,
                                                                                success:
                                                                                        function(rsp)
                                                                                        {
                                                                                                if (bShow)
                                                                                                {
                                                                                                        $("#search-result").show();
                                                                                                        $("#search-result-cnt").html(rsp).fadeIn(300);
                                                                                                }
                                                                                        }
                                                                        });
                                                                });
                                                        });
                                                        $("#formSearch").submit(function(){
                                                                var term = document.getElementById("q").value;
                                                                
                                                                if (!term || term == "" || term == "<?php __('search_val'); ?>")
                                                                {
                                                                        $("#q").focus();
                                                                        return false;
                                                                }
                                                        });
                                                        </script>
                                                </td>
                                                <td width="350px" align="right">
                                                        <span class="tab" id="servers-section">
                                                                <span id="dropdown-servers">
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/ranking" style="font-size: 11px;"><?php __('menu_ranking'); ?></a></div>
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/account/server/create" style="font-size: 11px;"><?php __('menu_servers_create'); ?></a></div>
                                                                </span>
                                                                <a href="javascript:KS.menu.doServers();" id="servers-section-butt"><span id="servers-section-butt-txt"><?php __('menu_servers'); ?></span></a>
                                                        </span>
                                                        <span class="tab" id="account-section">
                                                                <span id="dropdown">
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/user/<?php echo strtolower($_SESSION['strAccount']); ?>" style="font-size: 11px;"><?php __('menu_my_profile'); ?></a></div>
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/account" style="font-size: 11px;"><?php __('menu_edit_profile'); ?></a></div>
                                                                        <?php if (LOGGED_IN === 2) { ?><div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/admin" style="font-size: 11px;"><?php __('menu_administration'); ?></a></div><?php } ?>
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/logout" style="font-size: 11px;"><?php __('menu_logout'); ?></a></div>
                                                                </span>
                                                                <a href="javascript:KS.menu.doAccount();" id="account-section-butt"><span id="account-section-butt-txt"><?php __('menu_account'); ?></span></a>
                                                        </span>
                                                        <span class="tab" id="comm-section">
                                                                <span id="dropdown-comm">
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/blog" style="font-size: 11px;"><?php __('blog_title'); ?></a></div>
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/forum" style="font-size: 11px;"><?php __('menu_forum'); ?></a></div>
                                                                        <div class="section" onmouseover="this.childNodes[0].style.color='#eee';" onmouseout="this.childNodes[0].style.color='#aaa';"><a href="/chat" style="font-size: 11px;"><?php __('menu_chat'); ?></a></div>
                                                                </span>
                                                                <a href="javascript:KS.menu.doCommunity();" id="comm-section-butt"><span id="comm-section-butt-txt"><?php __('menu_community'); ?></span></a>
                                                        </span>
                                                        <script type="text/javascript">
                                                        $().ready(function(){
                                                                /**
                                                                 * template fix
                                                                 */
                                                                var wm = $("#account-section").css('width');
                                                                var wd = $("#dropdown").css('width');
                                                                if (intval (wm) > (intval (wd) - 10))
                                                                        $("#dropdown").css({'width': (intval (wm) + 10)});
                                                                wm = $("#servers-section").css('width');
                                                                wd = $("#dropdown-servers").css('width');
                                                                if (intval (wm) > (intval (wd) - 10))
                                                                        $("#dropdown-servers").css({'width': (intval (wm) + 10)});
                                                                wm = $("#comm-section").css('width');
                                                                wd = $("#dropdown-comm").css('width');
                                                                if (intval (wm) > (intval (wd) - 10))
                                                                        $("#dropdown-comm").css({'width': (intval (wm) + 10)});
                                                                
                                                        });
                                                        </script>
                                                </td>
                                                <?php
                                                }
                                                else
                                                {
                                                ?>
                                                <script type="text/javascript">
                                                $().ready(function(){
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
                                                                                                window.location = window.location;
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
                                                });
                                                </script>
                                                <td width="700px" align="center">
                                                        <div align="right" style="padding-right: 9px;">
                                                                <form action="/login" id="formLogin" name="formLogin" method="post">
                                                                        <?php __('glob_not_signed_in'); ?>&nbsp;&nbsp;&nbsp;
                                                                        <span id="login-callback"></span>
                                                                        <input type="text" id="account-id-l" name="account-id-l" value="<?php __('account_id'); ?>" onfocus="if(this.value=='<?php __('account_id'); ?>'){this.value='';}" onblur="if(this.value==''){this.value='<?php __('account_id'); ?>';}" maxlength="55" />
                                                                        <input type="password" id="account-pw-l" name="account-pw-l" value="<?php __('account_pw'); ?>" onfocus="if(this.value=='<?php __('account_pw'); ?>'){this.value='';}" onblur="if(this.value==''){this.value='<?php __('account_pw'); ?>';}" maxlength="35" />
                                                                        <input type="submit" value="<?php __('account_login'); ?>" class="button-special" style="width: auto; padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; font-weight: bold; background: #1b0000; border: 1px solid #2b0101; color: #ccc;" />
                                                                </form>
                                                        </div>
                                                </td>
                                                <?php
                                                }
                                                ?>
                                        </tr>
                                </table>
                        </div>
                </div>
                <div id="header-spacer"></div>
                <div align="center">
                        <div id="container-main" align="left">
                                <div style="height: 2px;"></div>
                                <div style="padding-left: 2px; padding-right: 6px; width: 992px;">
                                        <?php $main->template->page->doInitPage($main); ?>
                                </div>
                        </div>
                </div>
                <div align="center">
                        <div id="footer" align="center">
                                <div id="fcat" align="center">
                                        <div id="footer-sub" align="left">
                                                <i><a href="javascript:;" id="lang"><?php @__('footer_select_language', array ((string) $main->template->langs[$_SESSION['strLang']])); ?></a></i><br />
                                                <script type="text/javascript">
                                                $().ready(function(){
                                                        $("#lang").click(function(){
                                                                
                                                                var attr = new Array(0, null, '/ajax/translate?overview=1', null);
                                                                KS.doPopup(attr);
                                                                
                                                                /*
                                                                Popupify.doPopup(
                                                                                {
                                                                                        type: Popupify.as_ajax,
                                                                                        ajax: {
                                                                                                url: '/ajax/translate',
                                                                                                method: 'GET',
                                                                                                data: 'overview=1',
                                                                                                dataType: 'html',
                                                                                                success: function(rsp){
                                                                                                        Popupify.doPopup({type: Popupify.as_html, html: rsp});
                                                                                                }
                                                                                        }
                                                                                }
                                                                                );
                                                                */
                                                        });
                                                        $(".rollovertipsy").tipsy({gravity: "n"});
                                                        $(".rollovertipsyx").tipsy({gravity: "e"});
                                                        $(".rollovertipsyz").tipsy({gravity: "s"});
                                                        $(".rollovertipsyy").tipsy({gravity: "w"});
                                                });
                                                </script>
                                                <b>Knight's Shout</b> &copy; <?php echo date("o"); ?> - <?php __('home_all_rights'); ?> &mdash; <?php __('home_developed_by'); ?><br />
                                                <?php __('home_rendering_time', array ((float) round (((rtime() - $main->misc['render']['start_time']) * 1000), 6))); ?>
                                        </div>
                                </div>
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