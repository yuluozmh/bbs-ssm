<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>右边板块-隐藏</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
</head>
<body>
<!--右边板块-隐藏-->
<div id="content_right" style="display: none;">
    <div class="row">
        <div class="about_nsbbs_img">
            <img src="${APP_PATH}/static/img/about-nsbbs.png" style="width: 100%;">
        </div>
    </div>
    <div id="about_nsbbs" style="display: none;">
        <div class="row" style="color: #000;">
            <div class="col-md-12 text-center" style="position: relative; top: -25px;">
                <img src="${APP_PATH}/static/img/nan.jpg" style="width: 80px; height:80px;" class="img-circle">
            </div>
            <div class="col-md-12 text-center">
                <div style="line-height: 28px; padding: 0 0 8px 0;">
                    南生论坛，个人程序人生的点滴记录和时光储备。淡泊明志，宁静致远。珍惜原创，矢志不渝。
                </div>
            </div>
            <hr style="border-top: 1px solid #f9f9f9!important;">
            <div class="col-md-12 text-center">
                <div class="col-md-4">
                    <p>文章</p>
                    <span id="about_nsbbs_article" class="badge" style="background-color: #15acda;"></span>
                </div>
                <div class="col-md-4">
                    <p>评论</p>
                    <span id="about_nsbbs_comment" class="badge" style="background-color: #15acda;"></span>
                </div>
                <div class="col-md-4">
                    <p>访客</p>
                    <span id="about_nsbbs_visit" class="badge" style="background-color: #15acda;"></span>
                </div>
            </div>
        </div>
        <br>
        <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>
    </div>

    <div id="about_user" style="display: none;">
        <div class="row">
            <div class="col-md-12" style="position: relative; padding-top: 10px;">
                <b>关于作者</b>
                <hr>
            </div>
        </div>
        <div class="row" style="color: #000;">
            <div class="col-md-3 col-xs-2">
                <div style="position: relative; width: 52px; height: 52px;">
                    <img id="about_photo" alt="用户头像" src="${APP_PATH}/static/img/head.png"
                         style="width: 100%; height: 100%; border-radius: 26px;">
                </div>
            </div>
            <div class="col-md-9 col-xs-10">
                <b id="about_name" style="position: relative; top: 2px; font-size: 16px;"></b>
                <p id="about_email" style="position: relative; top: 8px; color: #72777b;"></p>
            </div>
            <div class="col-md-12" style="padding: 5px 0 3px 25px">
                <span title="粉丝" class="glyphicon glyphicon-fire attention_r"></span>
                <span style="font-size: 15px; padding: 0 0 0 15px;">拥有粉丝
                    <span id="about_fansCount" class="text-primary" style="padding: 0 0 0 5px"></span>
                </span>
            </div>
            <div class="col-md-12" style="padding: 5px 0 3px 25px">
                <samp title="收藏" class="glyphicon glyphicon-heart collect_r"></samp>
                <span style="font-size: 15px; padding: 0 0 0 15px;">获得收藏
                    <span id="about_collectCount" class="text-primary" style="padding: 0 0 0 5px"></span>
                </span>
            </div>
            <div class="col-md-12" style="padding: 5px 0 3px 25px">
                <span title="点赞" class="glyphicon glyphicon-thumbs-up enjoy_r"></span>
                <span style="font-size: 15px; padding: 0 0 0 15px;">获得点赞
                    <span id="about_enjoyCount" class="text-primary" style="padding: 0 0 0 5px"></span>
                </span>
            </div>
            <div class="col-md-12" style="padding: 5px 0 3px 25px">
                <img src="${APP_PATH}/static/img/share/eye.png" style="position: relative; top: -1px;">
                <span style="font-size: 15px; padding: 0 0 0 15px;">文章被阅读
                    <span id="about_pvCount" class="text-primary" style="padding: 0 0 0 5px"></span>
                </span>
            </div>
        </div>
        <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>
    </div>

    <div class="row">
        <div class="col-md-12" style="position: relative; padding-top: 10px;">
            <b>所有板块</b>
            <hr>
        </div>
    </div>
    <!-- 板块展示-模板 -->
    <div class="row" id="plates_all_hide" style="display: none">
        <div class="col-xs-4 col-md-4 text-center">
            <a id="plates_all_a" href="#">
                <img class="img_right_logo_bankuai" src="${APP_PATH}/static/img/houtai.png">
                <p id="plates_all_bname"></p>
            </a>
        </div>
    </div>
    <!-- 板块展示-实际数据 -->
    <div class="row" id="plates_all"></div>
    <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>

    <div class="row">
        <div class="col-md-12" style="position: relative; padding-top: 10px;">
            <b>热门文章</b>
            <hr>
        </div>
    </div>
    <!-- 热门文章展示-模板 -->
    <div id="hotArticle_all_hide" style="display: none">
        <div class="row">
            <div class="col-md-3">
                <img id="hotArticle_img" style="display: none; width: 100%; min-height: 20px; max-height: 80px;">
            </div>
            <div class="col-md-offset-3">
                <a href="javascript:void(0)">
                    <span id="hotArticle_all_a"></span>
                    <img src="${APP_PATH}/static/img/share/eye.png" style="position: relative; top: -1px;">
                    <!-- 文章浏览量 -->
                    <span id="hotArticle_pv" style="color: #c0c0c0;"></span>
                </a>
            </div>
            <div class="col-md-12"><br></div>
        </div>
    </div>
    <!-- 热门文章展示-实际数据 -->
    <div id="hotArticle_all"></div>
    <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>

    <div class="row">
        <div class="col-md-12" style="position: relative; padding-top: 10px;">
            <b>最新评论</b>
            <hr>
        </div>
    </div>
    <!-- 最新评论展示-模板 -->
    <div id="newComment_all_hide" style="display: none">
        <div class="row">
            <div class="col-md-12">
                <a href="javascript:void(0)" id="newComment_all_a"></a>
            </div>
            <div class="col-md-12"><br></div>
        </div>
    </div>
    <!-- 最新评论展示-实际数据 -->
    <div id="newComment_all"></div>
    <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>

    <div class="row">
        <div class="col-md-12" style="position: relative; padding-top: 10px;">
            <b>访问统计</b>
            <hr>
        </div>
    </div>
    <div style="height:280px;" id="visit_country"></div>
    <hr>
    <div style="height:380px;" id="visit_province"></div>

    <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>
    <!-- 论坛简介、更新日志、友情链接 -->
    <jsp:include page="util.jsp"></jsp:include>
</div>
</body>
</html>
