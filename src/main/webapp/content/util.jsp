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
    <title>论坛简介、更新日志、友情链接</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
</head>
<body>
    <div class="row">
        <div class="col-md-12" style="position: relative; padding-top: 10px;">
            <b>友情链接</b>
            <hr>
        </div>
    </div>
    <div style="line-height:30px;">
        <p>
            <a href="https://github.com/maliangnansheng" target="_blank">
                <b class="text-primary">GitHub</b> - <small>虽千万人吾往矣、虽千万事吾往矣</small>
            </a>
        </p>
        <p>
            <a href="https://gitee.com/maliangnansheng" target="_blank">
                <b class="text-primary">Gitee</b> - <small>虽千万人吾往矣、虽千万事吾往矣</small>
            </a>
        </p>
        <p>
            <a href="http://www.nansin.top/" target="_blank">
                <b class="text-primary">南生论坛</b> - <small>弱者才言命，强者只言运！</small>
            </a>
        </p>
        <h4>......</h4>
    </div>
    <br>
</body>
</html>
