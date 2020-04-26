<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jqueryui/jquery-ui.min.css">
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/js/msgbox/msgbox.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/smartpaginator.css"></link>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/smartpaginator.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<script>
function pasFun(){
	resetMsg();	
	if($("#pasF").val()!=$("#pasS").val()){
		$("#pasS").parent().addClass("has-error");
		$("#pasS").siblings("div").css({
			"display":"block"
		});
	}
}
function save(){
	$.ajax({
		type: "post",
		url: "<%=path%>/admin/changePas",
		dataType: "json",
		data: "syuser.id=" + '<%=request.getSession().getAttribute("userId")%>' + "&syuser.password=" + $("#pasF").val(),
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("修改成功！", "");
			}else{
				msgError("修改失败，请稍后重试！");
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) {
			alert(XMLHttpRequest.status);
			alert(XMLHttpRequest.readyState);
			alert(textStatus);
		}
	});
}
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">
		修改密码
	</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td style="width:20%;" class="table_text">登录用户：</td>
			<td style="width:80%;">
				<div class="form-group"><input id="typeName" class="form-control" type="text" style="width:200px;float:left;" value="<%=request.getSession().getAttribute("userName")%>" disabled></div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><font style='color:red;'>*</font>新密码：</td>
			<td>
				<div class="form-group"><input id="pasF" class="form-control" type="password" style="width:200px;float:left;" oncontextmenu="return false"></div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><font style='color:red;'>*</font>重复密码：</td>
			<td>
				<div class="form-group"><input id="pasS" class="form-control" type="password" style="width:200px;float:left;" onblur="pasFun();" oncontextmenu="return false"><div class="errormsg">&nbsp;&nbsp;两次输入密码不一致！</div></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<button type="button" class="btn btn-success btn-sm" onclick="save()"><span class="glyphicon glyphicon-saved"></span>&nbsp;<strong>保存</strong></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-danger btn-sm" onclick="resetForm()"><span class="glyphicon glyphicon-refresh"></span>&nbsp;<strong>重置</strong></button>
			</td>
		</tr>
	</table>
</div>
</html>