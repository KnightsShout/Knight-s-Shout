<script type="text/javascript">
$().ready(function(){
        $("#blog-header-n").css({'height': (intval ($("#inner").css('height')) + 16)});
        /*$("#container-main").append('<div class="spacer"></div>');*/
});
</script>
<div id="blog-header-n" align="left">
        <div style="padding-left: 162px; padding-top: 12px;" id="inner" align="left">
                <h1><?php __('blog_title'); ?> &raquo; <?php __('blog_title_new_post'); ?></h1>
                <div id="frmNewPostCallback" class="frmNewPostCallback"></div>
                <div class="spacer"></div>
                <hr />
                <script type="text/javascript">
                $().ready(function(){
                        $("#frmNewPost").submit(function(){
                                var strTitle = document.getElementById("post-title").value;
                                var strCntet = document.getElementById("post-content").value;
                                
                                if(strTitle.length < 4)
                                {
                                        KS.doError('#frmNewPostCallback', "<?php __('blog_new_post_title_too_short'); ?>");
                                        return false;
                                }
                                if(strCntet.length < 10)
                                {
                                        KS.doError('#frmNewPostCallback', "<?php __('blog_new_post_content_too_short'); ?>");
                                        return false;
                                }
                                
                                var data = $("#frmNewPost").serialize();
                                KS.doLoad(".frmNewPostCallback");
                                $('input').attr('disabled', 'true');
                                
                                $.ajax({
                                        url: "/ajax/blog/new_post",
                                        type: "post",
                                        data: data,
                                        dataType: "json",
                                        success:
                                                function(obj)
                                                {
                                                        if (obj.response == "fail")
                                                        {
                                                                KS.doError('#frmNewPostCallback', "<?php __('blog_new_post_failure'); ?>");
                                                        }
                                                        else
                                                        {
                                                                KS.doSuccess('#frmNewPostCallback', "<?php __('blog_new_post_success'); ?>");
                                                                $("#frmNewPost").slideToggle(300);
                                                                setTimeout(function(){
                                                                        KS.doLoad('#frmNewPostCallback');
                                                                        window.location = '/blog';
                                                                }, 200);
                                                        }
                                                },
                                        failure:
                                                function(error)
                                                {
                                                        alert (error);
                                                },
                                        complete:
                                                function()
                                                {
                                                        $('input').attr('disabled', 'false');
                                                }
                                });
                                
                                return false;
                        });
                });
                </script>
                <form action="/blog/new_post" method="post" id="frmNewPost">
                        <input type="hidden" name="bProcess" value="1" />
                        <table cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                        <td width="200px" align="left" valign="top">
                                                <h2><b><?php __('blog_post_category') ;?></b></h2>
                                        </td>
                                        <td width="5px"></td>
                                        <td width="618px" align="left" valign="top">
                                                <select name="post-category">
                                                        <option value="1"><?php __('blog_post_category_comm'); ?></option>
                                                        <option value="2"><?php __('blog_post_category_tech'); ?></option>
                                                        <option value="3"><?php __('blog_post_category_none'); ?></option>
                                                </select>
                                        </td>
                                        <td width="5px"></td>
                                </tr>
                                <tr>
                                        <td width="200px" align="left" valign="top">
                                                <h2><b><?php __('blog_post_title') ;?></b></h2>
                                        </td>
                                        <td width="5px"></td>
                                        <td width="618px" align="left" valign="top">
                                                <input type="text" id="post-title" name="post-title" maxlength="60" />
                                        </td>
                                        <td width="5px"></td>
                                </tr>
                                <tr>
                                        <td width="200px" align="left" valign="top">
                                                <h2><b><?php __('blog_post_content') ;?></b></h2>
                                                <blockquote>
                                                        <i>
                                                                <?php __('blog_post_content_expl'); ?>
                                                        </i>
                                                </blockquote>
                                        </td>
                                        <td width="5px"></td>
                                        <td width="618px" align="left" valign="top">
                                                <textarea id="post-content" name="post-content"></textarea>
                                        </td>
                                        <td width="5px"></td>
                                </tr>
                                <tr>
                                        <td colspan="4" class="spacer"></td>
                                </tr>
                                <tr>
                                        <td colspan="4" align="center">
                                                <input type="submit" value="<?php __('blog_post_new_submit'); ?>" class="btn" />
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="4" class="spacer"></td>
                                </tr>
                        </table>
                </form>
                <hr />
                <script type="text/javascript">
                function bbx(){$("#frmNewPost").slideToggle(300);setTimeout(function(){KS.doLoad('#frmNewPost');window.location = '/blog';}, 200);}
                </script>
                <div class="spacer"></div>
                <a href="javascript:bbx();">&nbsp;&nbsp;&laquo;&nbsp;<?php __('glob_cancel'); ?></a>
        </div>
</div>