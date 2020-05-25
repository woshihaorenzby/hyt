<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String userName = request.getSession().getAttribute("userName").toString();
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.min.css"></link>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
<script>
$(function(){
});
function toPage(){
	window.parent.document.getElementById("mainAreaFrame").src="<%=path%>/admin/changePasShow";
}
function outSys(){
	window.parent.location.href="<%=path%>/admin/showLogin";
}
</script>
</head>
<body onload="showDT();">
<div style="padding-top:10px;padding-right:10px;width:100%;height:70px;background:#37b3E0;">
	<span style="font-size:20px;color:white;font-weight:bold;line-height:50px;">&nbsp;&nbsp;选卡网后台管理系统</span>
	<img src="<%=path%>/images/cancel.png" onclick="outSys()" style="float:right;width:35px;height:35px;margin-top:10px;cursor:pointer;" title="退出系统">
	<img src="<%=path%>/images/paper.png" onclick="toPage()" style="float:right;width:35px;height:35px;margin-top:10px;cursor:pointer;margin-right:5px;" title="修改密码">
	<div style="float:right;margin-right:30px;margin-top:30px;color:white;font-weight:bold;">欢迎您：<%=userName%>&nbsp;&nbsp;&nbsp;系统时间：<span id="theClock"></span></div>
</div>
</body>
</html>