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
<title>选号网-微信推广神器</title>
<link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/css/wx/style.css?v=4" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/css/wx/app.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
<script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
<style type="text/css">
    body {
        background: #F3F3F3;
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
<script type="text/javascript">
var curPage = 1;
var pageRecordCount = 20;
var uploadSuc = false;
var upload = false;
var meiWid = 0;
var itemnum = 0;
var searchType = "scalNum";
var number="";
$(function () {
    console.log("load------4")
    loadData();
    $(window).bind("scroll",col_scroll);
    $.ajax({
        type: "post",
        url: "<%=path%>/hyuser/wxIndexType",
        dataType: "json",
        data: "",
        success: function (data) {
            var pinWidth = window.screen.availWidth;
            meiWid = (pinWidth-10)/5;

            if (data != null && data.length > 0) {
                $("#soldiv").css("display", "block");
                var appStr = "";
                for (var i = 0; i < data.length; i++) {
                    appStr += "<div style='width:"+meiWid+"px;' onclick=\"gotoTypeUrl('"+data[i].typeName+"', '"+data[i].webUrl+"')\"><img style=\"width:35px;height:35px;\" src=\"<%=path%>"+data[i].typeImg+"\"/><br/>"+data[i].typeName+"</div>";
                }
                $(".tuiguang_xuanxiang").append(appStr);
                var num = data.length/2;
                num = num.toFixed(0);
                itemnum = num;
                $(".tuiguang_xuanxiang").css("width", (num*meiWid)+20+"px");
                var chw = ((pinWidth*100/num*meiWid)).toFixed(0);
                if(chw<1){
                    chw = 1;
                }
                var totalWid = $("#soldivnei").width();
                $("#soldivnei").css("width", totalWid/chw + "px");
            }
        }
    });
    $("#typediv").scroll(function() {
        var gun = $(this).scrollLeft();
        var chw = 1-(gun*100/(itemnum*meiWid)).toFixed(0)/(window.screen.availWidth);
        $("#soldivnei").css("left", chw + "%");
    });
});
function  searchNum(e) {
    console.log(e);
    curPage= 1;
    console.log("load------1")
    loadData(number,searchType);
     $("#ulid").empty();
}
function  resetNum(e) {
    curPage= 1;
    // $("input[type='tel']").val("");
    if(searchType=="scalNum"){
        var txts = $(".accurate input");
        for (var i = 1; i < txts.length; i++) {
            var t = $(txts[i]);
            t.val("");
        }
    }else if(searchType=="anyNum"){
        var txts = $("#anyNumInp");
        txts.val("");
    }else if(searchType=="endNum"){
        var txts = $("#endNumInp");
        txts.val("");
    }
    number = "";
    console.log("load------2")
    loadData();
    $("#ulid").empty();
}
function loadData() {
    if(searchType=="scalNum"){
        var txts = $(".accurate input");
        number = "1";
        console.log("txts---------"+txts.length);
        for (var i = 1; i < txts.length; i++) {
            var t = $(txts[i]).val();
            if(t!=null&&t!=""){
                number = number+t;
            }else{
                number = number+"_";
            }
        }
    }else if(searchType=="anyNum"){
        var txts = $("#anyNumInp");
        number = txts.val();
    }else if(searchType=="endNum"){
        var txts = $("#endNumInp");
        number = txts.val();
    }
    if(number!=null&&number!=""){
        if(number=="undefined"){
            number = "";
        }
    }
    $("#note").show();
    $.ajax({
        type: "post",
        url: "<%=path%>/wxMobileSale/wxMobileSaleMainList",
        dataType: "json",
        data: "page.curPage=" + curPage + "&page.pageRecordCount=" + pageRecordCount + "&mobileSale.hasSale=0&mobileSale.mobileNum="+number+"&mobileSale.searchType="+searchType,
        success: function (data) {
            $("#note").hide();
            if (data != null && data.length > 0) {
                var appStr = "";
                for (var i = 0; i < data.length; i++) {
                    appStr += "<ul >";
                    appStr += "<a href=\"javascript:;\" onclick=\"showDetail('<%=path%>/wxMobileSale/wxMobileSaleDetail?mobileSale.id="+data[i].id+"')\">";
                    appStr += "<li style='height: 8.533vw'>";
                    <%--appStr += "<img src=\"<%=path%>" + data[i].imagePath + "\" />";--%>
                   /* appStr += "<p class=\"index_p1\">" + data[i].mobileNum + "</p>";
                    appStr += "<p class=\"index_p1\">" + data[i].province+data[i].city + "</p>";*/
                    appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                    appStr += "<span style=\"margin-left:10px;\">" + data[i].mobileNum + "</span>";
                    appStr += "</span>";
                    appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                    appStr += "<span style=\"margin-left:30px;\">" + data[i].province+data[i].city + "</span>";
                    appStr += "</span>";
                    appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                    appStr += "<span style=\"margin-left:20px;\">" + "联通" + "</span>";
                    appStr += "</span>";
                    appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                    appStr += "<span style=\"margin-left:20px;color: #e54c3f\" >" +  "￥"+data[i].price + "</span>";
                    appStr += "</span>";
                    appStr += "</li>";
                    appStr += "</a>";
                    appStr += "</ul>";
                }
                // $("#ulid").empty();
                $("#ulid").append(appStr);
                //00000000000000000000000000000000
            }else{
                var noMuch =   $("#noMuch");
                if(noMuch==null){
                    appStr = "<span id= 'noMuch'>没有更多数据了</span>";
                    $("#ulid").append(appStr);
                }
            }
        }
    });
}
//下拉到底部加载更多数据
//加载函数
function findData(){
    curPage++;
    upload = false;
    console.log("load------3")
    loadData();
}
function showDetail(url) {
    window.open(url, "_self");
}
function gotoTypeUrl(typeName, webUrl) {
    if(webUrl=="") {
        window.open("<%=path%>/video/wxVideo?video.mainType=1&typeName="+typeName, "_self");
    } else {
        window.open(webUrl, "_self");
    }
}
var col_scroll = function(){
    if(($(document).height() -$(window).height()) == ($(window).scrollTop()-$(".index_di2").height())){
        if(!uploadSuc && !upload){
            upload = true;
            //调用加载中样式
            findData();
        }
    }
}
</script>
</head>
<body id="homeContent">
<div class="tuiTitle">
    <div class="tuiTileCenter">选号网</div>
<%--    <a href="<%=path%>/hyuser/wxMine">--%>
<%--        <div class="tuiTileLeft" style="z-index: 10;font-size:13px;width:80px;"><img src="<%=path%>/images/yonghu.png?v=2"/><br/>个人中心</div>--%>
<%--    </a>--%>
<%--    <a href="<%=path%>/adv/wxAdv">--%>
<%--        <div class="tuiTileRight" style="z-index: 10;font-size:13px;"><img src="<%=path%>/images/guangg.png?v=2"/><br/>广告制作</div>--%>
<%--    </a>--%>
</div>

<div data-v-2a84ec57="" id="homeWrapper" class="home-wrapper child-view" style="top:2px">
    <div id="focus" class="focus">
        <div class="hd">
            <ul></ul>
        </div>
        <div class="bd">
            <ul>
                <s:iterator value="lunimgList" id="item">
                    <li><a href="<s:property value="url" />" target="_blank"><img
                            src="http://www.haoyt168.com<s:property value="imagePath" />"/></a></li>
                </s:iterator>
            </ul>
        </div>
    </div>
    <%-- <div id="FontScroll" class="dian">
        <ul>
            <li><a href="<%=path%>/notice/wxNoticeDetail?notice.id=<s:property value="notice.id" />"><s:property value="notice.title" /></a></li>
        </ul>
    </div> --%>
    <div id="typediv" style="width: 100%;height:auto;overflow-x:scroll">
        <div class="tuiguang_xuanxiang">
            <!-- <div><img src="<%=path%>/images/usercode.png"/><br/>热点推荐</div> -->

        </div>
    </div>

    <div id="soldiv" style="background:white;padding-bottom:5px;display:none;">
        <div style="position:relative;margin-left:auto;margin-right:auto;width: 81%;background:#f3f3f3;height:3px;">
            <div id="soldivnei" style="position:absolute;left:0px;width: 81%;background:#fb543e;height:3px;">

            </div>
        </div>
    </div>
<%--<div data-v-2a84ec57="" class="filter-top">--%>
<%--    <div data-v-2a84ec57="" class="filter-wrapper">--%>
<%--        <ul data-v-2a84ec57="" class="filter-ul">--%>
<%--&lt;%&ndash;            <li data-v-2a84ec57="" class="filter-li">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div data-v-2a84ec57="" class="a">运营商</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div data-v-2a84ec57="" class="img-wrapper"><img data-v-2a84ec57=""&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                                 src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAJCAYAAADtj3ZXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCMEM1NzBEQTIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCMEM1NzBEQjIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkIwQzU3MEQ4MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkIwQzU3MEQ5MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+QTvx+wAAAOZJREFUeNqMkr0LQVEYhw8pw00yWpRZJkVKuUrKdneTYrFJJpvFH6CMrJKSkjIIAxlsymy0mUQZruetM1yfufWc3+mc9znv6XRdZjpdUEp5F8tlV/3xZUzTR9Rg5GFoQ4DFJFnhkPsPMURMIAohN0MRLlCCKQX+L2KM2GrxAE03ncZMTDhBFtYUhl9Ei1hBEOaQwjtKZ8VkRyRgDxHYIMS1WCWGYEAP8tSfZc9l27azg1x5ADm4wgykqxQ1kFrOGz3J+gB5xA6U9dJN3gWx//oOb7LjkDohWIibj0Uif4N/wPi1/xBgAPgGcjXTUAHPAAAAAElFTkSuQmCC"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                                 alt="" class="img-item"> <img data-v-2a84ec57=""&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                                                               src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAICAYAAADJEc7MAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpERjQ4Q0ExQTIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpERjQ4Q0ExQjIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkRGNDhDQTE4MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkRGNDhDQTE5MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8++i8EYAAAAHFJREFUeNpi/P//PwM6eObrIAOkdkO5rlKbDzxBV8OIrhGq6QAQK0OF7gKxA7pmJjya7kIxiH0AKoepEYsmByjGqpkJlyaQ06DOw6qZ8amPPVZNBLzgALJxDz5NIIDF5j0gjX+A+CYuTVg0g9T+AQgwALzhRjZKZM4DAAAAAElFTkSuQmCC"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                                                               alt="" class="img-item"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                                                               style="display: none;">&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div> <!----></li>&ndash;%&gt;--%>
<%--            <li data-v-2a84ec57="" class="filter-li">--%>
<%--                <div data-v-2a84ec57="" class="a">归属地</div>--%>
<%--                <div data-v-2a84ec57="" class="img-wrapper"><img data-v-2a84ec57=""--%>
<%--                                                                 src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAJCAYAAADtj3ZXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCMEM1NzBEQTIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCMEM1NzBEQjIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkIwQzU3MEQ4MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkIwQzU3MEQ5MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+QTvx+wAAAOZJREFUeNqMkr0LQVEYhw8pw00yWpRZJkVKuUrKdneTYrFJJpvFH6CMrJKSkjIIAxlsymy0mUQZruetM1yfufWc3+mc9znv6XRdZjpdUEp5F8tlV/3xZUzTR9Rg5GFoQ4DFJFnhkPsPMURMIAohN0MRLlCCKQX+L2KM2GrxAE03ncZMTDhBFtYUhl9Ei1hBEOaQwjtKZ8VkRyRgDxHYIMS1WCWGYEAP8tSfZc9l27azg1x5ADm4wgykqxQ1kFrOGz3J+gB5xA6U9dJN3gWx//oOb7LjkDohWIibj0Uif4N/wPi1/xBgAPgGcjXTUAHPAAAAAElFTkSuQmCC"--%>
<%--                                                                 alt="" class="img-item"> <img data-v-2a84ec57=""--%>
<%--                                                                                               src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAICAYAAADJEc7MAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpERjQ4Q0ExQTIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpERjQ4Q0ExQjIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkRGNDhDQTE4MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkRGNDhDQTE5MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8++i8EYAAAAHFJREFUeNpi/P//PwM6eObrIAOkdkO5rlKbDzxBV8OIrhGq6QAQK0OF7gKxA7pmJjya7kIxiH0AKoepEYsmByjGqpkJlyaQ06DOw6qZ8amPPVZNBLzgALJxDz5NIIDF5j0gjX+A+CYuTVg0g9T+AQgwALzhRjZKZM4DAAAAAElFTkSuQmCC"--%>
<%--                                                                                               alt="" class="img-item"--%>
<%--                                                                                               style="display: none;">--%>
<%--                </div>--%>
<%--                <div data-v-2a84ec57=""><div data-v-4e63860f="" data-v-2a84ec57="" class="pullDown"><!----> <div data-v-4e63860f="" class="one-slider second-slider"><div data-v-4e63860f="" class="pullDown-group" style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);"><ul data-v-4e63860f="" class="pull-ul" style="pointer-events: auto;"><li data-v-4e63860f="" class="pull-li pull-lis select-bgc">不限</li><li data-v-4e63860f="" class="pull-li pull-lis">北京市</li><li data-v-4e63860f="" class="pull-li pull-lis">天津市</li><li data-v-4e63860f="" class="pull-li pull-lis">河北省</li><li data-v-4e63860f="" class="pull-li pull-lis">山西省</li><li data-v-4e63860f="" class="pull-li pull-lis">内蒙古自治区</li><li data-v-4e63860f="" class="pull-li pull-lis">辽宁省</li><li data-v-4e63860f="" class="pull-li pull-lis">吉林省</li><li data-v-4e63860f="" class="pull-li pull-lis">黑龙江省</li><li data-v-4e63860f="" class="pull-li pull-lis">上海市</li><li data-v-4e63860f="" class="pull-li pull-lis">江苏省</li><li data-v-4e63860f="" class="pull-li pull-lis">浙江省</li><li data-v-4e63860f="" class="pull-li pull-lis">安徽省</li><li data-v-4e63860f="" class="pull-li pull-lis">福建省</li><li data-v-4e63860f="" class="pull-li pull-lis">江西省</li><li data-v-4e63860f="" class="pull-li pull-lis">山东省</li><li data-v-4e63860f="" class="pull-li pull-lis">河南省</li><li data-v-4e63860f="" class="pull-li pull-lis">湖北省</li><li data-v-4e63860f="" class="pull-li pull-lis">湖南省</li><li data-v-4e63860f="" class="pull-li pull-lis">广东省</li><li data-v-4e63860f="" class="pull-li pull-lis">广西壮族自治区</li><li data-v-4e63860f="" class="pull-li pull-lis">海南省</li><li data-v-4e63860f="" class="pull-li pull-lis">重庆市</li><li data-v-4e63860f="" class="pull-li pull-lis">四川省</li><li data-v-4e63860f="" class="pull-li pull-lis">贵州省</li><li data-v-4e63860f="" class="pull-li pull-lis">云南省</li><li data-v-4e63860f="" class="pull-li pull-lis">西藏自治区</li><li data-v-4e63860f="" class="pull-li pull-lis">陕西省</li><li data-v-4e63860f="" class="pull-li pull-lis">甘肃省</li><li data-v-4e63860f="" class="pull-li pull-lis">青海省</li><li data-v-4e63860f="" class="pull-li pull-lis">宁夏回族自治区</li><li data-v-4e63860f="" class="pull-li pull-lis">新疆维吾尔自治区</li></ul></div></div> <div data-v-4e63860f="" class="two-slider second-slider"><div data-v-4e63860f="" class="pullDown-group" style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);"><ul data-v-4e63860f="" class="pull-ul" style="pointer-events: auto;"><div data-v-4e63860f=""><li data-v-4e63860f="" class="pull-li pull-lis is-select">不限</li></div><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----></ul></div></div></div></div>--%>
<%--            </li>--%>
<%--            <li data-v-2a84ec57="" class="filter-li">--%>
<%--                <div data-v-2a84ec57="" class="a">规律</div>--%>
<%--                <div data-v-2a84ec57="" class="img-wrapper"><img data-v-2a84ec57=""--%>
<%--                                                                 src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAJCAYAAADtj3ZXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCMEM1NzBEQTIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCMEM1NzBEQjIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkIwQzU3MEQ4MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkIwQzU3MEQ5MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+QTvx+wAAAOZJREFUeNqMkr0LQVEYhw8pw00yWpRZJkVKuUrKdneTYrFJJpvFH6CMrJKSkjIIAxlsymy0mUQZruetM1yfufWc3+mc9znv6XRdZjpdUEp5F8tlV/3xZUzTR9Rg5GFoQ4DFJFnhkPsPMURMIAohN0MRLlCCKQX+L2KM2GrxAE03ncZMTDhBFtYUhl9Ei1hBEOaQwjtKZ8VkRyRgDxHYIMS1WCWGYEAP8tSfZc9l27azg1x5ADm4wgykqxQ1kFrOGz3J+gB5xA6U9dJN3gWx//oOb7LjkDohWIibj0Uif4N/wPi1/xBgAPgGcjXTUAHPAAAAAElFTkSuQmCC"--%>
<%--                                                                 alt="" class="img-item"> <img data-v-2a84ec57=""--%>
<%--                                                                                               src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAICAYAAADJEc7MAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpERjQ4Q0ExQTIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpERjQ4Q0ExQjIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkRGNDhDQTE4MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkRGNDhDQTE5MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8++i8EYAAAAHFJREFUeNpi/P//PwM6eObrIAOkdkO5rlKbDzxBV8OIrhGq6QAQK0OF7gKxA7pmJjya7kIxiH0AKoepEYsmByjGqpkJlyaQ06DOw6qZ8amPPVZNBLzgALJxDz5NIIDF5j0gjX+A+CYuTVg0g9T+AQgwALzhRjZKZM4DAAAAAElFTkSuQmCC"--%>
<%--                                                                                               alt="" class="img-item"--%>
<%--                                                                                               style="display: none;">--%>
<%--                </div> <!----></li>--%>
<%--            <li data-v-2a84ec57="" class="filter-li">--%>
<%--                <div data-v-2a84ec57="" class="a">更多</div>--%>
<%--                <div data-v-2a84ec57="" class="img-wrapper"><img data-v-2a84ec57=""--%>
<%--                                                                 src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAJCAYAAADtj3ZXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCMEM1NzBEQTIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCMEM1NzBEQjIyRDYxMUU5QjNFODhDMjRGMUUwQTczQyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkIwQzU3MEQ4MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkIwQzU3MEQ5MjJENjExRTlCM0U4OEMyNEYxRTBBNzNDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+QTvx+wAAAOZJREFUeNqMkr0LQVEYhw8pw00yWpRZJkVKuUrKdneTYrFJJpvFH6CMrJKSkjIIAxlsymy0mUQZruetM1yfufWc3+mc9znv6XRdZjpdUEp5F8tlV/3xZUzTR9Rg5GFoQ4DFJFnhkPsPMURMIAohN0MRLlCCKQX+L2KM2GrxAE03ncZMTDhBFtYUhl9Ei1hBEOaQwjtKZ8VkRyRgDxHYIMS1WCWGYEAP8tSfZc9l27azg1x5ADm4wgykqxQ1kFrOGz3J+gB5xA6U9dJN3gWx//oOb7LjkDohWIibj0Uif4N/wPi1/xBgAPgGcjXTUAHPAAAAAElFTkSuQmCC"--%>
<%--                                                                 alt="" class="img-item"> <img data-v-2a84ec57=""--%>
<%--                                                                                               src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAICAYAAADJEc7MAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpERjQ4Q0ExQTIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpERjQ4Q0ExQjIyRDYxMUU5QjhGQUU4NDhFOTA3NDIwMCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkRGNDhDQTE4MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkRGNDhDQTE5MjJENjExRTlCOEZBRTg0OEU5MDc0MjAwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8++i8EYAAAAHFJREFUeNpi/P//PwM6eObrIAOkdkO5rlKbDzxBV8OIrhGq6QAQK0OF7gKxA7pmJjya7kIxiH0AKoepEYsmByjGqpkJlyaQ06DOw6qZ8amPPVZNBLzgALJxDz5NIIDF5j0gjX+A+CYuTVg0g9T+AQgwALzhRjZKZM4DAAAAAElFTkSuQmCC"--%>
<%--                                                                                               alt="" class="img-item"--%>
<%--                                                                                               style="display: none;">--%>
<%--                </div> <!----></li>--%>
<%--            <li data-v-2a84ec57="" class="filter-li">--%>
<%--                <div data-v-2a84ec57="" class="a">排序</div>--%>
<%--                <div data-v-2a84ec57="" class="img-wrapper"><img data-v-2a84ec57=""--%>
<%--                                                                 src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAUCAYAAACEYr13AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpFREU1RjA3QTIyRDYxMUU5QTBFRjlFQkE0QUFDRDlEQyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpFREU1RjA3QjIyRDYxMUU5QTBFRjlFQkE0QUFDRDlEQyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkVERTVGMDc4MjJENjExRTlBMEVGOUVCQTRBQUNEOURDIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkVERTVGMDc5MjJENjExRTlBMEVGOUVCQTRBQUNEOURDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+ZaBgwQAAATNJREFUeNq8k7FKgmEUho//4j+EWoS1tEVXIdhskA1OglMh3UJkk4ugpEO4mIsXITR1ASVOjtENZJZDJFL6HniFQ5r/Z4EvPH7H75z39eP3+0OHyWRGRG5BVFbTOzjz8FH/g1noqWuAz4082HQkT4+vATV+KTHsLQCfs6qaBhRBF2yBpsPRm5xVT1EDxiAHRiClD2aJ+ZQzI3rGHhs9UGBdBrsLzNugwvqKHvHMQBV0QMwMWl2wp0e/nm3agC9wzjoLDkwvYp78JWfnAlSP4A6EjEF1AjbAM/vyW4CqwTVt9o65tsB3UMA9mIB9XhpVwvQkKOAV9FnvMWSHv/zgEqB64aoXJs5aQz9cAz65ThgyO5m4Buh1bfM/D/8IdQq4AUdgGPRiePJPrSXgCQx4S+c0FWAAB+1AZWSDHDIAAAAASUVORK5CYII="--%>
<%--                                                                 alt="" class="img-item"> <img data-v-2a84ec57=""--%>
<%--                                                                                               src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAUCAYAAACEYr13AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoxMDBFMjQxQTIyRDcxMUU5QUQwN0U4QTMyMEZCNzRGNiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoxMDBFMjQxQjIyRDcxMUU5QUQwN0U4QTMyMEZCNzRGNiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjEwMEUyNDE4MjJENzExRTlBRDA3RThBMzIwRkI3NEY2IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjEwMEUyNDE5MjJENzExRTlBRDA3RThBMzIwRkI3NEY2Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+2SfS7QAAATVJREFUeNq8kz9LQmEUxs+9S3eQLLE/i1v0KYL2Cm1oCpwU8SuINrkERTm4pUsfQnDyA6g4NUZTi/1viETKngOPcNDqviX4wM/33Pue8/NyffVu97YPRKQGovK3vICsB0EfxYr8L3c+PgJe5MCyIznOBCqo8OKYsucQAvZqKioogx6IgbrDY9fZqzNlFQxBGgzAjr6YX4Yz7BlwZuhz4wqUWJ+A9W+G4+CU9RFnxDcN56ALlkyjTYF7+uhn45tW8AHyrA/BptlbNG++yN4pgaYDmsAzA5p9EAE33JefBJoLrilzL8n1EnyGCVpgBDZ4aDRbZk/CBI/ggXWCkjV+c9tFoLnnqgdmlbVK31wF71xHlIyfTFwFelwb/M0XJqROgirYBa9hfwxfZsxcBNfgiad0Kl8CDABowEMmiGMQoQAAAABJRU5ErkJggg=="--%>
<%--                                                                                               alt="" class="img-item"--%>
<%--                                                                                               style="display: none;">--%>
<%--                </div> <!----></li>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--</div>--%>
<div data-v-2a84ec57="" class="card">
    <div data-v-2a84ec57="" class="selecter">
        <div class="tab">
            <div id="scalNum"  class="tab-item tab-selected">精准搜号</div>
            <div id="anyNum" class="tab-item marginleft">任意搜号</div>
            <div id="endNum" class="tab-item marginleft">末位搜号</div>
        </div>
        <div class="swiper-container swiper-container-horizontal">
            <div  class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
                <div id="scalNumDiv" class="swiper-no-swiping swiper-slide swiper-slide-active" style="width: 360px;">
                    <div class="content"><p>*请在指定位置上填写数字，无要求的位置可留空</p>
                        <div class="mobile-input">
                            <div class="accurate">
                                <input type="tel" disabled="disabled" maxlength="1" value="1">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <input type="tel" maxlength="1" autocomplete="false" autocorrect="off" autocapitalize="off" spellcheck="false">
                            </div>
                        </div> <!---->
                        <footer><label class="reset" onclick="resetNum(this)">
                            重置
                        </label> <label class="submit" onclick="searchNum(this)">
                            搜索
                        </label></footer>
                    </div>
                </div>
                <div id="anyNumDiv" class="swiper-no-swiping swiper-slide swiper-slide-next" style="width: 360px;">
                    <div class="content"><p>*11位手机号码任意位置匹配数字搜索</p>
                        <div class="mobile-input">
                            <div class="blurry"><label>
                         <%--       <svg slot="icon-active" aria-hidden="true" class="icon serched">
                                    <use xlink:href="#icon-serched"></use>
                                </svg>--%>
                                <input id="anyNumInp" type="tel" placeholder="请输入喜欢的数字" maxlength="11"> <!----></label></div>
                        </div> <!---->
                        <footer><label class="reset" onclick="resetNum(this)">
                            重置
                        </label> <label class="submit" onclick="searchNum(this)">
                            搜索
                        </label></footer>
                    </div>
                </div>
                <div id="endNumDiv" class="swiper-no-swiping swiper-slide" style="width: 360px;">
                    <div class="content"><p>*11位手机号码末尾数字匹配搜索</p>
                        <div class="mobile-input">
                            <div class="blurry"><label>
