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
var syInsert = "<%=syInsert%>";
var mainType = "<s:property value="video.mainType" />";
var auditTag = "<s:property value="video.auditTag" />";
var pageRecordCount = 15;
var selId = "";
$(function(){
	if(mainType == "2") {
		$("#thlink").remove();
	}
	if(syInsert == "0") {
		$("#thcur").remove();
		$("#thaudit").remove();
		$("#thshen").remove();
	}
	if(auditTag == "1") {
		$("#thaudit").remove();
	}
	loadData(1, true);
});
function loadData(curPage, refTag){
	$.ajax({
		type:"post",
		url: "<%=path%>/video/list",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount + "&video.mainType="+mainType + "&video.auditTag="+auditTag + "&video.syInsert="+syInsert,
		success:function(json){
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<tr id='"+data[i].id+"' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
				appStr += "<td>"+((curPage-1)*pageRecordCount+i+1)+"</td>";
				appStr += "<td>"+data[i].typeName+"</td>";
				appStr += "<td><img src='<%=path%>"+data[i].imagePath+"' style='width:50px;' /></td>";
				appStr += "<td>"+data[i].title+"</td>";
				if(mainType == "1") {
					appStr += "<td>"+data[i].videoUrl+"</td>";
				}
				appStr += "<td>"+data[i].viewNum+"</td>";
				appStr += "<td>"+data[i].shareNum+"</td>";
				if(syInsert == "1") {
					var videoSyInsert = data[i].syInsert;
					var userName;
					if(videoSyInsert == "1") {
						userName = data[i].userName;
					} else if(videoSyInsert == "0") {
						userName = data[i].niName;
					}
					appStr += "<td>"+userName+"</td>";
					if(auditTag=="0") {//控制审核是否显示
						if(data[i].auditTag=="1"){
							appStr += "<td><img src='<%=path%>/images/button/check_alt.png' width=18 style='cursor:pointer;' hidetag='1' onclick='updateTag(this, \"auditTag\", \"hy_video\")'/></td>";
						}else{
							appStr += "<td><img src='<%=path%>/images/button/x_alt.png' width=18 style='cursor:pointer;'  hidetag='0' onclick='updateTag(this, \"auditTag\", \"hy_video\")'/></td>";
						}
					}
					if(data[i].topShow=="1"){
						appStr += "<td><img src='<%=path%>/images/button/check_alt.png' width=18 style='cursor:pointer;' hidetag='1' onclick='updateTag(this, \"topShow\", \"hy_video\")'/></td>";
					}else{
						appStr += "<td><img src='<%=path%>/images/button/x_alt.png' width=18 style='cursor:pointer;'  hidetag='0' onclick='updateTag(this, \"topShow\", \"hy_video\")'/></td>";
					}
				}
				appStr += "<td><button onclick='updateOrder(this)' type='button' class='btn btn-info btn-xs'>修改</button>&nbsp;<button onclick='deleteOrder(this)' type='button' class='btn btn-info btn-xs'>删除</button></td></tr>";
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
function add() {
	window.open("<%=path%>/video/editPage?video.mainType="+mainType, "_self");
}
function updateOrder(obj) {
	selId = $(obj).parent().parent().attr("id");
	window.open("<%=path%>/video/editPage?video.mainType="+mainType+"&video.id="+selId, "_self");
}
function deleteOrder(obj) {
	var id = $(obj).parent().parent().attr("id");
	if(window.confirm("您确认要删除这1条信息吗？")) {
		$.ajax({
			type: "POST",
			url: "<%=path%>/video/delete",
			data: "video.id="+id,
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
		<s:if test="video.mainType == '1'.toString()">
			视频列表
		</s:if>
		<s:elseif test="video.mainType == '2'.toString()">
			文章列表
		</s:elseif>
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
				<th style="width:10%;">缩略图</th>
				<th style="width:20%;">标题</th>
				<th id="thlink" style="width:20%;">连接</th>
				<th style="width:5%;">访问量</th>
				<th style="width:5%;">分享数量</th>
				<th id="thcur" style="width:10%;">创建人</th>
				<th id="thaudit" style="width:5%;">审核</th>
				<th id="thshen" style="width:5%;">推荐</th>
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