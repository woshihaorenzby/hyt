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
    <title>我的发布</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/style.css?v=4" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
    <style type="text/css">
        body {
            background: #F3F3F3;
        }

        #zhuanfa ul li {
            float: left;
            width: 28%;
            margin-top: 2%;
            font-weight: bolder;
        }

        #text ul li {
            float: left;
            width: 25%;
            margin: 2% 2.5%;
            font-weight: bolder;

        }

        .wode_p1 {
            height: 30px;
            max-height: 30px;
            line-height: 30px;
            margin-top: 5px;
        }

        .wode_p2 {
            height: 30px;
            max-height: 30px;
            line-height: 30px;
        }

        #FontScroll {
            width: 100%;
            height: 40px;
            line-height: 40px;
            overflow: hidden;
            margin: 0 auto;
            color: #595959;
            text-align: center;
        }
    </style>
    <script>
        $(function(){
            $.ajax({
                type: "post",
                url: "<%=path%>/hyuser/wxUserShareNear",
                dataType: "json",
                data: "",
                success: function (data) {
                    if(data!=null && data.length>0) {
                        var appStr = "";
                        for(var i=0; i<data.length; i++) {
                            appStr += "<tr style='border-bottom:1px solid #e1e1e1;height:30px;'>";
                            appStr += "<td style='border-right:1px solid #e1e1e1;'>"+data[i].niName+"</td>";
                            appStr += "<td style='border-right:1px solid #e1e1e1;color:#018EE8;'>"+data[i].title+"</td>";
                            appStr += "<td>"+data[i].createTime+"</td>";
                            appStr += "</tr>";
                        }
                        $("#huoBody").append(appStr);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        });
    </script>
</head>
<body id="homeContent" style="background-color: #fff">
<div class="tuiTitle">
    <div class="tuiTileCenter">活跃用户</div>
    <a href="<%=path%>/hyuser/wxMine">
        <div class="tuiTileLeft" style="z-index: 10;font-size:13px;"><img src="<%=path%>/images/yonghu.png?v=2"/><br/>我的
        </div>
    </a>
    <a href="<%=path%>/adv/wxAdv">
        <div class="tuiTileRight" style="z-index: 10;font-size:13px;"><img src="<%=path%>/images/guangg.png?v=2"/><br/>广告制作
        </div>
    </a>
</div>
<div style="position:relative;top:60px;">
    <table style="width:100%;text-align:center;">
        <thead>
            <tr style="border-top:1px solid #e1e1e1;border-bottom:1px solid #e1e1e1;height:30px;">
                <td style="width:20%;border-right:1px solid #e1e1e1;">发布用户</td>
                <td style="width:60%;border-right:1px solid #e1e1e1;">广告标题</td>
                <td style="width:20%;">发布时间</td>
            </tr>
        </thead>
        <tbody id="huoBody">

        </tbody>
    </table>
</div>
<!--底部导航-->
<div class="index_di2">
    <a href="<%=path%>/hyuser/wxIndex">
        <div><img src="<%=path%>/images/home.png"/><br/>首页</div>
    </a>
    <a href="<%=path%>/video/wxVideo?video.mainType=1">
        <div><img src="<%=path%>/images/ku.png"/><br/>推广库</div>
    </a>
    <a href="<%=path%>/hyuser/wxUserRelease">
        <div><img src="<%=path%>/images/set.png"/><br/>我的发布</div>
    </a>
    <a href="<%=path%>/hyuser/wxUserHuo">
        <div class="hong"><img src="<%=path%>/images/mine_on.png"/><br/>活跃用户</div>
    </a>
</div>
<script type="text/javascript">
    function Allsc() {
        $("#homeContent").css("height", document.body.clientHeight);
        var $w = document.body.clientWidth;
        //$(".bd li img").css("height", $w/3.069672131147541);
    }

    window.onload = function () {
        Allsc();
    };

    window.onresize = function () {
        //捕捉屏幕窗口变化，
        Allsc();
    }
</script>
</body>
</html>