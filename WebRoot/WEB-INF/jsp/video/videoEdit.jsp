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
	<script type="text/javascript" src="<%=path%>/js/jquery.ui.datepicker-zh-TW.js"></script>
<script>
var id = "<s:property value="video.id" />";
var mainType = "<s:property value="video.mainType" />";
var typeName = "<s:property value="video.typeName" />";
var articleContent = "<s:property value="video.articleContent" />";
var auditTag = "<s:property value="video.auditTag" />";
if(auditTag == "") auditTag = "0";
var pushTime = "<s:property value="video.pushTime" />";
$(function(){
	$("#typeName").val(typeName);
	$("#pushTime").datepicker($.datepicker.regional["zh-TW"]);
	$("#pushTime").datepicker("option","dateFormat","yy-mm-dd");
	if(pushTime=="") {
		$("#pushTime").datepicker('setDate',new Date());
	} else {
		$("#pushTime").datepicker('setDate',pushTime);
	}

	CKEDITOR.replace("articleContent");
	CKEDITOR.instances.articleContent.setData(unHtml(articleContent));
});
function save() {
	resetMsg();
	
	var validateTag = true;
	var typeName = $("#typeName").val();
	var title = $("#title").val();
	var imagePath = $("#imagePath").attr("filepath");
	var videoUrl = $("#videoUrl").val();
	var articleContent = CKEDITOR.instances.articleContent.getData();
	var pushTime = $("#pushTime").val();
	
	validateTag = validateInput("typeName", typeName, validateTag);
	validateTag = validateInput("title", title, validateTag);
	validateTag = validateInput("imagePath", imagePath, validateTag);
	if(mainType == "1") {
		validateTag = validateInput("videoUrl", videoUrl, validateTag);
	} else if(mainType == "2") {
		validateTag = validateInput("articleContent", articleContent, validateTag);
	}
	
	if(validateTag == false){
		window.scrollTo(0,0);
		return;
	}
	articleContent = articleContent.replace(/[\r\n]/g,"");
	articleContent = encodeURIComponent(articleContent);
	if(videoUrl.indexOf("src")>-1) {
		videoUrl = videoUrl.substring(videoUrl.indexOf("src=") + 5);
		videoUrl = videoUrl.substring(0, videoUrl.indexOf("\""));
	}
	title = encodeURIComponent(title);
	videoUrl = encodeURIComponent(videoUrl);
	
	$.ajax({
		type: "post",
		url: "<%=path%>/video/save",
		dataType: "json",
		data: "video.id=" + id + "&video.mainType=" + mainType + "&video.typeName=" + typeName + "&video.title=" + title + "&video.imagePath=" + imagePath + "&video.videoUrl=" + videoUrl + "&video.articleContent=" + articleContent + "&video.pushTime=" + pushTime,
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("保存成功！", "<%=path%>/video/show?video.mainType="+mainType+"&video.auditTag="+auditTag);
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
		<s:if test="video.id != null and video.id != ''">
			<s:if test="video.mainType == '1'.toString()">
				修改视频
			</s:if>
	    	<s:elseif test="video.mainType == '2'.toString()">
	    		修改文章
			</s:elseif>
	    </s:if>
	    <s:else>
			<s:if test="video.mainType == '1'.toString()">
				添加视频
			</s:if>
	    	<s:elseif test="video.mainType == '2'.toString()">
	    		添加文章
			</s:elseif>
	    </s:else>
	</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td class="table_text"><span style="color:red;">*</span>类别：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<select id="typeName" class="form-control" style="width:130px;float:left;">
						<option value="">请选择</option>
						<s:iterator value="typeList" id="item">
						    <option value="<s:property value="typeName" />"><s:property value="typeName" /></option>
						</s:iterator>
					</select>
					<div class="errormsg">&nbsp;&nbsp;请选择视频类别！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>标题：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="title" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="video.title" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写标题！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>缩略图：</td>
			<td class="table_textright">
				<form>
					<div class="form-group">
						<input name="file" class="form-control" type="file" style="width:300px;float:left;">
						<button id="imagePath" filepath="<s:property value="video.imagePath" />" type="button" class="btn btn-info btn-sm" onclick="uploadImg('image', this)" style="margin-left:10px;"><span class="glyphicon glyphicon-upload"></span>&nbsp;<strong>上传</strong></button>
						<div id="imgerror" class="errormsg">&nbsp;&nbsp;请上传缩略图！</div>
					</div>
					<s:if test="video.imagePath != null and video.imagePath != ''">
						<div style="float:left;margin-left:10px;" imgfile="<s:property value="video.imagePath" />">
							<img src="<%=path%>/images/button/minusred_alt.png" style="position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;" onclick="removeImg(this)">
							<img src="<%=path%><s:property value="video.imagePath" />" style="width:200px;">
						</div>
				    </s:if>
				</form>
			</td>
		</tr>
		<tr <s:if test="video.mainType == '2'.toString()">style="display:none;"</s:if>>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>链接：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="videoUrl" class="form-control" type="text" style="width:600px;float:left;" value="<s:property value="video.videoUrl" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写链接！</div>
				</div>
			</td>
		</tr>
		<tr <s:if test="video.mainType == '1'.toString()">style="display:none;"</s:if>>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>内容：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<textarea id="articleContent" name="articleContent" style="float:left;"></textarea>
					<div class="errormsg">&nbsp;&nbsp;请填写内容！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>发布时间：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="pushTime" class="form-control" type="text" style="width:200px;float:left;"/>
					<div class="errormsg">&nbsp;&nbsp;请填写发布时间！</div>
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