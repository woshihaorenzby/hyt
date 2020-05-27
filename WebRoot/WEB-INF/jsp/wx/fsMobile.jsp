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
    <title>选卡网-微信推广神器</title>
    <link href="<%=path%>/css/wx/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/alongsty.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/style.css?v=4" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/wx/app.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/kendo.core.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/fontscroll.js"></script>
    <script type="text/javascript" src="<%=path%>/js/wx/TouchSlide.1.1.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="<%=path%>/js/area.js"></script>
    <style type="text/css">
        body {
            background: #F3F3F3;
        }
        .filterCheckbox{
            height:6px;
        }
        .select {
            display: inline-block;
            width: 300px;
            position: relative;
            vertical-align: middle;
            padding: 0;
            overflow: hidden;
            background-color: #fff;
            color: #555;
            border: 1px solid #aaa;
            text-shadow: none;
            border-radius: 4px;
            transition: box-shadow 0.25s ease;
            z-index: 2;
        }

        .select:hover {
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
        }

        .select:before {
            content: "";
            position: absolute;
            width: 0;
            height: 0;
            border: 10px solid transparent;
            border-top-color: #ccc;
            top: 14px;
            right: 10px;
            cursor: pointer;
            z-index: -2;
        }
        .select select {
            cursor: pointer;
            padding: 10px;
            width: 100%;
            border: none;
            background: transparent;
            background-image: none;
            -webkit-appearance: none;
            -moz-appearance: none;
        }

        .select select:focus {
            outline: none;
        }
        div .searchContent{
            margin-top: -15px;
        }
        .searchContent .mobile-input{
            margin-top: 10px;
        }

    </style>
    <script type="text/javascript">
        var curPage = 1;
        var pageRecordCount = 5;
        var uploadSuc = false;
        var upload = false;
        var meiWid = 0;
        var itemnum = 0;
        var searchType = "scalNum";
        var number="";
        $(function () {
            $("input[type=radio][name=operate][value='-1']").prop("checked", true);
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
                            appStr += "<div style='width:"+meiWid+"px;' onclick=\"gotoTypeUrl('"+data[i].webUrl+"', '"+data[i].webUrl+"')\"><img style=\"width:35px;height:35px;\" src=\"<%=path%>"+data[i].typeImg+"\"/><br/>"+data[i].typeName+"</div>";
                        }
                        $(".tuiguang_xuanxiang").append(appStr);
                        var num = data.length/2;
                        num = num.toFixed(0);
                        itemnum = num;
                        var w = ((num*meiWid)+20)>$(".tuiguang_xuanxiang").parent().width()?((num*meiWid)+20+"px"):"100%";
                        $(".tuiguang_xuanxiang").css("width",w);
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
            addressInit("province","city","","请选择","请选择");
        });
        function  searchNum(e) {
            console.log(e);
            curPage= 1;
            loadData(number,searchType);
            $("#ulid").empty();
        }
        function  resetNum(e) {
            location.reload();
        }
        function loadData() {
            if(searchType=="scalNum"){
                var txts = $(".accurate input");
                number = "1";
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
            let operator =  $("input[name='operate']:radio:checked").val();
            let province =  $("#province").val()!="请选择所在省"?$("#province").val():"";
            let city =  $("#city").val()!="请选择所在市"?$("#province").val():"";
            let val = $("#price").find("option:selected").val();
            let startPrice = null;
            let endPrice = null;
            if(val!=null&&val!=undefined){
                let p = val.split("-");
                startPrice= p[0]!=null&&p[0]!=''&&p[0]!='不限'?p[0]:null;
                endPrice= p[1]!=null&&p[1]!=''&&p[1]!='不限'?p[1]:null;
            }
            let order = "";
            let orderBy = "";
            let order_by = $("#order_by").find("option:selected").val()+'';
            if(order_by=='0'){
                order='asc';
                orderBy = "price";
            }
            if(order_by=='1'){
                order='desc';
                orderBy = "price";
            }
            let preference = [];
            let preferenceStr ="";
            $("input[name='preference']:checkbox").each(function(index) {
                if ($(this).prop("checked") === true) {
                    preference.push($(this).val());
                }
            });
            preferenceStr = preference.join(",");
            let law = null;
            if($("#law").val()!=null&&$("#law").val()!=undefined){
                law = $("#law").val();
            }
            $("#note").show();
            $.ajax({
                type: "post",
                url: "<%=path%>/wxMobileSale/wxMobileSaleMainList",
                dataType: "json",
                data: {
                    "page.curPage": curPage,
                    "page.pageRecordCount" : pageRecordCount,
                    "page.order" : order,
                    "page.orderBy" : orderBy,
                    "mobileSale.hasSale":0,
                    "mobileSale.free":2,
                    "mobileSale.mobileNum":number,
                    "mobileSale.searchType":searchType,
                    "mobileSale.operator":operator,
                    "mobileSale.province":province,
                    "mobileSale.city":city,
                    "mobileSale.startPrice":startPrice,
                    "mobileSale.endPrice":endPrice,
                    "mobileSale.preferenceStr":preferenceStr,
                    "mobileSale.law":law,
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
                            appStr += "<a href=\"javascript:;\" onclick=\"showDetail('<%=path%>/wxMobileSale/wxMobileSaleDetail?mobileSale.id="+data[i].id+"')\">";
                            appStr += "<li style='height: 8.533vw'>";
                            appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                            appStr += "<span style=\"margin-left:10px;\">" + data[i].mobileNum + "</span>";
                            appStr += "</span>";
                            appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                            appStr += "<span style=\"margin-left:30px;\">" + data[i].province+data[i].city + "</span>";
                            appStr += "</span>";
                            appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                            appStr += "<span style=\"margin-left:30px;\">" + operatorStr + "</span>";
                            appStr += "</span>";
                            appStr += "<span class=\"index_p1\" style=\"left:23%;\">";
                            appStr += "<span style=\"margin-left:20px;color: #e54c3f\" >" +  "￥"+data[i].price + "</span>";
                            appStr += "</span>";
                            appStr += "</li>";
                            appStr += "</a>";
                            appStr += "</ul>";
                        }
                        $("#ulid").append(appStr);
                    }else{
                        var noMuch = $("#noMuch").text();
                        if (noMuch == null||noMuch=='') {
                            appStr = "<span id= 'noMuch' style=\"text-align: center;display:block;margin-top:20px;color: #949494;\">没有更多数据了</span>";
                            $("#ulid").append(appStr);
                        }
                    }
                }
            });
        }
        function  searchNum(e) {
            console.log(e);
            curPage= 1;
            loadData(number,searchType);
            $("#ulid").empty();
        }
        function  resetNum(e) {
            location.reload();
        }

        //下拉到底部加载更多数据
        //加载函数
        function findData(){
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
        var col_scroll = function(){
            if($(document).height() - $(this).scrollTop() - $(this).height() < 20 &&!upload){
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
    <div class="tuiTileCenter">风水能量号</div>
</div>

<div data-v-2a84ec57="" id="homeWrapper" class="home-wrapper child-view" style="top:2px">
    <div data-v-2a84ec57="" class="card">
        <div data-v-2a84ec57="" class="selecter" style="margin-top:50px">
            <div class="tab">
                <div id="scalNum"  class="tab-item tab-selected">精准搜号</div>
                <div id="anyNum" class="tab-item marginleft">任意搜号</div>
                <div id="endNum" class="tab-item marginleft">末位搜号</div>
            </div>
            <div class="swiper-container swiper-container-horizontal">
                <div  class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
                    <div id="scalNumDiv" class="swiper-no-swiping swiper-slide swiper-slide-active" style="width:100%;">
                        <div class="content searchContent" style="margin-top:-15px"><p>*请在指定位置上填写数字，无要求的位置可留空</p>
                            <div class="mobile-input" style="margin-top:10px">
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
                            </div>
                        </div>
                    </div>
                    <div id="anyNumDiv" class="swiper-no-swiping swiper-slide swiper-slide-next" style="width:100%;">
                        <div class="content searchContent"><p>*11位手机号码任意位置匹配数字搜索</p>
                            <div class="mobile-input">
                                <div class="blurry"><label>
                                    <input id="anyNumInp" type="tel" placeholder="请输入喜欢的数字" maxlength="11"> <!----></label></div>
                            </div>
                        </div>
                    </div>
                    <div id="endNumDiv" class="swiper-no-swiping swiper-slide" style="width: 100%;">
                        <div class="content searchContent"><p>*11位手机号码末尾数字匹配搜索</p>
                            <div class="mobile-input">
                                <div class="blurry"><label>
                                    <input id="endNumInp" type="tel" placeholder="请输入喜欢的数字" maxlength="11"></label></div>
                            </div> <!---->

                        </div>
                    </div>
                </div>
                <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                <div class="filter" style="margin-top:0px;background: white">
                    <div class="long" style="margin-top:-3px"><span>运营商</span>
                        <div class="filterRadio">
                            <div><input type="radio" id="01" hidden="hidden" value="-1" name="operate" checked="checked"> <label for="01">
                                不限</label></div>
                            <div><input type="radio" id="11" hidden="hidden" value="0" name="operate"> <label for="11">
                                移动</label></div>
                            <div><input type="radio" id="21" hidden="hidden" value="1" name="operate"> <label for="21">
                                联通</label></div>
                            <div><input type="radio" id="31" hidden="hidden" value="2" name="operate"> <label for="31">
                                电信</label></div>
                            <div><input type="radio" id="41" hidden="hidden" value="3" name="operate"> <label for="41">
                                虚商</label></div>
                        </div>
                    </div>
                    <div style="width:98%;margin-top:-3px"><span>归属地</span>
                        <select class="select" id="province" style="width:49%;background-color: ghostwhite; text-align:center;text-align-last:center;" ></select>
                        <select class="select" id="city" style="width:49%;background-color: ghostwhite; text-align:center;text-align-last:center;"></select>
                    </div>
                    <div style="width:98%;margin-top:-3px "><span>规律</span>
                        <select class="select" id="law" style="width:98%;background-color: ghostwhite; text-align:center;text-align-last:center;" >
                            <option class="van-ellipsis van-picker-column__item van-picker-column__item--selected"
                                    style="height: 44px;">不限
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AAAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AAAAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAAA+
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AAABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AAAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AABBCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAAAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAAAAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数ABBA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数AAAAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数ABAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABCDABCD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数连续ABCDE+
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数ABCDE
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAABCCCCD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABBBCCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AABBCCDD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABCCCD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AABBCDDD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABCDDD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABBBCDDD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AABBCCCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABCCCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABBBCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABCCCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABAAAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABBBBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAABAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAAABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAABBBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABBBABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AABBABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABABAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间ABABABAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AAAABBBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAAABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABBBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAAABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数AAABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABABA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABCABC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABCDEABCDE
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABACADAE
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数ABCD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">尾数连续ABC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABCDDCBA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABCDAABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                尾数ABABACAC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AAABBBCCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AABBCCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AAAAAAA+
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AAABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AABBCC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间AAAAAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">中间AAAAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">中间AABBB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">中间AAABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">中间AABB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">中间AAAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间ABCDABCD
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间ABABABA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间ABCABC
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间ABABAB
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">中间AAA
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间连续ABCDE+
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间连续ABCDE
                            </option>
                            <option class="van-ellipsis van-picker-column__item" style="height: 44px;">
                                中间连续ABCD
                            </option>
                        </select>
                    </div>
                    <div><span>价格</span>
                        <select class="select" id="price" style="width:67%;background-color: ghostwhite; text-align:center;text-align-last:center; margin-left:-5px">
                            <option class="van-ellipsis van-picker-column__item van-picker-column__item--selected"
                                    style="height: 44px;" value="不限-不限">不限
                            </option>
                            <option class="van-ellipsis van-picker-column__item" value="0-100" style="height: 44px;">100以下</option>
                            <option class="van-ellipsis van-picker-column__item" value="100-200" style="height: 44px;">100-200</option>
                            <option class="van-ellipsis van-picker-column__item" value="200-300" style="height: 44px;">200-300</option>
                            <option class="van-ellipsis van-picker-column__item" value="300-500" style="height: 44px;">300-500</option>
                            <option class="van-ellipsis van-picker-column__item" value="500-1000" style="height: 44px;">500-1000</option>
                            <option class="van-ellipsis van-picker-column__item" value="1000-2000" style="height: 44px;">1000-2000
                            </option>
                            <option class="van-ellipsis van-picker-column__item" value="2000-5000" style="height: 44px;">2000-5000
                            </option>
                            <option class="van-ellipsis van-picker-column__item" value="5000-10000" style="height: 44px;">5000-1万</option>
                            <option class="van-ellipsis van-picker-column__item" value="10000-20000" style="height: 44px;">1万-2万</option>
                            <option class="van-ellipsis van-picker-column__item" value="20000-30000" style="height: 44px;">2万-3万</option>
                            <option class="van-ellipsis van-picker-column__item" value="30000-50000" style="height: 44px;" >3万-5万</option>
                            <option class="van-ellipsis van-picker-column__item" value="50000-不限" style="height: 44px;">5万以上</option>
                        </select>
                    </div>
                    <div><span>排序</span>
                        <select class="select" id="order_by" style="width:67%;background-color: ghostwhite; text-align:center;text-align-last:center;">
                            <option class="van-ellipsis van-picker-column__item van-picker-column__item--selected"
                                    style="height: 44px;" value="-1">默认排序
                            </option>
                            <option class="van-ellipsis van-picker-column__item" value="0"  style="height: 44px;">价格从高到低</option>
                            <option class="van-ellipsis van-picker-column__item" value="1"  style="height: 44px;">价格从低到高</option>
                        </select>
                    </div>
                    <div class="long" style="margin-top:-15px"><span>偏好</span>
                        <div class="filterCheck" style="margin:10px">
                            <div class="filterCheckbox"><label><input type="checkbox" name="test"
                                                                      hidden="hidden">
                                <input type="checkbox" class="checkbox" value="3" name="preference">
                                <span>不含3</span></label></div>
                            <div class="filterCheckbox"><label><input type="checkbox" name="test"
                                                                      hidden="hidden">
                                <input type="checkbox" class="checkbox" value="4" name="preference">
                                <span>不含4</span></label></div>
                            <div class="filterCheckbox"><label><input type="checkbox" name="test"
                                                                      hidden="hidden">
                                <input type="checkbox" class="checkbox" value="7" name="preference">
                                <span>不含7</span></label></div>
                        </div>
                    </div>
                    <span class="content">
                <footer style="margin-top: -6.133vw;padding: 0 5vw;"><label class="reset" onclick="resetNum(this)">
                    重置
                </label> <label class="submit" onclick="searchNum(this)">
                    搜索
                </label></footer>
                </span>
                </div>

            </div> <!---->
        </div>

    </div>
    <div class="index_nr" >
        <dvi id="ulid"></dvi>
        <div class="w94" id="note" style="text-align:center;vertical-align:middle;display:none"><img src="<%=path%>/images/loader.gif" /></div>
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
    bottom: 0;">
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
            $('#anyNumDiv').parent().attr("style","transform: translate3d(-100%, 0px, 0px); transition-duration: 0ms;");
            searchType="anyNum"
        });
        $('#endNum').click(function () {
            $('#scalNum').attr("class","tab-item");
            $('#anyNum').attr("class","tab-item marginleft");
            $('#endNum').attr("class","tab-item marginleft tab-selected");
            $('#scalNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-next");
            $('#anyNumDiv').attr("class","swiper-no-swiping swiper-slide");
            $('#endNumDiv').attr("class","swiper-no-swiping swiper-slide swiper-slide-active");
            $('#endNumDiv').parent().attr("style","transform: translate3d(-200%, 0px, 0px); transition-duration: 0ms;");
            searchType="endNum"
        });

        function Allsc() {
            $("#homeContent").css("height", document.body.clientHeight+10);
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
            var txts = $(".accurate input");
            for (var i = 1; i < txts.length; i++) {
                var t = txts[i];
                t.index = i;
                t.onClick = function(){
                    this.removeAttribute("readonly");
                }
                t.onkeyup = function() {
                    this.value = this.value.replace(/^(.).*$/, '$1');
                    var next = this.index + 1;
                    if (next > txts.length - 1) return;
                    txts[next].focus();
                }
            }
        });
    </script>
</body>
</html>