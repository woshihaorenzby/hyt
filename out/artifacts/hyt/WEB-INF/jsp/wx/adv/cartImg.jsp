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
	<title>图片剪切</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cut/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cut/default.css">
    <link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
  	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cut/cropper.min.css" rel="stylesheet">
  	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cut/main.css" rel="stylesheet">
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
	<script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
<script>
$(function(){
	$("#cut").click(function(){
		$.ajax({
			type: "POST",
			url: "<%=path%>/adv/wxDoCut",
			data: "adv.id=<s:property value="adv.id" />&cutImg.x="+parseInt($("#dataX").val())+"&cutImg.y="+parseInt($("#dataY").val())+"&cutImg.w="+parseInt($("#dataWidth").val())+"&cutImg.h="+parseInt($("#dataHeight").val()),
			success: function(data){
				window.open("<%=path%>/adv/wxAdvEdit?adv.id=<s:property value="adv.id" />&advType=<s:property value="advType" />", "_self");
			}
		});
	});
});
</script>
</head> 
<body>
<div class="htmleaf-container">
	<!-- Content -->
	<div class="container">
		<div class="row">
			<div class="col-md-9" style="padding:0px;">
				<!-- <h3 class="page-header">Demo:</h3> -->
				<div class="img-container">
					<img class="cropper" src="<%=path%><s:property value="adv.imagePath" />" alt="Picture">
				</div>
			</div>
		</div>
	</div>
	<button id="cut" type="button" class="btn btn-primary btn-sm">裁剪</button>
	<input id="dataX" type="hidden"/>
	<input id="dataY" type="hidden"/>
	<input id="dataHeight" type="hidden"/>
	<input id="dataWidth" type="hidden"/>
	<input id="dataRotate" type="hidden"/>
</div>
<script src="<%=path%>/js/jquery-1.11.0.min.js"></script>
<script src="<%=path%>/js/bootstrap.min.js"></script>
<script src="<%=path%>/css/cut/cropper.min.js"></script>
<script src="<%=path%>/css/cut/main.js"></script>
</body>
</html>