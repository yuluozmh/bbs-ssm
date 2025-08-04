<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增轮播图</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
</head>
<body>
	<div class="modal fade" id="slider_Add" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content col-md-10 col-md-offset-1">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title text-center" id="exampleModalLabel">新增轮播图</h3>
				</div>
				<div class="modal-body">
					<form id="form_addSlider">
						<%-- 进度条 --%>
						<jsp:include page="/content/progress.jsp"></jsp:include>
						<p class="text-muted">文字内容：</p>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="给这张轮播图一段说明" id="text" name="text">
						</div>
						<p class="text-muted">文字链接：</p>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="给上面的文字内容一个链接" id="textUrl" name="textUrl">
						</div>
						<p class="text-muted">轮播图：</p>
						<div class="form-group">
							<input type="file" class="form-control" id="imageUrl" name="imageUrl" accept="image/*">
						</div>

						<div class="modal-footer">
							<button type="reset" class="btn btn-default">清空</button>
							<button type="button" class="btn btn-primary" onclick="sliderAdd()">提交</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>