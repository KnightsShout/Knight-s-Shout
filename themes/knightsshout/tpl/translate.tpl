<?php
global $main;
?>
<div align="center" class="ppheadline"><?php __('title_translate'); ?></div>
<div align="left" class="ppcontent">
        <?php __('translate_expl'); ?><br />
        <script type="text/javascript">
        $().ready(function(){
                $("#lngapply").click(function(){
                        var data = new Array(0, null, '/ajax/translate?act=info', null);
                        KS.doPopup(data);
                        /*
                        Popupify.doPopup({type: Popupify.as_ajax, ajax: {
                                url: '/ajax/translate',
                                method: 'GET',
                                data: 'act=info',
                                success: function(rsp){
                                        Popupify.doPopup({type: Popupify.as_html, html: rsp});
                                }
                        }});
                        */
                });
        });
        </script>
        <div class="spacer"></div>
        <table cellpadding="0" cellspacing="0" align="center">
                <tr>
                        <th width="196px"></th>
                        <th width="196px"></th>
                        <th width="196px"></th>
                </tr>
                <?php
                $n = 0;
                foreach ($main->conf['translation']['languages'] as $k => $v)
                {
                        $n++;
                        if ($n == 1)
                                echo "<tr>";
                        ?>
                        <td align="left" style="height: 25px; padding-top: 2px; padding-bottom: 2px;"><a href="javascript:KS.switchLang('<?php echo $k; ?>');" style="padding: 3px; background: #666; border: 2px solid #444; color: #eee;"><?php echo $v; ?></a></td>
                        <?php
                        if ($n == 3)
                        {
                                echo "</tr>";
                                $n = 0;
                        }
                }
                if ($n == 1)
                        echo "<td></td><td></td></tr>";
                if ($n == 2)
                        echo "<td></td></tr>";
                ?>
        </table>
</div>