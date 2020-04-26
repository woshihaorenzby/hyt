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
var pageRecordCount = 20;
var selId = "";
$(function(){
	loadData(1, true);
});
function loadData(curPage, refTag){
	$.ajax({
		type:"post",
		url: "<%=path%>/admin/list",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount,
		success:function(json){
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<tr id='"+data[i].id+"' roleId='"+data[i].roleId+"' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
				appStr += "<td>"+((curPage-1)*pageRecordCount+i+1)+"</td>";
				appStr += "<td>"+data[i].userName+"</td>";
				appStr += "<td>"+data[i].roleName+"</td>";
				appStr += "<td>"+data[i].loginTime+"</td>";
				appStr += "<td><button onclick='revertPas(this)' type='button' class='btn btn-info btn-xs'>还原密码</button>&nbsp;<button onclick='updateOrder(this)' type='button' class='btn btn-info btn-xs'>修改</button>&nbsp;<button onclick='deleteOrder(this)' type='button' class='btn btn-info btn-xs'>删除</button></td></tr>";
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
		height:300,
		width:500,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var userName = $("#userName").val();
				var roleId = $("#roleId").val();
				if(userName == "") {
					alert("请填写用户名");
					return;
				}
				if(roleId == "") {
					alert("请填写角色名称");
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/admin/save",
					dataType:"json",
					data: "syuser.id="+selId+"&syuser.userName="+userName+"&syuser.roleId="+roleId,
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
	$("#form_edit")[0].reset();
	$("#dialog-edit").dialog("option", "title", "添加用户").dialog("open");
}
function revertPas(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要还原该账户密码为111111吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/admin/revertPas",
			data: "syuser.id="+id,
			success: function(data){
				if(data.code == "1"){
					msgSuccess("还原成功！");
				}else{
					msgError("还原失败，请稍后重试！");
				}
			}
		});
	}
}
function updateOrder(obj) {
	selId = $(obj).parent().parent().attr("id");
	$("#userName").val($(obj).parent().parent().children().eq(1).text());
	var roleId = $(obj).parent().parent().attr("roleId");
	$("#roleId").val(roleId);
	$("#dialog-edit").dialog("option", "title", "修改用户").dialog("open");
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要删除该用户吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/admin/delete",
			data: "syuser.id="+id,
			success: function(data){
				if(data.code == "1"){
					msgSuccessReload("删除成功！");
				}else{
					msgError("删除失败，请稍后重试！");
				}
			}
		});
	}
}
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">系统管理员列表</font>
	<div style="float:right;">
		<button type="button" class="btn btn-success btn-sm" onclick="add()"><span class="glyphicon glyphicon-plus"></span>&nbsp;<strong>添加</strong></button>
	</div>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="table" style="margin-top:5px;">
		<thead class="table_th">
			<tr>
				<th style="width:2%;">编号</th>
				<th style="width:5%;">用户名</th>
				<th style="width:8%;">角色名</th>
				<th style="width:8%;">登录时间</th>
				<th style="width:15%;">操作</th>
			</tr>
		</thead>
		<tbody id="table_tb">
		</tbody>
	</table>
	<div id="fenPaper" style="padding-right:20px;"></div>
</div>
<div id="dialog-edit" title="添加用户">
	<form id="form_edit">
		<table class="form_table">
		    <tr>
				<td class="table_text">用户名称：</td>
				<td><input id="userName" class="form-control" type="text" style="width:180px;"></td>
			</tr>
			<tr>
				<td class="table_text">角色：</td>
				<td>
					<select id="roleId" class="form-control" style="width:130px;float:left;">
						<option value="">请选择</option>
						<s:iterator value="roleList" id="item">
						    <option value="<s:property value="id" />"><s:property value="roleName" /></option>
						</s:iterator>
					</select>
				</td>
			</tr>
	    </table>
    </form>
</div>
</html>