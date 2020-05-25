<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jqueryui/jquery-ui.min.css">
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/js/msgbox/msgbox.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/smartpaginator.css"></link>
	<script type="text/javascript">
		var ctxPath="<%=path%>";
	</script>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.ui.datepicker-zh-TW.js"></script>
<script>
var id = "<s:property value="mobileSale.id" />";
var province = "<s:property value="mobileSale.province" />";//省
var city = "<s:property value="mobileSale.city" />";//市
var price = "<s:property value="mobileSale.price" />";//价格
var mobileNum = "<s:property value="mobileSale.mobileNum" />";//号码
var telephoneBill = "<s:property value="mobileSale.telephoneBill" />";//内含话费
var minimumConsumption = "<s:property value="mobileSale.minimumConsumption" />"; //最低消费
var hasSale = "<s:property value="mobileSale.hasSale" />";
$(function(){
	console.log(hasSale);
	$("#pushTime").datepicker($.datepicker.regional["zh-TW"]);
	$("#pushTime").datepicker("option","dateFormat","yy-mm-dd");
	if(pushTime=="") {
		$("#pushTime").datepicker('setDate',new Date());
	} else {
		$("#pushTime").datepicker('setDate',pushTime);
	}

	CKEDITOR.replace("articleContent");
	CKEDITOR.instances.articleContent.setData(unHtml(articleContent));
});
function save() {
	resetMsg();
	var id = "<s:property value="mobileSale.id" />";
	var province = $("#province").val();//省
	var city = $("#city").val();//市
	var price = Number($("#price").val());//价格
	var mobileNum = $("#mobileNum").val();//号码
	var telephoneBill = Number($("#telephoneBill").val());//内含话费
	var hasSale = $("#hasSale").find("option:selected").val();
	var minimumConsumption = Number($("#minimumConsumption").val()); //最低消费
	var details = $("#details").val(); //详情介绍
	var free = $("#free").find("option:selected").val();; //类型
	$.ajax({
		type: "post",
		url: "<%=path%>/wxMobileSale/save",
		dataType: "json",
		data: {"mobileSale.id":id ,
                "mobileSale.province" : province ,
                "mobileSale.city" : city ,
                "mobileSale.price":price ,
                "mobileSale.mobileNum": mobileNum ,
                "mobileSale.telephoneBill": telephoneBill ,
                "mobileSale.minimumConsumption":minimumConsumption ,
                "mobileSale.hasSale" :hasSale,
                "mobileSale.details" :details,
                "mobileSale.free" :free
        },
		success: function(data){
			if(data.code == "1"){
				msgSuccessUrl("保存成功！", "<%=path%>/wxMobileSale/wxShow");
			}else{
				msgError("保存失败，请稍后重试！");
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) {
			msgError("保存失败，请稍后重试！");
		}
	});
}
</script>
</head>
<body class="bodyst">
<div class="table_content" style="margin-top:10px;">
	<table class="form_table">
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>号码：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="mobileNum" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.mobileNum" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写号码！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>省：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="province" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.province" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写省！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>市：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="city" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.city" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写市！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>价格：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="price" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.price" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写价格！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>价格：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="telephoneBill" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.telephoneBill" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写内含话费！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>价格：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="minimumConsumption" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.minimumConsumption" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写最低消费！</div>
				</div>
			</td>
		</tr>
			<tr>
				<td class="table_text"><span style="color:red;">*</span>是否已经卖出：</td>
				<td class="table_textright">
					<div class="form-group" style="margin:0px;">
						<select id="hasSale" class="form-control" style="width:130px;float:left;">
							<option value="0" <s:if test="mobileSale.hasSale==0">selected = "selected"</s:if>>未卖出</option>
							<option value="1" <s:if test="mobileSale.hasSale==1">selected = "selected"</s:if>>已卖出</option>
						</select>
						<div class="errormsg">&nbsp;&nbsp;是否已经卖出！</div>
					</div>
				</td>
			</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>详情介绍：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="details" class="form-control" type="text" style="width:200px;float:left;" value="<s:property value="mobileSale.details" />" />
					<div class="errormsg">&nbsp;&nbsp;请填写详情介绍！</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>类型：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<select id="free" class="form-control" style="width:130px;float:left;">
						<option value="0" <s:if test="mobileSale.free==0">selected = "selected"</s:if>>普通</option>
						<option value="1" <s:if test="mobileSale.free==1">selected = "selected"</s:if>>靓号</option>
						<option value="2" <s:if test="mobileSale.free==2">selected = "selected"</s:if>>风水</option>
						<option value="3" <s:if test="mobileSale.free==3">selected = "selected"</s:if>>免费</option>
					</select>
					<div class="errormsg">&nbsp;&nbsp类型</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<button type="button" class="btn btn-success btn-sm" onclick="save()"><span class="glyphicon glyphicon-saved"></span>&nbsp;<strong>保存</strong></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-danger btn-sm" onclick="resetForm()"><span class="glyphicon glyphicon-refresh"></span>&nbsp;<strong>重置</strong></button>
			</td>
		</tr>
	</table>
</div>

</html>