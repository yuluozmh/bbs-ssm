// 构造【首页】文章信息
function getArticlesAll(data) {
    var articles_all = "";
    var articles = data.listArticle;
    // 此处进行循环展示-文章
    for (var i = 0; i < articles.length; i++) {
        var article = articles[i];
        // 文章创建者id
        var fuserid = article.userid;
        // 文章id
        var fid = article.fid;
        // 板块id
        var bid = article.bid;
        // 板块名
        var bname = article.bname;

        // 板块信息
        $("#listArticle_bname").html(bname);
        $("#listArticle_bname").attr("onclick", "getBid('" + bid + "','" + bname + "')");

        // 时间
        $("#listArticle_time").html(dateTimeFormat(article.createTime));

        //文章发布者头像信息
        $("#listArticle_userphoto_a").attr("href", "javascript:void(0)");
        $("#listArticle_userphoto_a").attr("onclick", 'getOther("' + fuserid + '")');
        if (article.userPhoto != null) {
            $("#listArticle_userphoto_img").attr("src", article.userPhoto);
        } else {
            // 恢复原状
            $("#listArticle_userphoto_img").attr("src", APP_PATH + '/static/img/head.png');
        }

        //文章创建者姓名
        $("#listArticle_username_href").attr("href", "javascript:void(0)");
        $("#listArticle_username_href").attr("onclick", 'getOther("' + fuserid + '")');
        $("#listArticle_username").html(article.name);

        /*--------------------------------------------------- 关注 ---------------------------------------------------*/
        // 如果是登录用户本人，则不显示关注按钮
        if (fuserid != userid) {
            var gid = article.gid;
            $(".form_attentionDel").attr("class", "form_attentionDel_" + fuserid + " del_" + fid);
            $(".form_attentionAdd").attr("class", "form_attentionAdd_" + fuserid + " add_" + fid);

            //判断该文章对应的用户是否被关注
            if (gid != null) {    // 被关注
                // "取消关注"
                $("#form_attentionDel_btn").attr("onclick", "attentionDel('" + fuserid + "')");
                // fuserid
                $("#form_attentionDel_btn").attr("class", "btn btn-sm " + fuserid);
                // 鼠标移上去显示
                $("#form_attentionDel_btn").attr("onmouseover", "onmouseoverAttentioned('" + fuserid + "')");
                // 鼠标移出显示
                $("#form_attentionDel_btn").attr("onmouseout", "onmouseoutAttentioned('" + fuserid + "')");
                // "关注她"
                $("#form_attentionAdd_btn").attr("onclick", "attentionAdd('" + fuserid + "')");
                // 显示“取消关注”
                $(".form_attentionDel_" + fuserid).show();
            } else {    // 未被关注
                // "取消关注"
                $("#form_attentionDel_btn").attr("onclick", "attentionDel('" + fuserid + "')");
                // fuserid
                $("#form_attentionDel_btn").attr("class", "btn btn-sm " + fuserid);
                // 鼠标移上去显示
                $("#form_attentionDel_btn").attr("onmouseover", "onmouseoverAttentioned('" + fuserid + "')");
                // 鼠标移出显示
                $("#form_attentionDel_btn").attr("onmouseout", "onmouseoutAttentioned('" + fuserid + "')");
                // "关注她"
                $("#form_attentionAdd_btn").attr("onclick", "attentionAdd('" + fuserid + "')");
                // 显示“关注她”
                $(".form_attentionAdd_" + fuserid).show();
            }
        }
        /*--------------------------------------------------- 关注-end ---------------------------------------------------*/

        // 标题
        $("#listArticle_titles").html(article.titles);
        $("#listArticle_titles").attr("onclick", "skipArticle('" + fid + "')");

        // 内容
        $("#listArticle_fcontent").html(article.fcontent);
        $("#listArticle_fcontent").attr("onclick", "skipArticle('" + fid + "')");

        //文章配图
        if (article.photo != "") { // 有“配图”
            if (article.photo.endsWith(".mp4") || article.photo.endsWith(".avi")) {
                $("#listArticle_video").attr("src", article.photo);
                $("#listArticle_video").attr("onclick", "skipArticle('" + fid + "')");
                // 显示“视频”
                $("#listArticle_video").show();
                // 隐藏“图片”
                $("#listArticle_img").hide();
            } else {
                $("#listArticle_img").attr("src", article.photo);
                $("#listArticle_img").attr("onclick", "skipArticle('" + fid + "')");
                // 显示“图片”
                $("#listArticle_img").show();
                // 隐藏“视频”
                $("#listArticle_video").hide();
            }
        } else {
            // 隐藏“图片”
            $("#listArticle_img").hide();
            // 隐藏“视频”
            $("#listArticle_video").hide();
        }

        // 评论数
        $("#listArticle_sum").html(article.commentCount + " 条评论");
        $("#listArticle_sum").attr("onclick", "skipArticle('" + fid + "')");
        // 浏览量
        $("#article_pv").html(article.pv);
        /*--------------------------------------------------- 收藏 ---------------------------------------------------*/
        // 收藏赋值
        setCollect(article, fid);
        /*--------------------------------------------------- 收藏-end ---------------------------------------------------*/

        /*--------------------------------------------------- 点赞 ---------------------------------------------------*/
        // 点赞赋值
        setEnjoy(article, fid);
        /*--------------------------------------------------- 点赞-end ---------------------------------------------------*/

        // 拼接所有的标签数据
        articles_all = articles_all + $("#articles_all_hide").html();

        // 隐藏“取消关注”-复原
        $(".del_" + fid).attr("class", "form_attentionDel");
        $(".form_attentionDel").hide();
        // 隐藏“关注她”-复原
        $(".add_" + fid).attr("class", "form_attentionAdd");
        $(".form_attentionAdd").hide();
        // 隐藏“取消收藏”-复原
        $(".form_collectDel_" + fid).attr("class", "form_collectDel");
        $(".form_collectDel").hide();
        // 隐藏“收藏”-复原
        $(".form_collectAdd_" + fid).attr("class", "form_collectAdd");
        $(".form_collectAdd").hide();
        // 隐藏“取消点赞”-复原
        $(".form_enjoyDel_" + fid).attr("class", "form_enjoyDel");
        $(".form_enjoyDel").hide();
        // 隐藏“点赞”-复原
        $(".form_enjoyAdd_" + fid).attr("class", "form_enjoyAdd");
        $(".form_enjoyAdd").hide();
        // 隐藏“视频”-复原
        $("#listArticle_video").hide();
        // 隐藏“图片”-复原
        $("#listArticle_img").hide();
    }

    return articles_all;
}