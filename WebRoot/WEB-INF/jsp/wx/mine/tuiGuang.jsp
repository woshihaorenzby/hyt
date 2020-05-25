<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xuri.main.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String domain = Constant.domain;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>我推荐</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/wx/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style type="text/css">
	body{ background-color:#fff}
	.yingcang{overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
	.baikuang{width:40%;height:55%; text-align:center; font-size:10px; background:#FFFFFF; border-radius:10px; position:absolute; top:70px; left:30%}
	.jieshou{position:absolute; top:240px; left:8%; font-size:14px; color:#666; line-height:25px;width:92%; }
</style>
<script type="text/javascript">
var title = "<s:property value="user.niName" />-推广海报";
var linkUrl = "<%=domain%>hyuser/wxTuiGuang?user.id=<s:property value="user.id" />";
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
        "closeWindow",
        "chooseWXPay"
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
</script>
</head>
<body style="background-color:#FFE300;">
	<div class="index_tou">
	    <p>推广海报<a href="javascript:window.history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
	</div>
	<div class="h40"></div>
	<div style="position:relative;">
		<img src="<%=path%>/images/tui_bg.png" style="position:absolute;width:100%;height:auto;"/>
		<img src="<%=path%>/images/tui_hyt.png" style="position:absolute;top:20px;left:20px;width:80px;height:auto;"/>
		<img src="<%=path%>/images/tui_miao2.png" style="position:absolute;top:70px;left:15%;right:15%;width:70%;height:auto;"/>
		<div style="position:absolute;top:190px;left:20px;">
			<img src="<s:property value="user.headimgurl" />" style="width:60px;height:60px;border-radius:60px;float:left;">
			<div style="float:left;">
				<p style="font-size:18px;font-weight:bold;margin-left:20px;">我是<s:property value="user.niName" /></p>
				<p style="font-size:18px;font-weight:bold;margin-left:50px;">推荐你使用“选卡网”</p>
			</div>
		</div>
		<div style="position:absolute;top:270px;width:100%;height:150px;">
			<img src="<%=path%>/images/tui_con1.png" style="margin-left:15%;float:left;height:80px;width:auto;margin-top:30px;"/>
			<div style="float:left;width:180px;height:180px;background-color:white;margin-left:20px;text-align:center;">
				<img src="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=<s:property value="ticket.ticket" />" style="width:160px; height:160px; border-radius:10px"><br /><!--二维码图 -->
				<span style="line-height:15px;font-size:14px;">长按此图片 识别关注二维码</span>
			</div>
			<img src="<%=path%>/images/tui_con2.png" style="float:left;margin-left:20px;height:80px;width:auto;margin-top:30px;"/>
		<div>
	</div>
	<img src="<%=path%>/images/tui_bgbot.png" style="width:100%;height:auto;position:fixed;bottom:0;left:0;"/>
</body>
</body>
</html>