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
	<title>微名片</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<style type="text/css">
.index_tou_baocun{ width:50px;float:right;top:5px;position:absolute;right:3%;}
.green1{ background-color:#00DD37}
.bottitle{ width:49.5%;height:50px;background-color:#e9ca93;float:left;font-size:18px;text-align:center;line-height:50px;font-weight:bold; }
</style>
<script type="text/javascript">
$(function(){
	$("#edit").click(function(){
		window.open("<%=path%>/hyuser/wxEditCard", "_self");
	});
});
</script>
</head>
<body>
<!--头部-->
<div class="index_tou">
    <p>微名片<a href="javascript:history.back(-1);"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
    <div>
    	<button type="button" id="edit" class="color_white green1 index_tou_baocun f16"  style="border:none; border-radius:3px; height:30px; line-height:30px">编辑</button>
    </div> 
</div>
<!--名片内容-->
<div style="background-color:#F7F2CC;height:200px;padding-top:50px;">
	<div style="width:100px;height:100px;padding-top:10px;padding-left:15px;float:left;">
		<img src="<s:property value="user.headimgurl" />" style="width:60px;height:60px;border-radius:60px;" /><br/><br/>
		<span>阅读<s:property value="user.mpClick" /></span><br/>
		<span>分享<s:property value="user.mpShare" /></span>
	</div>
	<div style="width:200px;height:100px;float:left;padding-left:20px;">
		<div><s:property value="user.niName" /></div>
		<div><img src="<%=path%>/images/card_photo.png" style="width:20px;height:auto;" />&nbsp;<s:property value="user.mpJob" /></div>
		<div><img src="<%=path%>/images/card_phone.png" style="width:20px;height:auto;" />&nbsp;<s:property value="user.mpPhone" /></div>
		<div><img src="<%=path%>/images/card_wx.png" style="width:20px;height:auto;" />&nbsp;<s:property value="user.mpWxcode" /></div>
		<div><img src="<%=path%>/images/card_email.png" style="width:20px;height:auto;" />&nbsp;<s:property value="user.mpEmail" /></div>
		<div><img src="<%=path%>/images/card_home.png" style="width:20px;height:auto;" />&nbsp;<s:property value="user.mpCompany" /></div>
	</div>
</div>
<div style="width:100%;height:50px;">
	<div class="bottitle" style="border-bottom:4px solid #ea3f37">
		供求信息
	</div>
	<div style="width:1%;height:50px;background-color:white;float:left;">
	</div>
	<div class="bottitle">
		视频信息
	</div>
</div>
<div id="adv1">
	<div style="padding:10px;width:100%;height:auto;overflow:auto;">
		<div style="width:50px;height:30px;border:1px solid #c9c9c9;border-radius:5px;text-align:center;line-height:30px;float:left;">提供</div>
		<div style="float:left;width:70%;padding-left:10px;height:auto;">
			<s:property value="user.mpTigong" />
		</div>
	</div>
	<div style="padding:10px;width:100%;height:auto;overflow:auto;">
		<div style="width:50px;height:30px;border:1px solid #c9c9c9;border-radius:5px;text-align:center;line-height:30px;float:left;">需求</div>
		<div style="float:left;width:70%;padding-left:10px;">
			<s:property value="user.mpNeed" />
		</div>
	</div>
</div>
</body>
</html>