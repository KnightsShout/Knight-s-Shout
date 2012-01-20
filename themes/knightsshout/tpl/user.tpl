<?php
pUser::$user = $user = $main->database->doRead ();
if ($_SESSION['strAccount'] == pUser::$user['strAccountID'])
{
        $friends = 4;
}
else
{
        switch (intval ($user['nStatus']))
        {
                case 2:
                        $friends = 2; break;
                case 1:
                        $friends = $_SESSION['strAccount'] !== pUser::$user['strRequester'] && !empty (pUser::$user['strRequester']) ? 1 : 3; break;
                default:
                        $friends = 0; break;
        }
}
pUser::$friends = $friends;
?>
<script type="text/javascript">
set_title ("<?php __(Template::$title[0], array(pUser::$user['strAccountID'])); ?>");
</script>
<div id="user-profile">
        <table cellpadding="0" cellspacing="0" align="left">
                <tr>
                        <th width="200px"></th>
                        <th width="600px"></th>
                        <th width="200px"></th>
                </tr>
                <tr>
                        <td colspan="3" class="spacer"></td>
                </tr>
                <tr>
                        <td align="center" valign="top" id="user-profile-parter">
                                <?php
                                $avatar = '/resources/user-content/';
                                if (!empty ($user['strAvatar']))
                                {
                                        $avatar.= $user['strAvatar'];
                                }
                                else
                                {
                                        $avatar.= 'default.png';
                                }
                                ?>
                                <a href="/media/<?php echo pUser::$account; ?>?view=pp"><img src="<?php echo $avatar; ?>" alt="" /></a>
                                <div style="height: 7px;"></div>
                                <div id="user-profile-sections" align="left">
                                        <div style="height: 7px;"></div>
                                        <div id="button-game" class="user-profile-section-button"><a href="/user/<?php echo pUser::$account; ?>/game"><img src="<?php t(); ?>img/profile-icon-game.png" alt="" />&nbsp;<?php __('user_profile_game'); ?></a></div>
                                        <div id="button-personality" class="user-profile-section-button"><a href="/user/<?php echo pUser::$account; ?>/personality"><img src="<?php t(); ?>img/profile-icon-person.png" alt="" />&nbsp;<?php __('user_profile_info'); ?></a></div>
                                        <div id="button-media" class="user-profile-section-button"><a href="/media/<?php echo pUser::$account; ?>"><img src="<?php t(); ?>img/profile-icon-media.png" alt="" />&nbsp;<?php __('user_profile_media'); ?></a></div>
                                        <div id="button-wall" class="user-profile-section-button"><a href="/user/<?php echo pUser::$account; ?>/wall"><img src="<?php t(); ?>img/profile-icon-wall.png" alt="" />&nbsp;<?php __('user_profile_wall'); ?></a></div>
                                        <div style="height: 7px;"></div>
                                </div>
                                <script type="text/javascript">
                                /*$().ready(function(){*/
                                        function profileSectionSelect(section)
                                        {
                                                $("#button-game").removeClass('user-profile-section-button-active');
                                                $("#button-personality").removeClass('user-profile-section-button-active');
                                                $("#button-media").removeClass('user-profile-section-button-active');
                                                $("#button-wall").removeClass('user-profile-section-button-active');
                                                $(section).addClass('user-profile-section-button-active');
                                        }
                                        
                                        /*profileSectionSelect("l");*/
                                /*});*/
                                </script>
                        </td>
                        <td align="left" valign="top" id="user-profile-content">
                                <table cellpadding="0" cellspacing="0" align="left">
                                        <tr>
                                                <td valign="top" align="left" style="width: 400px;"><h1><?php echo $user['strAccountID']; ?></h1></td>
                                                <td valign="top" align="right" style="width: 180px;">&nbsp;<?php
                                switch ($friends)
                                {
                                        case 3:
                                                Template::load ('friends_requested_requester');
                                                befriend_progress ($user['strAccountID']);
                                                break;
                                        case 2:
                                                Template::load ('friends_disband');
                                                defriend ($user['strAccountID']);
                                                break;
                                        case 1:
                                                Template::load ('friends_requested');
                                                befriend_requested ($user['strAccountID']);
                                                break;
                                        case 0:
                                                Template::load ('friends_can');
                                                befriend ($user['strAccountID']);
                                                break;
                                }
                                ?></td>
                                        </tr>
                                        <tr>
                                                <td colspan="2">
                                                        <div id="user-profile-content-pipe">
                                                                <?php
                                                                $main->template->page->in();
                                                                ?>
                                                        </div>
                                                </td>
                                        </tr>
                                </table>
                        </td>
                        <td align="center" valign="top">
                                <i>ads</i>
                        </td>
                </tr>
        </table>
</div>
<div id="profile-callback"></div>
.