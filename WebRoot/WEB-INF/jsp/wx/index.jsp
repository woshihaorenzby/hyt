﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
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
    <title>选卡网</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/style.css?v=4" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/app.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/secList.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.cookie.js"></script>
    <style type="text/css">
        body {
            background: #F3F3F3;
        }
        .fillter1_item{
            width: 20%;

        }
        .on{
            color: #ff5200 !important;
        }
        .pullDown{
            display: none;
        }
        .home-wrapper{
            height: 700px;
        }
        .fillter_content{
            position:absolute ;
            z-index: 999;
            width: 100%;
            background-color: #fff;
        }
        .w94{ position:absolute;}
        .operators-ul span{
            margin-left:45%
        }
    </style>
    <script type="text/javascript">
        var curPage = 1;
        var pageRecordCount = 10;
        var uploadSuc = false;
        var upload = false;
        var meiWid = 0;
        var itemnum = 0;
        var searchType = "scalNum";
        var number = "";
        $(function () {
            loadData();
            $(window).bind("scroll", col_scroll);
            $.ajax({
                type: "post",
                url: "<%=path%>/hyuser/wxIndexType",
                dataType: "json",
                data: "",
                success: function (data) {
                    var pinWidth = window.screen.availWidth;
                    meiWid = (pinWidth - 10) / 5;

                    if (data != null && data.length > 0) {
                        $("#soldiv").css("display", "block");
                        var appStr = "";
                        for (var i = 0; i < data.length; i++) {
                            appStr += "<div  onclick=\"gotoTypeUrl('" + data[i].webUrl + "', '" + data[i].webUrl + "')\"><img style=\"width:35px;height:35px;\" src=\"<%=path%>" + data[i].typeImg + "\"/><br/>" + data[i].typeName + "</div>";
                        }
                        $(".tuiguang_xuanxiang").append(appStr);
                        var num = data.length / 2;
                        num = num.toFixed(0);
                        itemnum = num;
                        var w = ((num * meiWid) + 20) > $(".tuiguang_xuanxiang").parent().width() ? ((num * meiWid) + 20 + "px") : "100%";
                        var chw = ((pinWidth * 100 / num * meiWid)).toFixed(0);
                        if (chw < 1) {
                            chw = 1;
                        }
                        var totalWid = $("#soldivnei").width();
                        $("#soldivnei").css("width", totalWid / chw + "px");
                    }
                }
            });
            $(".fillter1_item").on("click",function() {
                let index =$('.fillter1_item').index(this);
                if($(".pullDown :eq("+index+")").is(":hidden")){
                    $(".pullDown").hide();
                    $(".pullDown :eq("+index+")").show();
                    if(index===1){//区域

                    }
                }else{
                    $(".pullDown").hide();
                }
            });
            $(".operators-ul li").on("click",function () {
                $(".operators-ul li").removeClass("on");
                $(this).addClass("on");
                $("#operators").addClass("on");
                $("#operators").html($(this).text());
                $(".pullDown").hide();
                curPage = 1;
                loadData();
                $("#ulid").empty();

            });
        });
        $("#typediv").scroll(function () {
            var gun = $(this).scrollLeft();
            var chw = 1 - (gun * 100 / (itemnum * meiWid)).toFixed(0) / (window.screen.availWidth);
            $("#soldivnei").css("left", chw + "%");
        });
        $("#ulid").scroll(function () {
            var gun = $(this).scrollLeft();
            $("#ulid").css("left", "20%");
        });
            var txts = $(".accurate input");
            for (var i = 1; i < txts.length; i++) {
                var t = txts[i];
                t.index = i;
                t.onClick = function () {
                    this.removeAttribute("readonly");
                }
                t.onkeyup = function () {
                    this.value = this.value.replace(/^(.).*$/, '$1');
                    var next = this.index + 1;
                    if (next > txts.length - 1) return;
                    txts[next].focus();
                }
            };


            function searchNum(e) {
                curPage = 1;
                loadData(number, searchType);
                $("#ulid").empty();
            }
            function loadData() {
                if (searchType == "scalNum") {
                    var txts = $(".accurate input");
                    number = "1";
                    for (var i = 1; i < txts.length; i++) {
                        var t = $(txts[i]).val();
                        if (t != null && t != "") {
                            number = number + t;
                        } else {
                            number = number + "_";
                        }
                    }
                } else if (searchType == "anyNum") {
                    var txts = $("#anyNumInp");
                    number = txts.val();
                } else if (searchType == "endNum") {
                    var txts = $("#endNumInp");
                    number = txts.val();
                }
                if (number != null && number != "") {
                    if (number == "undefined") {
                        number = "";
                    }
                }
                //运营商
                let operator = $(".operators-ul li.on").attr("data-id");
                $("#note").show();
                $.ajax({
                    type: "post",
                    url: "<%=path%>/wxMobileSale/wxMobileSaleMainList",
                    dataType: "json",
                    data: {
                        "page.curPage": curPage,
                        "page.pageRecordCount": pageRecordCount,
                        "mobileSale.hasSale": 0,
                        "mobileSale.mobileNum": number,
                        "mobileSale.searchType": searchType,
                        "mobileSale.operator":operator
                    },
                    success: function (data) {
                        $("#note").hide();
                        if (data != null && data.length > 0) {
                            var appStr = "";
                            for (var i = 0; i < data.length; i++) {
                                let operatorStr= "联通";
                                let operator = data[i].operator+'';
                                switch (operator) {
                                    case '0':
                                        operatorStr= "移动";
                                        break;
                                    case '2':
                                        operatorStr= "电信";
                                        break;
                                    case '3':
                                        operatorStr= "虚商";
                                        break;
                                }
                                appStr += "<ul >";
                                appStr += "<a href=\"javascript:;\" onclick=\"showDetail('<%=path%>/wxMobileSale/wxMobileSaleDetail?mobileSale.id=" + data[i].id + "')\">";
                                appStr += "<li style='height: 8.533vw'>";
                                appStr += "<span class=\"index_p1\" >";
                                appStr += "<span >" + data[i].mobileNum + "</span>";
                                appStr += "</span>";
                                appStr += "<span class=\"index_p1\">";
                                appStr += "<span >" + data[i].province + data[i].city + "</span>";
                                appStr += "</span>";
                                appStr += "<span class=\"index_p1\" >";
                                appStr += "<span >" + operatorStr + "</span>";
                                appStr += "</span>";
                                appStr += "<span class=\"index_p1\" >";
                                appStr += "<span style=\"color: #e54c3f\" >" + "￥" + data[i].price + "</span>";
                                appStr += "</span>";
                                appStr += "</li>";
                                appStr += "</a>";
                                appStr += "</ul>";
                            }
                            $("#ulid").append(appStr);
                        } else {
                            var noMuch = $("#noMuch").text();
                            if (noMuch == null||noMuch=='') {
                                appStr = "<span id= 'noMuch' style=\"text-align: center;display:block;margin-top:20px;color: #949494;\">没有更多数据了</span>";
                                $("#ulid").append(appStr);
                            }
                        }
                    }
                });
            }
            function resetNum(e) {
                curPage = 1;
                if (searchType == "scalNum") {
                    var txts = $(".accurate input");
                    for (var i = 1; i < txts.length; i++) {
                        var t = $(txts[i]);
                        t.val("");
                    }
                } else if (searchType == "anyNum") {
                    var txts = $("#anyNumInp");
                    txts.val("");
                } else if (searchType == "endNum") {
                    var txts = $("#endNumInp");
                    txts.val("");
                }
                number = "";
                loadData();
                $("#ulid").empty();
            }



            //下拉到底部加载更多数据
            //加载函数
            function findData() {
                curPage++;
                upload = false;
                loadData();
            }

            function showDetail(url) {
                window.open(url, "_self");
            }

            function gotoTypeUrl(typeName, webUrl) {
                window.open(webUrl, "_self");
            }

            let col_scroll = function () {
                if ($(document).height() - $(this).scrollTop() - $(this).height() < 20 &&!upload) {
                    if (!uploadSuc && !upload) {
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
    <div class="tuiTileCenter">选卡网</div>
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
                            src="<%=path%><s:property value="imagePath" />"/></a></li>
                </s:iterator>
            </ul>
        </div>
    </div>
    <div id="typediv" style="width: 100%;height:auto;overflow-x:scroll">
        <div class="tuiguang_xuanxiang">

        </div>
    </div>

    <div id="soldiv" style="background:white;padding-bottom:5px;display:none;">
        <div style="position:relative;margin-left:auto;margin-right:auto;width: 81%;background:#f3f3f3;height:3px;">
            <div id="soldivnei" style="position:absolute;left:0px;width: 81%;background:#fb543e;height:3px;">

            </div>
        </div>
    </div>
    <div data-v-2a84ec57="" class="card">
        <div data-v-2a84ec57="" class="selecter">
            <div class="tab">
                <div id="scalNum" class="tab-item tab-selected">精准搜号</div>
                <div id="anyNum" class="tab-item marginleft">任意搜号</div>
                <div id="endNum" class="tab-item marginleft">末位搜号</div>
            </div>
            <div class="swiper-container swiper-container-horizontal">
                <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
                    <div id="scalNumDiv" class="swiper-no-swiping swiper-slide swiper-slide-active"
                         style="width: 100%;">
                        <div class="content"><p>*请在指定位置上填写数字，无要求的位置可留空</p>
                            <div class="mobile-input">
                                <div class="accurate">
                                    <input type="tel" disabled="disabled" maxlength="1" value="1">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                    <input type="tel" maxlength="1" autocomplete="false" autocorrect="off"
                                           autocapitalize="off" spellcheck="false">
                                </div>
                            </div> <!---->
                            <footer><label class="reset" onclick="resetNum(this)">
                                重置
                            </label> <label class="submit" onclick="searchNum(this)">
                                搜索
                            </label></footer>
                        </div>
                    </div>
                    <div id="anyNumDiv" class="swiper-no-swiping swiper-slide swiper-slide-next" style="width: 100%;">
                        <div class="content"><p>*11位手机号码任意位置匹配数字搜索</p>
                            <div class="mobile-input">
                                <div class="blurry"><label>
                                    <input id="anyNumInp" type="tel" placeholder="请输入喜欢的数字" maxlength="11"> <!---->
                                </label></div>
                            </div> <!---->
                            <footer><label class="reset" onclick="resetNum(this)">
                                重置
                            </label> <label class="submit" onclick="searchNum(this)">
                                搜索
                            </label></footer>
                        </div>
                    </div>
                    <div id="endNumDiv" class="swiper-no-swiping swiper-slide" style="width: 100%;">
                        <div class="content"><p>*11位手机号码末尾数字匹配搜索</p>
                            <div class="mobile-input">
                                <div class="blurry"><label>
                                    <input id="endNumInp" type="tel" placeholder="请输入喜欢的数字" maxlength="11"></label>
                                </div>
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
    <div class="index_nr" >
        <div  id="fixBox">
            <div class="fillter_title">
                <div class="fillter1">
                    <div class="fillter1_item">
                        <div class="fillter1_text">
                            <span id="operators">运营商</span>
                        </div>
                    </div>
                    <div class="fillter1_item">
                        <div class="fillter1_text">
                            <span class="a">归属地</span>
                        </div>
                    </div>
                    <div class="fillter1_item">
                        <div class="fillter1_text">
                            <span>规律</span>
                        </div>
                    </div>
                    <div class="fillter1_item">
                        <div class="fillter1_text borderrn">
                            <span>更多</span>
                        </div>
                    </div>
                    <div class="fillter1_item">
                        <div class="fillter1_text borderrn">
                            <span>排序</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="fillter_content">
            <div  class="pullDown">
                <div class="single">
                    <div  class="pullDown-group operators"
                         style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);">
                        <ul  class="pull-ul operators-ul" style="pointer-events: auto;">
                            <li class="pull-li on" data-id="-1"><span>不限</span></li>
                            <li class="pull-li" data-id="0"><span>移动</span></li>
                            <li class="pull-li" data-id="1"><span>联通</span></li>
                            <li class="pull-li" data-id="2"><span>电信</span></li>
                            <li class="pull-li" data-id="3"><span>虚商</span></li>
                        </ul>
                    </div>
                </div>
            </div>
                <div class="pullDown">
                    <div class="single">
                        <div  class="pullDown-group areas"
                              style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);">
                            <ul  id="province-ul" class="pull-ul province-ul" style="pointer-events: auto;">
                                <li class="pull-li is-select"><span>不限</span></li>
                            </ul>
                            <ul id = "city-ul"  class="pull-ul city-ul" style="pointer-events: auto;">
                                <li class="pull-li is-select"><span>不</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="pullDown">
                    <div class="single">
                        <div  class="pullDown-group"
                              style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);">
                            <ul  class="pull-ul province" style="pointer-events: auto;">
                            </ul>
                            <ul  class="pull-ul city" style="pointer-events: auto;">
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="pullDown">
                    <div class="single">
                        <div  class="pullDown-group"
                              style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);">
                            <ul  class="pull-ul" style="pointer-events: auto;">
                                <li class="pull-li is-select">不</li>
                                <li class="pull-li">移</li>
                                <li class="pull-li">联</li>
                                <li class="pull-li">电信</li>
                                <li class="pull-li">虚商</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="pullDown">
                    <div class="single">
                        <div  class="pullDown-group"
                              style="transition-timing-function: cubic-bezier(0.165, 0.84, 0.44, 1); transition-duration: 0ms; transform: translate(0px, 0px) scale(1) translateZ(0px);">
                            <ul  class="pull-ul" style="pointer-events: auto;">
                                <li class="pull-li is-select">不</li>
                                <li class="pull-li">移</li>
                                <li class="pull-li">联</li>
                                <li class="pull-li">电</li>
                                <li class="pull-li">虚商</li>
                            </ul>
                        </div>
                    </div>
                </div>
        </div>
    </div>
        <div class="w94" id="note" style="text-align:center;vertical-align:middle;display:none"><img
                src="<%=path%>/images/loader.gif"/></div>
    </div>
    <div class="index_nr ulid-div" style=" overflow-y:scroll; width:100%; height:400px;" >
        <dvi id="ulid" ></dvi>

    </div>

        <!--底部导航-->
    <div class="index_di2" style="
    width: 100%;
    height: 52px;
    background: #fff;
    border-top: 1px solid #DEDEDE;
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 999;
">
        <a href="<%=path%>/hyuser/wxIndex" style="width: 33.3%">
            <div class="hong"><img src="<%=path%>/images/home_on.png"/><br/>首页</div>
        </a>
        <a href="<%=path%>/wxMobileSale/wxCollectionNums" style="width: 33.3%">
            <div><img src="<%=path%>/images/ku.png"/><br/>收藏夹</div>
        </a>
        <a href="<%=path%>/wxMobileSale/wxConsultation?qr.type=2" style="width: 33.3%">
            <div style="position:relative"><img src="<%=path%>/images/mine.png"/><br/>咨询</div>
        </a>
    </div>
    <script type="text/javascript">

        $(function () {
            //time是时间间隔，num是行数（修改num时需要修改$('#FontScroll')对应css的高度）
            //$('#FontScroll').FontScroll({time: 3000,num: 1});

                if($(".hd ul li").length>0){
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
                }
        });

        $('#scalNum').click(function () {
            $('#scalNum').attr("class", "tab-item tab-selected");
            $('#anyNum').attr("class", "tab-item marginleft");
            $('#endNum').attr("class", "tab-item marginleft");
            $('#scalNumDiv').attr("class", "swiper-no-swiping swiper-slide swiper-slide-active");
            $('#anyNumDiv').attr("class", "swiper-no-swiping swiper-slide swiper-slide-next");
            $('#endNumDiv').attr("class", "swiper-no-swiping swiper-slide");
            $('#scalNumDiv').parent().attr("style", "transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;");
            searchType = "scalNum"
        });
        $('#anyNum').click(function () {
            $('#scalNum').attr("class", "tab-item");
            $('#anyNum').attr("class", "tab-item marginleft tab-selected");
            $('#endNum').attr("class", "tab-item marginleft");
            $('#scalNumDiv').attr("class", "swiper-no-swiping swiper-slide");
            $('#anyNumDiv').attr("class", "swiper-no-swiping swiper-slide swiper-slide-active");
            $('#endNumDiv').attr("class", "swiper-no-swiping swiper-slide swiper-slide-next");
            $('#anyNumDiv').parent().attr("style", "transform: translate3d(-100%, 0px, 0px); transition-duration: 0ms;");
            searchType = "anyNum"
        });
        $('#endNum').click(function () {
            $('#scalNum').attr("class", "tab-item");
            $('#anyNum').attr("class", "tab-item marginleft");
            $('#endNum').attr("class", "tab-item marginleft tab-selected");
            $('#scalNumDiv').attr("class", "swiper-no-swiping swiper-slide swiper-slide-next");
            $('#anyNumDiv').attr("class", "swiper-no-swiping swiper-slide");
            $('#endNumDiv').attr("class", "swiper-no-swiping swiper-slide swiper-slide-active");
            $('#endNumDiv').parent().attr("style", "transform: translate3d(-200%, 0px, 0px); transition-duration: 0ms;");
            searchType = "endNum"
        });
        function Allsc() {
            $("#homeContent").css("height", window.innerHeight);
            var $w = document.body.clientWidth;
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

        });

    </script>
</body>
</html>