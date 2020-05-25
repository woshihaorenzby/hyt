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
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<title>选卡网-微信推广神器</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css?v=4" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
</head>
<style type="text/css">
body{
	background:#fdfdfd;
}
.index_tou_baocun{
	width:50px;
	float:right;
	top:5px;
	position:absolute;
	right:3%;
}
.green1{ background-color:#00DD37}
.green1:hover{ background-color:#00EA3A}
	
.wh12{
	width:12px!important;
    height:12px!important;
	margin:4px 2px 0 0!important;
}
.shu{ position:absolute; top:5px; right:2%; width:16px; height:16px; font-size:10px;}
.guanggou ul li img{
	float:left;
	display:block;
	width:125px;
	height:58px;
	margin-right:0px;
	border-radius:0px;
}
.dianji img{ margin-left:7px}
.dianji{ margin-top:14px}
.shiyongguangg{height:25px; line-height:10px;border-radius:0px; padding:0 5px}
.yulan{height:25px; line-height:10px;border-radius:0px; padding:0 10px; position:absolute; right:0px; color:#114ee8;}
	 
.yingcang{overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
.weizhi-3{position:absolute; top:32px; padding-left:75px;height:15px; font-size:12px}
.weizhi-4{position:absolute; top:48px;padding-left:75px;height:14px; font-size:12px;}
.dianji img{ margin-left:7px}
.dianji{ margin-top:16px}
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
.sharePage{
	width:90%;
	height:auto;
	position:absolute;
	z-index:999;
	top:72px; margin-left:5%;
	background:#fff; text-align:center;
}
.advdiv {
	width: 25%;float:left;
}
.advdiv img{
	width:40px;height:40px;
}
.advdiv div{
	font-size: 12px;
	text-align: center;
}
</style>
<script>
var memLevel = "<s:property value="user.memLevel" />";
var joinCompany = "<s:property value="user.joinCompany" />";
if(joinCompany == "1") memLevel = "4";//如果是加入了企业群组，则和企业VIP是一样的权限
var advLen = "<s:property value="advList.size" />";
$(function() {
	$("#tianjia").click(function(){
		if(memLevel == "1" && advLen == "5") {
			$("#personId").show();
			$(".sharePage").show();
		 	$(".sharePagelayerBg").show();
			return;
		} else if((memLevel == "2" || memLevel == "3") && advLen == "10") {
			$("#companyId").show();
			$(".sharePage").show();
		 	$(".sharePagelayerBg").show();
			return;
		}
		showAdvDialog();
		//location.href="<%=path%>/adv/wxAdvEdit";
	});
	
	$("#listUl").on("click", ".yulan", function(){
		var $this = $(this);
		var url = $this.data('url');
		var urlType = $this.data('urltype');
		if(urlType == 1){
			location.href="http://"+url+"";
		}else if(urlType == 2){
			location.href="https://"+url+"";
		}
	});
	
	//关闭提示弹窗
	$("#closeBtn, #closeBtn2, #closeBtn3").click(function(){
		$(".sharePage").hide();  
	 	$(".sharePagelayerBg").hide();
	});
	$("#closeBtnMod").click(function(){
		$("#advModel").hide();
		$(".sharePage").hide();
		$(".sharePagelayerBg").hide();
	});

});
//删除广告
function delAd(id, useTag){
	if (confirm("确定要删除此广告吗？")) {
		$.ajax({
			type: "post",
			url: "<%=path%>/adv/wxDelete",
			dataType: "json",
			data: "adv.id=" + id + "&adv.useTag=" + useTag,
			success: function(data){
				if(data.code == "1"){
					msgSuccessUrl("删除成功！", "<%=path%>/adv/wxAdv");
				}else{
					msgError("删除失败，请稍后重试！");
				}
			},error: function(XMLHttpRequest, textStatus, errorThrown) {
				msgError("删除失败，请稍后重试！");
			}
		});
	}
}
//设置名片为广告
function setUserAd() {
	$.ajax({
		type: "post",
		url: "<%=path%>/adv/wxSetAdvMp",
		dataType: "json",
		data: "",
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("设置成功！", "<%=path%>/adv/wxAdv");
			}else{
				msgError("设置失败，请稍后重试！");
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("设置失败，请稍后重试！");
		}
	});
}
//设置使用广告
function setAd(id){
 	$.ajax({
		type: "post",
		url: "<%=path%>/adv/wxSetAdvUse",
		dataType: "json",
		data: "adv.id=" + id,
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("设置成功！", "<%=path%>/adv/wxAdv");
			}else{
				msgError("设置失败，请稍后重试！");
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("设置失败，请稍后重试！");
		}
	});
}
function yulan(id, advType) {
	window.open("<%=path%>/adv/wxAdvEdit?adv.id=" + id + "&advType=" + advType, "_self");
}
function showAdvDialog() {
	$("#advModel").show();
	$(".sharePage").show();
	$(".sharePagelayerBg").show();
}
function gotoUrl(url) {
	location.href = url;
}
</script>
<body>
<div class="index_tou">
	<p>广告设置<a href="javascript:history.back(-1);"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
</div>
<div class="h50"></div>
<div class="index_nr guanggou" style="border-bottom:none;">
	<ul id="listUl">
		<s:if test="user.memLevel=='3'.toString() or user.memLevel=='4'.toString() or user.joinCompany=='1'.toString()">
			<li>
				<div>
					<a href="<%=path%>/hyuser/wxCard"><img src="<s:property value="user.headimgurl" />" style="width:65px;height:65px"/></a>
					<span style="font-size:12px; padding-left:7px">微名片</span>
					<span style="font-size:12px; padding-left:50px">名片点击次数：<s:property value="user.mpClick" /></span>
					<div class="pull-right" >
						<button type="button" class="btn btn-default yulan" onclick="javascript:window.open('<%=path%>/hyuser/wxCard', '_self');" style="height:26px;border-radius:3px;background-color:#aaa;color:#fff; right:0px;">预览</button>
					</div>
				</div>
				<div>
					<div style="width:150px;float:left;">
						<span style="font-size:12px;padding-left:7px;"><s:property value="user.mpNiName" />&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="user.mpJob" /></span><br/>
						<span style="font-size:12px;padding-left:7px;"><s:property value="user.mpCompany" /></span>
					</div>
					<div class="dianji" tt="0" data="14664" style="float:right;margin-right:-10px;"> 
						<div style="margin-left:5px; width:15px; height:25px; border-radius:3px 0px 0px 3px; background-color:<s:if test="user.mpUse == '1'.toString()">#eb3838;</s:if><s:else>#aaaaaa;</s:else>float:left"></div>
						<button type="button" onclick="setUserAd()" class="btn btn-default shiyongguangg" style="<s:if test="user.mpUse == '1'.toString()">border:1px solid #eb3838; color:#eb3838;float:left</s:if><s:else>border:1px solid #aaa; color:#aaa;float:left</s:else>">使用广告</button>
					</div>
				</div>
			</li>
		</s:if>
		<s:iterator value="advList" id="item">
			<li>
				<div>
					<a href="javascript:void(0);" onclick="yulan('<s:property value="id" />', '<s:property value="advType" />')"><img src="<%=path%><s:property value="imagePath" />" /></a>
					<span style="font-size:12px; padding-left:7px">广告点击数：<s:property value="clickNum" />&nbsp;</span>
					<div class="pull-right" >
						<button type="button" class="btn btn-default yulan" onclick="delAd(<s:property value="id" />, <s:property value="useTag" />)" style="height:26px;border-radius:3px;background-color:#aaa;color:#fff; right:0px;">删除</button>
					</div>
				</div>
				<div class="dianji" tt="0" data="14664" style="float:left"> 
					<div style="margin-left:5px; width:15px; height:25px; border-radius:3px 0px 0px 3px; background-color:<s:if test="useTag == '1'.toString()">#eb3838;</s:if><s:else>#aaaaaa;</s:else>float:left"></div>
					<button type="button" onclick="setAd(<s:property value="id" />)" class="btn btn-default shiyongguangg" style="<s:if test="useTag == '1'.toString()">border:1px solid #eb3838; color:#eb3838;float:left</s:if><s:else>border:1px solid #aaa; color:#aaa;float:left</s:else>">使用广告</button>
				</div>	
				<div class="pull-right" style="margin-top:16px">
					<button type="button" class="btn btn-default yulan" onclick="yulan('<s:property value="id" />', '<s:property value="advType" />')" style="height:26px;border-radius:3px;background-color:#aaa;color:#fff; right:0px;">预览</button>
				</div>
			</li>
		</s:iterator>
		<!-- <li>
			<div>
				<a href="/member/memberAd/edit/14664.jhtml"><img src="/upload/AdImg/201605/OAfdMtmjHq579q4ql8PQ_c1FVckKGd6lb5s8P80Prw2TF6sKEySBH2Tw1CikVEoE.jpeg" /></a>
				<span style="font-size:12px; padding-left:7px">广告点击数：1&nbsp;</span>
				<div class="pull-right" >
					<button type="button" class="btn btn-default yulan" onclick="delAd(14664)" style="height:26px;border-radius:3px;background-color:#aaa;color:#fff; right:0px;">删除</button>
				</div>
			</div>
			<div class="dianji" tt="0" data="14664" style="float:left"> 
				<div style="margin-left:5px; width:15px; height:25px; border-radius:3px 0px 0px 3px; background-color:#eb3838; float:left"></div>
				<button type="button" id="ad_14664" class="btn btn-default shiyongguangg" style="border:1px solid #eb3838; color:#eb3838;float:left">使用广告</button>
			</div>	
			<div class="pull-right" style="margin-top:16px">
				<button type="button" class="btn btn-default yulan" data-url="www.baidu.com" data-urltype="1" style="height:26px;border-radius:3px;background-color:#aaa;color:#fff; right:0px;">预览</button>
			</div>
		</li> -->
	</ul>
</div>
<div class="w94">
	<button type="button" id="tianjia" class="btn btn-default btn-block btn-lg m-top10 f16" style="padding-bottom:10px">
      	<img src="<%=path%>/images/jiahao-hei.png" style="width:22px; height:20px" />添加新广告
    </button>
</div>
<div class="h60"></div>
<!-- <div class="index_di2">
	<a href="<%=path%>/hyuser/wxIndex"><div ><img src="<%=path%>/images/home.png" /><br />首页</div></a>
    <a href="<%=path%>/video/wxVideo?video.mainType=1"><div><img src="<%=path%>/images/ku.png" /><br />推广库</div></a>
    <a href="<%=path%>/adv/wxAdv"><div class="hong"><img src="<%=path%>/images/set_on.png" /><br />设置</div></a>
    <a href="<%=path%>/hyuser/wxMine"><div style="position:relative"><img src="<%=path%>/images/mine.png" /><br />我的</div></a>
</div> -->
<div class="sharePage" style="display:none;">
	<div id="personId" style="display:none;">
		<div >
			<button type="button" id="closeBtn" class="close" style="padding:0 20px;">&times;</button>
			<h6 style="height:20px;">&nbsp;</h6>
		</div>
		<h5 style="position:relative; padding:5px 20px; color:#777; line-height:35px;letter-spacing:1px;text-align:left; margin-top:10px; border-top:1px solid  #ddd;" >
			<span>你还不是付费会员，广告最多设置5条，请升级会员后获取权限。</span><br />
			<div style="font-size:10px; padding-top:10px;letter-spacing:0px;">注：加入企业群组后可同样获得使用权限。</div>
		</h5>
		<div style="padding:20px; padding-top:0px; border-top:none;float:right;">
			<button type="button" id="vipBtn" class="btn" style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				了解详情
			</button>
		</div>
	</div>
	<div id="companyId" style="display:none;">
		<div>
			<button type="button" id="closeBtn" class="close" style="padding:0 20px;">&times;</button>
			<h6 style="height:20px;">&nbsp;</h6>
		</div>
		<h5 style="position:relative; padding:5px 20px; color:#777; line-height:35px;letter-spacing:1px;text-align:left; margin-top:10px; border-top:1px solid  #ddd;" >
			<span>你还不是企业VIP，广告最多设置10条，请升级会员后获取权限。</span><br />
			<div style="font-size:10px; padding-top:10px;letter-spacing:0px;">注：加入企业群组后可同样获得使用权限。</div>
		</h5>
		<div style="padding:20px; padding-top:0px; border-top:none;float:right;">
			<button type="button" id="vipBtn1" class="btn" style="background-color:#eb3838; border:none; height:32px; padding:0px 15px; color:#FFFFFF; font-size:14px;letter-spacing:2px;">
				了解详情
			</button>
		</div>
	</div>
	<div id="advModel" style="display:none;">
		<div>
			<button type="button" id="closeBtnMod" class="close" style="padding:0 20px;">&times;</button>
			<h6 style="height:20px;">&nbsp;</h6>
		</div>
		<div>
			<div class="advdiv" onclick="gotoUrl('<%=path%>/adv/wxAdvEdit?advType=1')">
				<img src="<%=path%>/images/icon_tong.png" />
				<div>通用广告</div>
			</div>
			<div class="advdiv" onclick="gotoUrl('<%=path%>/adv/wxAdvEdit?advType=2')">
				<img src="<%=path%>/images/icon_phone.png" />
				<div>电话广告</div>
			</div>
			<div class="advdiv" onclick="gotoUrl('<%=path%>/adv/wxAdvEdit?advType=3')">
				<img src="<%=path%>/images/icon_code.png" />
				<div>二维码广告</div>
			</div>
			<div class="advdiv" onclick="gotoUrl('<%=path%>/adv/wxAdvEdit?advType=5')">
				<img src="<%=path%>/images/icon_card.png" />
				<div>名片广告</div>
			</div>
		</div>
		<div>
			<div class="advdiv" onclick="gotoUrl('<%=path%>/adv/wxAdvEdit?advType=4')">
				<img src="<%=path%>/images/icon_tuwen.png" />
				<div>图文广告</div>
			</div>
		</div>
		<div style="height:20px;width:100%;float:left;"></div>
	</div>
</div>
<div class="sharePagelayerBg" style="display:none;"></div>
</body>
<script type="text/javascript">
$(".index_nr ul li").find('.dianji').click(function(e){
	var data = $(this).attr("data");

	$(this).find('div').css('background-color','#eb3838');
	$(this).find('button').css('color','#eb3838').css('border-color','#eb3838')
	
	//$(this).find('img').attr('src','/resources/shop/mobile/image/xuanze-2.png');
	$(this).attr("tt","1");
	//$(this).parents().siblings().find('.dianji img').attr('src','/resources/shop/mobile/image/weixuanze-1.png');
	$(this).parents().siblings().find('.dianji div').css('background-color','#aaa');
	$(this).parents().siblings().find('.dianji button').css('border','1px solid #aaa').css('color', '#aaa').css('float', 'left');
	$(this).parents().siblings().find('.dianji').attr("tt","0");
	
	//setAd(data);
	$("#info").val(data);
	return false;
});
</script>
</html>