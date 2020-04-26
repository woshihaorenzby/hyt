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
	<title>选号网-微信推广神器</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<script>
var urlType = "<s:property value="adv.urlType" />";
var id = "<s:property value="adv.id" />";
var advType = "<s:property value="advType" />";
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
/*wx.error(function (res) {
    alert('wx.error: '+res);
});*/
$(document).ready(function(){
	if(advType=="1") {
		$("#cartDivId").remove();
	} else if(advType=="2") {
		$("#advTitle").text("电话广告");
		$("#advTypeTip").text("输入电话号码");
		$("#advtip").attr("placeholder", "请输入电话号码");
		$("#advDesTit").text("标题");
		$("#cartDivId").remove();
	} else if(advType=="3") {
		$("#advTitle").text("二维码广告");
		$("#advTypeTip").remove();
		$("#advtip").remove();
		$("#cartDivId").remove();
	} else if(advType=="4") {
		$("#advTitle").text("图文广告");
		$("#cartDivId").remove();
	} else if(advType=="5") {
		$("#advDesTit").remove();
		$("#advDesInp").remove();

		$("#advTitle").text("名片广告");
		$("#advTypeTip").remove();
		$("#advtip").remove();
	}
	if(urlType.length > 0) {
		$("#urlType").val(urlType);
	}
	$("#adImgDivId, #addImgId").click(function(){
		wx.chooseImage({
		    count: 1, // 默认9
		    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
		    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
		    success: function (res) {
		        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
				$("#adImgId").attr("src", localIds);
				$("#adImgId").show();
				Allsc();
				
				wx.uploadImage({
				    localId: localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
				    isShowProgressTips: 1, // 默认为1，显示进度提示
				    success: function (res) {
				        var serverId = res.serverId; // 返回图片的服务器端ID
				        $("#imgId").val(serverId);
				    }
				});
		    }
		});
	});
	$("#editImg").click(function(){
		if(id == "") {//说明是新增
			$("#advDisplay").val("0");//设置图片隐藏
		}
		if(advType=="2") {
			var advDesInp = $("#advDesInp").text();
			if(advDesInp.length>13) {
				alert("标题不能超过13个字");
				return;
			}
		}

		$("#inputForm").ajaxSubmit({
			type: "post",
			url: "<%=path%>/adv/wxSave",
			dataType: "json",
			success: function(data){
				if(data.code == "1"){
					window.open("<%=path%>/adv/wxCutImg?adv.id="+data.message+"&advType="+advType, "_self");
				}else{
					msgError("剪切失败，请稍后重试！");
				}
			}
		});
	});
	$("#updateMember").click(function(){
		$("#advDisplay").val("1");
		
		$("#inputForm").ajaxSubmit({
			type: "post",
			url: "<%=path%>/adv/wxSave",
			dataType: "json",
			success: function(data){
				if(data.code == "1"){
					msgSuccessUrl("保存成功！", "<%=path%>/adv/wxAdv");
				}else{
					msgError("保存失败，请稍后重试！");
				}
			}
		});
	});
});
</script>
<body id="homeContent">
<form id="inputForm" action="" method="post">
	<input type="hidden" name="adv.id" value="<s:property value="adv.id" />" />
	<input type="hidden" name="adv.imagePath" id="imgId" value="<s:property value="adv.imagePath" />" />
	<input type="hidden" name="adv.display" id="advDisplay" value="<s:property value="adv.display" />" />
	<input type="hidden" name="adv.advType" value="<s:property value="advType" />" />
	<div class="index_tou">
		<p><font id="advTitle">广告设置</font><a href="<%=path%>/adv/wxAdv"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
	</div>
	<div class="h45"></div>
	<div class="w94">
	    <p class="f18 m-bottom5">插入图片<span class="f14"></span>:<span class="f12 f-right m-top9">↓点击图片重新选择可替换↓</span></p>
	    <!--
	    <p class="f18 m-bottom5">插入图片<span class="f14">(515x100)</span>:<span class="f12 f-right m-top9">↓点击图片重新选择可替换↓</span></p>
	    <div id="adImgDivId" class="guanggao fb f50">
	        	<font style="color:#ccc;text-align:center;font-size:16px;">插入广告图片，建议尺寸：515x100</font>
					<img id="adImgId" style="display:none;"/>
	    </div>-->
		<div id="adImgDivId" style="min-height:100px;margin-bottom:20px;">
			<div>
				<s:if test="adv.imagePath != ''">
					<img id="adImgId" src="<%=path%><s:property value="adv.imagePath" />" />
			    </s:if>
			    <s:else>
					<img id="adImgId" style="display:none;" />
			    </s:else>
			</div> 
	        <div class="photo_w100-1 fb f16 hui">插入广告图片</div>
		</div>
		<button id="editImg" type="button" class="btn btn-default btn-block btn-lg m-top10 f16">图片编辑</button>
		<button id="addImgId" type="button" class="btn btn-default btn-block btn-lg m-top10 f16">
			<s:if test="adv.imagePath != ''">
				删除广告图片
			</s:if>
			<s:else>
				添加广告图片
			</s:else>
		</button>
	    <div class="h10"></div>
	    <p id="advTypeTip" class="h35 f16 m-left5">外链地址:
		    <select id="urlType" name="adv.urlType" style="width:25%;height:25px;margin-left:5px;">
		    	<option value="1" >http://</option>
		    	<option value="2" >https://</option>
		    </select>
	    </p>
	    <textarea id="advtip" name="adv.url" warp="virtual" class="wanshanziliao2" placeholder="请填写广告外链地址" maxlength="150"><s:property value="adv.url" /></textarea>
	    <div class="h10"></div>
	    <p id="advDesTit" class="h35 f16 m-left5" >广告描述:</p>
		<textarea id="advDesInp" name="adv.des" warp="virtual" class="wanshanziliao2" placeholder="请填写广告语" maxlength="38"><s:property value="adv.des" /></textarea>
		<div id="cartDivId">
			<p class="h35 f16 m-left5" >姓名:</p>
			<input type="text" name="adv.usName" style="height:40px;" class="wanshanziliao2" placeholder="请填写姓名" value="<s:property value="adv.usName" />"/>
			<p class="h35 f16 m-left5" >电话:</p>
			<input type="text" name="adv.usPhone" style="height:40px;" class="wanshanziliao2" placeholder="请填写电话" value="<s:property value="adv.usPhone" />"/>
			<p class="h35 f16 m-left5" >地址:</p>
			<input type="text" name="adv.usAddress" style="height:40px;" class="wanshanziliao2" placeholder="请填写地址" value="<s:property value="adv.usAddress" />"/>
		</div>
		<div class="h10"></div>
	    <button type="button" id="updateMember" class="btn btn-default btn-block btn-lg m-top10 f16">提交</button>
	</div>
	<div class="h10"></div>
	<!--新增广告协议-->
	<p class="text-center h35 lanse">
	    <input type="checkbox" id="tipId" checked="checked" />
	    <a target="_blank" href="<%=path%>/hyuser/wxUserXie"><span class="m-left5 m-top-5" >同意选号网用户协议</span></a>
	</p>
</form>
</body>
<script type="text/javascript">
	function Allsc(){
	   	$("#homeContent").css("height", document.body.clientHeight);
	   	 var PageWidth = $("#homeContent").width(); //获取页面宽度 
	   	 var w = 0.94*PageWidth;
	   	 //var h = w/5.15;
	   	 $("#adImgId").css("width", w+"px");
		 //$("#adImgId").css("height", h+"px");
	 }
	 window.onload=function(){Allsc();};
	 window.onresize = function(){
		//捕捉屏幕窗口变化，
		Allsc();
	 }	
	 
	 $("#deleteImg").click(function(){
	 	$.ajax({
				url: "/member/memberAd/delAdImg/.jhtml",
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$("#deleteImg").prop("disabled", true);
				},
				success: function(data) {
					//alert(data.message.type);
					if (data.message.type == "success") {
						//alert(1);
						//$.message(data.message);
						$("#adImgId").attr("src", "");
						$("#adImageId").val("");
						$("#imgId").val("");
					}else{
						//alert(0);
					}
				},
				complete: function() {
					$("#deleteImg").prop("disabled", false);
					$("#adImgId").attr("src", "");
					setTimeout(function() {location.reload(true);}, 200);
				}
		});
	 });
</script>
</html>