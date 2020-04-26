<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>帮助中心</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
<style>
body{ background-color:#f3f3f3}
ul li{ background-color:#fff; border-bottom:1px #D0D0D0 solid; margin-bottom:5px; padding:9px 10px; height:40px;overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
ul li span{ padding-left:10px}
a,a:focus{ color:#333}
</style>
<script>

</script>
</head>
<body>
<!--公共参数-->
<div class="index_tou">
	<p>帮助中心 </p>
	<a href="javascript:window.history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a>
</div>
<div class="h40"></div>
<div class="h10"></div>
<div>
	<ul>
		<s:iterator value="helpList" id="item" status="index">
			<a href="<s:property value="url" />"><li><strong><s:property value="#index.index+1"/> </strong><span><s:property value="title" /></span></li></a>
		</s:iterator>
	</ul>
</div>
<div class="h30"></div>
</body>
</html>