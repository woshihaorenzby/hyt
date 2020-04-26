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
	<title>消息中心</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body{
	background:#F3F3F3;
}
</style>
</head>
<body>
<div class="index_tou">
    <p>消息中心<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
</div>
<div class="h60"></div>
<div class="w100">
	<ul class="xiaoxi_ul">
		<s:iterator value="noticeList" id="item">
			<a href="<%=path%>/notice/wxNoticeDetail?notice.id=<s:property value="id" />">
				<li>
					<div class="w96">
						<p class="dian h40 f16 hei" title="<s:property value="title" />"><s:property value="title" /></p>
						<p class="f5 qianhui"><s:property value="createTime" /></p>
					</div>
	           </li>
	       </a>
		</s:iterator>
	</ul>
</div>
<div class="h50"></div>
</body>
</html>