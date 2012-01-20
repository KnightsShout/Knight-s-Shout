<script type="text/javascript">profileSectionSelect("#button-game");</script>
<?php
$classes = array (1 => 'glob_class_warrior', 2 => 'glob_class_rogue', 3 => 'glob_class_mage', 4 => 'glob_class_priest');
$races = array (1 => 'glob_karus', 2 => 'glob_elmo');
$can_edit = $_SESSION['strAccount'] == pUser::$user['strAccountID'] ? 1 : 0;
$edit = '';
if ($can_edit)
        $edit = '<div align="left">&nbsp;<a href="/account/game" style="font-size: 18px; font-weight: normal; color: #a00;">&rarr;&nbsp;' . ___('user_profile_edit') . '</a></div><div style="height: 15px;"></div>';
/*
echo '
<table cellpadding="0" cellspacing="0" align="left">
        <tr>
                <th width="120px"></th>
                <th width="460px"></th>
        </tr>
        <tr>
                <td colspan="2" class="profile-content-section-header" align="left">
                        <div class="profile-content-section-header-h1">
                                ' . ___('user_profile_game') . $edit . '
                        </div>
                </td>
        </tr>
        <tr>
                <td colspan="2" class="spacer"></td>
        </tr>
        <tr>
                <td align="left" width="120px">
                        <b>' . ___('account_fav_class') . '</b>
                </td>
                <td align="left" width="460px">
                        ' . ___($classes[pUser::$user['nFavoriteClass']]) . '
                </td>
        </tr>
        <tr>
                <td colspan="2" class="spacer"></td>
        </tr>';
*/
$count = $main->database->doQuery ("SELECT * FROM MEMBERS_SERVERS WHERE strAccountID = '%s' ORDER BY bActive DESC, nPK ASC", pUser::$account);
?>
<div id="user-profile-game-content" valign="middle">
        <div style="height: 30px;"></div>
        <table cellpadding="0" cellspacing="0" align="center" valign="middle">
                <tr>
                        <td width="240px" align="center" rowspan="2" valign="bottom">
                                <h1><?php __('account_servers'); ?></h1>
                                <div class="user-profile-game-servers-list user-profile-game-servers-list-s ks-fancy-scrollbar">
                                        <script type="text/javascript">
                                        function previewServer(server)
                                        {
                                                if (server.length < 3)
                                                {
                                                        alert ('[Failed Loading.] Bad call.');
                                                }
                                                else
                                                {
                                                        $("#server-pre-info").html("<img src='<?php t(); ?>img/ajax-loader-4.gif' alt='' />&nbsp;<?php __('glob_loading'); ?>");
                                                        $.ajax({
                                                                method: "get",
                                                                url: "/ajax/preview_server/" + server,
                                                                data: null,
                                                                dataType: "json",
                                                                success:
                                                                        function(server)
                                                                        {
                                                                                if (!server.isValid)
                                                                                {
                                                                                        $("#server-pre-info").html("<?php __('server_preview_no_information'); ?>");
                                                                                }
                                                                                else
                                                                                {
                                                                                        
                                                                                }
                                                                        }
                                                        });
                                                }
                                        }
                                        </script>
                                        <?php
                                        if (!$count)
                                        {
                                                __('account_servers_none', array (ucfirst (pUser::$account)));
                                        }
                                        else
                                        {
                                                while ($server = $main->database->doRead ())
                                                {
                                                        $race = $races[$server['nCharNation']];
                                                        $class = $classes[$server['nCharClass']];
                                                        
                                                        $status = intval ($server['bActive']) === 1 ? 'active' : 'inactive';
                                                        ?>
                                                                <div class="user-profile-game-server-single" align="left">
                                                                        <img src="<?php t(); ?>img/<?php echo $status; ?>.png" alt="" class="rollovertipsyx" title="<?php __('account_server_is_' . $status); ?>" /><?php
                                                                        if (strlen ($server['strClanID']) > 1)
                                                                        {
                                                                                __('user_profile_server', array (strtolower ($server['strServerID']), $server['strServerID'], ___($race), ___($class), $server['strCharID'], $server['strClanID']));
                                                                        }
                                                                        else
                                                                        {
                                                                                __('user_profile_server_none', array (strtolower ($server['strServerID']), $server['strServerID'], ___($race), ___($class), $server['strCharID']));
                                                                        }
                                                                        ?>&nbsp; <a href="javascript:;" onclick="previewServer('<?php echo strtolower ($server['strServerID']); ?>');" style="font-style: italic; color: #f33;">&rarr; <?php __('glob_preview'); ?></a>
                                                                </div>
                                                        <?php
                                                }
                                        }
                                        ?>
                                </div>
                        </td>
                        <td width="10px"></td>
                        <td width="320px" align="center" valign="top">
                                <h1><?php __('account_fav_class_is', array($classes[pUser::$user['nFavoriteClass']], ___($classes[pUser::$user['nFavoriteClass']]))); ?></h1>
                        </td>
                </tr>
                <tr>
                        <td></td>
                        <td width="320px" align="center" valign="bottom">
                                <?php echo $edit; ?>
                                <div class="user-profile-game-servers-list user-profile-game-servers-list-c ks-fancy-scrollbar" align="center" valign="middle">
                                        <div valign="middle" id="server-pre-info">
                                                <i><?php __('user_profile_game_select_server'); ?></i>
                                        </div>
                                </div>
                        </td>
                </tr>
        </table>
</div>
<script type="text/javascript">
$().ready(function(){
        ks_url.fake('', '/user/<?php echo strtolower (pUser::$user['strAccountID']); ?>/game', 2);
});
</script>
<?php
/*
if (!$count)
{
        echo '
        <tr>
                <td align="left" width="120px">
                        <b>' . ___('account_servers') . '</b>
                </td>
                <td align="left" width="460px">
                        ' . ___('account_servers_none') . '
                </td>
        </tr>';
}
else
{
        $servers = '
        <tr>
                <td align="left" width="120px" valign="top">
                        <b>' . ___('account_servers') . '</b>
                </td>
                <td align="left" width="460px">';
        
        $active = 1;
        while ($server = $main->database->doRead ())
        {
                $race = $races[$server['nCharNation']];
                $class = $classes[$server['nCharClass']];
                
                if (intval ($server['bActive']) == 0)
                {
                        $txt = ___('user_profile_server_past', array (strtolower ($server['strServerID']), $server['strServerID'], ___($race), ___($class), $server['strCharID'], $server['strClanID']));
                        if (empty ($server['strClanID']))
                                $txt = ___('user_profile_server_past_none', array (strtolower ($server['strServerID']), $server['strServerID'], ___($race), ___($class), $server['strCharID']));
                }
                else
                {
                        $txt = ___('user_profile_server', array (strtolower ($server['strServerID']), $server['strServerID'], ___($race), ___($class), $server['strCharID'], $server['strClanID']));
                        if (empty ($server['strClanID']))
                                $txt = ___('user_profile_server_none', array (strtolower ($server['strServerID']), $server['strServerID'], ___($race), ___($class), $server['strCharID']));
                }
                $servers.= '
                <div class="user-profile-server">
                ' . $txt . '
                </div>';
        }
        
        $servers.= '
                </td>
        </tr>';
        
        echo $servers;
}

echo '
        <tr>
                <td colspan="2" class="spacer"><script type="text/javascript">$(".tipsys").tipsy({gravity: "w"});</script></td>
        </tr>
</table>';
 */
?>