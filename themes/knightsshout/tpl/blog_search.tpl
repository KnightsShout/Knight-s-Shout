<?php
$term = str_replace ('%', ' ', preg_replace ('/[^a-z0-9 ]/i', '', $_GET['q']));
?>
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
        <div style="padding-left: 12px; padding-top: 12px;" align="left">
        <h1><?php __('blog_title_search'); ?></h1>
        <hr />
        <script type="text/javascript">
        /*
        $().ready(function(){
                var data = $("#search-def").serialize();
                process(data);
        });
        */
        </script>
        <div id="inside">
                <div id="status"><b><?php __('search_process', array((string) str_replace ('%', ' ', $term))); ?></b></div>
                <div style="height: 4px;"></div>
                <hr />
                <div id="inside-s"></div>
        </div>
        <div id="frmNewPostCallback" class="frmNewPostCallback"></div>
        <div class="spacer"></div>
        <script type="text/javascript">
        /*
        function process(d)
        {
                KS.doLoad('#inside-s');
                var term = document.getElementById('q').value;
                
                $.ajax({
                        url: "/ajax/blog/search",
                        method: "post",
                        data: d,
                        success:
                                function(rsp)
                                {
                                        $("#inside-s").html(rsp).removeClass('loading').hide();
                                        $("#inside #status").animate(
                                                {
                                                        'margin-top': '-100px'
                                                },
                                                300,
                                                function(){
                                                        $(this).html("<b><?php __('search_result', array((string) $term)); ?></b>").css({'margin-top': '130px'}).animate(
                                                                {
                                                                        'margin-top': '0px'
                                                                },
                                                                300,
                                                                function(){
                                                                        $(this).show();
                                                                        $("#inside-s").fadeIn(300);
                                                                        alert(rsp);
                                                                }
                                                        );
                                                }
                                                );
                                }
                });
        }
        */
        </script>
</div>