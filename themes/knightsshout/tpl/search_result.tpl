<?php
$q = doMkAccount ($_GET['q']);
?>
<div id="search-actual" style="padding-left: 7px; padding-top: 10px; min-height: 414px; width: 992px; background-image: url(<?php t(); ?>img/search_bg.png); background-position: top left; background-repeat: no-repeat;" align="left">
        <h1><?php __('search'); ?></h1>
        <h2><div style="text-shadow: #ccc 1px 2px 2px; color: #111;"><?php __('search_results', array ($q)); ?></div></h2>
        <div class="spacer"></div>
        <?php
        while (Search::$result = $main->database->doRead ())
        {
                $avatar = '/resources/user-content/';
                if (empty (Search::$result['strAvatar']))
                        $avatar.= 'default.png';
                else
                        $avatar.= Search::$result['strAvatar'];
                $u = Search::$result['strAccountID'];
                $user = preg_replace ('/(' . $q . ')/i', '<b>\\1</b>', $u);
                ?>
                <div class="search-result">
                        <a href="/user/<?php echo strtolower (Search::$result['strAccountID']); ?>">
                                <table cellpadding="0" cellspacing="0" align="left">
                                        <tr>
                                                <td width="100px" align="center" valign="middle">
                                                        <img src="<?php echo $avatar; ?>" alt="" width="100px" height="100px" />
                                                </td>
                                                <td width="25px"></td>
                                                <td width="800px" align="left" valign="top">
                                                        <h1><?php echo $user; ?></h1>
                                                </td>
                                        </tr>
                                </table>
                        </a>
                </div>
                <?php
        }
        ?>
</div>