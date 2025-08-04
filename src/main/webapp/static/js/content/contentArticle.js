//某一文章展示
$(function () {
    var fid = getQueryString("fid");

    // 背景颜色设置为透明
    $("#content_left").css("background-color", "transparent");
    $.ajax({
        url: APP_PATH + apiUrl + "/article/getArticleFid/" + fid,
        type: "get",
        dataType: "json",
        success: function (data) {
            // 恢复背景颜色为白色
            $("#content_left").css("background-color", "#ffffff");
            // 恢复右边板块的显示
            $("#content_right").show();

            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            data = data.data;
            if (code == 200) {
                var article = data.article;
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
                }

                //发帖人姓名
                $("#listArticle_username_href").attr("href", "javascript:void(0)");
                $("#listArticle_username_href").attr("onclick", 'getOther("' + fuserid + '")');
                $("#listArticle_username").html(article.name);

                /*--------------------------------------------------- 关注and修改文章 ---------------------------------------------------*/
                // 如果是登录用户本人，则不显示关注按钮
                if (fuserid != userid) {
                    // 关注表信息
                    var gid = article.gid;

                    $(".form_attentionDel").attr("class", "form_attentionDel_" + fuserid);
                    $(".form_attentionAdd").attr("class", "form_attentionAdd_" + fuserid);

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
                } else if (userid != "" && fuserid == userid) {    // 用户登录且该文章是登录用户的，则显示修改按钮
                    // "修改文章"
                    $("#form_articleUpdate_btn").attr("onclick", "skipUpdateArticle('" + fid + "')");
                    // 显示“修改文章”
                    $(".form_articleUpdate").show();
                }
                /*--------------------------------------------------- 关注and修改文章-end ---------------------------------------------------*/

                // 标题
                $("#listArticle_title").html(article.titles);

                // 内容 $("#id").html()会丢失部分数据，所以使用$("#id").val()
                $("#listArticle_fcontent").val(article.fcontent);
                // $("#listArticle_fcontent").html(article.fcontent);

                // 文章配图
                if (article.photo != "") { // 有“配图”
                    if (article.photo.endsWith(".mp4") || article.photo.endsWith(".avi")) {
                        $("#listArticle_video").attr("src", article.photo);
                        // 显示“视频”
                        $("#listArticle_video").show();
                    } else {
                        $("#listArticle_img").css("cursor", "zoom-in").attr("onclick", 'magnify("' + article.photo + '")').attr("src", article.photo);
                        // 显示“图片”
                        $("#listArticle_img").show();
                    }
                } else {
                    // 隐藏“视频”
                    $("#listArticle_video").hide();
                    // 隐藏“图片”
                    $("#listArticle_img").hide();
                }

                // 评论数
                $("#listArticle2_sum").html(article.commentCount + " 条评论");
                // 浏览量
                $("#article_pv").html(article.pv + 1);
                /*--------------------------------------------------- 收藏 ---------------------------------------------------*/
                // 收藏赋值
                setCollect(article, fid);
                /*--------------------------------------------------- 收藏-end ---------------------------------------------------*/

                /*--------------------------------------------------- 点赞 ---------------------------------------------------*/
                // 点赞赋值
                setEnjoy(article, fid);
                /*--------------------------------------------------- 点赞-end ---------------------------------------------------*/

                /*--------------------------------------------------- 分享 ---------------------------------------------------*/
                // 分享
                var share_title = article.titles;
                var share_url = window.location.href;
                // 访问地址是"localhost"不显示配图，可用127.0.0.1替代localhost看效果
                var share_pics = "";
                if (article.photo == "") { //没有配图
                    share_pics = window.location.protocol + '//' + window.location.host + APP_PATH + '/static/img/beijing.jpg';
                } else {
                    share_pics = article.photo;
                }
                $("#share").attr("onclick", "shareToQQ('" + share_title + "','" + share_url + "','" + share_pics + "')");
                // 等所有数据配置完再显示
                $("#articles_all").show();
                /*--------------------------------------------------- 分享-分享 ---------------------------------------------------*/

                /*--------------------------------------------------- 评论 ---------------------------------------------------*/
                // 用户登录后才显示评论框
                if (userid != "") {
                    $(".form_commentAdd").show();
                    $("#form_commentAdd_btn").attr("onclick", "commentAdd('" + fid + "','" + fuserid + "')");
                }
                // 评论展示
                var comments = data.listComment;
                if (comments != null) {  // 有评论
                    // 评论展示
                    getComment(comments, fuserid);
                }
                /*--------------------------------------------------- 评论-end ---------------------------------------------------*/

                /*----------------- 把MD语法文档，转换为HTML语法 - js---------------------------*/
                $(function () {
                    const testEditor = editormd.markdownToHTML("artice-doc-content", {//注意：这里是上面DIV的id
                        //htmlDecode: true,       // 开启 HTML 标签解析，为了安全性，默认不开启
                        htmlDecode: "style,script,iframe",  // you can filter tags decode
                        //toc             : false,
                        tocm: true,    // Using [TOCM]
                        //tocContainer: "#custom-toc-container", // 自定义 ToC 容器层
                        //gfm: false,
                        //tocDropdown: true,
                        // markdownSourceCode: true, // 是否保留 Markdown 源码，即是否删除保存源码的 Textarea 标签
                        emoji: true,
                        taskList: true,
                        tex: true,  // 默认不解析
                        flowChart: true,  // 默认不解析
                        sequenceDiagram: true,  // 默认不解析
                    });
                });
                /*--------------------------------- end ------------------------------------*/

                // 关于作者
                getAboutUser(fuserid);
            } else if (code == 500) {
                layer.msg(msg, {icon: 5});
            }
            // 板块展示
            getPlate(data.plate);
            // 热门文章
            getHotArticle(data.listHotArticle);
            // 最新评论
            getNewComment(data.listNewComment);
            // 显示扇形图 (echarts图表内的canvas宽度为0)
            setTimeout(()=>{
                showCountrysProvinces(data);
            },500)
        },
        error: function () {
            layer.msg("出错！", {icon: 5});
        }
    });
});

//根据参数名获取对应的url参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

/*跳转到文章详情（新开一个tab）*/
function skipArticle(fid) {
    var url = APP_PATH + '/article.jsp?fid=' + fid;
    window.open(url, "_blank");
}

/*跳转到修改文章（新开一个tab）*/
function skipUpdateArticle(fid) {
    var url = APP_PATH + '/update.jsp?fid=' + fid + "&source=contentArticle";
    window.location.href = url;
}

/* 取消关注-鼠标移上去 */
function onmouseoverAttentioned(userid) {
    $("." + userid).css("background-color", "#d43f3a");
    $("." + userid).css("color", "#ffffff");
    $("." + userid).html('<samp class="glyphicon glyphicon-minus-sign"></samp> 取消关注');
}

/* 取消关注-鼠标移出 */
function onmouseoutAttentioned(userid) {
    $("." + userid).removeAttr("style");
    $("." + userid).html('<samp class="glyphicon glyphicon-ok-sign"></samp> 已经关注');
}