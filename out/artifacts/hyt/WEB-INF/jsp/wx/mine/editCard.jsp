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
	<title>完善微名片资料</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<style type="text/css">
body{ background-color:#f3f3f3;padding-left:10px;padding-right:10px;padding-bottom:20px;}
.index_tou_baocun{ width:50px;float:right;top:5px;position:absolute;right:3%;}
.green1{ background-color:#00DD37}
.tit{font-size:14px;line-height:30px;}
.inp{ width:100%;height:35px;padding-left:5px;border:1px solid #e1e1e1;border-radius:5px;font-size:12px;}
</style>
<script type="text/javascript">
$(function(){
	$("#saveBtn").click(function(){
		$("#mpform").ajaxSubmit({
			type: "post",
			url: "<%=path%>/hyuser/save",
			dataType: "json",
			success: function(data){
				if(data.code == "1"){
					msgSuccessUrl("保存成功！", "<%=path%>/hyuser/wxCard");
				}else{
					msgError("保存失败，请稍后重试！");
				}
			}
		});
	});
});
</script>
</head>
<body>
<!--头部-->
<div class="index_tou">
    <p>完善微名片资料<a href="javascript:history.back(-1);"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
    <div>
    	<button type="button" id="saveBtn" class="color_white green1 index_tou_baocun f16"  style="border:none; border-radius:3px; height:30px; line-height:30px">保存</button>
    </div> 
</div>
<!--头部end-->
<div class="h50"></div>
<form id="mpform">
	<p class="tit">用户昵称</p>
	<input class="inp" name="user.mpNiName" type="text" value="<s:property value="user.mpNiName" />"/>
	<p class="tit">我的职位</p>
	<input class="inp" name="user.mpJob" type="text" value="<s:property value="user.mpJob" />"/>
	<p class="tit">公司名称</p>
	<input class="inp" name="user.mpCompany" type="text" value="<s:property value="user.mpCompany" />"/>
	<p class="tit">电话号码</p>
	<input class="inp" name="user.mpPhone" type="text" value="<s:property value="user.mpPhone" />"/>
	<p class="tit">微信号</p>
	<input class="inp" name="user.mpWxcode" type="text" value="<s:property value="user.mpWxcode" />"/>
	<p class="tit">电子邮箱</p>
	<input class="inp" name="user.mpEmail" type="text" value="<s:property value="user.mpEmail" />"/>
	<p class="tit">提供</p>
	<textarea class="inp" style="height:70px;" name="user.mpTigong"><s:property value="user.mpTigong" /></textarea>
	<p class="tit">需求</p>
	<textarea class="inp" style="height:70px;" name="user.mpNeed"><s:property value="user.mpNeed" /></textarea>
</form>
</body>
</html>