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
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/area.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.ui.datepicker-zh-TW.js"></script>
<script>
var id = "<s:property value="freeOrder.mobileSale.id" />";
var addressProvince = "<s:property value="freeOrder.addressProvince" />";//省
var addressCity = "<s:property value="freeOrder.addressCity" />";//省
var addressArea = "<s:property value="freeOrder.addressArea" />";//省
$(function(){
	addressInit("addressProvince","addressCity","addressArea",addressProvince,addressCity,addressArea);
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
	var id = "<s:property value="freeOrder.id" />";
	var name = $("#province").val();//省
	var idNumber = $("#idNumber").val();//市
	var contact = $("#contact").val();//市
	var addressProvince = $("#addressProvince").val();//市
	var addressCity = $("#addressCity").val();//市
	var addressArea = $("#addressArea").val();//市
	var addressName = $("#addressName").val();//市
	var addressMobile = $("#addressMobile").val();//市
	var address = $("#address").val();//市
	var stutus = $("#stutus").val();//市
	$.ajax({
		type: "post",
		url: "<%=path%>/freeOrder/save",
		dataType: "json",
		data: {"freeOrder.id":id ,
                "freeOrder.name" : name ,
                "freeOrder.idNumber" : idNumber ,
                "freeOrder.contact":contact ,
                "freeOrder.addressProvince": addressProvince ,
                "freeOrder.addressCity": addressCity ,
                "freeOrder.addressArea":addressArea ,
                "freeOrder.addressName" :addressName,
                "freeOrder.addressMobile" :addressMobile,
                "freeOrder.address" :address,
                "freeOrder.stutus" :stutus
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
					<input  id="mobileNum" class="form-control" type="text" disabled="disabled" style="width:200px;float:left;" value="<s:property value="freeOrder.mobileSale.mobileNum" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>归属地</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="province" class="form-control" disabled="disabled" type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.mobileSale.province + freeOrder.mobileSale.city" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>价格：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="price" class="form-control" disabled="disabled" type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.mobileSale.price" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>价格：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="telephoneBill" class="form-control" disabled="disabled" type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.mobileSale.telephoneBill" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text" style="vertical-align : middle;"><span style="color:red;">*</span>价格：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="minimumConsumption" class="form-control" disabled="disabled" type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.mobileSale.minimumConsumption" />" />
				</div>
			</td>
		</tr>
			<tr>
				<td class="table_text"><span style="color:red;">*</span>是否已经卖出：</td>
				<td class="table_textright">
					<div class="form-group" style="margin:0px;">
						<select id="hasSale" class="form-control" style="width:130px;float:left;">
							<option value="0" <s:if test="freeOrder.mobileSale.hasSale==0">selected = "selected"</s:if>>未卖出</option>
							<option value="1" <s:if test="freeOrder.mobileSale.hasSale==1">selected = "selected"</s:if>>已卖出</option>
						</select>
					</div>
				</td>
			</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>详情介绍：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="details" class="form-control" disabled="disabled" type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.mobileSale.details" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>证件姓名：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="name" class="form-control"  type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.name" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写买家证件姓名！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>证件编号：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="idNumber" class="form-control"  type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.idNumber" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写买家证件编号！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>联系方式：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="contact" class="form-control"  type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.contact" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写买家联系方式！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>收货人姓名：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="addressName" class="form-control"  type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.addressName" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写收货人姓名！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>收货人电话：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="addressMobile" class="form-control"  type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.addressMobile" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写收货人电话！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>收货地址-省：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<select id="addressProvince" class="form-control"  style="width:200px;float:left;" value="<s:property value="freeOrder.addressProvince" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写收货地址-省！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>收货地址-市：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<select id="addressCity" class="form-control"  style="width:200px;float:left;" value="<s:property value="freeOrder.addressCity" />" />
				</div>
				<div class="errormsg">&nbsp;&nbsp;请填写收货地址-市！</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;"></span>收货地址-区：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<select id="addressArea" class="form-control" style="width:200px;float:left;" value="<s:property value="freeOrder.addressArea" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>收货详细地址：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<input id="address" class="form-control"  type="text" style="width:200px;float:left;" value="<s:property value="freeOrder.address" />" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="table_text"><span style="color:red;">*</span>是否已经发货：</td>
			<td class="table_textright">
				<div class="form-group" style="margin:0px;">
					<select id="status" class="form-control" style="width:130px;float:left;">
						<option value="0" <s:if test="freeOrder.status==0">selected = "selected"</s:if>>未发货</option>
						<option value="1" <s:if test="freeOrder.status==1">selected = "selected"</s:if>>已发货</option>
					</select>
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