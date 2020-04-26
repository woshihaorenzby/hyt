<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String companyName = request.getSession().getAttribute("companyName").toString();
	String userName = request.getSession().getAttribute("userName").toString();
	String phone = request.getSession().getAttribute("phone").toString();
	String yaoCode = request.getSession().getAttribute("yaoCode").toString();
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
	<script type="text/javascript">
		var ctxPath="<%=path%>";
	</script>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ckeditor/ckeditor.js"></script>
<script>
function save() {
	resetMsg();
	
	var validateTag = true;
	var companyName = $("#companyName").val();
	
	validateTag = validateInput("companyName", companyName, validateTag);
	if(validateTag == false){
		window.scrollTo(0,0);
		return;
	}
	
	$.ajax({
		type: "post",
		url: "<%=path%>/hyuser/saveCompanyInf",
		dataType: "json",
		data: "user.companyName=" + companyName,
		success: function(data){
			if(data.code == "1"){
				msgSuccess("保存成功！");
			}else{
				msgError("保存失败，请稍后重试！");
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("保存失败，请稍后重试！");
		}
	});
}
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">企业信息</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>企业名称：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="companyName" class="form-control" type="text" style="width:200px;float:left;" value="<%=companyName%>" />
					<div class="errormsg">&nbsp;&nbsp;请填写企业名称！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">群主管理员：</td>
			<td class="table_textright"><%=userName%></td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">联系方式：</td>
			<td class="table_textright"><%=phone%></td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">邀请码：</td>
			<td class="table_textright"><%=yaoCode%></td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">现有人数：</td>
			<td class="table_textright"><s:property value="companyMemCount" /></td>
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