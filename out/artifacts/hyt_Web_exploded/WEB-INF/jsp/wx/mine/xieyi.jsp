<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String host = request.getServerName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>用户协议</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/wx/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	body{ background-color:#fff}
	.yingcang{overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
	.baikuang{width:40%;height:55%; text-align:center; font-size:10px; background:#FFFFFF; border-radius:10px; position:absolute; top:70px; left:30%}
	.jieshou{position:absolute; top:240px; left:8%; font-size:14px; color:#666; line-height:25px;width:92%; }
</style>
<script type="text/javascript">

</script>
</head>
<body>
	<div class="index_tou">
	    <p>选号网用户服务协议<a href="javascript:window.history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
	</div>
	<div class="h60"></div>
	<div class="w90">
		<s:property value="hySystem.userAggrement" />
	</div>
</body>
</body>
</html>