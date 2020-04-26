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
$(function(){
	CKEDITOR.replace("userAggrement");
});
function save() {
	resetMsg();
	
	var validateTag = true;
	var userAggrement = CKEDITOR.instances.userAggrement.getData();
	
	validateTag = validateInput("userAggrement", userAggrement, validateTag);
	
	if(validateTag == false){
		window.scrollTo(0,0);
		return;
	}
	userAggrement = userAggrement.replace(/[\r\n]/g,"");
	userAggrement = encodeURIComponent(userAggrement);
	
	$.ajax({
		type: "post",
		url: "<%=path%>/hyuser/saveXieYi",
		dataType: "json",
		data: "hySystem.userHelp=" + userAggrement,
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
	<font class="head_font">操作说明</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td class="table_text" style="vertical-align : middle;width:20%;"><span style="color:red;">*</span>操作说明：</td>
			<td class="table_textright" style="width:50%;">
				<div class="form-group" style="margin:0px;">
					<textarea id="userAggrement" name="userAggrement" style="float:left;"><s:property value="hySystem.userHelp" /></textarea>
					<div class="errormsg">&nbsp;&nbsp;请填写操作说明！</div>
				</div>
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