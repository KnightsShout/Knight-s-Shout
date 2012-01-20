<?php
$q = doMkAccount ($_GET['q']);
?>
<div id="search-actual" style="padding-left: 7px; padding-top: 10px; min-height: 414px; width: 992px; background-image: url(<?php t(); ?>img/search_bg.png); background-position: top left; background-repeat: no-repeat;" align="left">
        <table cellpadding="0" cellspacing="0" align="left">
                <tr>
                        <td width="250px"></td>
                        <td align="left" width="650px">
                                <h1><?php __('search'); ?></h1>
                                <h2><div style="text-shadow: #ccc 1px 2px 2px; color: #111;"><?php __('search_no_results', array ($q)); ?></div></h2>
                        </td>
                </tr>
        </table>
</div>