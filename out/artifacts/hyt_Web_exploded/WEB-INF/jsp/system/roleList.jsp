<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/zTreeStyle/zTreeStyle.css">
	<script>
		var cxtPath = "<%=path%>";
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
var pageRecordCount = 20;
var selId = "";
$(function(){
	loadData(1, true);
});
function loadData(curPage, refTag){
	$.ajax({
		type:"post",
		url: "<%=path%>/role/list",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount,
		success:function(json){
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<tr id='"+data[i].id+"' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
				appStr += "<td>"+((curPage-1)*pageRecordCount+i+1)+"</td>";
				appStr += "<td>"+data[i].roleName+"</td>";
				appStr += "<td>"+data[i].roleDes+"</td>";
				appStr += "<td><button onclick='addQuan(this)' type='button' class='btn btn-info btn-xs'>授权</button>&nbsp;<button onclick='updateOrder(this)' type='button' class='btn btn-info btn-xs'>修改</button>&nbsp;<button onclick='deleteOrder(this)' type='button' class='btn btn-info btn-xs'>删除</button></td></tr>";
			}
			$("#table_tb").append(appStr);
			nodata(0);
			if(refTag == true){
				if(parseInt(totalRecord)>0){
					$("#fenPaper").css({
						"display":"block"
					});
					$("#fenPaper").smartpaginator({
						totalrecords: totalRecord,
						recordsperpage: pageRecordCount,
						length: pageRecordCount,
						next: '下一页',
						prev: '上一页',
						first: '首页',
						last: '尾页',
						theme: 'red',
						controlsalways: true,
						onchange: function (newPage) {
							loadData(newPage, false);
		            	}
					});
				}else{
					$("#fenPaper").css({
						"display":"none"
					});
					nodata(1);
				}
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
	
	$("#dialog-edit").dialog({
		autoOpen:false,
		height:350,
		width:500,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var roleName = $("#roleName").val();
				var roleDes = $("#roleDes").val();
				if(roleName == "") {
					alert("请填写角色名称");
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/role/save",
					dataType:"json",
					data: "role.id="+selId+"&role.roleName="+roleName+"&role.roleDes="+roleDes,
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
	//授权
	$("#dialog-quanxian").dialog({
		autoOpen:false,
		height:350,
		width:500,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getCheckedNodes(true);
				var nodeId = "";
				for(var i=0;i<nodes.length;i++){
					nodeId += nodes[i].id + "|";
				}
				if(nodeId.length>0){
					nodeId = nodeId.substring(0, nodeId.length-1);
				}else{
					msgError("您未选着任何节点，请选择后提交");
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/role/auditTree",
					dataType:"json",
					data: "role.id="+selId+"&nodeId="+nodeId,
					success:function(data){
						if(data.code=="1"){
							msgSuccessReload("授权成功");
						}else{
							msgError("授权失败，请稍后重试");
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
	$("#form_edit")[0].reset();
	$("#dialog-edit").dialog("option", "title", "添加角色").dialog("open");
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(id == "1" || id == "2") {
		msgError("系统内置角色，不可删除");
		return;
	}
	if(window.confirm("您确认要删除这1条信息吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/role/delete",
			data: "role.id="+id,
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
	$("#form_edit")[0].reset();
	$("#roleName").val($(obj).parent().parent().children().eq(1).text());
	$("#roleDes").val($(obj).parent().parent().children().eq(2).text());
	$("#dialog-edit").dialog("option", "title", "修改角色").dialog("open");
}
function addQuan(obj) {
	selId = $(obj).parent().parent().attr("id");
	$.ajax({
		type:"post",
		url:"<%=path%>/role/roleTree",
		dataType:"json",
		data: "role.id="+selId,
		success:function(data){
			var setting = {
				check: {
					enable: true
				},data: {
					simpleData: {
						enable: true
					}
				}
			};
			var zNodes = data;
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$("#dialog-quanxian").dialog("open");
		}
	});
}
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">角色列表</font>
	<div style="float:right;">
		<button type="button" class="btn btn-success btn-sm" onclick="add()"><span class="glyphicon glyphicon-plus"></span>&nbsp;<strong>添加角色</strong></button>
	</div>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="table" style="margin-top:5px;">
		<thead class="table_th">
			<tr>
				<th style="width:2%;">编号</th>
				<th style="width:5%;">角色名</th>
				<th style="width:8%;">描述</th>
				<th style="width:15%;">操作</th>
			</tr>
		</thead>
		<tbody id="table_tb">
		</tbody>
	</table>
	<div id="fenPaper" style="padding-right:20px;"></div>
</div>
<div id="dialog-edit" title="添加角色">
	<form id="form_edit">
		<table class="form_table">
		    <tr>
				<td class="table_text">角色名称：</td>
				<td><input id="roleName" class="form-control" type="text" ></td>
			</tr>
			<tr>
				<td class="table_text">备注：</td>
				<td><textarea id="roleDes" class="form-control" rows="4"></textarea></td>
			</tr>
	    </table>
    </form>
</div>
<div id="dialog-quanxian" title="角色授权">
	<ul id="treeDemo" class="ztree"></ul>
</div>
</html>