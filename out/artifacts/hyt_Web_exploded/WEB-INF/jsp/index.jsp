<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="x-ua-compatible" content="ie=9" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	<title>选号网后台管理系统</title>
</head>
<frameset frameSpacing="0" name="indexFrameSet" border="0" frameBorder="no" rows="70,*">
	<frame id="topFrame" noResize="" src="<%=path%>/admin/head" name="topFrame" scrolling="no">
	<frameset id="mainFrameSet" frameSpacing="0" name="mainFrameSet" cols="180,*" frameBorder="no" rows="*">
		<frame id="mainLeftFrame" noResize="" src="<%=path%>/admin/left" name="mainLeftFrame" scrolling="yes">
		<frame id="mainAreaFrame" noResize="" src="" name="mainAreaFrame" scrolling="auto">
	</frameset>
</frameset>
</html>