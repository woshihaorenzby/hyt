<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="x-ua-compatible" content="ie=9" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	<title>选号网</title>
	<style>
		.box{ position:absolute;}
	</style>
	<script>
		 window.onload=function()
		 {
			 var oBox=document.getElementById('box');
			 adjustResize();
			window.onresize=window.onscroll=adjustResize;
			function adjustResize()
			{
			     var iWidth=document.documentElement.clientWidth;
				 var iHegiht=Math.max(document.documentElement.clientHeight,document.body.clientHeight);
				 oBox.style.left=(iWidth-oBox.offsetWidth)/2+'px';
				 oBox.style.top=(iHegiht-oBox.offsetHeight)/2+'px';
				  }
			}
	</script>
</head>
<div class="box" id="box">
<iframe  width="375" height="680"  id="mainFrame" noResize="" src="<%=path%>/hyuser/wxIndex" name="mainFrame" scrolling="yes"></iframe >
</div>
</html>