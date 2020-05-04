<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>靓号定制</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/style.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
    <script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
    <script type="text/javascript" src="<%=path%>/js/area.js"></script>
    <style>
        .sub {
            margin-top: 20px;
            width: 100%;
            height: 40px;
            border-radius: 5px;
            border: 1px solid #cbcbcb;
            background-color: white;
            text-align: center;
            line-height: 40px;
            display: block;
        }
    </style>
    <script>
        $(function () {
            addressInit("province", "city", "", "请选择");
        });

        function save() {
            var province = $("#province").val();
            var city = $("#city").val();
            var mobile = $("#mobile").val();
            var details = $("#details").val();
            var contact = $("#contact").val();
            if (mobile.length == 0) {
                alert("请填写您想要的手机号码");
                return;
            }
            if (details.length == 0) {
                alert("请填写手机详情");
                return;
            }
            if (contact.length == 0) {
                alert("请留下您的联系方式");
                return;
            }
            $.ajax({
                type: "post",
                url: "<%=path%>/customized/wxSave",
                dataType: "json",
                data: {
                    "customized.province": province,
                    "customized.city": city,
                    "customized.mobile": mobile,
                    "customized.details": details,
                    "customized.contact": contact,
                },
                success: function (data) {
                    if (data.code == "1") {
                        $("#province").val("请选择");
                        $("#city").val("请选择");
                        $("#contact").val("");
                        $("#details").val("预算:");
                        $("#mobile").val("");
                        msgSuccess("添加定制资料成功！");
                    } else {
                        msgError("添加定制资料失败，请稍后重试！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    msgError("添加定制资料失败，请稍后重试！");
                }
            });
        }
    </script>
</head>
<body style="background:#F3F3F3;padding:0px 15px 15px 15px;margin:0px;">
<div class="index_tou">
    <p>靓号定制<a href="javascript:history.go(-1)"><img src="<%=path%>/images/last_icon.png" class="index_tou_img3"/></a>
    </p>
</div>
<div class="h60"></div>
<div>
		<span style="font-size:1em; ">号码归属地:
			<i class="notnull">不选表示不限城市</i>
	</span>
    <div>
        <select id="province" style="margin-top:10px;width:49%;height:30px;border:1px solid #cbcbcb"></select>
        <select id="city" style="margin-top:10px;width:49%;height:30px;border:1px solid #cbcbcb"></select>
    </div>
    <div style="height:18px"></div>
    <span style="font-size:1em; ">手机号码
		<i class="notnull">*必填选项</i>
	</span>
    <input type="text" placeholder="请输入你需要包含的数字，例如：189****5210" id="mobile" style="margin-top:10px;width:98%;height:30px;border:1px solid #cbcbcb">
    <div style="height:18px"></div>
    <span style="font-size:1em; ">手机详情
		<i class="notnull">*必填选项</i>
	</span>
    <textarea id="details" style="margin-top:10px;width:98%;height:50px;border:1px solid #cbcbcb">
预算:
	</textarea>
    <div style="height:18px"></div>
	<span style="font-size:1em; ">联系方式
		<i class="notnull">*必填选项</i>
	</span>
	<input type="text" placeholder="请输入您的手机号码" id="contact" style="margin-top:10px;width:98%;height:30px;border:1px solid #cbcbcb">
    <div style="height:18px"></div>
    <a href="javascript:void(0)" class="sub" onclick="save()">提交</a>
</div>

</body>
</html>