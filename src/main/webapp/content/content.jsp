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
    <link href="${APP_PATH}/static/css/css.css" rel="stylesheet">
    <link rel="stylesheet" href="${APP_PATH}/static/slider/jSlider.min.css">
</head>
<body>
<!--主体（下）-->
<div class="container">
    <div class="row">
        <!--左边板块-->
        <div id="content_left">
            <%-- 轮播图-模板 --%>
            <div id="slider_hide" style="display: none;">
                <div>
                    <span class="article_cat">
                        <a class="slider_text" target="_blank"></a>
                    </span>
                    <img class="slider_image">
                </div>
            </div>
            <%-- 轮播图-实际数据 --%>
            <div id="slider_all" class="jSlider" data-loop="true" style="width: 104%; left: -2%;"></div>
            <div class="row" style="position: relative; background-color: #f6f6f6; height: 10px;"></div>
            <!--代码部分begin-->
            <div class="jq22">
                <!-- 文章展示-模板 -->
                <jsp:include page="articlesHide.jsp"></jsp:include>
                <!-- 文章展示-实际数据 -->
                <div id="articles_all"></div>
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
    <br>
</div>

<script src="${APP_PATH }/static/js/echars/echarts.min.js"></script>

<script src="${APP_PATH }/static/js/content/content.js"></script>
<script src="${APP_PATH }/static/js/content/comment.js"></script>
<script src="${APP_PATH }/static/js/content/attention.js"></script>
<script src="${APP_PATH }/static/js/content/collect.js"></script>
<script src="${APP_PATH }/static/js/content/enjoy.js"></script>
<script src="${APP_PATH }/static/js/content/plate.js"></script>
<script src="${APP_PATH }/static/js/content/article.js"></script>
<script src="${APP_PATH }/static/js/content/visit.js"></script>
<script src="${APP_PATH }/static/js/content/common.js"></script>
<script id="appendJS"></script>

<script src="${APP_PATH }/static/js/phones_pc.js"></script>
<script src="${APP_PATH }/static/js/load_more.js"></script>

</body>
</html>