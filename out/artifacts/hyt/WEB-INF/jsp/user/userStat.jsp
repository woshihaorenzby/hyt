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
	<script type="text/javascript" src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
<script>
$(function(){
	$("#tabs").tabs();
	$.ajax({
		type:"post",
		url: "<%=path%>/hyuser/userStatData",
		dataType:"json",
		data:"hyUserStat.statType=1",
		success:function(json){
			var dataArr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			for(var i=0;i<json.length;i++) {
				dataArr[parseInt(json[i].month)-1] = parseInt(json[i].con)
			}
			$("#container").highcharts({
		        title: {
		            text: "月增长人数统计",
		            x: -20
		        },
		        xAxis: {
		            categories: ["一月", "二月", "三月", "四月", "五月", "六月","七月", "八月", "九月", "十月", "十一月", "十二月"]
		        },
		        yAxis: {
		            title: {
		                text: "人数"
		            },
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: "#808080"
		            }]
		        },
		        tooltip: {
		            valueSuffix: "人"
		        },
		        legend: {
		            layout: "vertical",
		            align: "right",
		            verticalAlign: "middle",
		            borderWidth: 0
		        },
		        series: [{
		            name: "每月人数",
		            data: dataArr
		        }]
		    });
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
	
	$.ajax({
		type:"post",
		url: "<%=path%>/hyuser/userStatData",
		dataType:"json",
		data:"hyUserStat.statType=2",
		success:function(json){
			var nanArr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var nvArr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			for(var i=0;i<json.length;i++) {
				if(json[i].nancon != "") {
					nanArr[parseInt(json[i].month)-1] = parseInt(json[i].nancon)
				}
			}
			for(var i=0;i<json.length;i++) {
				if(json[i].nvcon != "") {
					nvArr[parseInt(json[i].month)-1] = parseInt(json[i].nvcon)
				}
			}
			$("#sexcon").highcharts({
		        chart: {
		            type: "column"
		        },
		        title: {
		            text: "性别统计"
		        },
		        xAxis: {
		            categories: ["一月", "二月", "三月", "四月", "五月", "六月","七月", "八月", "九月", "十月", "十一月", "十二月"]
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: "人数"
		            }
		        },
		        tooltip: {
		            headerFormat: "<span style='font-size:10px'>{point.key}</span><table>",
		            pointFormat: "<tr><td style='color:{series.color};padding:0'>{series.name}: </td>" + "<td style='padding:0'><b>{point.y:f} 人</b></td></tr>",
		            footerFormat: "</table>",
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: "男",
		            data: nanArr
		
		        }, {
		            name: "女",
		            data: nvArr
		
		        }]
		    });
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
	
	$.ajax({
		type:"post",
		url: "<%=path%>/hyuser/userStatData",
		dataType:"json",
		data:"hyUserStat.statType=3",
		success:function(json){
			var array = new Array(); 
			for(var i=0;i<json.length;i++) {
				array[i] = new Array();
				var shCity = json[i].city;
				if(shCity=="") shCity="未知";
				array[i][0] = shCity + "";
				array[i][1] = parseInt(json[i].con);
			}
			
			$("#areacon").highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: "区域统计"
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: "pointer",
		                dataLabels: {
		                    enabled: true,
		                    color: "#000000",
		                    connectorColor: "#000000",
		                    format: "<b>{point.name}</b>: {point.percentage:.1f} %"
		                }
		            }
		        },
		        series: [{
		            type: "pie",
		            name: "人数",
		            data: array
		        }]
		    });
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
});
</script>
</head>
<body class="bodyst">
<div class="content_head">
	<font class="head_font">统计报表</font>
</div>
<div class="table_content" style="margin-top:10px;">
	<div id="tabs">
		<ul>
			<li><a href="#fragment-1">月增长人数统计</a></li>
			<li><a href="#fragment-2">男女统计</a></li>
			<li><a href="#fragment-3">区域统计</a></li>
		</ul>
		<div id="fragment-1">
			<div id="container" style="width:90%;height:400px"></div>
		</div>
		<div id="fragment-2">
			<div id="sexcon" style="width:90%;height:400px"></div>
		</div>
		<div id="fragment-3">
			<div id="areacon" style="width:90%;height:400px"></div>
		</div>
	</div>
</div>
</html>