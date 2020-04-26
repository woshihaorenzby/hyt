<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String syInsert = request.getSession().getAttribute("syInsert").toString();
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
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/zTreeStyle/zTreeStyle.css">
	<script>
		var cxtPath = "<%=path%>";
		var ctxPath = "<%=path%>";
	</script>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/smartpaginator.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<script>
var pageRecordCount = 15;
var selId = "";
$(function(){
	loadData(1, true);
});
function loadData(curPage, refTag){
	$.ajax({
		type:"post",
		url: "<%=path%>/adv/modList",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount + "&advMod.typeId=",
		success:function(data){
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<tr id='"+data[i].id+"' typeId='"+data[i].typeId+"' typeImg='"+data[i].imgUrl+"' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
				appStr += "<td>"+((curPage-1)*pageRecordCount+i+1)+"</td>";
				appStr += "<td>"+data[i].typeName+"</td>";
				appStr += "<td><img src='<%=path%>"+data[i].imgUrl+"' style='width:50px;' /></td>";
				appStr += "<td>"+data[i].rid+"</td>";
				appStr += "<td><button onclick='updateOrder(this)' type='button' class='btn btn-info btn-xs'>修改</button>&nbsp;<button onclick='deleteOrder(this)' type='button' class='btn btn-info btn-xs'>删除</button></td></tr>";
			}
			$("#table_tb").append(appStr);
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
	$("#dialog-edit").dialog({
		autoOpen:false,
		height:600,
		width:600,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var typeName = $("#typeName").val();
				var imagePath = $("#imagePath").attr("filePath");
				var rid = $("#rid").val();
				if(typeName == "") {
					alert("请选择分类");
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/adv/saveMod",
					dataType:"json",
					data: "advMod.id="+selId+"&&advMod.typeId="+typeName+"&advMod.imgUrl="+imagePath+"&advMod.rid="+rid,
					success:function(data){
						if(data.code=="1"){
							msgSuccessReload("保存成功");
						}else{
							msgError("保存失败，请稍后重试");
						}
					}
				});
			},
			"取消": function(){
				$(this).dialog("close");
			}
		},
		close:function(){
			$(this).dialog("close");
		}
	});
}
function add() {
	selId = "";
	$("#typeName").val("");
	$("#imagePath").attr("filePath", "");
	$("#rid").val("");
	$("#dialog-edit").dialog("option", "title", "添加模板").dialog("open");
}
function updateOrder(obj) {
	selId = $(obj).parent().parent().attr("id");
	$("#typeName").val($(obj).parent().parent().attr("typeId"));
	$("#imagePath").attr("filePath", $(obj).parent().parent().attr("typeImg"));
	$("#rid").val($(obj).parent().parent().children().eq(3).text());
	$("#dialog-edit").dialog("option", "title", "修改模板").dialog("open");
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要删除这1条信息吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/adv/deleteMod",
			data: "advMod.id="+id,
			success: function(data){
				if(data.code == "1"){
					msgSuccessReload("删除成功！");
				}else{
					msgError("删除错误，请稍后重试！");
				}
			}
		});
	}
}
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">
		模板列表
	</font>
	<div style="float:right;">
		<button type="button" class="btn btn-success btn-sm" onclick="add()"><span class="glyphicon glyphicon-plus"></span>&nbsp;<strong>添加</strong></button>
	</div>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="table" style="margin-top:5px;">
		<thead class="table_th">
			<tr>
				<th style="width:5%;">编号</th>
				<th style="width:5%;">类别</th>
				<th style="width:10%;">广告图</th>
				<th style="width:10%;">排序</th>
				<th style="width:15%;">操作</th>
			</tr>
		</thead>
		<tbody id="table_tb">
		</tbody>
	</table>
	<div id="noPaper" class="nodata">没有查询到任何数据</div>
</div>

<div id="dialog-edit" title="添加类别">
	<table class="form_table">
		<tr>
			<td class="table_text">类别名称：</td>
			<td>
				<select id="typeName" class="form-control" style="width:130px;float:left;">
					<option value="">请选择</option>
					<s:iterator value="typeList" id="item">
						<option value="<s:property value="id" />"><s:property value="typeName" /></option>
					</s:iterator>
				</select>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">图片：</td>
			<td class="table_textright">
				<form>
					<div class="form-group">
						<input name="file" class="form-control" type="file" style="width:300px;float:left;">
						<button id="imagePath" filePath="" type="button" class="btn btn-info btn-sm" onclick="uploadImg('image', this)" style="margin-left:10px;"><span class="glyphicon glyphicon-upload"></span>&nbsp;<strong>上传</strong></button>
					</div>
				</form>
			</td>
		</tr>
		<tr>
			<td class="table_text">排序：</td>
			<td><input id="rid" class="form-control" type="text" style="width:100px;float:left;" value="<s:property value="lunimg.rid" />" onkeyup="value=value.replace(/[^0-9]/g,'')" onblur="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu="return false"></td>
		</tr>
	</table>
</div>
</html>