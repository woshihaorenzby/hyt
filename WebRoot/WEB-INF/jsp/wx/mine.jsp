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

	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
<style type="text/css">
body{ background:#F3F3F3;}
.wode_p1{ height:30px; max-height:30px; line-height:30px; margin-top:5px;font-size:16px;}
.wode_p2{ height:30px; max-height:30px; line-height:30px;}
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
	background:none}
	input[type="text"],input[type="password"],input[type="date"],input[type="month"],input[type="month"],input[type="time"],input[type="week"],input[type="email"],select{border:none; outline:none; transition:border 0.2s ease-in 0s;  }
	input[type="button"],input[type="submit"]{outline:none;cursor:pointer;border:none;}		input[type="text"]:focus,input[type="password"]:focus,input[type="date"]:focus,input[type="month"]:focus,input[type="month"]:focus,input[type="time"]:focus,input[type="week"]:focus,input[type="email"]:focus,select:focus{border:1px solid #17a862;  
}
.ziliao_ul-img{
	width:12px;
	height:12px;
	position:absolute;
	right:3%;
	top:50%;
	margin-top:-6px;
}
.ziliao_ul-i{ width:20px; height:20px; margin-right:8px; margin-left:5px;}
.hong-shu{ height:12px; width:14px; background-color:#FF0000; border-radius:7px; float:left; margin-left:3px; margin-top:17px; line-height:12px; text-align:center; font-size:10px; color:#FFFFFF;}
.xiangqing_ceng_1{
	position:absolute;
	z-index:10;
	bottom:0;
	left:0;
	color:#FFF;
	height:auto;
	width:100%;
	color:#FFF;
	background:rgba(0,0,0,0.7);
	text-align:center;
	padding:0px 0px;
	font-size:12px;
}
</style>
<script>
var memLevel = "<s:property value="user.memLevel" />";
$(function(){
//点击微名片
$("#memberHead").click(function(){
	if(memLevel != "3" && memLevel != "4") {
		$("#profileId").show();
		$("#myAccountId").hide();
		$(".sharePage").show();
	 	$(".sharePagelayerBg").show();
	} else {
		window.open("<%=path%>/hyuser/wxCard", "_self");
	}
});
})
</script>
<body>
<div class="index_tou">
	<p>个人中心<a href="javascript:history.back(-1);"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
</div>
<div class="h50"></div>
	<div class="wode_tou">
		<div class="xiangdui wode_touxiang">
			<img src="<s:property value="user.headimgurl" />" class="wode_touxiang" id="userImgId"/>
		<div class="xiangqing_ceng_1">
			ID:<s:property value="user.userCode" />
		</div>
	</div>
	<p class="wode_p1"><s:property value="user.niName" /></p>
	<!--<p class="wode_p2"></p>-->
	<div style="color:#777;line-height:38px;margin-bottom:-10px;">
		<s:if test="user.memLevel == '1'.toString()">
			<img src="<%=path%>/images/mianfei.png" style="margin-bottom:10px; width:43px; height:42px; color:#FF0000" />&nbsp;
	    </s:if>
	    <s:elseif test="user.memLevel == '2'.toString()">
	    	<img src="<%=path%>/images/geren.png" style="margin-bottom:10px; width:43px; height:42px; color:#FF0000" />&nbsp;
	    	到期时间：<a href="javascript:void(0);"><s:property value="user.memEndTime" /></a>&nbsp;&nbsp;
	    </s:elseif>
	    <s:elseif test="user.memLevel == '3'.toString()">
	    	<img src="<%=path%>/images/qiye.png" style="margin-bottom:10px; width:43px; height:42px; color:#FF0000" />&nbsp;
	    	到期时间：<a href="javascript:void(0);"><s:property value="user.memEndTime" /></a>&nbsp;&nbsp;
	    </s:elseif>
	    <s:elseif test="user.memLevel == '4'.toString()">
	    	<img src="<%=path%>/images/qiyevip.png" style="margin-bottom:10px; width:43px; height:42px; color:#FF0000" />&nbsp;
	    	到期时间：<a href="javascript:void(0);"><s:property value="user.memEndTime" /></a>&nbsp;&nbsp;
	    </s:elseif>
		<s:if test="user.ischeck == '1'.toString()">
			<a href="javascript:void(0);">已验证</a>
	    </s:if>
	    <s:else>
			<a href="<%=path%>/hyuser/wxBind">未验证</a>
	    </s:else>
		<span id="memberHead" style="position:absolute;right:7%;top:50%;margin-top:-20px;">微名片</span>
	</div>
	<img src="<%=path%>/images/next_icon.png" class="wode_jiantou" /> 
		<div class="clear"></div>
	</div>
	<div class="h1" style="backgroud:#F0F0F0"></div>
	<ul class="gerenshuju_ul">
		<li style="width:34%;line-height:20px;"><span class="f12hui">广告展现总数 <br/><s:property value="user.advShow" /></span></li>
        <li style="width:33%;line-height:20px;"><span class="f12hui">广告点击总数 <br/><s:property value="user.advClick" /></span></li>
        <li style="width:33%;line-height:20px;"><span class="f12hui">积分总数 <br/><s:property value="user.point" /></span></li>
        <!--数字与文字换行，增加广告点击总数-->
    </ul>
	<div class="h10"></div>
	<ul class="ziliao_ul">
		<a href="<%=path%>/hyuser/wxMemberup?memLevel=<s:property value="user.memLevel" />"><li><img src="<%=path%>/images/mineup.png" class="ziliao_ul-i" />会员升级<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/hyuser/wxTuiGuang?user.id=<s:property value="user.id" />"><li><img src="<%=path%>/images/minetui.png" class="ziliao_ul-i" />推广海报<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/hyuser/wxFans"><li><img src="<%=path%>/images/minefans.png" class="ziliao_ul-i" />我的粉丝<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/hyuser/wxDeposit"><li><img src="<%=path%>/images/mineshou.png" class="ziliao_ul-i" />我的收入<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/hyuser/wxShareOrder"><li><img src="<%=path%>/images/mineshare.png" class="ziliao_ul-i" />分享记录<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <s:if test="user.memLevel == '4'.toString()">
	    	<a href="<%=path%>/hyuser/wxCompanyGroup"><li><img src="<%=path%>/images/minecompany.png" class="ziliao_ul-i" />公司群组<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    </s:if>
	    <a href="<%=path%>/hyuser/wxCodeJi"><li><img src="<%=path%>/images/minecode.png" class="ziliao_ul-i" />积分机制<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/advice/wxAdvice"><li><img src="<%=path%>/images/mineyijian.png" class="ziliao_ul-i" />反馈意见<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="tel:0755-82556962"><li><img src="<%=path%>/images/mineke.png" class="ziliao_ul-i" />客服热线：0755-82556962<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/hyuser/wxConShang"><li><img src="<%=path%>/images/mineup.png" class="ziliao_ul-i" />联系上级<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	    <a href="<%=path%>/help/wxHelp"><li><img src="<%=path%>/images/help.png" class="ziliao_ul-i" />帮助中心<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
		<a href="<%=path%>/hyuser/wxOper"><li><img src="<%=path%>/images/icon_del.png" class="ziliao_ul-i" />操作说明<img src="<%=path%>/images/next_icon.png" class="ziliao_ul-img" /></li></a>
	</ul>
	<div class="h15"></div>
	<div class="h55"></div>
<!-- <div class="index_di2">
	<a href="<%=path%>/hyuser/wxIndex"><div><img src="<%=path%>/images/home.png" /><br />首页</div></a>
    <a href="<%=path%>/video/wxVideo?video.mainType=1"><div><img src="<%=path%>/images/ku.png" /><br />推广库</div></a>
    <a href="<%=path%>/adv/wxAdv"><div><img src="<%=path%>/images/set.png" /><br />设置</div></a>
    <a href="<%=path%>/hyuser/wxMine"><div class="hong" style="position:relative"><img src="<%=path%>/images/mine_on.png" /><br />我的</div></a>
</div> -->
<div class="sharePage" style="display:none;">	
	<!--视名片-->
	<div id="profileId" class="modal-content"  style="display:none;border-radius:3px; width:90%; margin:auto; margin-top:35%">
		<div class="modal-header">
			<button type="button" id="closeBtn" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h6 class="modal-title" id="myModalLabel">&nbsp;</h6>
		</div>
		<h5 class="modal-body" style="position:relative; padding:5px 20px; color:#777; line-height:25px;letter-spacing:1px;" >
			<span>视频商务名片可以独立分享，也可以作为广告素材，请升级到企业版后获取该功能。</span><br />
			<div style="font-size:10px; padding-top:10px;letter-spacing:0px;">注：加入企业群组后可同样获得使用权限。</div>
		</h5>
		<div class="modal-footer" style="padding:20px; padding-top:0px; border-top:none">
			<button type="button" id="vipBtn" class="btn"  style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				了解详情
			</button>
		</div>
	</div>
	<!--我的账户-->
	<div id="myAccountId" class="modal-content"  style="display:none;border-radius:3px; width:90%; margin:auto; margin-top:35%">
		<div class="modal-header">
			<button type="button" id="closeAccountBtn" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h6 class="modal-title" id="myModalLabel">&nbsp;</h6>
		</div>
		<h5 class="modal-body" style="position:relative; padding:5px 20px; color:#777; line-height:25px;letter-spacing:1px;" >
			<span>免费版会员不享有软件分销的二级收益特权。想获得自动赚钱账户系统，请升级会员。</span><br />
		</h5>
		<div class="modal-footer" style="padding:20px; padding-top:0px; border-top:none">
			<button type="button" id="accountBtn" class="btn"  style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				了解详情
			</button>
		</div>
	</div>
</div>
<div class="sharePagelayerBg" style="display:none;"></div>
</body>
<script type="text/javascript">
    $(".index_tou_img2").click(function(){
		$(".sousuo").slideToggle();
		$(".sousuo").css("display","block")
	})
	
	$("#userImgId").click(function(){
		/*
		wx.chooseImage({
		    count: 1, // 默认9
		    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
		    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
		    success: function (res) {
		        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
		        //alert(localIds);
		    }
		});
		*/
	});
	

	
	$("#closeBtn, #closeAccountBtn").click(function(){
		$(".sharePage").hide();  
	 	$(".sharePagelayerBg").hide();
	});
	
	//购买企业会员服务
	$("#vipBtn").click(function(){
		window.location.href="<%=path%>/hyuser/wxMemberup?memLevel=3";
	});
	
	$("#accountBtn, #vipId").click(function(){
		window.location.href="<%=path%>/hyuser/wxMemberup?memLevel=4";
	});
	
	
	$("#helpId").click(function(){
		//window.location.href="/help/list.jhtml";
	});
	
	//我的账户，只有交费用户才可以查看
	$("#accountId").click(function(){
		//window.location.href="/member/deposit/list.jhtml";
	});
</script>
</html>