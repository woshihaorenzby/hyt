<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<title>我的账户</title>
	<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/wx/swiper.3.1.7.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
<style type="text/css">
body{background:#fff;}
.index_di div{height:52px;width:33.3%;float:left;text-align:center;color:#999999;font-size:12px;padding-top:4px;}
.yingcang{overflow:hidden; text-overflow:ellipsis;white-space:nowrap;max-width:100%;display:block; }
.tou-1{width:25%;height:50px;border-right:1px solid #FFFFFF;}
.tou-2{width:25%; height:50px;}
.tou-p{ height:20px; width:60px; line-height:18px; margin:10px auto;text-align:center; font-size:12px; border-radius:3px;}
.tou-p-b{ background-color:#ff6600}
.shouru{height:50px; background:#ddd; line-height:50px; color:#333; font-size:16px; padding:0px 10px; width:100%; text-align:left; }
.shuoru-xl{width:100%; border:1px solid #f3f3f3; border-top:none;}
.h-jishu{ height:16px; width:25px; background-color:#FF0000; border-radius:8px; float:left; margin-left:10px; margin-top:17px; line-height:14px; text-align:center; font-size:12px; color:#FFFFFF;}
.tixian{height:50px; background:#ddd; line-height:50px; color:#333; font-size:16px; padding:0px 10px; width:100%; text-align:left;}
.tixian-xl{ width:100%;border:1px solid #f3f3f3; border-top:none;}
.shouqi{height:25px; line-height:10px; width:60px; border-radius:6px; background-color:#ccc; color:#333}
.tixian-anniu{width:70px; height:30px; background-color:#FFFFFF; color:#333333; line-height:30px;margin:10px auto; border-radius:3px;}
.tixian-anniu:hover{ background-color:#ff6600;}
.ye li{ float:left; font-size:14px;text-align:center;color:#fff; margin:0; height:50px; line-height:10px;overflow:hidden; text-overflow:ellipsis;white-space:nowrap ; background-color:#cc3300 ; padding:2px 2px;}
.ye{ width:100%;  height:80px; font-size:14px; background-color:#cc3300; padding-top:15px}
.ye li a{ color:#fff; background-color:#cc3300; padding:0; margin:0}
.ye li a:hover{ background-color:#cc3300}
.color a{ color:#EB3838!important;}
.bottom{  border-bottom:3px solid #EB3838!important;}
.nav > li > a:hover, .nav > li > a:focus { text-decoration: none; background-color: #cc3300}
</style>
<script type="text/javascript">
var yuMon = "<s:property value="user.yueMon" />";
yuMon = Number(yuMon);
var curYiPage = 1;
var curErpage = 1;
var curTiPage = 1;
var pageRecordCount = 4;
$(document).ready(function(){
	tizong(1);//加载一级返利数据
	yiti();//加载提现数据
	$(".ye ul li").click(function(){
		if($(this).attr("val")==0) return;
			$(this).siblings().find('p').removeClass('tou-p-b');
		$(this).find('p').addClass('tou-p-b');
	});
	//取消提现
	$("#cancelBtnId").click(function(){
		$("#error").html("");
		$("#cashBtnId").html("确认结算");
		$("#myModal").hide();
	});
	//提现
	$("#cashBtnId").click(function(){
		var cash = $("#cashId").val();
		if(cash==""){
			$("#error").html("请输入提现金额");
			$("#error").show();
			return false;
		}
		if(Number(cash)>yuMon){
			$("#error").html("用户余额不足");
			$("#error").show();
			return false;
		}
		var yuMoney = yuMon - Number(cash);
		$.ajax({
			type: "post",
			url: "<%=path%>/hyuser/wxTiXian",
			dataType: "json",
			data: "tiOrder.tiMoney=" + cash + "&tiOrder.yuMoney=" + yuMoney,
			success: function(message){
				if(message.code == "1") {
					msgSuccessReload("提现成功");
				} else if(message.code == "2") {
					$("#error").html("余额不足");
				} else {
					$("#error").html("兑换失败，请重试");
				}
			}
		});
	});
	//下拉菜单显示/隐藏
	$(".alei").click(function(){
		$(".alei-l").slideToggle(300);
	});
	//蓝色背景、加减切换
	$(".alei").click(function(e){
		if($(".alei").attr("tt") == "0"){
			$(this).css('background-color','#ddd');
		  	$(".alei").attr("tt","1");
		  	$(".alei span").show();
			$(".alei i").hide();
			return false;
		}else{
			$(this).css('background-color','#ccc');
			$(".alei").attr("tt","0");
		 	$(".alei span").hide();
		  	$(".alei i").show();
			return false;
		}
	});
	//下拉菜单显示/隐藏
	$(".blei").click(function(){
		$(".blei-l").slideToggle(300);
	});
	//蓝色背景、加减切换
	$(".blei").click(function(e){
		if($(".blei").attr("tt") == "0"){
			$(this).css('background-color','#ddd');
		  	$(".blei").attr("tt","1");
		   	$(".blei span").show();
		  	$(".blei i").hide();
		  	return false;
		}else{
			$(this).css('background-color','#ccc');
			$(".blei").attr("tt","0");
		 	$(".blei span").hide();
		  	$(".blei i").show();
			return false;
		}
	});
	//下拉菜单显示/隐藏
	$(".clei").click(function(){
		$(".clei-l").slideToggle(300);
	});
	//蓝色背景、加减切换
	$(".clei").click(function(e){
		if($(".clei").attr("tt") == "0"){
			$(this).css('background-color','#ddd');
		  	$(".clei").attr("tt","1");
	  	 	$(".clei span").show();
		  	$(".clei i").hide();
		  	return false;
		}else{
			$(this).css('background-color','#ccc');
			$(".clei").attr("tt","0");
		 	$(".clei span").hide();
		 	$(".clei i").show();
			return false;
		}
	});
	//下拉菜单显示/隐藏
	$(".dlei").click(function(){
		$(".dlei-l").slideToggle(300);
	});
	//蓝色背景、加减切换
	$(".dlei").click(function(e){
		if($(".dlei").attr("tt") == "0"){
			$(this).css('background-color','#ddd');
		  	$(".dlei").attr("tt","1");
		   	$(".dlei span").show();
		  	$(".dlei i").hide();
		  	return false;
		}else{
			$(this).css('background-color','#ccc');
			$(".dlei").attr("tt","0");
		 	$(".dlei span").hide();
		  	$(".dlei i").show();
			return false;
		}
	});
	//下拉菜单显示/隐藏
	$(".tixian").click(function(){
		$(".tixian-xl").slideToggle(300);
	});
	//蓝色背景、加减切换
	$(".tixian").click(function(e){
		if($(".tixian").attr("tt") == "0"){
			$(this).css('background-color','#ddd');
		  	$(".tixian").attr("tt","1");
		   	$(".tixian span").show();
		  	$(".tixian i").hide();
		  	return false;
		}else{
			$(this).css('background-color','#ccc');
			$(".tixian").attr("tt","0");
		 	$(".tixian span").hide();
		  	$(".tixian i").show();
			return false;
		}
	});
	$("#div_moreInfos1").click(function(){
		curYiPage++;
		tizong(1);
	});
	$("#div_moreInfos2").click(function(){
		curErPage++;
		tizong(2);
	});
	//点击提现的更多记录
	$("#div_moreInfos5").click(function(){
		curTiPage++;
		yiti();
	});
	$(".tixian-anniu").click(function(){
		$("#myModal").addClass("in");
		$("#myModal").css({
			"display": "block"
		});
	});
});
//切换到提成总额
function qiezong() {
	$("#zonge").addClass("in active");
	$("#yzhf").removeClass("in active");
}
//切换到提现记录
function qietixian() {
	$("#zonge").removeClass("in active");
	$("#yzhf").addClass("in active");
}
//加载一级返利数据
function tizong(fanType) {
	var cpage = "";
	if(fanType == "1") {
		cpage = curYiPage;
	} else {
		cpage = curErPage;
	}
	$("#div_moreInfos" + fanType).hide();
	$("#note" + fanType).show();
	$.ajax({
		type: "post",
		url: "<%=path%>/hyuser/wxDepositOrder",
		dataType: "json",
		data: "page.curPage=" + cpage + "&page.pageRecordCount=" + pageRecordCount + "&fanOrder.fanType="+fanType,
		success: function(json){
			$("#note" + fanType).hide();
			
			var htmlSource="";
			var data = json.data;
			for(var i=0; i<data.length; i++) {
				htmlSource += "<div style='height:55px; border-bottom:1px dashed #999999; padding-top:10px;'>";
				htmlSource += "<div style='height:15px; line-height:15px'>";
				htmlSource += "<div style='width:100%; float:left'><span style='padding-right:8px'>"+data[i].fanMoney+"</span></div>";
				htmlSource += "</div>";
				var createTime = data[i].createTime;
				createTime = createTime.substring(0, 19);
				htmlSource += "<div style='height:18px; line-height:18px; color:#999'>"+createTime+"</div>";
				htmlSource += "</div>";
			}
			$("#contentId" + fanType).append(htmlSource);
			if(cpage<json.pageSize){
				$("#div_moreInfos" + fanType).show();
			}else{
				$("#div_moreInfos" + fanType).hide();
			}
		}
	});
}
//查询已提现记录
function yiti() {
	$("#div_moreInfos5").hide();
	$("#tinote").show();
	$.ajax({
		type: "post",
		url: "<%=path%>/hyuser/wxTiOrder",
		dataType: "json",
		data: "page.curPage=" + curTiPage + "&page.pageRecordCount="+pageRecordCount,
		success: function(json){
			$("#tinote").hide();
			
			var htmlSource="";
			var data = json.data;
			for(var i=0; i<data.length; i++) {
				htmlSource += "<div style='height:75px; border-bottom:1px dashed #999999; padding-top:5px;'>";
				htmlSource += "<div style='height:20px; line-height:20px'>";
				htmlSource += "<span style='padding-right:8px'>结算交易号："+data[i].payOrder+"</span>";
				htmlSource += "</div>";
				htmlSource += "<div style='height:15px; line-height:15px'>";
				htmlSource += "<span style='padding-right:8px'>提现金额：<span class='hong'>￥"+data[i].tiMoney+"</span></span>";
				htmlSource += "</div>";
				htmlSource += "<div style='height:15px; line-height:15px'>";
				htmlSource += "<span style='padding-right:8px'>账户余额：<span class='hong'>￥"+data[i].yuMoney+"</span></span>";
				htmlSource += "</div>";
				var createTime = data[i].createTime;
				createTime = createTime.substring(0, 19);
				htmlSource += "<div style='height:18px; line-height:18px; color:#999'>提现时间："+createTime+"</div>";
				htmlSource += "</div>";
			}
			$("#contentId5").append(htmlSource);
			if(curTiPage<json.pageSize){
				$("#div_moreInfos5").show();
			}else{
				$("#div_moreInfos5").hide();
			}
		}
	});	
}
</script>
</head>
<body id="homeContent">
<div class="index_tou">
    <p>我的账户<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3" /></a></p>
</div>
<div class="h40"></div>
<div class="ye">
	<ul id="myTab" class="nav" style="height:50px; width:100%; padding:0; margin:0; background-color:eb3838">
		<li class="active tou-1">
			<a href="javascript:void(0)" data-toggle="tab" onclick="qiezong()">
				<span style="height:16px; line-height:16px; font-size:14px;">￥<s:property value="user.totalMon" /></span>
				<p class="tou-p tou-p-b">提成总额</p>
			</a>
		</li>
		<li class="tou-1">
			<a href="javascript:void(0)" data-toggle="tab" onclick="qietixian()">
				<span style="height:15px; line-height:15px; font-size:14px">￥<s:property value="user.tiMon" /></span>
				<p class="tou-p">已提现</p>
			</a>
		</li>
		<li class="tou-1" val="0"> 
			<a href="javascript:void(0)" data-toggle="tab">
				<span style="height:16px; line-height:16px; font-size:14px;">￥<s:property value="user.yueMon" /></span>
				<p class="tou-p"> 账户余额</p>
			</a>
		</li>
		<li class="tou-2"> 
			<div class="tixian-anniu" data-toggle="modal" data-target="#myModal">提现</div>
		</li>
	</ul>
</div>
<div class="h0"></div>
<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="zonge">
		<div style="width:100%;">
			<div class="shouru alei" tt="0">
				<div style="float:left">一级用户提成</div>
				<div class="h-jishu yingcang"><s:property value="oneFanMoney" /></div>
					<i class="icon-plus f18 pull-right" style="color:#666; line-height:50px; "></i><!--加号 -->
					<span class="icon-minus f18 pull-right" style="color:#fff; line-height:50px;display:none;"></span><!--减号 -->
				</div><!--收入按钮 -->
				<div class="clear"></div>	
				<div class="shuoru-xl alei-l" style="display:none;"><!--下拉 -->
					<div style="background-color:#FFFFFF; padding:0 10px; font-size:12px;">
						<div id="contentId1">
							<!-- <div style="height:55px; border-bottom:1px dashed #999999; padding-top:10px;">
								<div style="height:15px; line-height:15px">
									<div style="width:100%; float:left"><span style="padding-right:8px">asas</span></div>
								</div>
								<div style="height:18px; line-height:18px; color:#999">asas</div>
							</div> -->
						</div>
						<div id="div_moreInfos1" style="text-align:center;font-size:14px;line-height:30px;">点击查看更多</div>
						<div class="w94" id="note1" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
						<div class="w94" id="yinote" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
					</div>
					<div class="h5"></div>
				</div>
				<div class="h10"></div>
				<div class="shouru blei" tt="0">
					<div style="float:left">二级用户提成</div>
					<div class="h-jishu yingcang"><s:property value="twoFanMoney" /></div>
					<i class="icon-plus f18 pull-right" style="color:#666; line-height:50px; "></i><!--加号 -->
					<span class="icon-minus f18 pull-right" style="color:#fff; line-height:50px;display:none;"></span><!--减号 -->
				</div><!--收入按钮 -->
				<div class="clear"></div>	
				<div class="shuoru-xl blei-l" style="display:none;"><!--下拉 -->
					<div style="background-color:#FFFFFF; padding:0 10px; font-size:12px;">
						<div id="contentId2"></div>
						<div id="div_moreInfos2" style="text-align:center;font-size:14px;line-height:30px;">点击查看更多</div>
						<div class="w94" id="note2" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
						<div class="w94" id="yinote" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
					</div>
					<div class="h5"></div>
				</div>
			</div>
		</div>
	<div class="tab-pane fade" id="yzhf">
		<div class="tixian" tt="0">
			<div style="float:left">提现记录</div>
			<div  class="h-jishu yingcang"><s:property value="totTiMoney" /></div>
			<i class="icon-plus f18 pull-right" style="color:#666; line-height:50px; "></i><!--加号 -->
			<span class="icon-minus f18 pull-right" style="color:#fff; line-height:50px;display:none;"></span><!--减号 -->
		</div><!--结算按钮 -->
		<div class="clear"></div>
		<div  class="tixian-xl" style="display:none;"><!--下拉 -->
			<div style="background-color:#FFFFFF; padding:0px 10px; font-size:12px;">
				<div id="contentId5"></div>
				<div id="div_moreInfos5" style="text-align:center;font-size:14px;line-height:30px;">点击查看更多</div>
				<div class="w94" id="tinote" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
				<div class="h5"></div>
				<div class="h10"></div>
			</div>
		</div>
	</div>
</div>
<div class="h70"></div>
<!-- 提现模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="background-color:rgba(0,0,0,0.5)">
	<div class="modal-dialog">
		<div class="modal-content" style="border-radius:3px; width:90%; margin:auto; margin-top:30px;">
			<h5 class="modal-body" style="position:relative; padding:5px 20px; color:#777; line-height:25px;" >
			   <span style="color:#333">账户可结算金额（元）：</span><br />
			   <div style="width:100%; text-align:center; height:40px; margin-bottom:10px;line-height:40px; border-bottom:2px solid #666; color:#0066CC; font-size:20px; font-weight:600;">￥<s:property value="user.yueMon" /></div>
			   <span style="font-size:12px; line-height:16px;">提现规则：<br/>1.200元起提，只能取200的整数倍。<br/>2.同一用户，每日提现次数不能超过3次，每日提现总额不能超过2000元。<br/>3.双休日及国家法定节假日暂不能提现。<br/>4.用户提现平台代缴3.5%的税点。</span><br />
			   <span style="color:#333; line-height:20px;">请选择提现金额（元）：</span><br />
			   <div class="h10"></div>
			    <!--<input type="text" id="cashId" name="cashId" min="200" max="2000" style="width:80%; height:35px; margin-left:10%;line-height:35px; border:1px solid #ccc; color:#000; font-size:16px; padding-left:10px;" />-->
				<select id="cashId" name="cashId" style="width:80%; height:35px; margin-left:10%;line-height:35px; border:1px solid #eb3838; color:#000; font-size:16px; padding-left:10px;">
		 			<option value="200" selected>200元</option>
		 			<option value="400">400元</option>
		 			<option value="600">600元</option>
		 			<option value="800">800元</option>
		 			<option value="1000">1000元</option>
		 			<option value="1200">1200元</option>
		 			<option value="1400">1400元</option>
		 			<option value="1600">1600元</option>
		 			<option value="1800">1800元</option>
		 			<option value="2000">2000元</option>
		 		</select> 
		 		<div id="error" style="width:80%; height:25px; margin-left:10%; padding-left:10px;color:#eb3838;"></div>
		 		<button type="submit" class="btn" id="cashBtnId"  style="background-color:#eb3838;width:80%; height:35px; margin-left:10%; border:none; text-align:center;color:#FFFFFF; font-size:16px;letter-spacing:2px;">确认结算</button>
				<div class="h15"></div>
				<button type="button"  class="btn" id="cancelBtnId" style="background-color:#eb3838;width:80%; height:35px; margin-left:10%;  border:none; text-align:center;color:#FFFFFF; font-size:16px;letter-spacing:2px;">取消</button>
				<div class="h10"></div>
			</h5>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</body>
</html>