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
function deleteShare(id) {
    $.ajax({
        type: "post",
        url: "<%=path%>/share/wxShareDelete",
        dataType: "json",
        data: "share.id=" + id,
        success: function(data){
            location.reload();
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) { }
    });
}
function gotoArt(id) {
    window.open("<%=path%>/video/wxVideoDetail?video.id=" + id, "_self");
}
</script>
</head>
<body id="homeContent" style="background-color: #fff">
<div class="tuiTitle">
    <div class="tuiTileCenter">我的发布</div>
    <a href="<%=path%>/hyuser/wxMine">
        <div class="tuiTileLeft" style="z-index: 10;font-size:13px;"><img src="<%=path%>/images/yonghu.png?v=2"/><br/>我的
        </div>
    </a>
    <a href="<%=path%>/adv/wxAdv">
        <div class="tuiTileRight" style="z-index: 10;font-size:13px;"><img src="<%=path%>/images/guangg.png?v=2"/><br/>广告制作
        </div>
    </a>
</div>
<div id="focus" class="focus" style="text-align: center;">
    <p style="font-weight: bolder;font-style:italic;letter-spacing:4px;font-size:20px;margin:10px 0 6px 0;">
        选卡网广告效果的流量来源?</p>
    <p style="color:#9a9a9a">—— 阅读量 点击量 转发量及常见问题解释 ——</p>
</div>
<div style="position: relative;width: 100%;height:65px;margin-top: 60px;background-color: #f3f3f3;border-bottom: 1px solid #ddd;text-align: center;">
    <div style="position: relative;width: 100%;height:50px;" id="zhuanfa">
        <ul>
            <li><img src="<%=path%>/images/dengpao.png" width="16">&nbsp;阅读量<br><s:property value="totView"/></li>
            <!-- <li><img src="<%=path%>/images/dianji.png" width="14">&nbsp;总点击<br>0</li> -->
            <li><img src="<%=path%>/images/zhuanfa.png" width="14">&nbsp;总转发<br><s:property value="totShare"/></li>
        </ul>
        <div style="float:right;width: 15%;height:40px;border:1px solid #ddd;border-radius:30px 0 0 30px;background-color: #fff;margin-top: 2%;font-size:12px;color:#ff728a;">
            <img src="<%=path%>/images/hongshijian.png" width="16"><br/>
            最近
        </div>
    </div>
</div>
<div style="position: relative;width:100%;">
    <s:iterator value="shareList" id="item">
        <div onclick="gotoArt('<s:property value="videoId"/>')" style="position: relative;width:100%;margin-top: 15px;border-bottom: 1px solid #eaeaea">
            <div style="position: relative;width:85%;overflow:hidden;text-overflow:ellipsis; white-space:nowrap;float:left;margin-left: 2.5%">
                <s:property value="title"/>
            </div>
            <div style="position: relative;width:10%;float:right;" onclick="deleteShare('<s:property value="id"/>')">
                <img src="<%=path%>/images/delete.png" width="18"/></div>
            <br/><br/>
            <div style="position: relative;width:100%;height:60px;" id="text">
                <span style="height:60px;width:100%;margin-left: 2%;"><img src="<%=path%>/images/shijian.png" width="14" style="margin-right: 10px;"><s:property value="createTime"/></span>
                <ul>
                    <li>阅读:<span style="color:red"><s:property value="viewNum"/></span></li>
                    <!-- <li>点击:<span style="color:red">0</span></li> -->
                    <li>转发:<span style="color:red"><s:property value="shareNum"/></span></li>
                </ul>
            </div>
        </div>
    </s:iterator>
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
        <div class="hong"><img src="<%=path%>/images/set_on.png"/><br/>我的发布</div>
    </a>
    <a href="<%=path%>/hyuser/wxUserHuo">
        <div style="position:relative"><img src="<%=path%>/images/mine.png"/><br/>活跃用户</div>
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