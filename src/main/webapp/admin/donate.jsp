<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增捐赠</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
</head>
<body>
	<div class="modal fade" id="donate_Add" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content col-md-10 col-md-offset-1">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title text-center" id="exampleModalLabel">新增捐赠</h3>
				</div>
				<div class="modal-body">
					<form id="form_addDonate">
						<%-- 进度条 --%>
						<jsp:include page="/content/progress.jsp"></jsp:include>
						<p class="text-muted">捐赠者：</p>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="给你捐赠的人" id="donator" name="donator">
						</div>
						<p class="text-muted">捐赠金额：</p>
						<div class="form-group">
							<input type="number" class="form-control" placeholder="给你捐赠的金额" id="money" name="money">
						</div>
						<p class="text-muted">捐赠平台：</p>
						<div class="form-group">
							<select class="form-control" id="platform" name="platform">
								<option>支付宝</option>
								<option>微信</option>
								<option>QQ</option>
							</select>
						</div>
						<p class="text-muted">捐赠截图：</p>
						<div class="form-group">
							<input type="file" class="form-control" id="imagePath" name="imagePath" accept="image/*">
						</div>

						<div class="modal-footer">
							<button type="reset" class="btn btn-default">清空</button>
							<button type="button" class="btn btn-primary" onclick="donateAdd()">提交</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>