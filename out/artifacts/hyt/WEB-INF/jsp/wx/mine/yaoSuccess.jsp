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
	<title>微名片</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<style type="text/css">
.index_tou_baocun{ width:50px;float:right;top:5px;position:absolute;right:3%;}
.green1{ background-color:#00DD37}
.bottitle{ width:49.5%;height:50px;background-color:#e9ca93;float:left;font-size:18px;text-align:center;line-height:50px;font-weight:bold; }
</style>
<script type="text/javascript">
function inPage() {
	window.open("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx577b557dfebd5bd0&redirect_uri=http%3A%2F%2Fwd.cd08.com%2Fhyt%2Fhyuser%2FwxIndex&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect");
}
</script>
</head>
<body>
<!--头部-->
<div class="index_tou">
    <p>加入群组<a href="#"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
</div>
<div class="h100"></div>
<div style="text-align:center;">
	<span style="margin-left:auto;margin-right:auto;font-size:18px;"><s:property value="messageVo.message" /></span>
	<div onclick="inPage();" style="margin-left:auto;margin-right:auto;margin-top:50px;width:100px;padding-top:5px;padding-bottom:5px;border:1px solid #325f7e;border-radius:5px;color:#325f7e;">
		进入选号网
	</div>
</div>
</body>
</html>