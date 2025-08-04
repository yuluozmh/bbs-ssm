<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>南生论坛-管理系统</title>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<link href="${APP_PATH }/static/img/admin/favicon-admin.ico" rel='icon' type='image/x-icon'/>
	<link href="${APP_PATH }/static/css/base.css" rel="stylesheet" />
</head>
<body>
<!-- 管理员页面-头部 -->
<jsp:include page="/admin/head.jsp"></jsp:include>
<!-- 管理员页面-主体内容 -->
<jsp:include page="/admin/content.jsp"></jsp:include>
<!-- 管理员页面-登录、注册 -->
<jsp:include page="/admin/login.jsp"></jsp:include>
<!-- 管理员页面-新增文章 -->
<jsp:include page="/admin/plate.jsp"></jsp:include>
<!-- 管理员页面-修改文章 -->
<jsp:include page="/admin/plateEdit.jsp"></jsp:include>
<!-- 管理员页面-新增轮播图 -->
<jsp:include page="/admin/slider.jsp"></jsp:include>
</body>
</html>