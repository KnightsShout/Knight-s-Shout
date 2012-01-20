<script type="text/javascript">
$().ready(function(){
        $("#main").prepend('<div align="center">').append('</div>');
        $("#main").css({'margin-top': '4px'});
        $("#main").css({'width': KS.browser.width});
        $("#main").css({'background-image': 'url(<?php t(); ?>img/background-large.png)', 'background-position': 'top center', 'background-repeat': 'no-repeat', 'background-color': '#fff'});
        $(window).resize(function(){
                $("#main").css({'width': KS.browser.width});
        });
});
</script>
<div align="center">
<div style="width:1000px;" align="center">
        <div class="spacer"></div>
                                        <table cellpadding="0" cellspacing="0" align="center" valign="top">
                                                <tr>
                                                        <div style="position: absolute; margin-top: 275px; margin-left: 175px;">
                                                                <a href="/register" title="Sign Up today!"><img src="<?php t(); ?>img/button-signup.png" width="160px" alt="" /></a>
                                                        </div>
                                                        <td style="width: 1000px; height: 492px;" align="center" valign="top">
                                                                <table cellpadding="0" cellspacing="0" align="center" style="width: 1000px; height: 492px;">
                                                                        <tr>
                                                                                <th width="650px">
                                                                                        
                                                                                </th>
                                                                                <td width="350px">
                                                                                        
                                                                                </th>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="2" align="center" id="welcome">
                                                                                        <h1><?php __('home_welcome'); ?></h1>
                                                                                </td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td width="650px" align="left" valign="top">
                                                                                        <h2>&nbsp;<?php __('home_intro_1'); ?></h2>
                                                                                </td>
                                                                                <td width="350px" align="left" valign="bottom">
                                                                                        <div class="spacer"></div>
                                                                                        <div class="spacer"></div>
                                                                                        <div class="spacer"></div>
                                                                                        <h2>&nbsp;&nbsp;<?php __('home_intro_2'); ?></h2>
                                                                                </td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td width="650px" align="center" valign="middle">
                                                                                        <div class="spacer"></div>
                                                                                        <div class="spacer"></div>
                                                                                </td>
                                                                                <td width="350px" align="center" valign="bottom">
                                                                                        <a href="<?php echo getTwtr(); ?>" target="_blank"><img src="<?php t(); ?>img/btn_twitter.png" alt="KNIGHT'S SHOUT ON TWITTER" /></a>&nbsp;<a href="<?php echo getFB(); ?>" target="_blank"><img src="<?php t(); ?>img/btn_facebook.png" alt="KNIGHT'S SHOUT ON FACEBOOK" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                        <div class="spacer"></div>
                                                                                        <div class="spacer"></div>
                                                                                        <div class="spacer"></div>
                                                                                </td>
                                                                        </tr>
                                                                </table>
                                                                <!--<img src="<?php t(); ?>img/logo-1.jpg" alt="KNIGHT'S SHOUT" />-->
                                                        </td>
                                                </tr>
                                        </table>
        </div>
</div>