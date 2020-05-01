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
	var saler = $("#saler").val();
	var content = $("#content").val();
	var needContent = $("#needContent").val();
	var contactInformation = $("#contactInformation").val();
	if(saler.length == 0) {
		alert("请填写业务员");
		return;
	}
	if(content.length == 0) {
		alert("请填写投诉内容或建议");
		return;
	}
	if(needContent.length == 0) {
		alert("请填写您的诉求");
		return;
	}
	if(contactInformation.length == 0) {
		alert("请留下您的联系方式");
		return;
	}
	$.ajax({
		type: "post",
		url: "<%=path%>/advice/save",
		dataType: "json",
		data: {
			"advice.saler":saler,
			"advice.content":content,
			"advice.needContent":needContent,
			"advice.contactInformation":contactInformation,
		},
		success: function(data){
			if(data.code == "1"){
				$("#content").val("");
				$("#saler").val("");
				$("#needContent").val("");
				 $("#contactInformation").val("");
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
	    <p>投诉建议<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
	</div>
	<div class="h60"></div>
	<span style="font-size:1em; ">1、您是找哪个业务员购买的
		<i style="font-size:1.5em; font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;color: #9c0009">*</i>
	</span>
	<textarea id="saler" style="margin-top:10px;width:98%;height:30px;border:1px solid #cbcbcb"></textarea>
	<span style="font-size:1em; ">2、投诉内容或建议
		<i style="font-size:1.5em; font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;color: #9c0009">*</i>
	</span>
	<textarea id="content" style="margin-top:10px;width:98%;height:100px;border:1px solid #cbcbcb"></textarea>
	<span style="font-size:1em; ">3、您的诉求
		<i style="font-size:1.5em; font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;color: #9c0009">*</i>
	</span>
	<textarea id="needContent" style="margin-top:10px;width:98%;height:100px;border:1px solid #cbcbcb"></textarea>
	<span style="font-size:1em; ">4、留下您的联系方式
		<i style="font-size:1.5em; font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;color: #9c0009">*</i>
	</span>
	<textarea id="contactInformation" style="margin-top:10px;width:98%;height:100px;border:1px solid #cbcbcb"></textarea>
	<a href="javascript:void(0)" class="sub" onclick="save()">提交</a>
</body>
</html>