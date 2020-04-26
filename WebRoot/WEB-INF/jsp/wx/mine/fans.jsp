<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>查看粉丝</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/swiper.3.1.7.min.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/smartpaginator.js"></script>
<style>
body{background:#fff;}
.ye li{ float:left; font-size:14px;text-align:center;color:#333; margin:0; height:38px; line-height:10px; padding:0;overflow:hidden; text-overflow:ellipsis;white-space:nowrap;  }
.ye{ width:100%;  height:44px; font-size:14px; background-color:#FFFFFF}
.ye li a{ color:#333}
.ye li a:hover{ background-color:#ffffff}
.color a{ background-color:#FB543E!important;}
.nav > li > a:hover, .nav > li > a:focus { text-decoration: none; background-color: #fff}
.index_di div{
	height:52px;
	width:33.3%;
	float:left;
	text-align:center;
	color:#999999;
	font-size:12px;
	padding-top:4px;
}
.weizhi{position:absolute; top:6px; padding-left:85px; padding-right:10px; height:84px; font-size:12px;color:#333333}
.yingcang{overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
.yingcang-1{overflow:hidden; text-overflow:ellipsis;max-width:100%;display:block; }
.nav>li>a {position:relative;	display:block;padding:10px 0px}
.huiyuan{color:#eb3838}
</style>
<script>
var pageRecordCount = 15;
var curPage = 1;
var uploadSuc = false;
var upload = false;
var userNextTag = "1";
$(function(){
	loadData();
	$(window).bind("scroll",col_scroll);
})
function loadData(){
	$("#note").show();
	$.ajax({
		type:"post",
		url: "<%=path%>/hyuser/wxNextUser",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount+"&userNextTag="+userNextTag,
		success:function(json){
			$("#note").hide();
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<div style='padding:10px 10px; position:relative;border-bottom:1px dashed #aaa;'>";
				appStr += "<div class='height15'></div>";
				appStr += "<div class='photo_80'>";
				appStr += "<img src='"+data[i].headimgurl+"'/>";
				appStr += "</div>";
				appStr += "<div class='yingcang-1 weizhi'>";
				appStr += "<div>用户ID："+data[i].userCode+"</div>";
				appStr += "<div>昵称："+data[i].niName+"</div>";
				appStr += "<div>会员：非会员";
				appStr += "</div>";
				var createTime = data[i].createTime;
				createTime = createTime.substring(0, 16);
				appStr += "<div>关注时间："+createTime+"</div>";
				appStr += "</div></div>";
			}
			$("#listA").append(appStr);
		},error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
}
//下拉到底部加载更多数据
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
function lev(tag, obj) {
	userNextTag = tag;
	if(userNextTag == "1") {
		$(obj).parent().parent().children().eq(1).removeClass("active color bottom");
		$(obj).parent().addClass("active color bottom");
	} else if(userNextTag == "2") {
		$(obj).parent().parent().children().eq(0).removeClass("active color bottom");
		$(obj).parent().addClass("active color bottom");
	}
	$("#listA").children().remove();
	loadData();
}
</script>
</head>
<body>
<!--公共参数-->
<div class="index_tou">
	<p>查看粉丝 </p>
	<a href="javascript:window.history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a>
	<!--<img src="/resources/shop/mobile/icon/seach.png" class="index_tou_img2" />
	<div class="h10"></div>
	 <form class="sousuo" name="searchForm" action="/member/group/list.jhtml" method="get">
		<input type="hidden" name="searchProperty" id="searchProperty" value="title"/>
	    <input type="search" id="keyword" name="searchValue" />
	    <input type="submit" id="searchBtnId" value=""/>
	</form>-->	
	<div class="h5" style="background-color:#FFFFFF"></div>
	<div class="ye"  style="padding:0 10px">
		<ul id="myTab1" class="nav"  style=" width:100%;height:43px; border-bottom:2px solid #FB543E;" >
			<li tagId="A" class="active color bottom" style="width:50%; ">
				<a href="javascript:void(0)" onclick="lev(1, this)" data-toggle="tab"><span style="line-height:10px">一级用户</span><br/><span style="font-size:14px; line-height:20px">（<s:property value="userNumOne" />）</span></a>
			</li>
			<li tagId="B" style="width:50%" >
				<a href="javascript:void(0)" onclick="lev(2, this)" data-toggle="tab"><span style="line-height:10px">二级用户</span><br/><span style="font-size:14px; line-height:20px">（<s:property value="userNumTwo" />）</span></a>
			</li>
		</ul>
	</div>
</div>
<div class="h90"></div>
<div id="myTabContent1" class="tab-content" >
	<div class="tab-pane fade in active" id="Alei"> <!--Alei-->
		<div id="listA">
			<!-- <div style="padding:10px 10px; position:relative;border-bottom:1px dashed #aaa;">
				<div class="height15"></div>
				<div class="photo_80">
					<img src="http://wx.qlogo.cn/mmopen/kpcR1HbsqlqeddgSzg9YxuOeAJ9D52kPTVuYHgHFdx4yic0M6HG2h14aHBBUGaDw1p8ScJSWiaibqTORdFxRa4cttTvASLG79Cu/0"/>
				</div>
				<div class="yingcang-1 weizhi ">
					<div>用户ID：519183</div>
					<div>昵称：张金秋</div>
					<div>会员：非会员
					</div>
					<div>关注时间：16/04/26 01:10</div>
				</div>
			</div> -->
		</div>
	</div>
	<!--Alei-->
	<!--Blei-->
	<div class="tab-pane fade" id="Blei">
		<div id="listB"></div>
	</div>
	<!--Blei-->
	    <!--<div class="tab-pane fade" id="Clei">
			<div id="listC">
			</div>
	  </div> -->
</div>
<!-- id="myTabContent1"结束 -->
<div class="w94" id="note" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
<div class="h70"></div>
</body>
</html>