<script type="text/javascript">
$().ready(function(){
        set_title("<?php __('title_account'); ?>");
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
                                <h3 class="uc"><?php __('menu_edit_profile'); ?></h3>
                        </td>
                        <td></td>
                </tr>
                <tr>
                        <td width="6px"></td>
                        <td width="180px" align="right" valign="top" class="bb menux">
                                <a href="/account/game"><div class="menu-sub stripe-right uc" style="border-top: 2px solid #666;"><?php __('account_game'); ?></div></a>
                                <a href="/account/server"><div class="menu-sub stripe-right uc"><?php __('account_server'); ?></div></a>
                                <a href="/account/personality"><div class="menu-sub stripe-right uc"><?php __('account_personality'); ?></div></a>
                                <a href="/account/settings"><div class="menu-sub stripe-right uc" style="border-bottom: 2px solid #666;"><?php __('account_settings'); ?></div></a>
                        </td>
                        <td width="6px" class="bb" style="background: rgb(221,221,221);"></td>
                        <td width="794px" align="left" valign="top" class="bb ksfancyfont account-content">
                                <div class="account-header uc"><?php __('logged_in_as', array($_SESSION['strAccount'])); ?></div>
                                <?php __('account_select_section'); ?>
                        </td>
                        <td width="6px"></td>
                </tr>
        </table>
</div>