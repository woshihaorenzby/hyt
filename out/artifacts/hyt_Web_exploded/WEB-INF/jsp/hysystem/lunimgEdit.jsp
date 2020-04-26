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
var id = "<s:property value="lunimg.id" />";
function save() {
	resetMsg();
	
	var validateTag = true;
	var title = $("#title").val();
	var imagePath = $("#imagePath").attr("filepath");
	var url = $("#url").val();
	var remark = $("#remark").val();
	var rid = $("#rid").val();
	
	validateTag = validateInput("title", title, validateTag);
	validateTag = validateInput("imagePath", imagePath, validateTag);
	validateTag = validateInput("url", url, validateTag);
	
	if(validateTag == false){
		window.scrollTo(0,0);
		return;
	}
	
	$.ajax({
		type: "post",
		url: "<%=path%>/lunimg/save",
		dataType: "json",
		data: "lunimg.id=" + id + "&lunimg.title=" + title + "&lunimg.imagePath=" + imagePath + "&lunimg.url=" + url + "&lunimg.remark=" + remark + "&lunimg.rid=" + rid,
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("保存成功！", "<%=path%>/lunimg/show");
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
			修改轮播图片
	    </s:if>
	    <s:else>
			添加轮播图片
	    </s:else>
	</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>标题：</span></td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="title" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="lunimg.title" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写标题！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>轮播图片：</span></td>
			<td class="table_textright">
				<form>
					<div class="form-group">
						<input name="file" class="form-control" type="file" style="width:300px;float:left;">
						<button id="imagePath" filepath="<s:property value="lunimg.imagePath" />" type="button" class="btn btn-info btn-sm" onclick="uploadImg('image', this)" style="margin-left:10px;"><span class="glyphicon glyphicon-upload"></span>&nbsp;<strong>上传</strong></button>
						<div id="imgerror" class="errormsg">&nbsp;&nbsp;请上传轮播图片！</div>
					</div>
					<s:if test="lunimg.imagePath != ''">
						<div style="float:left;margin-left:10px;" imgfile="<s:property value="lunimg.imagePath" />">
							<img src="<%=path%>/images/button/minusred_alt.png" style="position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;" onclick="removeImg(this)">
							<img src="<%=path%><s:property value="lunimg.imagePath" />" style="width:200px;">
						</div>
				    </s:if>
				</form>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>链接：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="url" class="form-control" type="text" style="width:600px;float:left;" value="<s:property value="lunimg.url" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写链接！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">备注：</td>
			<td class="table_textright">
				<textarea id="remark" class="form-control" style="width:400px;height:100px;"><s:property value="lunimg.remark" /></textarea>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">排序：</td>
			<td class="table_textright">
				<div class="form-group">
					<input id="rid" class="form-control" type="text" style="width:100px;float:left;" value="<s:property value="lunimg.rid" />" onkeyup="value=value.replace(/[^0-9]/g,'')" onblur="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu="return false">
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