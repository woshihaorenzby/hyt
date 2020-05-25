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
	<title>会员验证</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<style type="text/css">
body{ background:#fff; }
.btn-default { color:#0066CC;background-color:#f3f3f3;border-color: #0066CC }
.btn-default:hover{ color:#0066CC;background-color:#f3f3f3;border-color: #0066CC}
.btn-default:focus{ color:#0066CC;background-color:#f3f3f3;border-color: #0066CC}
.shuoji{height:40px;border:2px solid #aaa; border-radius:6px; background-color:#FFFFFF;padding-left:20px;}
.denglu-hui:hover{ background-color:#2D96FF;}
.denglu-hui{width:40%;float:left; margin-left:2%; height:40px; border-radius:6px; background-color:#f3f3f3; border:1px solid #0066CC;text-align:center; color:#333; line-height:38px; font-size:16px}
.shuoming a{ color:#FF0000;}
</style>
<script type="text/javascript">  
var canSend = true;
function sendSMS() {
	var phone = $("#mobile").val();
	if(phone == "") {
		alert("请填写手机号码");
		return;
	}
	$("#error").text("");
	if(canSend == true) {
		$.ajax({
			type: "post",
			url: "<%=path%>/hyuser/wxSendMsg",
			dataType: "json",
			data: "user.phone=" + phone,
			success: function(data){
				if(data.code == "2") {
					$("#error").text("该手机号已经被占用");
				} else if(data.code == "1"){
					msgSuccess("短信下发成功！");
					$("#mobileBtn").css("background-color", "#f3f3f3");
					daoTime();
				}else{
					msgError("短信下发失败，请稍后重试！");
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				msgError("短信下发失败，请稍后重试！");
			}
		});
	} else {
		msgError("短信已下发，请注意查收");
	}
}
var i=60;
function daoTime() {
	if(i==0) {
		canSend = true;
		$("#mobileBtn").text("重新发送");
		i = 60;
		return;
	}
	canSend = false;
	$("#mobileBtn").text(i + "秒后重试");
	i--;
	setTimeout(function() {
		daoTime();
	}, 1000);
}
function subInf() {
	var phone = $("#mobile").val();
	var smscaptcha = $("#smscaptcha").val();
	if(phone == "") {
		alert("请填写手机号码");
		return;
	}
	if(smscaptcha == "") {
		alert("请填写验证码");
		return;
	}
	$.ajax({
		type: "post",
		url: "<%=path%>/hyuser/wxCheckPhone",
		dataType: "json",
		data: "user.phone=" + phone + "&msgcode=" + smscaptcha,
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("认证成功！", "<%=path%>/video/wxVideo?video.mainType=1");
			}else if(data.code == "2"){
				msgError("验证码数据有误！");
			}else{
				msgError("认证失败，请稍后重试！");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("认证失败，请稍后重试！");
		}
	});
}
</script>
</head>
<body>
<!--头部-->
<div class="index_tou">
    <p>用户认证<a href="javascript:history.back(-1);"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
</div>
<!--头部end-->
<div class="h60"></div>
<div class="h25"></div>
<div class="clear h20"></div>
<div style="width:90%; margin:auto; text-align:center">
	<div style="width:100%; height:40px;border:2px solid #aaa; border-radius:6px; background-color:#FFFFFF;padding-top:8px; padding-left:10px;">
		<input type="text" id="mobile" name="mobile" placeholder="手机号（为保障账户资金安全，务必真实）" maxlength="20" style="width:100%; padding-left:10px;"/>
	</div>
	<div class="h10"></div>
	<input type="text" id="smscaptcha" name="smscaptcha" placeholder="短信验证码"  maxlength="50" style="width:58%; float:left;"  class="shuoji"/><!--验证码 -->
	<button class="denglu-hui" id="mobileBtn" onclick="sendSMS()" value="获取验证码" style="">获取验证码</button>
	<div class="h15"></div>
</div>
<div style="padding-left:15px; line-height:40px;" class="w90 shuoming">
	<a href="javascript:;"><span style="border-bottom:1px solid #FF0000" id="error"></span></a>
</div>
<div class="h25"></div>
<div style="text-align:center">
	<button onclick="subInf()" type="submit" class="btn btn-default" style="height:40px; border-radius:3px; padding:0; text-align:center;" >
		<span style="font-size:16px; padding-left:15px; padding-right:15px;">提交</span> 
	</button>
</div>
<div class="h15"></div>
<div style="padding-left:15px; line-height:30px;" class="w90 shuoming">
	为了加强“选卡网”平台用户数据安全管理，规避潜在的政策风险，即日起“选卡网”所有未验证的用户需要先进行手机号码的验证，才能正常使用，给大家带来的不便，敬请谅解。 <br/><center>  选卡网   2016.4.21</center>
</div>
</body>
</html>