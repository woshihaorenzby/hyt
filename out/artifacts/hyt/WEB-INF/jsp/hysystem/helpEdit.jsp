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
<script>
var id = "<s:property value="help.id" />";
function save() {
	resetMsg();
	
	var validateTag = true;
	var title = $("#title").val();
	var url = $("#url").val();
	var rid = $("#rid").val();
	
	validateTag = validateInput("title", title, validateTag);
	validateTag = validateInput("url", url, validateTag);
	
	if(validateTag == false){
		window.scrollTo(0,0);
		return;
	}
	
	if(rid == "") rid = "0";
	$.ajax({
		type: "post",
		url: "<%=path%>/help/save",
		dataType: "json",
		data: "help.id=" + id + "&help.title=" + title + "&help.url=" + url + "&help.rid=" + rid,
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("保存成功！", "<%=path%>/help/show");
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
	<font class="head_font">
		<s:if test="lunimg.id != ''">
			修改帮助中心
	    </s:if>
	    <s:else>
			添加帮助中心
	    </s:else>
	</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>标题：</span></td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="title" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="help.title" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写标题！</div>
				</div>
			</td>
		</tr>
		
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>链接：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="url" class="form-control" type="text" style="width:600px;float:left;" value="<s:property value="help.url" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写链接！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">排序：</td>
			<td class="table_textright">
				<div class="form-group">
					<input id="rid" class="form-control" type="text" style="width:100px;float:left;" value="<s:property value="help.rid" />" onkeyup="value=value.replace(/[^0-9]/g,'')" onblur="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu="return false">
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