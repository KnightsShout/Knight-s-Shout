<?php
        $p[0] = $_GET[0] == 0 ? 1 : $_GET[0];
        $_GET[0] = intval (@$_GET[0]) > 1 ? intval (@$_GET[0]) - 1 : 0;
        $p[1] = $_GET[0] * 10;
        $main->database->doQuery ('SELECT COUNT(*) AS nCount FROM BLOG_POSTS');
        $total = $main->database->doRead ();
        $total = intval ($total['nCount']);
        $main->database->doQuery ('SELECT * FROM BLOG_POSTS ORDER BY nID DESC LIMIT ' . $p[1] . ', 10');
        $p[2] = ceil ($total / 10);
        $count = 0;
?>
<div id="blog-header" align="left">
        <div style="padding-left: 162px; padding-top: 12px;" align="left">
                <table cellpadding="0" cellspacing="0" align="left">
                        <tr>
                                <td width="400px" align="left">
                                        <h1><?php __('blog_title'); ?></h1>
                                </td>
                                <td width="400px" align="right">
                                        <div class="blog-page">
                                                <?php
                                                if ($p[0] > 1)
                                                        __('blog_page_backwards', array ((int) ($p[0] - 1)));
                                                __('blog_page', array ((int) $p[0], (int) $p[2]));
                                                if ($p[0] < $p[2])
                                                        __('blog_page_forward', array ((int) ($p[0] + 1)));
                                                ?>
                                        </div>
                                </td>
                        </tr>
                </table>
        <div><br /><br /><br /><br /><br />
        <div style="height: 3px;"></div>
                        <hr />
                        <i>
                                <?php __('blog_expl'); ?>
                        </i>
                        <div style="height: 6px;"></div>
                        <hr />
                        <table cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                        <td width="300px;" align="left">
                                                <?php if (LOGGED_IN === 2) { ?>
                                                <i>
                                                        <a href="/blog/new_post"><?php __('blog_make_post'); ?></a>
                                                </i>
                                                <?php } ?>
                                        </td>
                                        <td width="500px" align="right">
                                                <form action="/blog/search" method="get" id="frmSearchBlog">
                                                        <input type="text" maxlength="30" id="search-blog-input" name="q" value="<?php __('search_blog_val'); ?>" onfocus="if(this.value=='<?php __('search_blog_val'); ?>')this.value='';" onblur="if(this.value=='')this.value='<?php __('search_blog_val'); ?>';" /><input type="submit" class="search-submit" value="" />
                                                </form>
                                        </td>
                                        <script type="text/javascript">
                                        $("#frmSearchBlog").submit(function(){
                                                var term = document.getElementById("search-blog-input").value;
                                                
                                                if (!term || term == "" || term == "<?php __('search_blog_val'); ?>")
                                                {
                                                        $("#search-blog-input").focus();
                                                        return false;
                                                }
                                        });
                                        </script>
                                </tr>
                        </table>
                </div>
        </div>
