<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xuri.main.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String domain = Constant.domain;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>管理群组</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/swiper.3.1.7.min.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/smartpaginator.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style>
body{background:#fff;}
.ye li{ float:left; font-size:14px;text-align:center;color:#333; margin:0; height:38px; line-height:10px; padding:0;overflow:hidden; text-overflow:ellipsis;white-space:nowrap;  }
.ye{ width:100%;  height:44px; font-size:14px; background-color:#FFFFFF}
.ye li a{ color:#333}
.ye li a:hover{ background-color:#ffffff}
.color a{ background-color:#2D96FF!important;}
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
.index_tou_baocun{ width:90px;float:right;top:5px;position:absolute;right:3%;}
.green1{ background-color:#00DD37}

.wxLoginFirst{
	width:100%;
	position:fixed;
	z-index:999999;
	top:0px;
	left:0px;
	background:none
}
/*首次登陆指引*/
.sharePagelayerBg{
	width:100%;
	height:100%;
	background: url(<%=path%>/images/Luckydraw5.png);
	background-size:100% 100%;
	position: fixed;
	z-index:888;
	top:0px;
	left:0px;
}
</style>
<script>
var pageRecordCount = 15;
var curPage = 1;
var uploadSuc = false;
var upload = false;
var title = "<s:property value="user.niName" />-邀请您加入企业群组";
var yaoCode = "<s:property value="user.yaoCode" />";
yaoCode = yaoCode.replace("+", "%2B");
var linkUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx577b557dfebd5bd0&redirect_uri=http%3A%2F%2Fwd.cd08.com%2Fhyt%2Fhyuser%2FwxCompanyShare&response_type=code&scope=snsapi_userinfo&state="+yaoCode+"#wechat_redirect";
var headimgurl = "<s:property value="user.headimgurl" />";
wx.config({
	debug: false,
    appId: "wx577b557dfebd5bd0",
	timestamp: "<s:property value='wxSign.timestamp' />",
	nonceStr: "<s:property value='wxSign.nonceStr' />",
	signature: "<s:property value='wxSign.signature' />",
	jsApiList: [
		"checkJsApi",
        "onMenuShareTimeline",
        "onMenuShareAppMessage",
        "onMenuShareQQ",
        "onMenuShareWeibo",
        "onMenuShareQZone",
        "hideMenuItems",
        "showMenuItems",
        "hideAllNonBaseMenuItem",
        "showAllNonBaseMenuItem",
        "chooseImage",
        "previewImage",
        "uploadImage",
        "downloadImage",
        "openLocation",
        "getLocation",
        "hideOptionMenu",
        "showOptionMenu",
		"closeWindow"
	]
});
wx.ready(function(){
	//分享到朋友圈
	wx.onMenuShareTimeline({
	    title: title,
	    link: linkUrl,
	    imgUrl: headimgurl,
	    success: function () { },
	    cancel: function () { }
	});
	//分享到好友
	wx.onMenuShareAppMessage({
	    title: title,
	    desc: "点击查看更多信息",
	    link: linkUrl,
	    imgUrl: headimgurl,
	    success: function () { },
	    cancel: function () { }
	});
	//分享到QQ
	wx.onMenuShareQQ({
	    title: title,
	    desc: "点击查看更多信息",
	    link: linkUrl,
	    imgUrl: headimgurl,
	    success: function () { },
	    cancel: function () { }
	});
	//分享到腾讯微博
	wx.onMenuShareWeibo({
	    title: title,
	    desc: "点击查看更多信息",
	    link: linkUrl,
	    imgUrl: headimgurl,
	    success: function () { },
	    cancel: function () { }
	});
	//分享到QQ空间
	wx.onMenuShareQZone({
	    title: title,
	    desc: "点击查看更多信息",
	    link: linkUrl,
	    imgUrl: headimgurl,
	    success: function () { },
	    cancel: function () { }
	});
});
$(function(){
	loadData();
	$(window).bind("scroll",col_scroll);
	$("#addMem").click(function(){
		$(".wxLoginFirst").show();
		$(".sharePagelayerBg").show();
	});
	$(".wxLoginFirst").click(function(){
		$(".wxLoginFirst").hide();  
	 	$(".sharePagelayerBg").hide();
	});
})
function loadData(){
	$("#note").show();
	$.ajax({
		type:"post",
		url: "<%=path%>/hyuser/list",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount+"&user.joinCompany=1",
		success:function(json){
			$("#note").hide();
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<div style='height:50px;width:100%;padding:5px 10px 5px 10px; position:relative;border-bottom:1px solid #cbcbcb;'>";
				appStr += "<img src='"+data[i].headimgurl+"' style='width:40px;height:40px;float:left;'/>";
				appStr += "<span style='margin-left:10px;line-height:40px;'>"+data[i].niName+"</span>";
				appStr += "<span style='margin-right:10px;line-height:40px;float:right;'>"+data[i].point+"</span>";
				appStr += "</div>";
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
</script>
</head>
<body>
<!--公共参数-->
<div class="index_tou">
	<p>公司群组 </p>
	<a href="javascript:window.history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a>
	<div class="h5" style="background-color:#FFFFFF"></div>
	<div>
    	<button type="button" id="addMem" class="color_white green1 index_tou_baocun f16"  style="border:none; border-radius:3px; height:30px; line-height:30px">添加新成员</button>
    </div> 
</div>
<div class="h45"></div>
<div style="height:50px;">
	<img src="http://wx.qlogo.cn/mmopen/ajNVdqHZLLCnIROiboOGtHToBC3cqvaK0sMuxaETg8oLLA0A03ugicB0xTPzJMqJrRnKhC7d67iav1rEQgXsePOuA/0" style="width:50px;height:50px;margin-left:20px;" />
	<span><s:property value="user.companyName" /></span>
	<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" style="float:right;margin-top:15px;height:15px;width:auto;margin-right:10px;"/>
</div>
<div style="margin-top:10px;height:40px;border-top:1px solid #cbcbcb;border-bottom:1px solid #cbcbcb;background-color:#EEEEEE">
	<span style="float:left;margin-left:30px;line-height:40px;">用户信息</span>
	<span style="float:right;margin-right:10px;line-height:40px;">积分总数排行榜</span>
</div>
<div id="myTabContent1" class="tab-content" >
	<div class="tab-pane fade in active" id="Alei"> <!--Alei-->
		<div id="listA"></div>
	</div>
</div>
<!-- id="myTabContent1"结束 -->
<div class="w94" id="note" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
<div class="h70"></div>
<div class="wxLoginFirst" style="display:none;"><img src="<%=path%>/images/Luckydraw6.png" width="100%" style="margin-top:50px;"></div>
<div class="sharePagelayerBg" style="display:none;"></div>
</body>
</html>