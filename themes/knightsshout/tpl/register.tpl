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
<div style="width:1000px;" align="center">
<script type="text/javascript">
var nID = 0;function doAddServer(){if (nID >= 5)return KS.doError ('.reg-callback', "<?php __('register_servers_limit_reached'); ?>");nID++;$("#reg-servers").append('<div id="reg-server-' + nID + '" class="reg-server-single-section">' +' <table cellpadding="0" cellspacing="0" align="left" class="reg-server-single">' +' <tr>' +' <td colspan="4" style="height: 4px;"></td>' +' </tr>' +' <tr>' +' <td style="width: 150px;"><h3><b>' + KS.lang.register_server_name + '</b></h3></td>' +' <td style="width: 250px;"><input type="text" id="server-' + nID + '-name" name="account-servers[' + nID + '][0]" maxlength="21" /></td>' +' <td style="width: 150px;"><h3><b>' + KS.lang.register_server_char_nation + '</b></h3></td>' +' <td style="width: 250px;">' +' <select id="server-' + nID + '-nation" name="account-servers[' + nID + '][2]">' +' <option value="1">' + KS.lang.glob_karus + '</option>' +' <option value="2">' + KS.lang.glob_elmo + '</option>' +' </select>' +' </td>' +' </tr>' +' <tr>' +' <td style="width: 150px;"><h3><b>' + KS.lang.register_server_char_name + '</b></h3></td>' +' <td style="width: 250px;"><input type="text" id="server-' + nID + '-char" name="account-servers[' + nID + '][1]" maxlength="35" /></td>' +' <td style="width: 150px;"><h3><b>' + KS.lang.register_server_char_class + '</b></h3></td>' +' <td style="width: 250px;">' +' <select id="server-' + nID + '-class" name="account-servers[' + nID + '][3]">' +' <option value="1">' + KS.lang.glob_class_warrior + '</option>' +' <option value="2">' + KS.lang.glob_class_rogue + '</option>' +' <option value="3">' + KS.lang.glob_class_mage + '</option>' +' <option value="4">' + KS.lang.glob_class_priest + '</option>' +' </select>' +' </td>' +' </tr>' +' </table>' +' <div class="spacer"></div>' +'</div>');}function doRemoveServer(){$("#reg-server-" + nID).remove();$(".reg-callback").html('').fadeOut(100).removeClass('error');nID--;if (nID == 0){$("#reg-servers").slideToggle(300).html('').hide();document.getElementById("account-active").checked = false;}}function doProcessValidate(){$(".reg-callback").html('').fadeOut(100).removeClass('error');$("#no2").animate({'margin-left': '-890px'}, 300, function(){ $(this).hide().css({'visibility': 'hidden'}); });$("#no3").delay(300).css({'margin-left': '890px', 'display': 'block', 'width': '890px', 'visibility': 'hidden'}).show(50).css({'visibility': 'visible'}).animate({'margin-left': '0px'}, 300);KS.doLoad('.reg-callback');data = $("#formReg").serialize();$.ajax({url: "/ajax/register/snd_mail",type: "post",data: data,dataType: "json",success:function(obj){if (obj.response == "valid"){$("#final-callback").slideToggle(100);KS.doSuccess ('.reg-callback', "<?php __('register_email_sent'); ?>");}},failure:function(error){return KS.doError ('.reg-callback', error);}});}$().ready(function(){/*$('#no1').slideDown(300);*/$("#reg-button-step1").click(function(){var strNick = document.getElementById("account-id").value;var strPasswd = document.getElementById("account-pw").value;var strPasswdc = document.getElementById("account-pw-c").value;var strEMail = document.getElementById("account-em").value;var strEMailc = document.getElementById("account-em-c").value;var strSecretA = document.getElementById("account-secret-a").value;if (strNick.length < 4)return KS.doError ('.reg-callback', "<?php __('register_nick_too_short'); ?>");if (!strNick.match (/^[a-zA-Z0-9\-_:\.]+$/))return KS.doError ('.reg-callback', "<?php __('register_nick_invalid'); ?>");if (strPasswd.length < 4)return KS.doError ('.reg-callback', "<?php __('register_pass_too_short'); ?>");if (!strPasswd.match (/^[a-zA-Z0-9]+$/))return KS.doError ('.reg-callback', "<?php __('register_pass_invalid'); ?>");if (strPasswd !== strPasswdc)return KS.doError ('.reg-callback', "<?php __('register_pass_mismatch'); ?>");if (!strEMail.match (/^([a-z0-9])(([-a-z0-9._])*([a-z0-9]))*\@([a-z0-9])(([a-z0-9-])*([a-z0-9]))+(\.([a-z0-9])([-a-z0-9_-])?([a-z0-9])+)+$/i))return KS.doError ('.reg-callback', "<?php __('register_email_invalid'); ?>");if (strEMail !== strEMailc)return KS.doError ('.reg-callback', "<?php __('register_email_mismatch'); ?>");if (strSecretA.length < 4)return KS.doError ('.reg-callback', "<?php __('register_secret_too_short'); ?>");if (!strSecretA.match (/^[a-zA-Z0-9]+$/))return KS.doError ('.reg-callback', "<?php __('register_secret_invalid'); ?>");KS.doLoad('.reg-callback');$.ajax({url: "/ajax/register/chk_usr_mail",type: "post",data: "account=" + strNick + "&email=" + strEMail,dataType: "json",success:function(obj){/** * obj comes as json object already due to dataType: "json" * hence no need to call $.parseJSON on it. */if (obj.response == "error_1")return KS.doError('.reg-callback', "<?php __('register_nick_in_use'); ?>");if (obj.response == "error_2")return KS.doError('.reg-callback', "<?php __('register_email_in_use'); ?>");else{$(".reg-callback").html('').fadeOut(100).removeClass('error').removeClass('loading');$("#no1").animate({'margin-left': '-890px'}, 300, function(){ $(this).hide().css({'visibility': 'hidden'}); });$("#no2").delay(300).css({'margin-left': '890px', 'display': 'block', 'width': '890px', 'visibility': 'hidden'}).show(50).css({'visibility': 'visible'}).animate({'margin-left': '0px'}, 300);}},failure:function(error){KS.doError('.reg-callback', error);}});});$("#account-active").click(function(){var bPlaying = document.getElementById("account-active").checked;if (bPlaying){$("#reg-servers").append('<div align="left">' +' <a href="javascript:doAddServer();"><i><b>+' + KS.lang.register_add_server + '</b></i></a>&nbsp; / &nbsp;<a href="javascript:doRemoveServer();"><i><b>-' + KS.lang.register_remove_server + '</b></i></a>' +' <div style="height: 4px;"></div>' +'</div>').show();doAddServer ();}else{$("#reg-servers").slideToggle(300).html('').hide();nID = 0;}});$("#reg-button-step2").click(function(){var servobj = null;var servers = {"s1": null,"s2": null,"s3": null,"s4": null,"s5": null};for (var i = 1; i <= 5; i++){servobj = document.getElementById('reg-server-' + i);if (servobj !== null){server = {"name": document.getElementById('server-' + i + '-name').value,"char": document.getElementById('server-' + i + '-char').value,"nation": document.getElementById('server-' + i + '-nation').value,"class": document.getElementById('server-' + i + '-class').value};if (server.name.length < 4){servers = {"s1": null,"s2": null,"s3": null,"s4": null,"s5": null};return KS.doError ('.reg-callback', "<?php __('register_server_name_too_short'); ?>");}if (server.char.length < 1){servers = {"s1": null,"s2": null,"s3": null,"s4": null,"s5": null};return KS.doError ('.reg-callback', "<?php __('register_server_char_too_short'); ?>");}if (!server.name.match(/^[a-zA-Z0-9\-_]+$/)){servers = {"s1": null,"s2": null,"s3": null,"s4": null,"s5": null};return KS.doError ('.reg-callback', "<?php __('register_server_name_invalid'); ?>");}if (!server.char.match(/^[a-zA-Z0-9\-_:\.=;]+$/)){servers = {"s1": null,"s2": null,"s3": null,"s4": null,"s5": null};return KS.doError ('.reg-callback', "<?php __('register_server_char_invalid'); ?>");}switch (i){case 1:servers.s1 = server;break;case 2:servers.s2 = server;break;case 3:servers.s3 = server;break;case 4:servers.s4 = server;break;case 5:servers.s5 = server;break;}}}if (servers.s1 !== null){var nick = document.getElementById("account-id").value;var servers_json = "";var server_json = null;for (var n = 1; n <= 5; n++){switch (n){case 1:server_json = servers.s1;break;case 2:server_json = servers.s2;break;case 3:server_json = servers.s3;break;case 4:server_json = servers.s4;break;case 5:server_json = servers.s5;break;}if (server_json !== null){servers_json+= "&s" + n + "_name=" + server_json.name + "&s" + n + "_char=" + server_json.char + "&s" + n + "_nation=" + server_json.nation + "&s" + n + "_class=" + server_json.class;}}KS.doLoad('.reg-callback');$.ajax({url: "/ajax/register/chk_usr_serv",type: "post",data: "account=none" + servers_json,dataType: "json",success:function(obj){if (obj.prstate == "invalid")return KS.doError ('.reg-callback', obj.error_msg);doProcessValidate();},failure:function(error){return KS.doError ('.reg-callback', error);}});}else{doProcessValidate();}});});
</script>
<div id="container-registration" align="center">
        <div style="width: 1000px;" align="center">
                <div class="spacer"></div>
                <table cellpadding="0" cellspacing="0" align="center">
                        <tr>
                                <td style="width: 55px;"></td>
                                <td align="center" style="width: 890px;"><h1><?php __('register_welcome'); ?></h1></td>
                                <td style="width: 55px;"></td>
                        </tr>
                        <tr>
                                <td></td>
                                <td align="center">
                                        <form action="/register" id="formReg" name="formReg" method="post">
                                                <input type="hidden" name="bProcess" value="1" />
                                                <div id="registration-steps">
                                                        <div id="no1" class="registration-step" style="display: block; visibility: visible;">
                                                                <table cellpadding="0" cellspacing="0" align="center">
                                                                        <tr>
                                                                                <td style="width: 220px;"></td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no1" class="reg-step-box-highlight" align="center">
                                                                                                <div id="reg-highlight">#1</div>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_1'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no2" class="reg-step-box" align="center">
                                                                                                <h1>#2</h1>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_2'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no3" class="reg-step-box" align="center">
                                                                                                <h1>#3</h1>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_3'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 220px;"></td>
                                                                        </tr>
                                                                </table>
                                                                <div class="spacer"></div>
                                                                <div class="reg-callback"></div>
                                                                <div class="spacer"></div>
                                                                <table cellpadding="0" cellspacing="0" align="center" class="reg-table">
                                                                        <tr>
                                                                                <td style="width: 45px;"></td>
                                                                                <td style="width: 150px;"><h2><b><?php __('account_nick'); ?></b></h2></td>
                                                                                <td style="width: 250px;"><input type="text" id="account-id" name="account-id" maxlength="21" /></td>
                                                                                <td style="width: 150px;"></td>
                                                                                <td style="width: 250px;"></td>
                                                                                <td style="width: 45px;"></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td></td>
                                                                                <td><h2><b><?php __('account_pw'); ?></b></h2></td>
                                                                                <td><input type="password" id="account-pw" name="account-pw" maxlength="35" /></td>
                                                                                <td><h2><b><?php __('account_pw_c'); ?></b></h2></td>
                                                                                <td><input type="password" id="account-pw-c" name="account-pw-c" maxlength="35" /></td>
                                                                                <td></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td></td>
                                                                                <td><h2><b><?php __('account_em'); ?></b></h2></td>
                                                                                <td><input type="text" id="account-em" name="account-em" maxlength="55" /></td>
                                                                                <td><h2><b><?php __('account_em_c'); ?></b></h2></td>
                                                                                <td><input type="text" id="account-em-c" name="account-em-c" maxlength="55" /></td>
                                                                                <td></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td></td>
                                                                                <td><h2><b><?php __('account_secret_q'); ?></b></h2></td>
                                                                                <td>
                                                                                        <select name="account-secret-q">
                                                                                                <option value="1"><?php __('account_secret_q_1'); ?></option>
                                                                                                <option value="2"><?php __('account_secret_q_2'); ?></option>
                                                                                                <option value="3"><?php __('account_secret_q_3'); ?></option>
                                                                                                <option value="4"><?php __('account_secret_q_4'); ?></option>
                                                                                                <option value="5"><?php __('account_secret_q_5'); ?></option>
                                                                                        </select>
                                                                                </td>
                                                                                <td><h2><b><?php __('account_secret_a'); ?></b></h2></td>
                                                                                <td><input type="text" id="account-secret-a" name="account-secret-a" maxlength="55" /></td>
                                                                                <td></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="6" class="spacer"></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="6" align="center">
                                                                                        <a href="javascript:void(0);"><div class="button-special-proceed" style="width: 80px;" id="reg-button-step1"><?php __('glob_proceed'); ?></div></a>
                                                                                </td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="6" style="height: 150px;"></td>
                                                                        </tr>
                                                                </table>
                                                        </div>
                                                        <div id="no2" class="registration-step">
                                                                <table cellpadding="0" cellspacing="0" align="center">
                                                                        <tr>
                                                                                <td style="width: 220px;"></td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no1" class="reg-step-box" align="center">
                                                                                                <h1>#1</h1>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_1'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no2" class="reg-step-box-highlight" align="center">
                                                                                                <div id="reg-highlight">#2</div>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_2'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no3" class="reg-step-box" align="center">
                                                                                                <h1>#3</h1>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_3'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 220px;"></td>
                                                                        </tr>
                                                                </table>
                                                                <div class="spacer"></div>
                                                                <div class="reg-callback"></div>
                                                                <div class="spacer"></div>
                                                                <h2><b><i>All information given here can still be edited after registration!</i></b></h2>
                                                                <table cellpadding="0" cellspacing="0" align="center" class="reg-table">
                                                                        <tr>
                                                                                <td style="width: 45px;"></td>
                                                                                <td style="width: 200px;"><h2><b><?php __('account_fav_class'); ?></b></h2></td>
                                                                                <td style="width: 200px;">
                                                                                        <select name="account-fav-class">
                                                                                                <option value="1"><?php __('glob_class_warrior'); ?></option>
                                                                                                <option value="2"><?php __('glob_class_rogue'); ?></option>
                                                                                                <option value="3"><?php __('glob_class_mage'); ?></option>
                                                                                                <option value="4"><?php __('glob_class_priest'); ?></option>
                                                                                        </select>
                                                                                </td>
                                                                                <td style="width: 200px;"></td>
                                                                                <td style="width: 200px;"></td>
                                                                                <td style="width: 45px;"></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td></td>
                                                                                <td><h2><b><?php __('account_still_active'); ?></b></h2></td>
                                                                                <td><input type="checkbox" id="account-active" name="account-active" /></td>
                                                                                <td colspan="2" align="left">
                                                                                        <i><?php __('account_still_active_expl'); ?></i>
                                                                                </td>
                                                                                <td></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td></td>
                                                                                <td colspan="4" align="center">
                                                                                        <div id="reg-servers"></div>
                                                                                </td>
                                                                                <td></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="6" class="spacer"></td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="6" align="center">
                                                                                        <a href="javascript:void(0);"><div class="button-special-proceed" style="width: 80px;" id="reg-button-step2"><?php __('glob_proceed'); ?></div></a>
                                                                                </td>
                                                                        </tr>
                                                                        <tr>
                                                                                <td colspan="6" style="height: 180px;"></td>
                                                                        </tr>
                                                                </table>
                                                        </div>
                                                        <div id="no3" class="registration-step">
                                                                <table cellpadding="0" cellspacing="0" align="center">
                                                                        <tr>
                                                                                <td style="width: 220px;"></td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no1" class="reg-step-box" align="center">
                                                                                                <h1>#1</h1>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_1'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no2" class="reg-step-box" align="center">
                                                                                                <h1>#2</h1>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_2'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 150px;" align="center">
                                                                                        <div id="reg-step-box-no3" class="reg-step-box-highlight" align="center">
                                                                                                <div id="reg-highlight">#3</div>
                                                                                                <div style="margin-top: -15px;"><?php __('register_step_3'); ?></div>
                                                                                        </div>
                                                                                </td>
                                                                                <td style="width: 220px;"></td>
                                                                        </tr>
                                                                </table>
                                                                <div class="spacer"></div>
                                                                <div class="reg-callback"></div>
                                                                <div class="spacer"></div>
                                                                <div id="final-callback"><h2><b><i><?php __('register_validation_sent'); ?></i></b></h2></div>
                                                                <div style="height: 270px;"></div>
                                                        </div>
                                                </div>
                                        </form>
                                </td>
                                <td></td>
                        </tr>
                </table>
        </div>
</div>
</div>
</div>