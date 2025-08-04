/*
 * 仪表盘
 */
$(".cut-ybp").click(function() {
	$(".ybp").show();
	$(".yhgl").hide();
	$(".tzgl").hide();
	$(".bkgl").hide();
	$(".fwjl").hide();
	$(".bbgl").hide();
	$(".lbtgl").hide();
	$(".xmgl").hide();
	$(".jzgl").hide();

	$(".cut-ybp").attr("style", "color: #36e2ff !important; background-color: #1d262a; border-left: 3px solid #3c8dbc;");
	$(".cut-yhgl").removeAttr("style");
	$(".cut-tzgl").removeAttr("style");
	$(".cut-bkgl").removeAttr("style");
	$(".cut-fwjl").removeAttr("style");
	$(".cut-bbgl").removeAttr("style");
	$(".cut-lbtgl").removeAttr("style");
	$(".cut-xmgl").removeAttr("style");
	$(".cut-jzgl").removeAttr("style");
});

/*
 * 用户管理
 */
$(".cut-yhgl").click(function() {
	$(".ybp").hide();
	$(".yhgl").show();
	$(".tzgl").hide();
	$(".bkgl").hide();
	$(".fwjl").hide();
	$(".bbgl").hide();
	$(".lbtgl").hide();
	$(".xmgl").hide();
	$(".jzgl").hide();

	$(".cut-ybp").removeAttr("style");
	$(".cut-yhgl").attr("style", "color: #36e2ff !important; background-color: #1d262a; border-left: 3px solid #3c8dbc;");
	$(".cut-tzgl").removeAttr("style");
	$(".cut-bkgl").removeAttr("style");
	$(".cut-fwjl").removeAttr("style");
	$(".cut-bbgl").removeAttr("style");
	$(".cut-lbtgl").removeAttr("style");
	$(".cut-xmgl").removeAttr("style");
	$(".cut-jzgl").removeAttr("style");
});

/*
 * 文章管理
 */
$(".cut-tzgl").click(function() {
	$(".ybp").hide();
	$(".yhgl").hide();
	$(".tzgl").show();
	$(".bkgl").hide();
	$(".fwjl").hide();
	$(".bbgl").hide();
	$(".lbtgl").hide();
	$(".xmgl").hide();
	$(".jzgl").hide();

	$(".cut-ybp").removeAttr("style");
	$(".cut-yhgl").removeAttr("style");
	$(".cut-tzgl").attr("style", "color: #36e2ff !important; background-color: #1d262a; border-left: 3px solid #3c8dbc;");
	$(".cut-bkgl").removeAttr("style");
	$(".cut-fwjl").removeAttr("style");
	$(".cut-bbgl").removeAttr("style");
	$(".cut-lbtgl").removeAttr("style");
	$(".cut-xmgl").removeAttr("style");
	$(".cut-jzgl").removeAttr("style");
});

/*
 * 板块管理
 */
$(".cut-bkgl").click(function() {
	$(".ybp").hide();
	$(".yhgl").hide();
	$(".tzgl").hide();
	$(".bkgl").show();
	$(".fwjl").hide();
	$(".bbgl").hide();
	$(".lbtgl").hide();
	$(".xmgl").hide();
	$(".jzgl").hide();

	$(".cut-ybp").removeAttr("style");
	$(".cut-yhgl").removeAttr("style");
	$(".cut-tzgl").removeAttr("style");
	$(".cut-bkgl").attr("style", "color: #36e2ff !important; background-color: #1d262a; border-left: 3px solid #3c8dbc;");
	$(".cut-fwjl").removeAttr("style");
	$(".cut-bbgl").removeAttr("style");
	$(".cut-lbtgl").removeAttr("style");
	$(".cut-xmgl").removeAttr("style");
	$(".cut-jzgl").removeAttr("style");
});

/*
 * 访问记录
 */
$(".cut-fwjl").click(function() {
	$(".ybp").hide();
	$(".yhgl").hide();
	$(".tzgl").hide();
	$(".bkgl").hide();
	$(".fwjl").show();
	$(".bbgl").hide();
	$(".lbtgl").hide();
	$(".xmgl").hide();
	$(".jzgl").hide();

	$(".cut-ybp").removeAttr("style");
	$(".cut-yhgl").removeAttr("style");
	$(".cut-tzgl").removeAttr("style");
	$(".cut-bkgl").removeAttr("style");
	$(".cut-fwjl").attr("style", "color: #36e2ff !important; background-color: #1d262a; border-left: 3px solid #3c8dbc;");
	$(".cut-bbgl").removeAttr("style");
	$(".cut-lbtgl").removeAttr("style");
	$(".cut-xmgl").removeAttr("style");
	$(".cut-jzgl").removeAttr("style");
});

/*
 * 轮播管理
 */
$(".cut-lbtgl").click(function() {
	$(".ybp").hide();
	$(".yhgl").hide();
	$(".tzgl").hide();
	$(".bkgl").hide();
	$(".fwjl").hide();
	$(".bbgl").hide();
	$(".lbtgl").show();
	$(".xmgl").hide();
	$(".jzgl").hide();

	$(".cut-ybp").removeAttr("style");
	$(".cut-yhgl").removeAttr("style");
	$(".cut-tzgl").removeAttr("style");
	$(".cut-bkgl").removeAttr("style");
	$(".cut-fwjl").removeAttr("style");
	$(".cut-bbgl").removeAttr("style");
	$(".cut-lbtgl").attr("style", "color: #36e2ff !important; background-color: #1d262a; border-left: 3px solid #3c8dbc;");
	$(".cut-xmgl").removeAttr("style");
	$(".cut-jzgl").removeAttr("style");
});