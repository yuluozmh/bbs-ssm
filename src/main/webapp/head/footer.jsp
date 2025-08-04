<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>页脚</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <link href="${APP_PATH}/static/css/css.css" rel="stylesheet">
</head>
<body>
<br><br><br>
<footer id="nansheng_footer" class="container-fluid foot-wrap text-center">
    <p style="color: #737373;">
        版权 © <a href="http://www.nansin.top/" target="_blank"> 南生论坛 </a>丨
        <a href="http://www.beian.miit.gov.cn/" target="_blank">蜀ICP备19014736号-1 </a>
        <a href="#" target="_blank">
            <%--                赣公网安备360421020004437--%>
        </a>
    </p>
</footer>

<script src="${APP_PATH }/static/js/head/footer.js"></script>
</body>
</html>
