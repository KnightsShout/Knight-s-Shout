<?php
global $main;
if (Account::$count == 1)
{
        $s = $main->database->doRead ();
}
?>
<script type="text/javascript">
$().ready(function(){
        set_title("<?php __('title_account_server'); ?>");
});
</script>
<div style="width: 992px;" align="center">
        <table cellpadding="0" cellspacing="0" width="992px" align="center">
                <tr>
                        <td colspan="5" style="height: 10px;"></td>
                </tr>
                <tr>
                        <td></td>
                        <td class="bb"></td>
                        <td class="bb"></td>
                        <td align="left" class="bb" valign="bottom">
                                <h3 class="uc"><?php __('menu_edit_profile'); ?> &rarr; <?php if (Account::$count == 1) { echo $s['tName']; } else { __('title_account_server'); } ?></h3>
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
                                                <?php __('account_server_intro'); ?>
                                        </div>
                                        <?php __('account_server_intro_expl'); ?><br /><br /><br /><br />
                                        <div align="center">
                                                <a href="/account/server/create"><div class="ksbutton btn-maxed-b" align="center"><?php __('account_server_register'); ?></div></a><br /><br />
                                        </div>
                                        <br />
                                        <div class="account-header uc">
                                                <?php __('account_server_why'); ?>
                                        </div>
                                        <?php __('account_server_why_expl'); ?>
                                        <?php
                                }
                                else
                                {
                                        ?>
                                        <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                        <td width="7px"></td>
                                                        <td width="192px"></td>
                                                        <td width="192px"></td>
                                                        <td width="10px"></td>
                                                        <td width="385px"></td>
                                                        <td width="7px"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td colspan="4" align="left"><div class="account-header uc"><?php __('account_server_settings', array($s['tName'])); ?></td>
                                                        <td></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left">
                                                                <div class="uc account-h-cr"><?php __('account_server_name'); ?></div>
                                                        </td>
                                                        <td width="175px" align="right" class="inpt-sp">
                                                                <input type="text" value="<?php echo $s['tName']; ?>" disabled="true" />
                                                        </td>
                                                        <td></td>
                                                        <td id="status_strName"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left" colspan="2">
                                                                <div class="account-desc-cr"><?php __('account_server_name_expl2'); ?></div>
                                                        </td>
                                                        <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left">
                                                                <div class="uc account-h-cr"><?php __('account_server_aliases'); ?></div>
                                                        </td>
                                                        <td width="175px" align="right" class="inpt-sp">
                                                                <input type="text" id="server_tAliases" name="tAliases" value="<?php echo KSArrayToString ($s['tAliases']); ?>" maxlength="83" />
                                                        </td>
                                                        <td></td>
                                                        <td id="status_strName"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left" colspan="2">
                                                                <div class="account-desc-cr"><?php __('account_server_aliases_expl'); ?></div>
                                                        </td>
                                                        <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left">
                                                                <div class="uc account-h-cr"><?php __('account_server_phase'); ?></div>
                                                        </td>
                                                        <td width="175px" align="right" class="inpt-sp">
                                                                <select name="nType" id="server_nType">
                                                                        <option value="1"<?php echo $s['nType'] == 1 ? ' selected="selected"' : '';?>>BETA</option>
                                                                        <option value="2"<?php echo $s['nType'] == 2 ? ' selected="selected"' : '';?>>Official</option>
                                                                </select>
                                                        </td>
                                                        <td></td>
                                                        <td id="status_strName"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left" colspan="2">
                                                                <div class="account-desc-cr"><?php __('account_server_phase_expl'); ?></div>
                                                        </td>
                                                        <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left">
                                                                <div class="uc account-h-cr"><?php __('account_server_desc'); ?></div>
                                                        </td>
                                                        <td width="175px" align="right" class="inpt-sp" rowspan="2">
                                                                <textarea id="server_tAliases" name="tAliases" maxlength="250" style="width: 146px; height: 100%; background: #fff;"><?php echo $s['tDescription']; ?></textarea>
                                                        </td>
                                                        <td></td>
                                                        <td id="status_strName"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left" colspan="1">
                                                                <div class="account-desc-cr"><?php __('account_server_desc_expl'); ?></div>
                                                        </td>
                                                        <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left">
                                                                <div class="uc account-h-cr"><?php __('account_server_keywords'); ?></div>
                                                        </td>
                                                        <td width="175px" align="right" class="inpt-sp">
                                                                <input type="text" id="server_tAliases" name="tAliases" value="<?php echo KSArrayToString ($s['tKeywords']); ?>" maxlength="250" />
                                                        </td>
                                                        <td></td>
                                                        <td id="status_strName"></td>
                                                </tr>
                                                <tr>
                                                        <td></td>
                                                        <td align="left" colspan="2">
                                                                <div class="account-desc-cr"><?php __('account_server_keywords_expl'); ?></div>
                                                        </td>
                                                        <td colspan="2"></td>
                                                </tr>
                                        </table>
                                        <?php
                                }
                                ?>
                        </td>
                        <td width="6px"></td>
                </tr>
        </table>
</div>