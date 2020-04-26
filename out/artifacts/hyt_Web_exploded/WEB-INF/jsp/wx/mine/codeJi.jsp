<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>积分机制</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background:#F3F3F3;padding:0 15px 15px 15px;margin:0px;">
	<div class="index_tou">
	    <p>积分机制<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
	</div>
	<div class="h60"></div>
	<div style="width:100%;line-height:80px;font-size:1em;text-align:center;">积分机制</div>
	<div style="width:100%;height:1px;border-top:1px dashed #dedede;"></div>
	<p>1、阅读总数每10次积1分；</p>
	<p>2、每分享1次积1分；</p>
	<p>3、广告点击1次积1分；</p>
	<p>备注：积分未来可以消费</p>
</body>
</html>