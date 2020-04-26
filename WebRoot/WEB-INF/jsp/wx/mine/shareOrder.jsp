<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>分享视频记录</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/swiper.3.1.7.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/font-awesome.min.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
<style type="text/css">
body{
	background:#fdfdfd;
}
.wh12{
	width:12px!important;
    height:12px!important;
	margin-left:5px;
}
.shu{ position:absolute; top:5px; right:2%; width:16px; height:16px; font-size:10px;}

.color a{ color:#EB3838!important;}
.bottom{  border-bottom:3px solid #EB3838!important;}
	  
.swiper-slide a{ color:#000000}
.swiper-wrapper{ text-align:center}
	
/*首次登陆指引*/
.sharePagelayerBg{
	width:100%;
	height:100%;
	background: url(/resources/shop/mobile/image/Luckydraw5.png);
	background-size:100% 100%;
	position: fixed;
	z-index:888;
	top:0px;
	left:0px;
}
.wxLoginFirst{
	width:100%;
	position:fixed;
	z-index:999999;
	top:0px;
	left:0px;
	background:none
}
.sharePage{
	width:90%;
	height:auto;
	position:absolute;
	z-index:999;
	top:72px; margin-left:5%;
	background:#fff; text-align:center;
}
input[type="text"],input[type="password"],input[type="date"],input[type="month"],input[type="month"],input[type="time"],input[type="week"],input[type="email"],select{border:none; outline:none; transition:border 0.2s ease-in 0s;  }
input[type="button"],input[type="submit"]{outline:none;cursor:pointer;border:none;}		
input[type="text"]:focus,input[type="password"]:focus,input[type="date"]:focus,input[type="month"]:focus,input[type="month"]:focus,input[type="time"]:focus,input[type="week"]:focus,input[type="email"]:focus,select:focus{border:1px solid #17a862;  }
	
.ye li{ float:left; font-size:16px;text-align:center;color:#333; margin:0; height:30px; line-height:10px; padding:0;overflow:hidden; text-overflow:ellipsis;white-space:nowrap;  }
.ye{ width:100%;  height:30px; font-size:14px; background-color:#FFFFFF}
.ye li a{ color:#333}
.ye li a:hover{ background-color:#ffffff}
.color a{ color:#EB3838!important;}
.bottom{  border-bottom:3px solid #EB3838!important;}
.nav > li > a:hover, .nav > li > a:focus {text-decoration: none; background-color: #fff}
.sharePage1{
	width:80%; height:auto;
	position:absolute;
	z-index:777;
	top:32px; margin-left:10%;
	background:#eee; text-align:center;border:1px solid #0066CC; padding-bottom:10px;
}
.box{ width:21.25%;border:1px solid #0066CC;float:left; background-color:#FFFFFF; color:#333333;margin-top:10px; margin-left:3%;text-overflow:ellipsis;white-space:nowrap;}
.box a{ color:#333333}
</style>
<script type="text/javascript">
var pageRecordCount = 15;
var curPage = 1;
var topShow = 1;
var uploadSuc = false;
var upload = false;

var searchProperty = "";
$(function(){
	loadData();
	$(window).bind("scroll",col_scroll);
	
	//搜索
	$(".index_tou_img2").click(function(){
		$(".sousuo").slideToggle();
		$(".sousuo").css("display","block")
	});
});
function loadData(){
	$("#note").show();
	$.ajax({
		type:"post",
		url: "<%=path%>/share/list",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount + "&video.searchProperty="+searchProperty,
		success:function(json){
			$("#note").hide();
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				var dat;
				if(data[i].articleId != "") {
					dat = data[i].article;
				} else if(data[i].videoId != "") {
					dat = data[i].video;
				}
				appStr += "<a href=\"<%=path%>/video/wxVideoDetail?video.id="+dat.id+"\">";
				appStr += "<li>";
				appStr += "<img src='<%=path%>"+dat.imagePath+"' />";
				appStr += "<p class='index_p1'>"+dat.title+"</p>";
                appStr += "<span class='index_p3'>";
                appStr += "<img src='<%=path%>/images/bofang.png' class='wh12' style='margin-top:1px;'/>";
                appStr += "<span style='margin-left:-8px;'>"+dat.viewNum+"次</span>";
                var createTime = dat.createTime;
                createTime = createTime.substring(0, 10);
                appStr += "<span style='margin-left:10px;'>"+createTime+"</span></span></li></a>";
			}
			$("#contentId").append(appStr);
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
}
var col_scroll = function(){ 
	if(($(document).height() -$(window).height()) == $(window).scrollTop()){
		if(!uploadSuc && !upload){
			upload = true;
			//调用加载中样式
			findData();
		}
	}
};
//加载函数
function findData(){
	curPage++;
	upload = false;
	loadData();
}
function searchSousou() {
	searchProperty = $("#keyword").val();
	curPage = 1;
	$("#contentId").children().remove();
	loadData();
}
</script>
</head>
<body>
<div class="index_tou" style="z-index:999999;">
	<p>分享视频记录<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a><img src="<%=path%>/images/seach.png" class="index_tou_img2" /></p>
</div>
<div class="h50"></div>
<div class="sousuo">
    <input type="search" id="keyword" name="searchValue" />
    <input type="submit" id="searchBtnId" onclick="searchSousou()" value=""/>
</div>
<div class="index_nr">
	<ul id="contentId">
		<!-- <a href="javascript:;" onclick="showDetail('/media/view/5423.jhtml')">
			<li>
				<img src="/upload/image/201604/ce16ab88-b139-4c59-b499-0f06106103c1.jpg" />
				<p class="index_p1">大爷年轻时一定是杂技团的 骑车等红灯从头到尾脚不沾地 </p>
                <span class="index_p3">
                    <img src="/resources/shop/mobile/icon/bofang.png" class="wh12" style="margin-top:1px;"/>
                    <span style="margin-left:-8px;">9406次</span>
                    <span style="margin-left:10px;">16/04/21</span>
                </span>
            </li>
        </a> -->
	</ul>
	<div class="w94" id="note" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
	<div class="h70"></div>
</div>
</body>
</html>