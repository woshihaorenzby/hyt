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
	<title>选号网-微信推广神器</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css?v=4" rel="stylesheet" type="text/css" />
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
	background: url(<%=path%>/images/Luckydraw5.png);
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
var syInsert = 1;
var uploadSuc = false;
var upload = false;
var mainType = "<s:property value="video.mainType" />";
var isCheck = "<s:property value="user.ischeck" />";
var memLevel = "<s:property value="user.memLevel" />";
var joinCompany = "<s:property value="user.joinCompany" />";
if(joinCompany == "1") memLevel = "4";//如果是加入了企业群组，则和企业VIP是一样的权限
var searchProperty = "";//模糊查询的标题
var typeName = "${typeName}";
$(function(){
	if(typeName!="") {
		topShow = "";
		$(".tianjia1").addClass('active color bottom').siblings().removeClass('active color bottom');
	}
	loadData();
	$(window).bind("scroll",col_scroll);
	//点击视频类别
	$("#menuId div").click(function(){
	 	if(isCheck == "0") {
	 		$("#unBindId").show();
			$("#companyId").hide();
			$("#personId").hide();
			$(".sharePage").show();
		 	$(".sharePagelayerBg").show();
		 	return;
	 	}
	 	if(memLevel == "1") {//不是付费会员
			$("#unBindId").hide();
			$("#companyId").hide();
			$("#personId").show();
			$(".sharePage").show();
		 	$(".sharePagelayerBg").show();
		 	return;
		}
		
	 	typeName = $(this).children().attr("data");
	 	curPage = 1;
		$("#contentId").children().remove();
		loadData();
	});
	//点击标签切换
	$("#myTab1 li").click(function(event){
		var chargesType = $(this).children().attr("val");
		var tagId = $(this).children().attr("data");//标签类别
		var iscompany = $(this).children().attr("iscompany");//是否需要公司权限
		$(this).addClass('active color bottom').siblings().removeClass('active color bottom');
		if(tagId==undefined || tagId=='') return false;
		if(tagId == "1") {
			$("#contentId").children().remove();
			typeName = "";
			topShow = "1";
			syInsert = 1;
			loadData();
		} else if(tagId == "2") {
			if(isCheck == "0") {
				$("#unBindId").show();
				$("#companyId").hide();
				$("#personId").hide();
				$(".sharePage").show();
			 	$(".sharePagelayerBg").show();
			 	return;
			} else {
				if(memLevel == "1") {//不是付费会员
					$("#unBindId").hide();
					$("#companyId").hide();
					$("#personId").show();
					$(".sharePage").show();
				 	$(".sharePagelayerBg").show();
				 	return;
				}
			}
			$("#contentId").children().remove();
			typeName = "";
			topShow = "0";
			syInsert = 1;
			loadData();
		} else if(tagId == "3") {
			if(memLevel == "1" || memLevel == "2") {//不是付费会员
				if(isCheck == "0") {
					$("#unBindId").show();
					$("#companyId").hide();
					$("#personId").hide();
				} else {
					$("#unBindId").hide();
					$("#companyId").show();
					$("#personId").hide();
				}
				$(".sharePage").show();
			 	$(".sharePagelayerBg").show();
			 	return;
			}
			$("#contentId").children().remove();
			typeName = "";
			topShow = "";
			syInsert = 0;
			loadData();
		}
	});
	var $sharePage1 = $(".sharePage1");
	$sharePage1.click(function(){
	     $sharePage1.hide();
		 $(".tianjia1").attr("tt","0");
	});
	$(".tianjia1").click(function(e){
		if($(".tianjia1").attr("tt") == "0"){
			$sharePage1.show();
			$(".tianjia1").attr("tt","1");
			return false;
		} else {
			$sharePage1.hide();
			$(".tianjia1").attr("tt","0");
			return false;
		}
	});
	//点其他地方导航收起
	$(document).bind("click",function(e){
		$sharePage1.hide();
		$(".tianjia1").attr("tt","0");
	});
	$(".ye ul li").click(function(event){
		$(this).addClass('color').siblings().removeClass('color');
		$(this).addClass('bottom').siblings().removeClass('bottom');
	});
	$(".box").click(function(event){
		$(this).addClass('color').siblings().removeClass('color');
	});
});
function loadData(){
	$("#note").show();
	$.ajax({
		type:"post",
		url: "<%=path%>/video/list",
		dataType:"json",
		data:"page.curPage=" + curPage + "&page.pageRecordCount="+pageRecordCount + "&video.mainType=" + mainType + "&video.auditTag=1&video.topShow=" + topShow + "&video.title=" + searchProperty + "&video.typeName=" + typeName + "&video.syInsert=" + syInsert,
		success:function(json){
			$("#note").hide();
			var totalRecord = json.totalRecord;
			var data = json.data;
			$("#table_tb").children().remove();
			var appStr = "";
			for(var i=0; i<data.length; i++){
				appStr += "<a href=\"javascript:void(0)\" onclick=\"openVideo('<%=path%>/video/wxVideoDetail?video.id="+data[i].id+"')\">";
				appStr += "<li>";
				appStr += "<img src='<%=path%>"+data[i].imagePath+"' />";
				appStr += "<p class='index_p1'>"+data[i].title+"</p>";
                appStr += "<span class='index_p3'>";
                appStr += "<img src='<%=path%>/images/bofang.png' class='wh12' style='margin-top:1px;'/>";
                appStr += "<span style='margin-left:-8px;'>"+data[i].viewNum+"次</span>";
                var createTime = data[i].createTime;
                createTime = createTime.substring(0, 10);
                appStr += "<span style='margin-left:10px;'>"+createTime+"</span></span></li></a>";
			}
			$("#contentId").append(appStr);
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
function searchSousou() {
	searchProperty = $("#keyword").val();
	curPage = 1;
	$("#contentId").children().remove();
	loadData();
}
function openVideo(url) {
	if(isCheck == "0") {
		$("#unBindId").show();
		$("#companyId").hide();
		$("#personId").hide();
		$(".sharePage").show();
	 	$(".sharePagelayerBg").show();
	} else {
		window.open(url, "_self");
	}
}
</script>
</head>
<body>
<div class="index_tou" style="z-index:999999;">
    <p><a href="<%=path%>/video/wxVideo?video.mainType=1" style="margin-left:-40px;font-size:18px;<s:if test="video.mainType == '1'.toString()">color:#EB3838;</s:if><s:else>color:white;</s:else>">热点视频</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=path%>/video/wxVideo?video.mainType=2&typeName=<s:property value="typeName" />" style="font-size:18px;<s:if test="video.mainType == '2'.toString()">color:#EB3838;</s:if><s:else>color:white;</s:else>">热点文章</a><a href="<%=path%>/notice/wxNotice"><img src="<%=path%>/images/xinfeng.png" class="index_tou_img"/></a><img src="<%=path%>/images/seach.png" class="index_tou_img2" /></p>
</div>
<div class="h50"></div>
<div class="sousuo">
    <input type="search" id="keyword" name="searchValue" placeholder="输入搜索内容"/>
    <input type="submit" id="searchBtnId" onclick="searchSousou()" value=""/>
</div>
<div class="ye" style="position:relative">
	<ul id="myTab1" class="nav" style=" width:100%;height:30px;">
		<li class="active color bottom" style="width:25%">
			<a href="javascript:void(0);" data="1" iscompany="0" val="free" data-toggle="tab">推荐</a>
		</li>
		<li style="width:25%">
			<a href="#result_1" data="2" iscompany="0" val="personal" data-toggle="tab">热点</a>
		</li>
		<li style="width:25%; text-align:center" class="tianjia1" tt="0">
			<a href="#" data-toggle="tab">
				分类
				<!-- <i class="icon-angle-down" style="font-size:30px; line-height:10px"></i> -->
			</a>
		</li>
		<li style="width:25%">
			<a href="javascript:void(0);" data="3" iscompany="1" val="company" data-toggle="tab" >企业</a>
		</li>
		<div class="sharePage1 " style="display:none">
			<div id="menuId" style="height:100%; background-color:#eee; line-height:22px; color:#000000;">
				<s:iterator value="typeList" id="item">
					<div class="box"><a href="#result_3" data="<s:property value="typeName" />" val="personal" data-toggle="tab" ><s:property value="typeName" /></a></div>
				</s:iterator>
				<!-- <div class="box color active"><a href="#result_4" data="4" val="personal" data-toggle="tab" >励志</a></div> -->
			</div>
		</div>
	</ul>
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
<div class="index_di2">
	<a href="<%=path%>/hyuser/wxIndex"><div><img src="<%=path%>/images/home.png" /><br/>首页</div></a>
    <a href="<%=path%>/video/wxVideo?video.mainType=1"><div class="hong"><img src="<%=path%>/images/ku_on.png" /><br/>推广库</div></a>
    <a href="<%=path%>/hyuser/wxUserRelease"><div><img src="<%=path%>/images/set.png" /><br/>我的发布</div></a>
    <a href="<%=path%>/hyuser/wxUserHuo"><div style="position:relative"><img src="<%=path%>/images/mine.png" /><br/>活跃用户</div></a>
</div>
<div class="sharePage" style="display:none;">
	<div id="companyId" style="display:none;">
		<div>
			<button type="button" id="closeBtn" class="close" style="padding:0 20px;">&times;</button>
			<h6 style="height:20px;">&nbsp;</h6>
	     </div>
	     <h5 style="position:relative; padding:5px 20px; color:#777; line-height:25px;letter-spacing:1px;text-align:left; margin-top:10px; border-top:1px solid  #ddd;" >
			<span>如需使用企业自己上传的视频发布广告，请升级到企业版会员后获取企业标签使用特权。</span><br />
			<div style="font-size:10px; padding-top:10px;letter-spacing:0px;">注：加入企业群组后可同样获得使用权限。</div>
	     </h5>
	     <div style="padding:20px; padding-top:0px; border-top:none;float:right;">
			<button type="button" id="vipBtn" class="btn"  style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				了解详情
			</button>
	     </div>
	</div>
	<div id="personId" style="display:none; ">
		<div >
			<button type="button" id="closeBtn2" class="close" style="padding:0 20px;">&times;</button>
			<h6 style="height:20px;">&nbsp;</h6>
		</div>
		<h5 style="position:relative; padding:5px 20px; color:#777; line-height:35px;letter-spacing:1px;text-align:left; margin-top:10px; border-top:1px solid  #ddd;" >
			<span>你还不是付费会员，分类视频使用受到限制，请升级会员后获取权限。</span><br />
			<div style="font-size:10px; padding-top:10px;letter-spacing:0px;">注：加入企业群组后可同样获得使用权限。</div>
		</h5>
		<div style="padding:20px; padding-top:0px; border-top:none;float:right;">
			<button type="button" id="vipBtn2" class="btn" style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				了解详情
			</button>
		</div>
	</div>
	<div id="unBindId" style="display:none; ">
		<div >
			<button type="button" id="closeBtn3" class="close" style="padding:0 20px;">&times;</button>
			<h6 style="height:20px;">&nbsp;</h6>
		</div>
		<h5 style="position:relative; padding:5px 20px; color:#777; line-height:35px;letter-spacing:1px;text-align:left; margin-top:10px; border-top:1px solid  #ddd;" >
			<span>您还未做手机验证，视频相关功能受到限制。</span><br />
		</h5>
		<div style="padding:20px; padding-top:0px; border-top:none;float:right;">
			<button type="button" id="vipBtn3" class="btn" style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				验证
			</button>
		</div>
	</div>
</div>
<div class="wxLoginFirst" style="display:none;"><img src="<%=path%>/images/Luckydraw7.png" width="100%" style="margin-top:50px;"></div>
<div class="sharePagelayerBg" style="display:none;"></div>
</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	var $moreInfos = $("#moreInfos");
	var num = Number($("#pageNumberId").val());
	var tagId = $("#tagId").val(); 
	
	//加载更多
	$moreInfos.click(function(){
		num++;
 		getContentList(num, $("#tagId").val(), searchProperty, searchValue);
	});
	
	//搜索
	$(".index_tou_img2").click(function(){
		$("#keyword").val("");
		searchProperty = "";
		$(".sousuo").slideToggle();
		$(".sousuo").css("display","block")
	})
	
	//隐藏遮罩层
	var $sharePage = $(".sharePage");
	var $sharePagelayerBg = $(".sharePagelayerBg");
	 $sharePage.click(function(){
		$sharePage.hide();
		$sharePagelayerBg.hide();
		$(".swiper-wrapper .swiper-slide").addClass('active color bottom').siblings().removeClass('active color bottom');
	});
	
	//购买企业服务
	$("#vipBtn").click(function(){
		window.location.href="<%=path%>/hyuser/wxMemberup?memLevel=3";
	});
	
	//购买个人服务
	$("#vipBtn2").click(function(){
		window.location.href="<%=path%>/hyuser/wxMemberup?memLevel=2";
	});
	
	//验证手机号
	$("#vipBtn3").click(function(){
		window.location.href="<%=path%>/hyuser/wxBind";
	});
	
	//关闭提示弹窗
	$("#closeBtn, #closeBtn2, #closeBtn3").click(function(){
		$(".sharePage").hide();  
	 	$(".sharePagelayerBg").hide();
	});
	
	$(".wxLoginFirst").click(function(){
		$(".wxLoginFirst").hide();  
	 	$(".sharePagelayerBg").hide();
	});
});
</script>