<%--                                <svg slot="icon-active" aria-hidden="true" class="icon serched">--%>
<%--                                    <use xlink:href="#icon-serched"></use>--%>
<%--                                </svg> <!---->--%>
                                <input id="endNumInp" type="tel" placeholder="请输入喜欢的数字" maxlength="11"></label></div>
                        </div> <!---->
                        <footer><label class="reset" onclick="resetNum(this)">
                            重置
                        </label> <label class="submit" onclick="searchNum(this)">
                            搜索
                        </label></footer>
                    </div>
                </div>
            </div>
            <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div> <!---->
    </div>
</div>
<%--</div>--%>
<div class="index_nr" style="padding-bottom:60px;">
    <!-- <ul id="contentId">
		<a href="javascript:;" onclick="showDetail('<%=path%>/video/wxVideoDetail?video.id=')">
			<li>
				<img src="<%=path%>/images/advtui.png" />
				<p class="index_p1">大爷年轻时一定是杂技团的 骑车等红灯从头到尾脚不沾地 </p>
                <span class="index_p3" style="left:23%;">
                    <span style="margin-left:10px;">6小时前</span>
                </span>
            </li>
        </a>
    </ul> -->
    <dvi id="ulid"></dvi>
    <div class="w94" id="note" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
</div>
<%-- <ul class="zhinan_xuanxiang" style="border-top:1px solid #c6c6c6;">
    <a href="<%=path%>/hyuser/wxMemberup?memLevel=<s:property value="user.memLevel"/>"><li><img src="<%=path%>/images/userup.png" /><br/>我要升级</li></a>
    <a href="<%=path%>/hyuser/wxTuiGuang?user.id=<s:property value="user.id" />"><li><img src="<%=path%>/images/usercode.png" /><br/>我的二维码</li></a>
    <a href="<%=path%>/hyuser/wxFans"><li><img src="<%=path%>/images/userfans.png" /><br/>我的粉丝</li></a>
    <a href="<%=path%>/hyuser/wxDeposit"><li><img src="<%=path%>/images/usershou.png" /><br />我的收入</li></a>
    <div class="clear"></div>
