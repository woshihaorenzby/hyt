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
	<title>会员升级</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style type="text/css">
body{ background-color:#fff;}
.btn-hong:hover{ background-color:#FF0909;}
.btn-hong{height:37px; width:90% ;border-radius:6px; margin-left:5%; background-color:#eb3838;}
.zhekou_box{width:80px;font-size:16px;  height:33px; color:#FFFFFF; background-color:#999;text-align:center; border:1px solid #999; border-radius:6px; margin:auto; line-height:33px;}
.zhekou_box-1{width:60px;font-size:16px; height:33px;color:#FFFFFF; background-color:#999;text-align:center; border:1px solid #999;margin:auto; border-radius:6px; line-height:33px;}
.zhekou_box-2{width:60px;font-size:16px; height:33px;color:#FFFFFF; background-color:#999;text-align:center; border:1px solid #999;margin:auto; border-radius:6px; line-height:33px;}
.border-h{ border:1px solid #FF0000; background-color:#eb3838}
ul li{ float:left; text-align:center; color:#777;}
.banben{font-size:16px; padding-top:6px; padding-left:15px; font-weight:600; text-align:center; color:#333333}
.ljgm{font-size:16px; color:#FFFFFF; font-weight:600;letter-spacing:2px;}
.shuoming a{ color:#FF0000;}

.index_tou-1{width:100%; height:40px;line-height:40px;background:#323739;left:0;right:0;top:0;z-index:999;}
.shuoji{height:40px;border:2px solid #aaa; border-radius:6px; background-color:#FFFFFF;padding-left:20px;}
.denglu-hui:hover{ background-color:#2D96FF;}
.denglu-hui{
	width:40%;float:left; margin-left:2%; height:40px; border-radius:6px; background-color:#f3f3f3; border:1px solid #0066CC;text-align:center; color:#333; line-height:38px; font-size:16px
}
.biankuang-h{width:90%; margin:auto; border-top:none; padding:0px 10px; padding-top:10px; }
</style>
<script type="text/javascript">
var memLevel = "<s:property value="memLevel" />";
var payMoney;
if(memLevel == "1" || memLevel == "2") {
	payMoney = 188;
} else if (memLevel == "3") {
	payMoney = 888;
} else if (memLevel == "4") {
	payMoney = 1888;
}
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

$(function(){
if(memLevel == "1" || memLevel == "2") {//升级个人版
	$(".zhekou_box-2").click();
	$("#gerenId").show();
	$("#qiyeId").hide();
	$("#zongdaiId").hide();
	$("#zongdaiFormId").hide();
} else if(memLevel == "3") {//升级企业版
	$(".zhekou_box-1").click();
	$("#gerenId").hide();
	$("#qiyeId").show();
	$("#zongdaiId").hide();
	$("#zongdaiFormId").hide();
} else if(memLevel == "4") {//升级企业VIP
	$(".zhekou_box").click();
	$("#gerenId").hide();
	$("#qiyeId").hide();
	$("#zongdaiId").show();
	$("#zongdaiFormId").show();
}
//点击立刻购买
$("#buyVip").click(function(){
	var ruleId = $("#ruleId").val();
	var mobile = $("#mobile").val();
	var name = $("#name").val();
	var smscaptcha = $("#smscaptcha").val();
	if(ruleId==3){
		if(name==""){
			$("#error").html("请输入企业名称！");
			$("#error").show();
			return false;
		}else{
			//效验企业名称是否重复
		}
 	 	/*if(mobile==""){
 	 		$("#error").html("请输入您的手机号码！");
 	 			$("#error").show();
	 			return false;
 	 	}
		var telReg = !!mobile.match(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
		//如果手机号码不能通过验证
		if(telReg == false){
		 	$("#error").html("您输入的手机号码格式错误！");
	 			$("#error").show();
	 			return false;
		}
 	 	
 	 	if(smscaptcha==""){
 	 		$("#error").html("请输入短信验证码！");
	 			$("#error").show();
	 			return false;
		}*/
	}
	if(!$('#agreeId').is(':checked')){
		$("#error").html("您还未同意《选卡网系统在线使用服务协议》！");
 		$("#error").show();
  		return false;
  	}
  	
	$.ajax({
		type: "post",
		url: "<%=path%>/pay/wxGetPay",
		dataType: "json",
		data: "wxPayDto.totalFee="+payMoney*100+"&wxPayDto.body=会员购买",
		success: function(data){
			wx.chooseWXPay({
			    timestamp: data.timestamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
			    nonceStr: data.nonce_str, // 支付签名随机串，不长于 32 位
			    package: data.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
			    signType: "MD5", // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
			    paySign: data.sign, // 支付签名
			    success: function (res) {
			    	var preId = data.package;
			    	preId = preId.replace("prepay_id=", "");
			        $.ajax({//支付结果提交到服务器
						type: "post",
						url: "<%=path%>/pay/wxPaySuccess",
						dataType: "json",
						data: "payorder.prepayId="+preId+"&payorder.payMoney="+payMoney+"&payorder.memLevel="+memLevel+"&companyName="+name,
						success: function(data){
							if(data.code == "1") {
								msgSuccess("支付成功");
							} else {
								msgError("支付失败");
							}
						}
			        });
			    },cancel: function () { 
			        msgError("您取消了支付");
			    }
			});
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("支付失败，请稍后重试！");
		}
	});
});
});
</script>
</head>
<body>
	<input type="hidden" name="ruleId" id="ruleId" value="1"><!--vip会员等级id-->
	<div class="index_tou-1">
		<p style="height:40px;text-align:center;color:#FFF;font-size:22px;">会员升级
			<a href="javascript:;" onclick="javascript:history.back(-1);"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a>
		</p>
	</div>
	<div style="padding-left:15px; line-height:40px;" class="w90 shuoming">
		<a href="javascript:;">
			<span style="border-bottom:1px solid #FF0000" id="error"></span>
	    </a>
    </div>
	<div class="h5"></div>
	<div  class="w100" style="color:#333;">
		<div class="h10"></div>
		<div style="width:100%;">
			<ul>
				<li style="width:26%"><p class="banben">版本选择</p></li>
				<li style="width:23%">
					<div class="zhekou_box-2" style="position:relative">
						<span>¥ </span><span>188</span>
						<!--三角形-->
						<div id="sjx-h-2" style="position:absolute; bottom:0px; right:0px; display:none">
							<img src="<%=path%>/images/sanjiaoxing-b.png" style="margin-top:5px;width:25px; height:23px" />
							<div style="position:absolute; bottom:-10px; right:2px; font-size:14px; color:#eb3838">
								<img src="<%=path%>/images/gou-h.png" style="width:13px" />
							</div>
						</div>
						<!--三角形结束-->
					</div><!--zhekou-box-2 -->
					<p style="width:100%; text-align:center;line-height:30px">个人版/年</p>
				</li>
				<li style="width:23%">
					<div class="zhekou_box-1" style="position:relative">
						<span>¥ </span><span>888</span>
						<!--三角形-->
						<div id="sjx-h-1" style="position:absolute; bottom:0px; right:0px; display:none">
							<img src="<%=path%>/images/sanjiaoxing-b.png" style="margin-top:5px;width:25px; height:23px" />
							<div style="position:absolute; bottom:-10px; right:2px; font-size:14px; color:#eb3838">
								<img src="<%=path%>/images/gou-h.png" style="width:13px" />
							</div>
						</div>
						<!--三角形结束-->
					</div><!--zhekou-box-1 -->
					<p style="width:100%; text-align:center;line-height:30px">企业版/年</p>
				</li>
				<li style="width:23%">
					<div class="zhekou_box" style="position:relative">
						<span>¥ </span><span>18800</span>
						<div id="sjx-h" style="position:absolute; bottom:0px; right:0px;display:none">
							<img src="<%=path%>/images/sanjiaoxing-b.png" style="margin-top:5px;width:25px; height:23px" />
							<div style="position:absolute; bottom:-10px; right:2px; font-size:14px; color:#eb3838">
								<img src="<%=path%>/images/gou-h.png" style="width:13px" />
							</div>
						</div>
					</div>
					<p style="width:100%; text-align:center; line-height:30px">企业VIP版/年</p>
				</li>
		    </ul>
	    </div>
		<div class="clear h20"></div>
		<!--<div style="width:90%; margin:auto;">促销提示：2.6-2.28日春节期间，升级选卡网的任意版本，只需一年费用，即可额外再获两年的免费使用权。</div>-->

		<div style="width:90%; margin:auto;height:3px; background-color:#FF0909"></div>
		
		<div class="biankuang-h" id="gerenId" style="display:none;">
			<div style="height:30px; font-size:16px;">购买个人版的四大理由：</div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">1、免费推荐区视频每天只更新5条，可供选择少；成为个人会员，可供分享的视频多。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">2、再也不用自己到处找视频更新文章，省心省力。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">3、消费变投资，享受二级分销（一级提成30%、二级提成20%）收益，最后不仅收回188，还赚了不止8888。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">4、只有成为个人版会员或者企业版会员才能获取提成的资格。</div></div>
			<p>&nbsp;</p>
	    </div><!--新加介绍个人 -->
		
		<div  class="biankuang-h" id="qiyeId" style="display:none;">
			<div style="height:30px; font-size:16px;">购买企业版的四大理由：</div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">1、个人版只能分享平台推送的视频，企业版可以在后台自由更新任意视频，相当于自己拥有一个企业电视台。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">2、人人拥有商务名片，所有员工变成传播手，实现全员营销。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">3、对传播内容，员工传播效果实现统一管理。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">4、享受二级分销（一级提成30%、二级提成20%）收益，把所有员工变成老板自己的子级用户，员工发展的用户，老板还有提成。</div></div>
			<p>&nbsp;</p>
	    </div><!--新加介绍企业 -->
	
		<div  class="biankuang-h" id="zongdaiId" style="display:none;">
			<div style="height:30px; font-size:16px;">升级总代版的四大理由：</div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">1、享受个人版与企业版所有功能。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">2、除享受二级（一级提成30%、二级提成20%）收益外还额外享受所有关系链总额的15%总提成。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">3、成功介绍一个总代18800，提成高达50%。</div></div>
			<div><i class="icon-star f18" style="color:#ff6600; width:8%; float:left"></i><div style="width:92%; float:left">4、创业投资好项目，低风险高收益。</div></div>
			<p>&nbsp;</p>
	    </div><!--新加介绍总代 -->
	    
		<div class="clear h20"></div>
		<div  id="zongdaiFormId" style="width:90%; margin:auto; text-align:center;display:none;">
			<div style="width:100%; height:40px;border:2px solid #aaa; border-radius:6px; background-color:#FFFFFF;padding-top:8px; padding-left:10px;">
				<input type="text" id="name" name="name"  placeholder="企业名称" maxlength="50" style="width:100%; padding-left:10px;"/>
			</div>
			<div class="h10"></div>
			<!-- <div style="width:100%; height:40px;border:2px solid #aaa; border-radius:6px; background-color:#FFFFFF;padding-top:8px; padding-left:10px;">
				<input type="text" id="mobile" name="mobile" placeholder="手机号（为保障账户资金安全，务必真实）" maxlength="20" style="width:100%; padding-left:10px;"/>
			</div>
			<div class="h10"></div>
			<input type="text" id="smscaptcha" name="smscaptcha" placeholder="短信验证码"  maxlength="50" style="width:58%; float:left;"  class="shuoji"/>
			<input type="button" class="denglu-hui" id="mobileBtn" onclick="sendSMS()" value="获取验证码" style="">
			<span class="clear"></span> -->
		</div>
		
		<div style="width:90%; margin:auto; text-align:center;">
			<div class="h15"></div>
			<span><input id="agreeId" type="checkbox" checked="checked"/></span>
			<a target="_blank" href="<%=path%>/hyuser/wxUserXie"><span style="padding-left:10px;color:#777;">我已经阅读并完全同意<span style="color:#eb3838">《选卡网系统在线使用服务协议》</span></span></a>
		</div>
		<div class="h20"></div>
		<button type="button" id="buyVip" class="btn btn-hong">
			 <span class="ljgm">立即购买</span> 
		</button>
	    <div class="h20"></div>	
    </div>
	<!-- <div><img src="<%=path%>/images/gmbg.jpg" style="width:100%" /></div> -->
</body>
<script type="text/javascript">
//总代
$('.zhekou_box').click(function(){
	$(this).find('#sjx-h').fadeIn("fast");
	$(this).addClass('border-h');
	$('#sjx-h-1').fadeOut();
	$('#sjx-h-2').fadeOut();
	$(".zhekou_box-1").removeClass('border-h');
	$(".zhekou_box-2").removeClass('border-h');
	
	$(".ljgm").html("立即申请");
	$("#error").hide();
	$("#ruleId").val(3);
	$("#qiyeId").hide();
	$("#gerenId").hide();
	$("#zongdaiId").show();
	$("#zongdaiFormId").show();
	
	memLevel = "4";
	payMoney = 1888;
});
//企业
$('.zhekou_box-1').click(function(){
	$(this).find('#sjx-h-1').fadeIn("fast");
	$(this).addClass('border-h');
	$('#sjx-h').fadeOut();
	$('#sjx-h-2').fadeOut();
	$(".zhekou_box").removeClass('border-h');
	$(".zhekou_box-2").removeClass('border-h');
	
	$(".ljgm").html("立即购买");
	$("#error").hide();
	$("#ruleId").val(2);
	$("#qiyeId").show();
	$("#gerenId").hide();
	$("#zongdaiId").hide();
	$("#zongdaiFormId").hide();
	
	memLevel = "3";
	payMoney = 888;
});	
//个人
$('.zhekou_box-2').click(function(){
	$(this).find('#sjx-h-2').fadeIn("fast");
	$(this).addClass('border-h');
	$('#sjx-h').fadeOut();
	$('#sjx-h-1').fadeOut();
	$(".zhekou_box").removeClass('border-h');
	$(".zhekou_box-1").removeClass('border-h');
	
	$(".ljgm").html("立即购买");
	$("#error").hide();
	$("#ruleId").val(1);
	$("#zongdaiId").hide();
	$("#zongdaiFormId").hide();
	$("#qiyeId").hide();
	$("#gerenId").show();
	
	memLevel = "2";
	payMoney = 188;
});
</script>
</html>