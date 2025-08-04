<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>我的相册-相册</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH }/static/img/favicon.ico" rel='icon' type='image/x-icon'/>
</head>
<body>
<!-- 我的主页-头部 -->
<jsp:include page="/head/head.jsp"></jsp:include>
<!-- 我的主页-登录、注册 -->
<jsp:include page="/login/login.jsp"></jsp:include>
<!-- 我的主页-基本信息设置 -->
<jsp:include page="/head/setup.jsp"></jsp:include>
<!-- 我的相册（相册）-主体内容 -->
<jsp:include page="/photo/showAlbum.jsp"></jsp:include>
<!-- 我的相册-创建相册 -->
<jsp:include page="/photo/albumAdd.jsp"></jsp:include>
<!-- 首页-页脚 -->
<jsp:include page="/head/footer.jsp"></jsp:include>
</body>
</html>