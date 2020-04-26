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
	<title>意见反馈</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<style>
.sub{
	margin-top:20px;
	width:100%;
	height:40px;
	border-radius:5px;
	border:1px solid #cbcbcb;
	background-color:white;
	text-align:center;
	line-height:40px;
	display:block;
}
</style>
<script>
function save() {
	var content = $("#content").val();
	if(content.length == 0) {
		alert("请填写反馈内容");
		return;
	}
	$.ajax({
		type: "post",
		url: "<%=path%>/advice/save",
		dataType: "json",
		data: "advice.content=" + content,
		success: function(data){
			if(data.code == "1"){
				$("#content").val("");
				msgSuccess("反馈成功！");
			}else{
				msgError("反馈失败，请稍后重试！");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("反馈失败，请稍后重试！");
		}
	});
}
</script>
</head>
<body style="background:#F3F3F3;padding:0px 15px 15px 15px;margin:0px;">
	<div class="index_tou">
	    <p>反馈意见<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
	</div>
	<div class="h60"></div>
	<span style="font-size:1em;">内容描述</span>
	<textarea id="content" style="margin-top:10px;width:98%;height:100px;border:1px solid #cbcbcb"></textarea>
	<a href="javascript:void(0)" class="sub" onclick="save()">提交</a>
</body>
</html>