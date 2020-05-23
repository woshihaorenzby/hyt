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
	<script>
		var cxtPath = "<%=path%>";
		var ctxPath = "<%=path%>";
	</script>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/smartpaginator.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<script>
var typeLei = "<s:property value="type.typeLei" />";
var selId = "";
var fileFileName = "<s:property value="type.webUrl" />";
$(function(){
	loadData(1, true);
	$('#htmlFile').on('change',function(e){
		fileFileName = e.currentTarget.files[0].name;
		console.log(fileFileName);
	});
});
function loadData(curPage, refTag){
	$.ajax({
		type:"post",
		url: "<%=path%>/qr/wxList",
		dataType:"json",
		success:function(data){
			if(data == "") {
				nodata("1");
			} else {
				nodata("0");
			}
			let list = data.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<list.length; i++){
				let typeStr = "车牌定制";
				switch (list[i].type+'') {
					case '2':
						typeStr = "靓号咨询";
						break;
					case '3':
						typeStr = "名表回收";
						break;
				}

				appStr += "<tr id='"+list[i].id+"' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
				appStr += "<td>"+((curPage-1)*data.pageRecordCount+i+1)+"</td>";
				appStr += "<td>"+list[i].id+"</td>";
				appStr += "<td><img style='width: 20px; height: 18px;' id='img"+list[i].id+"' src='"+list[i].url+"'/></td>";
				appStr += "<td id=type"+list[i].id+" data-id="+list[i].type+">"+typeStr+"</td>";
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
				var type = $("#type").val();
				var url ='<%=path%>'+ $("#imagePath").attr("filePath");
				$.ajax({
					type:"post",
					url:"<%=path%>/qr/save",
					dataType:"json",
					data: {
						"qr.type" :type,
						"qr.url" :url,
						"qr.id":selId
					},
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
	$("#webUrl").val("");
	$("#rid").val("");
	$("#dialog-edit").dialog("option", "title", "添加二维码").dialog("open");
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要删除这1条信息吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/qr/delete",
			data: "qr.id="+id,
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
function updateOrder(obj) {
	selId = $(obj).parent().parent().attr("id");
	let typeImg = $("#img"+selId).attr("src");
	$("#imagePath").attr("filePath",typeImg);
	let type = $("#type"+selId).attr("data-id");
	$(" select option[value='"+type+"']").attr("selected","selected");
	var appStr = "<div class='delault-image' style='float:left;margin-left:10px;' imgfile='"+typeImg+"'><img src='"+typeImg+"' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+typeImg+"' style='width:200px;' /></div>";
	$(".delault-image").remove();
	$(".form-group").append(appStr);
	$("#dialog-edit").dialog("option", "title", "修改二维码").dialog("open");

}
//上传图片

function uploadHtml(fileType, obj){
	showProcess("上传中");
	$(obj).parent().parent().ajaxSubmit({
		type: "post",
		url: ctxPath + "/htmlUpload",
		dataType: "json",
		success: function(data){
			closeProcess();
			if(data.path != ""){
				if(fileType == "html") {
					var appStr = "<div style='float:left;margin-left:10px;' imgfile='"+ctxPath+data.path+"'><img src='"+ctxPath+"/images/button/minusred_alt.png' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+ctxPath+data.path+"' style='width:200px;' /></div>";
					$(obj).parent().parent().append(appStr);

					$(obj).text("已上传");
					$(obj).removeClass("btn-info");
					$(obj).addClass("btn-success");
					$(obj).attr("filePath", data.path);
				} else if(fileType == "file") {

				}
				console.log(fileFileName);
				$("#webUrl").val(fileFileName);
			}else{
				msgError("上传图片，请稍后重试！");
			}
		}
	});
}
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">二维码列表</font>
	<div style="float:right;">
		<button type="button" class="btn btn-success btn-sm" onclick="add()"><span class="glyphicon glyphicon-plus"></span>&nbsp;<strong>添加</strong></button>
	</div>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="table" style="margin-top:5px;">
		<thead class="table_th">
			<tr>
				<th style="width:5%;">序号</th>
				<th style="width:20%;">编号</th>
				<th style="width:20%;">图片</th>
				<th style="width:20%;">类型</th>
				<th style="width:15%;">操作</th>
			</tr>
		</thead>
		<tbody id="table_tb">
		</tbody>
	</table>
	<div id="noPaper" class="nodata">没有查询到任何数据</div>
</div>
<div id="dialog-edit" title="编辑二维码">
	<table class="form_table">
		<tr>
			<td class="table_text" style="vertical-align : middle;">图片：</td>
			<td class="table_textright">
				<form>
					<div class="form-group">
						<input name="file" class="form-control" type="file" style="width:300px;float:left;">
						<button id="imagePath" filePath="<>" type="button" class="btn btn-info btn-sm" onclick="uploadImg('image', this)" style="margin-left:10px;"><span class="glyphicon glyphicon-upload"></span>&nbsp;<strong>上传</strong></button>
					</div>
				</form>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;">类型：</td>
			<td>
				<select id="type" class="form-control" style="width:100px;float:left;">
					<option value="1" <s:if test="qr.type=='1'.toString()">selected = "selected"</s:if>>车牌定制</option>
					<option value="2" <s:if test="qr.type=='2'.toString()">selected = "selected"</s:if>>靓号咨询</option>
					<option value="3" <s:if test="qr.type=='3'.toString()">selected = "selected"</s:if>>名表回收</option>
				</select>
			</td>
		</tr>
	</table>
</div>
</html>