</ul> --%>
<!--
<div class="zhinan" style="height: 100px;">
    <a href="<%=path%>/hyuser/wxMemberup?memLevel=<s:property value="user.memLevel"/>"><p class="zhuanqianzhinan"><b>成为会员的好处 >></b></p></a>
</div>
-->
<!--底部导航-->
<div class="index_di2" style="
    width: 100%;
    height: 52px;
    background: #fff;
    border-top: 1px solid #DEDEDE;
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;">
    <a href="<%=path%>/hyuser/wxIndex">
        <div class="hong"><img src="<%=path%>/images/home_on.png"/><br/>首页</div>
    </a>
    <a href="<%=path%>/video/wxVideo?video.mainType=1">
        <div><img src="<%=path%>/images/ku.png"/><br/>推广库</div>
    </a>
    <a href="<%=path%>/hyuser/wxUserRelease">
        <div><img src="<%=path%>/images/set.png"/><br/>我的发布</div>
    </a>
    <a href="<%=path%>/hyuser/wxUserHuo">
        <div style="position:relative"><img src="<%=path%>/images/mine.png"/><br/>活跃用户</div>
    </a>
</div>
<script type="text/javascript">
    //轮播
    TouchSlide({
        slideCell: "#focus",
        titCell: ".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
        mainCell: ".bd ul",
        effect: "leftLoop",//“left”为不循环
        autoPlay: true,//自动播放
        autoPage: true, //自动分页
        switchLoad: "_src" //切换加载，真实图片路径为"_src"
    });

    $(function () {
        //time是时间间隔，num是行数（修改num时需要修改$('#FontScroll')对应css的高度）
        //$('#FontScroll').FontScroll({time: 3000,num: 1});
    });
    $('#scalNum').click(function () {
        $('#scalNum').attr("class","tab-item tab-selected");
        $('#anyNum').attr("class","tab-item marginleft");
        $('#endNum').attr("class","tab-item marginleft");
        $('#scalNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-active");
        $('#anyNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-next");
        $('#endNumDiv').attr("class","swiper-no-swiping swiper-slide");
        $('#scalNumDiv').parent().attr("style","transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;");
        searchType="scalNum"
    });
    $('#anyNum').click(function () {
        $('#scalNum').attr("class","tab-item");
        $('#anyNum').attr("class","tab-item marginleft tab-selected");
        $('#endNum').attr("class","tab-item marginleft");
        $('#scalNumDiv').attr("class","swiper-no-swiping swiper-slide");
        $('#anyNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-active");
        $('#endNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-next");
        $('#anyNumDiv').parent().attr("style","transform: translate3d(-360px, 0px, 0px); transition-duration: 0ms;");
        searchType="anyNum"
    });
    $('#endNum').click(function () {
        $('#scalNum').attr("class","tab-item");
        $('#anyNum').attr("class","tab-item marginleft");
        $('#endNum').attr("class","tab-item marginleft tab-selected");
        $('#scalNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-next");
        $('#anyNumDiv').attr("class","swiper-no-swiping swiper-slide");
        $('#endNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-active");
        $('#endNumDiv').parent().attr("style","transform: translate3d(-720px, 0px, 0px); transition-duration: 0ms;");
        searchType="endNum"
    });

    // <div id="scalNum"  class="tab-item tab-selected">精准搜号</div>
    //     <div id="anyNum" class="tab-item marginleft">任意搜号</div>
    //     <div id="endNum" class="tab-item marginleft">末位搜号</div>
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
    function gotoUrl(url) {
        location.href = url;
    }
    $(function () {
        var txts = $(".accurate input");
        console.log("txts---------"+txts.length);
        for (var i = 1; i < txts.length; i++) {
            console.log("1---------"+i);
            var t = txts[i];
            t.index = i;
            // t.setAttribute("readonly", true);
            t.onClick = function(){
                this.removeAttribute("readonly");
            }
            t.onkeyup = function() {
                console.log("2---------"+i);
                this.value = this.value.replace(/^(.).*$/, '$1');
                var next = this.index + 1;
                if (next > txts.length - 1) return;
                // txts[next].removeAttribute("readonly");
                txts[next].focus();
            }
        }
        // txts[1].removeAttribute("readonly");
        console.log("3---------"+i);
    });
</script>
</body>
</html>