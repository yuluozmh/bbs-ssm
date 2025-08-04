<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>头部</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link rel="stylesheet" href="${APP_PATH}/static/layui/css/layui.css"/>
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${APP_PATH}/static/css/css.css" rel="stylesheet">
</head>
<body>
<%-- 方便ajax获取APP_PATH --%>
<input id="APP_PATH" type="hidden" value="${APP_PATH}" >
<input id="session_userid" type="hidden" value="${userid}" >
<input id="session_username" type="hidden" value="${username}" >
<input id="session_email" type="hidden" value="${email}" >
<input id="session_userPhoto" type="hidden" value="${userPhoto}" >
<input id="session_aname" type="hidden" value="${sessionAname}" >
<input id="session_acreateTime" type="hidden" value="${sessionAcreateTime}" >

<!--导航条（头）-->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="row">
            <div class="col-md-11 nsbbs_head">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed"
                            data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                            aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span> <span
                            class="icon-bar"></span> <span class="icon-bar"></span> <span
                            class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand nsbbs_head_logo" href="${APP_PATH}/index.jsp">
                        <img class="img_logo" alt="Brand" src="${APP_PATH}/static/img/logo-lanse.png">
                    </a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="${APP_PATH}/index.jsp">首页 <span class="sr-only">(current)</span></a>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav">
                        <form class="navbar-form navbar-left" method="post">
                            <div class="col-xs-9 col-md-8">
                                <input type="text" name="articleTitle" class="form-control" placeholder="输入搜索内容..." required>
                            </div>
                            <div class="col-xs-3 col-md-4">
                                <button type="button" class="btn btn-primary">搜索</button>
                            </div>
                        </form>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="chat" style="cursor: pointer;">
                            <a href="http://chat.nansin.top/" target="_blank">闲聊</a>
                        </li>
                        <li>
                            <a href="${APP_PATH}/admin/index.jsp" target="_blank">管理端</a>
                        </li>
                        <li>
                            <a href="${APP_PATH}/posted.jsp">写文章</a>
                        </li>

                        <!----------------------------------- 未登录时显示 ----------------------------------->
                        <li class="head_logout" style="display:none;">
                            <a data-toggle="modal" data-target="#loginModal" href="#" id="loginButton">登录</a>
                        </li>
                        <!----------------------------------- 未登录时显示-end ----------------------------------->

                        <!----------------------------------- 已登录时显示 ----------------------------------->
                        <li class="dropdown head_login col-md-2" style="display:none;">
                            <img data-toggle="dropdown" class="head_userPhoto" src="${APP_PATH}/static/img/head.png" alt="头像">
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#" onclick="goMyHome()">
                                        <div class="row">
                                            <div class="col-xs-1 col-md-2 col-md-offset-1">
                                                <img src="${APP_PATH}/static/img/wodezhuye.png">
                                            </div>
                                            <div class="col-xs-3 col-md-6">我的主页</div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="${APP_PATH}/album.jsp">
                                        <div class="row">
                                            <div class="col-xs-1 col-md-2 col-md-offset-1">
                                                <img src="${APP_PATH}/static/img/xinagce.png">
                                            </div>
                                            <div class="col-xs-3 col-md-6">我的相册</div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" data-toggle="modal" data-target="#setup">
                                        <div class="row">
                                            <div class="col-xs-1 col-md-2 col-md-offset-1">
                                                <img src="${APP_PATH}/static/img/shezhi.png">
                                            </div>
                                            <div class="col-xs-6 col-md-6">设置</div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" id="userExit">
                                        <div class="row">
                                            <div class="col-xs-1 col-md-2 col-md-offset-1">
                                                <img src="${APP_PATH}/static/img/tuichu.png">
                                            </div>
                                            <div class="col-xs-6 col-md-6">退出</div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!----------------------------------- 已登录时显示-end ----------------------------------->
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="${APP_PATH}/static/bootstrap/js/bootstrap.js"></script>
<script src="${APP_PATH }/static/layer/layer.js"></script>
<script src="${APP_PATH }/static/layui/layui.js"></script>

<script src="${APP_PATH }/static/js/phones_pc.js"></script>
<script src="${APP_PATH}/static/js/share.js"></script>
<script src="${APP_PATH}/static/js/common.js"></script>
<script src="${APP_PATH}/static/js/head/head.js"></script>
</body>
</html>
