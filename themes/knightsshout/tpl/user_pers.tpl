<script type="text/javascript">profileSectionSelect("#button-personality");</script>
<?php
$classes = array (1 => 'glob_class_warrior', 2 => 'glob_class_rogue', 3 => 'glob_class_mage', 4 => 'glob_class_priest');
$races = array (1 => 'glob_karus', 2 => 'glob_elmo');
$can_edit = $_SESSION['strAccount'] == pUser::$user['strAccountID'] ? 1 : 0;
$edit = '';
if ($can_edit)
        $edit = '&nbsp;<a href="/account/personality">&rarr;&nbsp;' . ___('user_profile_edit') . '</a>';
echo '
<table cellpadding="0" cellspacing="0" align="left">
        <tr>
                <th width="120px"></th>
                <th width="460px"></th>
        </tr>
        <tr>
                <td colspan="2" class="profile-content-section-header" align="left">
                        <div class="profile-content-section-header-h1">
                                ' . ___('user_profile_pers') . $edit . '
                        </div>
                </td>
        </tr>
        <tr>
                <td colspan="2" class="spacer"></td>
        </tr>
        <tr>
                <td align="left" colspan="2">
                        ' . ___('disabled') . '
                </td>
        </tr>
        <tr>
                <td colspan="2" class="spacer"></td>
        </tr>
</table>';
?>
<script type="text/javascript">
$().ready(function(){
        ks_url.fake('', '/user/<?php echo strtolower (pUser::$user['strAccountID']); ?>/personality', 2);
});
</script>