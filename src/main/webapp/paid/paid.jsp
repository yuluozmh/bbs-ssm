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
</head>
<body>
<div class="container">
    <div class="container col-md-12">
        <%-- 商品-模板 --%>
        <div id="paid_hide" style="display: none;">
            <div class="col-md-6 col-xs-12" style="padding-top: 10px;">
                <div class="col-md-12" style="background-color: #ffffff">
                    <div class="product-grid">
                        <div class="product-content">
                            <h4>
                                <span id="paid_name" style="font-weight: bold;"></span>
                                <button class="btn-xs btn-primary" style="border: 0;">
                                    <a id="paid_detailPath" style="color: #fff;" target="_blank">详情</a>
                                </button>
                            </h4>
                            <div class="price discount" style="padding-bottom: 3px;">
                                <b>￥</b>
                                <span id="paid_oldPrice"></span>
                                <b id="paid_newPrice"></b>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <a id="paid_payLink" style="color: #fff;" target="_blank">
                                    <button class="btn-xs btn-danger" style="border: 0;">获取源码</button>
                                </a>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <small><a href="http://pay.nansin.top/pay" style="color:#9a9a9a;" target="_blank">先用一分钱测试下</a></small>
                            </div>
                            <div>
                                <b>技术栈：</b>
                                <small id="paid_technology" class="text-info"></small>
                            </div>
                            <div>
                                <b>演示：</b>
                                <small id="paid_demoUrl"></small>
                            </div>
                            <span>
                                <b>资料：</b>
                                <small id="paid_append" class="text-warning"></small>
                            </span>
                            <div style="color:#ff9900;">
                                <b>联系：</b>
                                <small id="paid_authorInfo"></small>
                            </div>
                        </div>
                        <div class="product-image">
                            <a href="#">
                                <img class="pic-1" alt="商品图1">
                                <img class="pic-2" alt="商品图2">
                            </a>
                            <span class="product-trend-label paid_type"></span>
                            <span class="product-discount-label paid_depreciate"></span>
                            <%--<ul class="social">
                                <li><a href="#" data-tip="Add to Cart"><i class="fas fa-shopping-cart"></i></a></li>
                                <li><a href="#" data-tip="Wishlist"><i class="far fa-heart"></i></a></li>
                                <li><a href="#" data-tip="Compare"><i class="fas fa-random"></i></a></li>
                                <li><a href="#" data-tip="Quick View"><i class="fas fa-search"></i></a></li>
                            </ul>--%>
                        </div>
                    </div>
                    <br>
                </div>
                <br>
            </div>
        </div>
        <%-- 商品-实际数据 --%>
        <div id="paid_all" class="row" style="display: flex; flex-wrap: wrap;"></div>
    </div>
</div>

</body>
</html>
