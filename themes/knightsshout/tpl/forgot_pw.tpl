<script type="text/javascript">
$().ready(function(){
        $("#main").prepend('<div align="center">').append('</div>');
        $("#main").css({'margin-top': '4px'});
        $("#main").css({'width': KS.browser.width});
        $("#main").css({'background': '#fff'});
        $(window).resize(function(){
                $("#main").css({'width': KS.browser.width});
        });
});
</script>
<div align="center">
        <div style="width:1000px;" id="forgot-pw-section" align="left">
                <div align="center">
                        <div class="spacer"></div>
                        <h1><?php __('forgot_pw_header'); ?></h1>
                </div>
                <script type="text/javascript">
                        function submit()
                        {
                                var strNick = document.getElementById("account-id").value;
                                
                                if (strNick.length < 4)
                                        return KS.doError ('#fp-callback', "<?php __('register_nick_too_short'); ?>");
                                if (!strNick.match (/^[a-zA-Z0-9\-_:\.]+$/) && !strNick.match (/^([a-z0-9])(([-a-z0-9._])*([a-z0-9]))*\@([a-z0-9])(([a-z0-9-])*([a-z0-9]))+(\.([a-z0-9])([-a-z0-9_-])?([a-z0-9])+)+$/i))
                                        return KS.doError ('#fp-callback', "<?php __('register_email_invalid'); ?>");
                                
                                var info = $("#fp-form").serialize();
                                KS.doLoad ('#fp-callback');
                                
                                $.ajax({
                                        url: '/ajax/forgot_pw/cast',
                                        type: "post",
                                        data: info,
                                        dataType: "json",
                                        success:
                                                function(rsp)
                                                {
                                                        if (rsp.result == "success")
                                                        {
                                                                $("#fp-button").attr('href', 'javascript:;');
                                                                KS.doSuccess ('#fp-callback', "<?php __('forgot_pw_success'); ?>");
                                                        }
                                                        else if (rsp.result == "captcha")
                                                        {
                                                                KS.doError ('#fp-callback', "<?php __('forgot_pw_captcha'); ?>");
                                                        }
                                                        else if (rsp.result == "email")
                                                        {
                                                                KS.doError ('#fp-callback', "<?php __('forgot_pw_no_id'); ?>");
                                                        }
                                                },
                                        failure:
                                                function(error)
                                                {
                                                        return KS.doError ('#fp-callback', error);
                                                }
                                });
                        }
                </script>
                <form action="/forgot_pw" method="post" id="fp-form">
                        <table cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                        <th width="250px"></th>
                                        <th width="100px"></th>
                                        <th width="650px"></th>
                                </tr>
                                <tr>
                                        <td colspan="3" align="center">
                                                <?php __('forgot_pw_expl'); ?>
                                                <div class="spacer"></div>
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="3" align="center" id="fp-callback" style="display: none;">
                                                
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="3" class="spacer"></td>
                                </tr>
                                <tr>
                                        <td align="center">
                                                <b><?php __('account_em'); ?></b>
                                        </td>
                                        <td align="center">
                                                <input id="account-id" name="account-id" maxlength="55" />
                                        </td>
                                        <td align="center">
                                                <?php
                                                require_once ('./plugins/inc.recaptchalib.php');
                                                echo recaptcha_get_html ($main->conf['reCAPTCHA']['publickey']);
                                                ?>
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="3" align="center">
                                                <div class="spacer"></div>
                                                <a href="javascript:submit();" id="fp-button"><div class="button-special-proceed" style="width: 80px;" id="reg-button-step2"><?php __('glob_proceed'); ?></div></a>
                                        </td>
                                </tr>
                        </table>
                </form>
                <script type="text/javascript">
                /*
                $().ready(function(){
                        $("#fp-form").submit(function(event){
                                event.preventDefault();
                                return false;
                        });
                });*/
                </script>
        </div>
</div>