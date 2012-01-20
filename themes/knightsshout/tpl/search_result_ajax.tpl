<?php
$avatar = '/resources/user-content/';
if (empty (Search::$result['strAvatar']))
        $avatar.= 'default.png';
else
        $avatar.= Search::$result['strAvatar'];
$q = doMkAccount ($_GET['q']);
$u = Search::$result['strAccountID'];
$user = preg_replace ('/(' . $q . ')/i', '<b>\\1</b>', $u);
?>
<div class="search-result">
        <a href="/user/<?php echo strtolower (Search::$result['strAccountID']); ?>">
                <table cellpadding="0" cellspacing="0" align="left">
                        <tr>
                                <td width="45px" align="center" valign="middle">
                                        <img src="<?php echo $avatar; ?>" alt="" width="45px" height="45px" />
                                </td>
                                <td width="5px"></td>
                                <td width="184px" align="left" valign="top">
                                        <?php echo $user; ?>
                                </td>
                        </tr>
                </table>
        </a>
</div>