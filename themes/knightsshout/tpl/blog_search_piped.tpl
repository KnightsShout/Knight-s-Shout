<script type="text/javascript">
$().ready(function(){
        $("#inside #status").animate(
                                        {
                                                'margin-left': '-100px'
                                        },
                                        300,
                                        function(){
                                                $(this).html("<b><?php __('search_result', array((string) Blog::$q)) ;?></b>").css({'margin-left': '130px'}).animate(
                                                        {
                                                                'margin-left': '0px'
                                                        },
                                                        300,
                                                        function(){
                                                                $(this).show();
                                                        }
                                                );
                                        }
                                );
        
        <?php
        if (!Blog::$jspc)
        {
        ?>
        $("#frmNewPostCallback").html("<?php __('blog_search_no_result', array((string) Blog::$q)); ?>").hide().fadeIn(300);
        <?php
        }
        ?>
});
</script>