</div>
<?php
if (LOGGED_IN == 2)
{
?>
<script type="text/javascript">
        function rmvpost(nID)
        {
                if (!confirm ("<?php __('blog_delete_confirm'); ?>"))
                        return false;
                $.ajax({
                        url: "/ajax/blog/remove:" + nID,
                        type: "post",
                        dataType: "json",
                        success:
                                function(obj)
                                {
                                        if (obj.rsp == 'done')
                                        {
                                                $("#blog-no-" + nID).slideToggle(300);
                                        }
                                }
                });
        }
        
        var cache = [];
        var _cache = [];
        function edtpost(nID, nClick)
        {
                var c;
                _cache[nID] = $("#blog-no-" + nID).html();
                
                if (typeof (cache[nID]) != 'undefined'){
                        c = cache[nID];
                        _edtpost(nID, c, nClick);
                }else{
                        KS.doLoad('#blog-no-' + nID);
                        $.ajax({
                                url: "/ajax/blog/edit:" + nID,
                                type: "post",
                                data: null,
                                dataType: "json",
                                success:
                                        function(obj)
                                        {
                                                /*
                                                $.each(obj, function(key,value){
                                                        alert(key + ' => ' + value);
                                                });
                                                */
                                                
                                                cache[nID] = c = obj;
                                                _edtpost(nID, c, nClick);
                                        }
                        });
                }
        }
        
        function _edtpost(nID, c, nClick)
        {
                $('#blog-no-' + nID).removeClass('loading').html(
                        '<form action="/ajax/blog/update:' + nID + '" method="post" class="frmEdtPst" id="frmEdtPst">' +
                                '<div class="spacer"></div>' +
                                _e(nClick) +
                                '<div class="h1"><img src="<?php t(); ?>img/blog-post.jpg" alt="" />&nbsp;<input type="text" id="blog-title" name="blog-title" value="' + unescape(c.strTitle.split('\"').join('"').split('+').join(' ')) + '" maxlength="60" /></div>' +
                                '<div class="h2">' +
                                '       <blockquote>' +
                                '               <i>//</i>&nbsp;<b>' + c.strDate + ':</b><br /><br />' +
                                '               <textarea id="post-content" name="post-content">' + unescape(c.strContent.split('\"').join('"').split('+').join(' ')) + '</textarea>' +
                                '               <div class="spacer"></div>' +
                                '               <input type="submit" value="<?php __('blog_post_new_submit'); ?>" class="btn" /> <input type="button" onclick="edtpostcncl(' + nID + ');" value="<?php __('glob_cancel'); ?>" class="btn" />' +
                                '       </blockquote>' +
                                '</div>' +
                                '<div class="spacer"></div>' +
                        '</form>'
                );
        }
        
        function _e(n)
        {
                return n > 1 ? '<hr />' : '';
        }
        
        function edtpostcncl(nID)
        {
                if (typeof (_cache[nID]) != 'undefined'){
                        $('#blog-no-' + nID).html(_cache[nID]);
                }
                return false;
        }
        
        /*
        function edtpostprcss(nID)
        {
                var strTitle = $('#edit-post-title-' + nID).attr('value');
                var strCntet = $('#edit-post-content-' + nID).attr('value');
                
                if(strTitle.length < 4)
                {
                        alert("<?php __('blog_new_post_title_too_short'); ?>");
                        return false;
                }
                if(strCntet.length < 10)
                {
                        alert("<?php __('blog_new_post_content_too_short'); ?>");
                        return false;
                }
                
                return false;
        }
        */
</script>
<?php
}
?>
<div id="blog-container" align="left">
        <?php
        while ($post = $main->database->doRead ())
        {
                $count++;
                $title = str_replace ("\'", "'", $post['strTitle']);
                $cont = str_replace ("\'", "'", preg_replace ('/<(.+)>/i', '', htmlspecialchars_decode ($post['strContent'])));
                #$sec = array(1 => ___('blog_post_category_comm'), 2 => ___('blog_post_category_tech'), 3 => '');
                $secz = array(1 => '-comm', 2 => '-tech', 3 => '');
                ?>
                <div class="blog-post" id="blog-no-<?php echo $post['nID']; ?>">
                        <?php
                        if ($count != 1)
                                echo "<hr />";
                        ?>
                        <div class="h1"><img src="<?php t(); ?>img/blog-post<?php echo $secz[$post['nCategory']];?>.jpg" alt="" />&nbsp;<?php echo $title; ?></div>
                        <div class="h2">
                                <blockquote>
                                        <i>//</i>&nbsp;<b><?php echo $post['strDate']; ?>:</b>
                                        <i>
                                                <?php if (strlen ($cont) > 200) { echo substr ($cont, 0, 200); ?>...<a href="/blog/<?php echo $post['nID'] . '-' . blog_title_to_url ($title); ?>">&nbsp;&laquo;&nbsp;<?php __('blog_post_read_more'); ?></a><?php }else{ echo $cont; ?><a href="/blog/<?php echo $post['nID'] . '-' . blog_title_to_url ($title); ?>">&nbsp;&laquo;&nbsp;<?php __('blog_post_read_more'); ?></a><?php } ?>
                                        </i>
                                </blockquote>
                        </div>
                        <?php if (LOGGED_IN == 2) { ?><i><a href="javascript:edtpost(<?php echo $post['nID'] . ',' . $count; ?>);"><img src="<?php t(); ?>img/blog-post-edit.jpg" alt="" /> <?php __('blog_post_edit'); ?></a> &mdash; <a href="javascript:rmvpost(<?php echo $post['nID']; ?>);"><img src="<?php t(); ?>img/blog-post-remove.jpg" alt="" /> <?php __('blog_post_remove'); ?></a></i><?php } ?>
                        <div class="spacer"></div>
                </div>
                <?php
        }
        if (!$count)
        {
                ?>
                <div class="spacer"></div>
                <div align="center">
                        <b><?php __('blog_no_posts'); ?></b>
                </div>
                <div class="spacer"></div>
                <?php
        }
        ?>
</div>