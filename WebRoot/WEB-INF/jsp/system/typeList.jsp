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
		url: "<%=path%>/type/list",
		dataType:"json",
		data:"type.typeLei="+typeLei,
		success:function(data){
			if(data == "") {
				nodata("1");
			} else {
				nodata("0");
			}
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				var fileFileName = data[i].webUrl.split(".")[0];
				appStr += "<tr id='"+data[i].id+"' typeImg='"+data[i].typeImg+"' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
				appStr += "<td>"+(i+1)+"</td>";
				appStr += "<td>"+data[i].typeName+"</td>";
				if(data[i].typeImg.length>0){
					appStr += "<td><img src='<%=path%>"+data[i].typeImg+"' style='width:40px;height:40px;'></td>";
				} else {
					appStr += "<td></td>";
				}

				appStr += "<td><a href='<%=path%>/WebRoot/file/htm/"+data[i].webUrl+"' download='"+fileFileName+"'>"+data[i].webUrl+"</a></td>";
				<%--if(data[i].topShow=="1"){--%>
				<%--	appStr += "<td><img src='<%=path%>/images/button/check_alt.png' width=18 style='cursor:pointer;' hidetag='1' onclick='updateTag(this, \"topShow\", \"sy_type\")'/></td>";--%>
				<%--}else{--%>
				<%--	appStr += "<td><img src='<%=path%>/images/button/x_alt.png' width=18 style='cursor:pointer;'  hidetag='0' onclick='updateTag(this, \"topShow\", \"sy_type\")'/></td>";--%>
				<%--}--%>
				<%--if(data[i].needQiTy=="1"){--%>
				<%--	appStr += "<td><img src='<%=path%>/images/button/check_alt.png' width=18 style='cursor:pointer;' hidetag='1' onclick='updateTag(this, \"needQiTy\", \"sy_type\")'/></td>";--%>
				<%--}else{--%>
				<%--	appStr += "<td><img src='<%=path%>/images/button/x_alt.png' width=18 style='cursor:pointer;'  hidetag='0' onclick='updateTag(this, \"needQiTy\", \"sy_type\")'/></td>";--%>
				<%--}--%>
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
				var webUrl = $("#webUrl").val();
				var rid = $("#rid").val();
				if(typeName == "") {
					alert("请填写类别名称");
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/type/save",
					dataType:"json",
					data: "type.id="+selId+"&type.typeLei="+typeLei+"&type.typeName="+typeName+"&type.typeImg="+imagePath+"&type.webUrl="+webUrl+"&type.rid="+rid,
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
	$("#dialog-edit").dialog("option", "title", "添加类别").dialog("open");
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要删除这1条信息吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/type/delete",
			data: "type.id="+id,
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
	let typeImg = $(obj).parent().parent().attr("typeImg");
	cxtPath+ typeImg
	$("#typeName").val($(obj).parent().parent().children().eq(1).text());
	$("#imagePath").attr("filePath",typeImg);
	$("#imagePathImg").attr("src", cxtPath+typeImg);
	$("#rid").val($(obj).parent().parent().children().eq(4).text());
	$("#webUrl").val($(obj).parent().parent().children().eq(3).text());
	var appStr = "<div class='delault-image' style='float:left;margin-left:10px;' imgfile='"+typeImg+"'><img src='"+ctxPath+typeImg+"' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+ctxPath+typeImg+"' style='width:200px;' /></div>";
	$(".delault-image").remove();
	$(".form-group").append(appStr);
	$("#dialog-edit").dialog("option", "title", "修改类别").dialog("open");

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
					var appStr = "<div style='float:left;margin-left:10px;' imgfile='"+data.path+"'><img src='"+ctxPath+"/images/button/minusred_alt.png' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+ctxPath+data.path+"' style='width:200px;' /></div>";
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
	<font class="head_font">类别列表</font>
	<div style="float:right;">
		<button type="button" class="btn btn-success btn-sm" onclick="add()"><span class="glyphicon glyphicon-plus"></span>&nbsp;<strong>添加</strong></button>
	</div>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="table" style="margin-top:5px;">
		<thead class="table_th">
			<tr>
				<th style="width:5%;">编号</th>
				<th style="width:15%;">类别名称</th>
				<th style="width:10%;">分类图片</th>
				<th style="width:10%;">外链地址</th>
<%--				<th style="width:15%;">首页置顶</th>--%>
<%--				<th style="width:15%;">企业VIP权限</th>--%>
				<th style="width:10%;">排序</th>
				<th style="width:10%;">操作</th>
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
			<td><input id="typeName" class="form-control" type="text" style="width:200px;"></td>
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
			<td class="table_text" style="vertical-align : middle;">跳转外链：</td>
			<td class="table_textright">
				<form>
					<div >
						<input id="webUrl" class="form-control" name="file" type="text" value="<s:property value="type.webUrl" />">
					</div>
				</form>
			</td>
		</tr>
		<tr>
			<td class="table_text"><s:property value="type.rid" />排序：</td>
			<td><input id="rid" class="form-control" type="text" style="width:100px;float:left;"  value="<s:property value="type.rid" />"  onkeyup="value=value.replace(/[^0-9]/g,'')" onblur="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu="return false"></td>
		</tr>
	</table>
</div>
</html>