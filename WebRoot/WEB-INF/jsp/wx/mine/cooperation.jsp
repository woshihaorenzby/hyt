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
	var company = $("#company").val();
	var cooperationer = $("#cooperationer").val();
	var mobile = $("#mobile").val();
	if(content.length == 0) {
		alert("请填写项目简介及初步合作方案说明");
		return;
	}
	if(cooperationer.length == 0) {
		alert("请填写项目联系人姓名");
		return;
	}
	if(mobile.length == 0) {
		alert("请留下项目联系人手机");
		return;
	}
	$.ajax({
		type: "post",
		url: "<%=path%>/cooperation/wxSave",
		dataType: "json",
		data: {
			"cooperation.content":content,
			"cooperation.company":company,
			"cooperation.cooperationer":cooperationer,
			"cooperation.mobile":mobile,
		},
		success: function(data){
			if(data.code == "1"){
				$("#content").val("");
				$("#company").val("");
				$("#cooperationer").val("");
				 $("#mobile").val("");
				msgSuccess("添加合作资料成功！");
			}else{
				msgError("添加合作资料，请稍后重试！");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("添加合作资料，请稍后重试！");
		}
	});
}
</script>
</head>
<body style="background:#F3F3F3;padding:0px 15px 15px 15px;margin:0px;">
	<div class="index_tou" style="background-color: rgb(62, 61, 50); height: auto; min-height: 180px; background-image: url('<%=path%>/images/cooperation.jpg'); background-position: 50% 50%; background-repeat: no-repeat; background-size:cover">
	    <p>商务合作<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
		<div class="h_description" style="text-align:center;color:#DABB87;"><span>请认真填写以下内容，如果有合作机会，我们会在48小时内主动与您取得联系，谢谢！</span></div>
	</div>
	<div class="h60"></div>
	<div style="margin-top:140px">
		<span style="font-size:1em; ">您的企业名称:
	</span>
		<textarea id="content" style="margin-top:10px;width:98%;height:30px;border:1px solid #cbcbcb"></textarea>
		<span style="font-size:1em; ">项目简介及初步合作方案说明
		<i class="notnull">*必填选项</i>
	</span>
		<textarea id="company" style="margin-top:10px;width:98%;height:100px;border:1px solid #cbcbcb"></textarea>
		<span style="font-size:1em; ">项目联系人姓名
		<i class="notnull">*必填选项</i>
	</span>
		<textarea id="cooperationer" style="margin-top:10px;width:98%;height:30px;border:1px solid #cbcbcb"></textarea>
		<span style="font-size:1em; ">项目联系人手机
		<i class="notnull">*必填选项</i>
	</span>
		<textarea id="mobile" style="margin-top:10px;width:98%;height:30px;border:1px solid #cbcbcb"></textarea>
		<a href="javascript:void(0)" class="sub" onclick="save()">提交</a>
	</div>

</body>
</html>