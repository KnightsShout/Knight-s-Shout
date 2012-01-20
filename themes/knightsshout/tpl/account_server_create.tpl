<script type="text/javascript">
$().ready(function(){
        set_title("<?php __('title_account_server'); ?>");
});
</script>
<div style="width: 992px;" align="center" id="container-srv">
        <table cellpadding="0" cellspacing="0" width="992px" align="center">
                <tr>
                        <td colspan="5" style="height: 10px;"></td>
                </tr>
                <tr>
                        <td></td>
                        <td class="bb"></td>
                        <td class="bb"></td>
                        <td align="left" class="bb" valign="bottom">
                                <h3 class="uc"><?php __('menu_edit_profile'); ?> &rarr; <?php __('title_account_server'); ?> &rarr; <?php __('account_server_signup'); ?></h3>
                        </td>
                        <td></td>
                </tr>
                <tr>
                        <td width="6px"></td>
                        <td width="180px" align="right" valign="top" class="bb menux">
                                <a href="/account/game"><div class="menu-sub stripe-right uc" style="border-top: 2px solid #666;"><?php __('account_game'); ?></div></a>
                                <a href="/account/server"><div class="menu-sub-a stripe-right uc"><?php __('account_server'); ?></div></a>
                                <a href="/account/personality"><div class="menu-sub stripe-right uc"><?php __('account_personality'); ?></div></a>
                                <a href="/account/settings"><div class="menu-sub stripe-right uc" style="border-bottom: 2px solid #666;"><?php __('account_settings'); ?></div></a>
                        </td>
                        <td width="6px" class="bb" style="background: rgb(221,221,221);"></td>
                        <td width="794px" align="left" valign="top" class="bb ksfancyfont account-content">
                                <?php
                                if (Account::$count == 0)
                                {
                                        ?>
                                        <div class="account-header uc">
                                                <?php __('account_server_why'); ?>
                                        </div>
                                        <?php __('account_server_why_expl'); ?><br /><br />
                                        <div class="account-header uc">
                                                <?php __('account_server_signup'); ?>
                                        </div>
                                        <form action="/account/server/create?try=1" id="frmCreateServer" method="post">
                                                <table cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                                <td width="350px" align="left" valign="top">
                                                                        <table cellpadding="0" cellspacing="0" align="left">
                                                                                <tr>
                                                                                        <td width="175px" align="left">
                                                                                                <div class="uc account-h-cr"><?php __('account_server_name'); ?></div>
                                                                                        </td>
                                                                                        <td width="175px" align="right" class="inpt-sp">
                                                                                                <input type="text" id="server_strName" name="strName" maxlength="20" />
                                                                                        </td>
                                                                                </tr>
                                                                        </table>
                                                                        <div class="account-desc-cr"><?php __('account_server_name_expl'); ?></div>
                                                                </td>
                                                                <td width="10px" align="center" valign="top">
                                                                        
                                                                </td>
                                                                <td width="390px" align="left" valign="top" id="status_strName">
                                                                        
                                                                </td>
                                                        </tr>
                                                        <tr>
                                                                <td width="350px" align="left" valign="top">
                                                                        <table cellpadding="0" cellspacing="0" align="left">
                                                                                <tr>
                                                                                        <td width="175px" align="left">
                                                                                                <div class="uc account-h-cr"><?php __('account_server_aliases'); ?></div>
                                                                                        </td>
                                                                                        <td width="175px" align="right" class="inpt-sp">
                                                                                                <input type="text" id="server_tAliases" name="tAliases" maxlength="83" />
                                                                                        </td>
                                                                                </tr>
                                                                        </table>
                                                                        <div class="account-desc-cr"><?php __('account_server_aliases_expl'); ?></div>
                                                                </td>
                                                                <td width="10px" align="center" valign="top">
                                                                        
                                                                </td>
                                                                <td width="390px" align="center" valign="top" id="status_tAliases">
                                                                        
                                                                </td>
                                                        </tr>
                                                        <tr>
                                                                <td width="350px" align="left" valign="top">
                                                                        <table cellpadding="0" cellspacing="0" align="left">
                                                                                <tr>
                                                                                        <td width="175px" align="left">
                                                                                                <div class="uc account-h-cr"><?php __('account_server_phase'); ?></div>
                                                                                        </td>
                                                                                        <td width="175px" align="right" class="inpt-sp">
                                                                                                <select name="nType" id="server_nType">
                                                                                                        <option value="1" selected="selected">BETA</option>
                                                                                                        <option value="2">Official</option>
                                                                                                </select>
                                                                                        </td>
                                                                                </tr>
                                                                        </table>
                                                                        <div class="account-desc-cr"><?php __('account_server_phase_expl'); ?></div>
                                                                </td>
                                                                <td width="10px" align="center" valign="top">
                                                                        
                                                                </td>
                                                                <td width="390px" align="left" valign="top">
                                                                        
                                                                </td>
                                                        </tr>
                                                        <tr>
                                                                <td width="350px" align="left" valign="top">
                                                                        <table cellpadding="0" cellspacing="0" align="left">
                                                                                <tr>
                                                                                        <td width="175px" align="left">
                                                                                                <div class="uc account-h-cr"><?php __('account_server_desc'); ?></div>
                                                                                        </td>
                                                                                        <td width="175px" align="right" class="inpt-sp">
                                                                                                <input type="text" maxlength="250" id="server_strDesc" name="strDesc" />
                                                                                        </td>
                                                                                </tr>
                                                                        </table>
                                                                        <div class="account-desc-cr"><?php __('account_server_desc_expl'); ?></div>
                                                                </td>
                                                                <td width="10px" align="center" valign="top">
                                                                        
                                                                </td>
                                                                <td width="390px" align="left" valign="top" id="status_strDesc">
                                                                        
                                                                </td>
                                                        </tr>
                                                        <tr>
                                                                <td width="350px" align="left" valign="top">
                                                                        <table cellpadding="0" cellspacing="0" align="left">
                                                                                <tr>
                                                                                        <td width="175px" align="left">
                                                                                                <div class="uc account-h-cr"><?php __('account_server_keywords'); ?></div>
                                                                                        </td>
                                                                                        <td width="175px" align="right" class="inpt-sp">
                                                                                                <input type="text" maxlength="50" id="server_strKeywords" name="tKeywords" />
                                                                                        </td>
                                                                                </tr>
                                                                        </table>
                                                                        <div class="account-desc-cr"><?php __('account_server_keywords_expl'); ?></div>
                                                                </td>
                                                                <td width="10px" align="center" valign="top">
                                                                        
                                                                </td>
                                                                <td width="390px" align="left" valign="top" id="status_strKeywords">
                                                                        
                                                                </td>
                                                        </tr>
                                                        <tr>
                                                                <td colspan="3" align="center">
                                                                        <div style="height: 15px;"></div>
                                                                        <a href="javascript:;" id="button-reg-go"><div class="ksbutton btn-maxed-b"><?php __('account_server_signup'); ?></div></a>
                                                                </td>
                                                        </tr>
                                                </table>
                                                <script type="text/javascript">
                                                $().ready(function(){
                                                        var bIn = false;
                                                        
                                                        function sendSrvRqst()
                                                        {
                                                                var bValid = true;
                                                                var strName = document.getElementById("server_strName").value;
                                                                var tAliases = document.getElementById("server_tAliases").value;
                                                                var nType = document.getElementById("server_nType").value;
                                                                var strDesc = document.getElementById("server_strDesc").value;
                                                                var strKeywords = document.getElementById("server_strKeywords").value;
                                                                
                                                                $("#status_strName").hide();
                                                                $("#status_tAliases").hide();
                                                                $("#status_strDesc").hide();
                                                                $("#status_strKeywords").hide();
                                                                
                                                                if (strName.length < 3)
                                                                {
                                                                        KS.doError("#status_strName", "<?php __('account_server_create_error_1'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                if (!strName.match(/^[a-zA-Z0-9\-_:\.]+$/))
                                                                {
                                                                        KS.doError("#status_strName", "<?php __('account_server_create_error_2'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                if (tAliases.split(',').length < 1 || tAliases.length < 1)
                                                                {
                                                                        KS.doError("#status_tAliases", "<?php __('account_server_create_error_3'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                if (tAliases.split(',').length > 4)
                                                                {
                                                                        KS.doError("#status_tAliases", "<?php __('account_server_create_error_4'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                if (strDesc.split(' ').length < 2 && strDesc.length < 10)
                                                                {
                                                                        KS.doError("#status_strDesc", "<?php __('account_server_create_error_5'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                if (strKeywords.split(',').length < 1 || strKeywords.length < 1)
                                                                {
                                                                        KS.doError("#status_strKeywords", "<?php __('account_server_create_error_6'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                if (strKeywords.split(',').length > 5)
                                                                {
                                                                        KS.doError("#status_strKeywords", "<?php __('account_server_create_error_7'); ?>");
                                                                        bValid = false;
                                                                        return;
                                                                }
                                                                
                                                                if (bValid)
                                                                {
                                                                        $("#status_strName").hide();
                                                                        $("#status_tAliases").hide();
                                                                        $("#status_strDesc").hide();
                                                                        $("#status_strKeywords").hide();
                                                                        
                                                                        KS.doLoad("#status_strName");
                                                                        KS.doLoad("#status_tAliases");
                                                                        bIn = true;
                                                                        data = $("#frmCreateServer").serialize();
                                                                        KS.disableInput();
                                                                        /*data = "strName=" + strName + "&tAliases=" + tAliases + "&nType=" + nType + "&strDesc=" + strDesc + "&tKeywords=" + strKeywords;*/
                                                                        /*alert(data);*/
                                                                        
                                                                        $.ajax({
                                                                                url: "/ajax/account/server/create/process",/*?strName=" + strName + "&tAliases=" + tAliases + "&nType=" + nType + "&strDesc=" + strDesc + "&tKeywords=" + strKeywords,*/
                                                                                method: "get",
                                                                                data: data,
                                                                                dataType: "json",
                                                                                success: function(response){
                                                                                        $("#status_strName").hide();
                                                                                        $("#status_tAliases").hide();
                                                                                        
                                                                                        /*alert(response.status);*/
                                                                                        
                                                                                        if (response.status == true)
                                                                                        {
                                                                                                $("#container-srv").fadeOut(300);
                                                                                                var attr = new Array(0, null, '/ajax/static/server_created', null);
                                                                                                KS.doPopup(attr);
                                                                                        }
                                                                                        else if (response.nameInUse == true)
                                                                                        {
                                                                                                KS.doError("#status_strName", "<?php __('account_server_create_error_8'); ?>");
                                                                                        }
                                                                                        else if (response.tagInUse == true)
                                                                                        {
                                                                                                KS.doError("#status_tAliases", "'" + response.tag + "': <?php __('account_server_create_error_9'); ?>");
                                                                                        }
                                                                                },
                                                                                complete: function(){
                                                                                        /*alert('k');*/
                                                                                        bIn = false;
                                                                                        KS.enableInput();
                                                                                }
                                                                        });
                                                                }
                                                        }
                                                        
                                                        $("#button-reg-go").click(function(){
                                                                sendSrvRqst();
                                                        });
                                                });
                                                </script>
                                        </form>
                                        <?php
                                }
                                else
                                {
                                        ?>
                                        <div id="ks-s-err"></div>
                                        <script type="text/javascript">
                                        KS.doError("#ks-s-err", "<?php __('account_server_create_cannot'); ?>");
                                        </script>
                                        <?php
                                }
                                ?>
                        </td>
                        <td width="6px"></td>
                </tr>
        </table>
</div>