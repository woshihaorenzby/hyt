<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xuri.main.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String domain = Constant.domain;
String sharedomain = Constant.sharedomain;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta name="format-detection" content="telephone=yes"/>
	<title><s:if test="share !=null and share=='1'.toString()"><s:property value="video.title" /></s:if><s:else>设置广告</s:else></title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css?v=2" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript" src="<%=path%>/js/fingerprint2.js"></script>
<script>
var share = "<s:property value='share' />"
//分享
var advType = "";
var imgUrl = "<%=domain%><s:property value="video.imagePath" />";
var linkUrl = encodeURI("<%=domain%>/video/wxVideoDetail?video.id=<s:property value="video.id" />&user.id=<s:property value="user.id" />&share=1");
var desc = "<s:property value="shareDesc" />";
var finger;
var zhenAdvType = "";
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
function shareWx() {
	//分享到朋友圈
	wx.onMenuShareTimeline({
	    title: $("#mediaTitle").html().replace("<br>",""),
	    link: linkUrl,
	    imgUrl: imgUrl,
        desc: desc,
	    success: function () {
	    	shareInfo();
	    },
	    cancel: function () {
	    	$(".sharePage").hide();
			$(".sharePageAd").hide();
			$(".sharePagelayerBg").hide();
	    }
	});
	//分享到好友
	wx.onMenuShareAppMessage({
	   title: $("#mediaTitle").html().replace("<br>",""),
	    link: linkUrl,
	    imgUrl: imgUrl,
        desc: desc,
	    success: function () {
	    	shareInfo();
	    },
	    cancel: function () {
	    	$(".sharePage").hide();
			$(".sharePageAd").hide();
			$(".sharePagelayerBg").hide();
	    }
	});
	//分享到QQ
	wx.onMenuShareQQ({
	    title: $("#mediaTitle").html().replace("<br>",""),
	    link: linkUrl,
	    imgUrl: imgUrl,
        desc: desc,
	    success: function () {
	    	shareInfo();
	    },
	    cancel: function () {
	    	$(".sharePage").hide();
			$(".sharePageAd").hide();
			$(".sharePagelayerBg").hide();
	    }
	});
	//分享到腾讯微博
	wx.onMenuShareWeibo({
	    title: $("#mediaTitle").html().replace("<br>",""),
	    link: linkUrl,
	    imgUrl: imgUrl,
        desc: desc,
	    success: function () {
	    	shareInfo();
	    },
	    cancel: function () {
	    	$(".sharePage").hide();
			$(".sharePageAd").hide();
			$(".sharePagelayerBg").hide();
	    }
	});
	//分享到QQ空间
	wx.onMenuShareQZone({
		title: $("#mediaTitle").html().replace("<br>",""),
		link: linkUrl,
		imgUrl: imgUrl,
        desc: desc,
		success: function () {
			shareInfo();
		},
		cancel: function () {
			$(".sharePage").hide();
			$(".sharePageAd").hide();
			$(".sharePagelayerBg").hide();
		}
	});
}
$(document).ready(function(){
	wx.ready(function(){
		shareWx();
	});
	loadVideoType();


    var pinWidth = window.screen.availWidth;
    $(".advcondiv").css("width", pinWidth-150);
    $("#phondiv").css("width", pinWidth);
    if(advType=="2") {
        var imgHei = $("#phoneAdvImg").height();
        $("#phoneAdvImg").parent().css("height", imgHei);
        $("#phoneAdvImg").next().css("height", imgHei);
        $("#phoneAdvImg").next().children().eq(0).css("height", imgHei);
    }
	//点击数
	if(share=="1") {
		$(".index_tou").remove();
		$(".h50").remove();

		//统计阅读量
        $.ajax({
            type: "post",
            url: "<%=path%>/share/wxShareView",
            dataType: "json",
            data: "share.videoId=<s:property value="video.id" />&share.userId=<s:property value='userId' />",
            success: function(data){ },
            error: function(XMLHttpRequest, textStatus, errorThrown) { }
        });
	}
	var fingerprint = new Fingerprint2();//浏览器指纹
	fingerprint.get(function(result) {
		finger = result;
		$.ajax({
			type: "post",
			url: "<%=path%>/video/wxVideoView",
			dataType: "json",
			data: "hyView.videoId=<s:property value="video.id" />&hyView.userId=<s:property value="user.id" />&hyView.figure="+result,
			success: function(data){ },
			error: function(XMLHttpRequest, textStatus, errorThrown) { }
		});
	});
	$(".sharePage").click(function(){
		$(".sharePage").hide();
		$(".sharePagelayerBg").hide();
	});
	$(".sharePageAd").click(function(){
		$(".sharePageAd").hide();
		$(".sharePagelayerBg").hide();
	});
	$("#fenxiang_tu,#fenxiang_btn").click(function(){
		$(".sharePage").show();
		$(".sharePagelayerBg").show();
		setTimeout(function(){Allsc();},100);
	})
	//点击其他地方隐藏分享窗口
	$(document).bind("click",function(e){
		var target = $(e.target);
		if(target.closest("#fenxiang_tu,#fenxiang_btn").length == 0){
			$(".xq_tc").hide();
			(".xq_tc ul").css("bottom","-160px")
		}
	})
	$(".guanggao, .block11css, .guanggou").click(function(){
		if(share == "1") {
			//设置广告点击统计
			$.ajax({
				type: "post",
				url: "<%=path%>/adv/wxAdvClick",
				dataType: "json",
				data: "user.id=<s:property value="user.id" />&user.mpUse=<s:property value="user.mpUse" />&hyView.videoId=<s:property value="video.id" />&hyView.figure="+finger,
				success: function(data){ },
				error: function(XMLHttpRequest, textStatus, errorThrown) { }
			});
			if(advType == "1") {
				window.location.href = "<%=domain%>/hyuser/wxShowCard?user.id=<s:property value='user.id'/>";
			} else {
                if(zhenAdvType =="3") {
                    $(".sharePagePop").css("top", (getScrollTop() + 100) + "px");
                    $(".sharePagePop").show();
                    $(".sharePagelayerBg").show();

                    var imgurl = $(this).children().eq(0).attr("src");
                    $("#cardPopImgId").attr("src", imgurl);
                } else {
                    var urlType = "<s:property value="adv.urlType"/>";
                    if(urlType == "1") {
                        urlType = "http://";
                    } else if(urlType == "2") {
                        urlType = "https://";
                    }
                    var urlaa = urlType + "<s:property value="adv.url"/>";
                    window.location.href = urlaa;
                }
			}
		} else {
			if(advType == "1") {
				window.location.href="<%=path%>/hyuser/wxCard";
			} else if(advType == "2") {
				window.location.href="<%=path%>/adv/wxAdvEdit?adv.id=<s:property value="adv.id"/>";
			} else if(advType == "3") {
				window.location.href="<%=path%>/adv/wxAdv";
			} else if(advType == "4") {
				window.location.href="<%=path%>/hyuser/wxMemberup?memLevel=<s:property value="user.memLevel"/>";
			}
		}
	});
	//点击到视频分享神器
	$("#download_btn").click(function(){
		window.open("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx577b557dfebd5bd0&redirect_uri=http%3A%2F%2F<%=sharedomain%>%2Fhyuser%2FwxIndex&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect", "_self");
	});

    $("#closeBtn").click(function(){
        $(".sharePagePop").hide();
        $(".sharePagelayerBg").hide();
    });
});
//调用分享成功
function shareInfo(){
	$(".sharePage").hide();
	$(".sharePageAd").hide();
	$(".sharePagelayerBg").hide();

	$.ajax({
		type: "post",
		url: "<%=path%>/share/wxSave",
		dataType: "json",
		data: "share.videoId=<s:property value="video.id" />&share.userId=<s:property value='userId' />",
		success: function(data){ },
		error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
}
var typeName = "${video.typeName}";
function loadVideoType() {
	$.ajax({
		type: "post",
		url: "<%=path%>/video/wxVideoMainList",
		dataType: "json",
		data: "page.curPage=1&video.typeName=" + typeName,
		success: function(data){
			if(data!=null && data.length>0) {
				var appStr = "";
				for(var i=0; i<data.length; i++) {
					appStr += "<a href='javascript:;' onclick='showDetail(\"<%=path%>/video/wxVideoDetail?video.id="+data[i].id+"\")'>";
					appStr += "<li>";
					appStr += "<img src='<%=path%>"+data[i].imagePath+"' style='float:right' />";
					appStr += "<p class='index_p1'>"+data[i].title+"</p>";
					appStr += "</li></a>";
				}
				$("#contentId").append(appStr);
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
}
function showDetail(url) {
    window.open(url, "_self");
}
function getScrollTop(){
    var scrollTop=0;
    if(document.documentElement&&document.documentElement.scrollTop){
        scrollTop=document.documentElement.scrollTop;
    }else if(document.body){
        scrollTop=document.body.scrollTop;
    }
    return scrollTop;
}
</script>
<style type="text/css">
    /*html, body{
        background:#eee;
}*/
/* 视频宽度100% */
.box .video div {
	width: 100%;
}
video, img {
	max-width: 100%;
  	display: block;
	text-align: center;
	width: 100%;
	height: auto;
}
.titleP {
	font-family: "黑体";
	padding-top:10px;
	font-size: 20px;
}
.titleP1 {
	font-family: "黑体";
	font-size: 20px;
}
.title1 {
	min-height:20px;
	font-size:20px;
/* 	background:#fff; */
}
.title2{
	min-height:20px;
	font-size:12px;
	margin-top:10px;
}
.xiangqing_ceng{
	z-index:10;
	bottom:0;
	left:0;
	color:#FFF;
	line-height:20px;
	width:100%;
	background:rgba(0,0,0,0.5);
	text-align:left;
	padding:0 10px;
	font-size:14px;
}
</style>
<style type="text/css">
	<!--
	.alert{
	  text-align: left;
	  color: white;
	  font-size: 14px;
	  margin: 2%;
	}
	.fenh{
		width:100%;position: relative;height: 40px;margin-top:13px;
	}
	.fenh li{
		border-radius:50px;
		background-color:#fff;
		width:22%;
		border:1px solid #eaeaea;
		float:left;
		height:35px;
		padding-top: 2px;
		padding-left: 12px;
		margin-left:5px;
	}
	.fenh img{
		max-width: 50%;
	   	float: left;
	    width: 40%;
	    height: auto;
	}
	.fenh span{
		float:left;margin-top:7px;font-size:12px;
	}
	/*分享朋友圈*/
	.sharePagelayerBg{
		width:100%;
		height:100%;
		background: url(<%=path%>/images/Luckydraw5.png);
		background-size:100% 100%;
		position: fixed;
		z-index:888888;
		top:0px;
		left:0px;
	}
	.sharePage{
		width:100%;
		position:fixed;
		z-index:999999;
		top:0px;
		left:0px;
		background:none
	}

	.sharePageAd{
		width:100%;
		position:fixed;
		z-index:999999;
		top:0px;
		left:0px;
		background:none
	}
	/* 广告位 */

	.block11css {
	    padding: 5px;
	}

	.block11css {
	  width: 100%;
	  background: #fff;
	  display: table;
	  border: 1px solid #bebebe;
	}
	.block11css div {
	  vertical-align: middle;
	  display: table-cell;
	}

	.block11css div:first-child {
	  position: relative;
	  /*width:35%;*/
	}
	.block11css div:last-child {
	  font-size: 16px;
	  font-family: "黑体";
	  color: #1c78d5;
	}
	.block11css .img1 {
	  position: absolute;
	  top: 0;
	}
	.block11css div .img2 {
	  height: 94px;
	  width: 94px;
	}
	.perInfo{
	    color:#1C78D5;
	    width:80%;
		margin-right:10px;
    }
.yingcang{overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
.weizhi{position:absolute; top:-2px; padding-left:80px;height:18px; font-size:14px}
.weizhi-2{position:absolute; top:18px; padding-left:80px;height:18px; font-size:14px}
.weizhi-3{position:absolute; top:38px; padding-left:80px;height:18px; font-size:14px}
.weizhi-4{position:absolute; top:58px;padding-left:80px;height:18px; font-size:14px;}
    .sharePagePop{
        width:90%;
        height:auto;
        position:absolute;
        z-index:9999999;
        top:30%; margin-left:5%;
        background:#fff; text-align:center;
    }
    .advcondiv{
        line-height: normal;width:60%;margin-left:110px;text-align:left;height:100px;
    }
    </style>
</head>
<body id="homeContent">
	<!--添加到朋友圈层 复制该层时把下面的js部分的$(".sharePagelayerBg")一并复制-->
	<div class="sharePage" style="display:none;"><img src="<%=path%>/images/Luckydraw6.png" width="100%"></div>
	<div class="sharePageAd" style="display:none;"><img src="<%=path%>/images/Luckydraw8.png" width="100%"></div>
	<div class="sharePagelayerBg" style="display:none;"></div>
	<!--添加到朋友圈层 END-->
 	<div class="index_tou">
		<p>
			<span class="f18"><s:if test="share !=null and share=='1'.toString()"><s:property value="video.title" /></s:if><s:else>在底部插入你的广告</s:else></span>
	        <a href="javascript:history.back(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a>
	    </p>
	</div>
	<div class="h50"></div>
	<s:if test="share == null or share == ''.toString()">
		<h3 class="titleP1" style="margin-left: 10px; margin-top:5px ; margin-bottom:5px;"><span style="margin-bottom:6px;" class="f12 m-top10">↓点击标题可更改内容↓</span></h3>
 		<p class="w94 f18 title1" contenteditable="true" id="mediaTitle" onpropertychange="shareWx();" oninput="shareWx();"><s:property value="video.title" /></p>
	</s:if>
	<s:else>
		<p class="w94 f18 title1" id="mediaTitle" style="margin-top:10px;"><s:property value="video.title" /></p>
		<p class="w94 f18 title2" ><span><s:property value="video.pushTime" /></span>&nbsp;&nbsp;<span>阅读：<s:property value="video.viewNum" />&nbsp;次</span></p>
		<div class="h10"></div>
		<!-- 新加 文章才会有头部广告-->
		<!-- 新加end -->
	</s:else>
	<div class="h10"></div>
	<div class="w94">
		<s:if test="video.mainType != null and video.mainType == '1'.toString()">
			<div id="videoUrl" class="video" style="width:auto;height:250px;background:black;">
		    	<iframe frameborder="0" width="100%" height="100%" src='<s:property value="video.videoUrl" />' allowfullscreen></iframe>&nbsp;
		    </div>
		</s:if>
		<s:elseif test="video.mainType != null and video.mainType == '2'.toString()">
			<div style="width:100%;height:auto;">
				<s:property value="video.articleContent" escape="false"/>
			</div>
		</s:elseif>
	    <s:if test="share != null and share == '1'.toString()">
	    	<%-- <span class="f12 f-right m-top0">阅读：<s:property value="video.viewNum" />&nbsp;&nbsp;&nbsp;&nbsp;</span> --%>
			<!-- <p style="margin-top:15px;"><img alt="" src="<%=path%>/images/dianzan.png" style="max-width:18px;float:left"><span style="float:left;margin-left:5px;">4555</span></p>
            <br/>  -->
            <!-- <div class="fenh">
                <ul >
                    <li onclick="shareAppMessage()"><img src="<%=path%>/images/weixin.png" /><span>微信</span></li>
                    <li onclick="shareTimeline()" style="width:25%"><img src="<%=path%>/images/pengyouquan.png" style="max-width:33%"/><span>朋友圈</span></li>
                    <li onclick="share2weibo()"><img src="<%=path%>/images/qq.png" /><span>QQ</span></li>
                    <li onclick="share2weibo()" style="width:25%"><img src="<%=path%>/images/qqkongjian.png" style="max-width:25%;margin-top:4px"/><span>&nbsp;QQ空间</span></li>
                </ul>
            </div> -->
            <p class="f18 m-top15 m-bottom0" style="font-size:14px;">广告</p>
        </s:if>
        <s:else>
            <p class="f18 m-top10 m-bottom0">点击编辑你的广告<span class="f12 f-right " style="margin-top:8px;"></span></p>
        </s:else>
        <s:if test="user.mpUse != null and user.mpUse != ''.toString() and user.mpUse == '1'.toString()">
            <s:if test="video.needQiTy == '1' and user.memLevel != '4'.toString()"><!-- 判断是否需要企业VIP会员才可以设置的视频 -->
                <script>advType = "4";</script>
                <div class="block11css overbox" style="border:0px" >
                    <div class="perInfo" style="width:100%;height:100px;">
                        <center><font style="color:#1c78d5">您现在的会员等级无法设置广告，请升级企业VIP会员</font></center>
                    </div>
                </div>
            </s:if>
            <s:else>
                <script>advType = "1";</script>
                <div class="block11css overbox" style="border:0px" >
                    <div class="perInfo" style="width:100%;height:100px;">
                        <img src="<s:property value="user.headimgurl" />" style="float:left;margin-left:10px;width:80px;height:80px;" />
                        <div style="float:left;margin-left:20px;color:black;font-size:14px;">
                            <span>微名片</span><br/>
                            <span><s:property value="user.mpNiName" /></span><br/>
                            <span><s:property value="user.mpJob" /></span><br/>
                            <span><s:property value="user.mpCompany" /></span>
                        </div>
                    </div>
                </div>
            </s:else>
        </s:if>
        <s:elseif test="adv.id != null and adv.id != ''.toString()">
            <s:if test="video.needQiTy == '1' and user.memLevel != '4'.toString()"><!-- 判断是否需要企业VIP会员才可以设置的视频 -->
                <script>advType = "4";</script>
                <div class="block11css overbox" style="border:0px" >
                    <div class="perInfo" style="width:100%;height:100px;">
                        <center><font style="color:#1c78d5">您现在的会员等级无法设置广告，请升级企业VIP会员</font></center>
                    </div>
                </div>
            </s:if>
            <s:elseif test="adv.advType != null and adv.advType == '1'.toString()">
                <script>advType = "2";zhenAdvType="1";</script>
                <div class="guanggao">
                    <img src="<%=path%><s:property value="adv.imagePath"/>" style="position:relative;width:100%; min-height:100px"/>
                 </div>
                <div class="xiangqing_ceng">
                    <p><s:property value="adv.des"/></p>
                </div>
            </s:elseif>
            <s:elseif test="adv.advType != null and adv.advType == '2'.toString()">
                <script>advType = "2";zhenAdvType="2";</script>
                <a href="tel:<s:property value="adv.url"/>">
                    <div class="guanggao" style="text-align: center;height:auto;">
                        <img id="phoneAdvImg" src="<%=path%><s:property value="adv.imagePath"/>" style="position:absolute;width:100%; height:auto;z-index:100;"/>
                        <div style="line-height: normal;width:100%;height:100px;z-index:102;position:absolute;">
                            <div id="phondiv" style="display: table-cell;vertical-align: middle;height:100px;width:420px;margin-left:auto;margin-right:auto;">
                                <div style="font-weight:bold;font-size:20px;color:#A60000;"><s:property value="adv.des"/></div>
                                <div style="font-weight:bold;font-size:25px;color:black;"><s:property value="adv.url"/></div>
                            </div>
                        </div>
                    </div>
                </a>
            </s:elseif>
            <s:elseif test="adv.advType != null and adv.advType == '3'.toString()">
                <script>advType = "2";zhenAdvType="3";</script>
                <div class="guanggao" style="height:102px;">
                    <img src="<%=path%><s:property value="adv.imagePath"/>" style="width:100px; height:100px;"/>
                    <div class="advcondiv">
                        <div style="display: table-cell;vertical-align: middle;height:100px;width:100%;">
                            <s:property value="adv.des"/>
                        </div>
                    </div>
                    <div style="position:absolute;bottom:0px;right:0px;width:80px;line-height:25px;background: green;color:white;">
                        关注
                    </div>
                </div>
            </s:elseif>
            <s:elseif test="adv.advType != null and adv.advType == '4'.toString()">
                <script>advType = "2";zhenAdvType="4";</script>
                <div class="guanggao" style="height:102px;">
                    <img src="<%=path%><s:property value="adv.imagePath"/>" style="width:100px; height:100px;"/>
                    <div class="advcondiv">
                        <div style="display: table-cell;vertical-align: middle;height:100px;width:100%;">
                            <s:property value="adv.des"/>
                        </div>
                    </div>
                </div>
            </s:elseif>
            <s:elseif test="adv.advType != null and adv.advType == '5'.toString()">
                <script>advType = "2";zhenAdvType="5";</script>
                <a href="tel:<s:property value="adv.usPhone"/>">
                    <div class="guanggao" style="height:102px;">
                        <img src="<%=path%><s:property value="adv.imagePath"/>" style="width:100px; height:100px;"/>
                        <div class="advcondiv">
                            <div style="display: table-cell;vertical-align: middle;height:100px;width:100%;">
                                <span style="">
                                    <s:property value="adv.usName"/>
                                </span><br/>
                                <span>
                                    <s:property value="adv.usPhone"/>
                                </span><br/>
                                <span>
                                    <s:property value="adv.usAddress"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </a>
            </s:elseif>
        </s:elseif>
        <s:else>
            <s:if test="video.needQiTy == '1' and user.memLevel != '4'.toString()"><!-- 判断是否需要企业VIP会员才可以设置的视频 -->
                <script>advType = "4";</script>
                <div class="block11css overbox" style="border:0px" >
                    <div class="perInfo" style="width:100%;height:100px;">
                        <center><font style="color:#1c78d5">您现在的会员等级无法设置广告，请升级企业VIP会员</font></center>
                    </div>
                </div>
            </s:if>
            <s:else>
                <script>advType = "3";</script>
                <div class="block11css overbox" style="border:0px" >
                    <div class="perInfo" style="width:100%;height:100px;">
                        <center><font style="color:#1c78d5">请设置广告图、文字及推广链接</font></center>
                    </div>
                </div>
            </s:else>
        </s:else>
        <div class="h8"></div>
        <s:if test="share != null and share == '1'.toString()">
            <div class="h8"></div>
            <button id="download_btn" type="button"  class="btn btn-default btn-block btn-lg m-top10 f16 hong">我也推广</button>
            <div class="h5"></div>

            <div class="index_nr" style="margin-top:10px">
                <ul id="contentId">

                </ul>
            </div>
            <!-- <div style="width:100%;position:relative; ">
                <div>
                    <ul style="margin-top:20px;">
                        <li style="width:12%;float:left;"><img src="<%=path%>/images/tou.png" style="border-radius:50%;"></li>
                        <li style="width:68%;float:left;"><p style="margin:15px 13px;color:#2a00e1">昵称</p></li>
                        <li style="width:20%;float:left;"><p style="margin-top:15px;"><img alt="" src="<%=path%>/images/dianzan.png" style="max-width:18px;float:left"><span style="float:left;margin-left:5px">4555</span></p></li>
                    </ul>
                    <br/>
                    <p style="margin-left:60px;margin-top:30px;">
                        是非得失读后感富商大贾华盛顿规划局可视电话刚解封灰色空间好东哥快捷方式逗号隔开后方可圣诞节和高科技货到付款结构化的看法
                    </p>
                    <p style="margin-left:60px;font-size:12px;margin-top:8px;">2018年12月30日</p>
                </div>
            </div> -->
            <center class="f12 w100 m-top5 m-bottom10 text-center" style="color:#ccc;margin-bottom:5px;margin-top: 30px;">此内容源自互联网，版权归原作者所有</center>
        </s:if>
        <s:else>
            <button id="fenxiang_btn" type="button" onclick="shareWx();" class="btn btn-default btn-block btn-lg m-top10 f16">分享<s:if test="video.mainType != null and video.mainType == '1'.toString()">视频</s:if><s:else>文章</s:else></button>
        </s:else>
    </div>
    <div class="h60"></div>
    <div class="xq_tc" style="display:none;">
        <ul>
            <li onclick="shareAppMessage()"><img src="<%=path%>/images/weixin.png" /><br />微信</li>
            <li onclick="shareTimeline()"><img src="<%=path%>/images/pengyouquan.png" /><br />朋友圈</li>
            <li onclick="share2weibo()"><img src="<%=path%>/images/qq.png" /><br />QQ</li>
        </ul>
    </div>
     <s:if test="share != null and share == '1'.toString()">
         <!-- <div style="position: fixed;z-index: 999;bottom: 0px;background-color: #fff;width: 100%;height:40px;display: none;" id="gundong">
            <ul>
                <li style="float:left"><input type="text" placeholder="写评论" style="width:300px;text-indent:25px;border:1px solid #eaeaea;border-radius:20px;height:30px;margin:5px 5%;"/></li>
                <li style="float:left"><img src="<%=path%>/images/mineyijian.png" style="width:30px;margin:5px 30px"></li>
            </ul>
         </div> -->
     </s:if>
    <div class="sharePagePop" style="display:none;">
        <div id="cardPopId" style="text-align:center;padding-bottom:20px;">
            <div >
                <button type="button" id="closeBtn" class="close" style="padding:0 20px;">&times;</button>
                <h6 style="height:20px;">&nbsp;</h6>
            </div>
            <img id="cardPopImgId" style="width:200px;height:auto;margin-left:auto;margin-right:auto;"/>
        </div>
    </div>
</body>
<script type="text/javascript">
var W = $(".index_tou").width();
$(".index_tou p span").width(W - 60);
function Allsc(){
    $("#homeContent").css("height", document.body.clientHeight);
       $(".sharePagelayerBg").css("height", $("body").height());
}
$(window).scroll(function(){//滚动事件获取//判断滚动条高度
    var $scroll = $(document).scrollTop();
    if($scroll>800){//判断滚动条高度
        $("#gundong").show();
        //增加CLASS
    }else{
        $("#gundong").hide();
        //移除CLASS
    }
})
function scrollToTop(){
            //   这里边可以写一些逻辑，比如偶数行一个一个的置顶，不如状态等于0的一个一个的置顶！
    document.getElementById('scrollBody').scrollTop = 1;
}
window.onload=function(){
    //Allsc();
    //bodyOnLoad();
    //share();
};
window.onresize = function(){
    //捕捉屏幕窗口变化，
    Allsc();
}

function bodyOnLoad() {
    /*var tmp = $("#videoUrl iframe").attr("style");
    tmp=tmp.substr(tmp.indexOf(";")+1);
    $("#videoUrl iframe").attr("style", tmp);*/
}
</script>
</html>