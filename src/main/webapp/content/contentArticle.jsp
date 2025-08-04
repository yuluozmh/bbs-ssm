<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>主体内容</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link rel="stylesheet" href="${APP_PATH}/static/editor.md-master/css/editormd.preview.min.css"/>
    <link href="${APP_PATH}/static/css/css.css" rel="stylesheet">
    <link href="${APP_PATH}/static/magnify/magnify.css" rel="stylesheet">
</head>
<body>
<!-- Swiper -->
<div class="swiper-container text-center" id="origin-img">
    <div class="swiper-wrapper"></div>
</div>
<!--主体（下）-->
<div class="container">
    <div class="row">
        <!--左边板块-->
        <div id="content_left">
            <!--代码部分begin-->
            <div class="jq22">
                <div class="articleDetails">
                    <!-- 文章展示-详情 -->
                    <jsp:include page="articleDetails.jsp"></jsp:include>
                </div>
                <div class="plateQuery">
                    <!-- 文章展示-模板（主要用于板块查询） -->
                    <jsp:include page="articlesHide.jsp"></jsp:include>
                    <!-- 文章展示-实际数据 -->
                    <div id="articles_all"></div>
                </div>
                <!-- 加载更多 -->
                <div class="text-center more">
                    <a id="appendMore" class="text-info" style="display: none;" href="javascript:void(0)">点击--->加载更多</a>
                </div>
            </div>
            <div class="row" style="position: relative; background-color: #f6f6f6; height: 30px;"></div>
        </div>

        <!--右边板块-->
        <jsp:include page="contentRight.jsp"></jsp:include>
    </div>
</div>
<script src="${APP_PATH}/static/editor.md-master/lib/marked.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/lib/prettify.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/lib/raphael.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/lib/underscore.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/lib/sequence-diagram.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/lib/flowchart.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/lib/jquery.flowchart.min.js"></script>
<script src="${APP_PATH}/static/editor.md-master/editormd.min.js"></script>

<script src="${APP_PATH }/static/js/echars/echarts.min.js"></script>

<script src="${APP_PATH }/static/js/delete.js"></script>
<script src="${APP_PATH }/static/js/content/contentArticle.js"></script>
<script src="${APP_PATH }/static/js/content/comment.js"></script>
<script src="${APP_PATH }/static/js/content/attention.js"></script>
<script src="${APP_PATH }/static/js/content/collect.js"></script>
<script src="${APP_PATH }/static/js/content/enjoy.js"></script>
<script src="${APP_PATH }/static/js/content/plate.js"></script>
<script src="${APP_PATH }/static/js/content/user.js"></script>
<script src="${APP_PATH }/static/js/content/visit.js"></script>
<script src="${APP_PATH }/static/js/share.js"></script>
<script src="${APP_PATH }/static/js/content/common.js"></script>
<script src="${APP_PATH }/static/js/content/article.js"></script>


<script src="${APP_PATH }/static/js/phones_pc.js"></script>
<script src="${APP_PATH }/static/js/load_more.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.2/js/swiper.min.js"></script>
<script src="${APP_PATH }/static/magnify/magnify.js"></script>
</body>
</html>