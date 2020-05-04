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
var pageRecordCount = 15;
$(function(){
	loadData(1, true);
});
function loadData(curPage, refTag){
	$.ajax({
		type:"post",
		url: "<%=path%>/cooperation/list",
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
				appStr += "<td>"+data[i].company+"</td>";
				appStr += "<td>"+data[i].content+"</td>";
				appStr += "<td>"+data[i].cooperationer+"</td>";
				appStr += "<td>"+data[i].mobile+"</td>";
				appStr += "<td>"+data[i].createTime+"</td>";
				appStr += "<td><button onclick='deleteOrder(this)' type='button' class='btn btn-info btn-xs'>删除</button></td></tr>";
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
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要删除这1条信息吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/cooperation/delete",
			data: "cooperation.id="+id,
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
	<font class="head_font">意见反馈</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<table class="table" style="margin-top:5px;">
		<thead class="table_th">
			<tr>
				<th style="width:5%;">编号</th>
				<th style="width:20%;">企业名称</th>
				<th style="width:20%;">合作方案说明</th>
				<th style="width:20%;">项目联系人</th>
				<th style="width:20%;">项目联系方式</th>
				<th style="width:20%;">时间</th>
				<th style="width:15%;">操作</th>
			</tr>
		</thead>
		<tbody id="table_tb">
		</tbody>
	</table>
	<div id="fenPaper" style="padding-right:20px;"></div>
	<div id="noPaper" class="nodata">没有查询到任何数据</div>
</div>
</html>