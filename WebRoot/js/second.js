/**
 * Created by Lyn on 2017/10/25.
 */
var page = 1, status = "true";
$(function () {
    var links = window.location.href;
    links = decodeURIComponent(decodeURIComponent(links));
    if (links.indexOf("search") > 0) {
        subName = links.substr(links.indexOf("search=") + 7)
        $("#search").val(subName);
    }
    var more1 = $("#more1").val();
    var more2 = $("#more2").val();
    var more5 = $("#more5").val();
    var more6 = $("#more6").val();
    if(typeof(more1) != "undefined" && more1 != null && more1 != ''){
        var value = more1.split(',');
        for(var j=0 ; j<value.length; j++){
           $(".more1 li").each(function () {
                   if($(this).attr("data-id") == value[j]){
                       $(this).addClass('active');
                   }
           });
           //外部地铁房、南北通透筛选
            $(".outside a").each(function(){
                if($(this).attr("data-id") == value[j] && $(this).attr("data-id") != 3){
                    $(this).addClass('active');
                }
            });
        }
        $(".fillter1_item:eq(3) span").css("color", "#ff5200");
    }
    if(typeof(more2) != "undefined" && more2 != null && more2 != ''){
        var value = more2.split(',');
        for(var j=0 ; j<value.length; j++){
            $(".more2 li").each(function () {
                if($(this).attr("data-id") == value[j]){
                    $(this).addClass('active');
                }
            });
        }
        $(".fillter1_item:eq(3) span").css("color", "#ff5200");
    }
    if(typeof(more5) != "undefined" && more5 != null && more5 != ''){
        var value = more5.split(',');
        for(var j=0 ; j<value.length; j++){
            $(".more5 li").each(function () {
                if($(this).attr("data-id") == value[j]){
                    $(this).addClass('active');
                }
            });
        }
        $(".fillter1_item:eq(3) span").css("color", "#ff5200");
    }
    if(typeof(more6) != "undefined" && more6 != null && more6 != ''){
        var value = more6.split(',');
        for(var j=0 ; j<value.length; j++){
            $(".more6 li").each(function () {
                if($(this).attr("data-id") == value[j]){
                    $(this).addClass('active');
                }
            });
        }
        $(".fillter1_item:eq(3) span").css("color", "#ff5200");
    }
    var area = $(".arealist li.on").html();
    if(typeof(area) != "undefined" && area != null && area != ''){
        $(".areaItems li").removeClass("on");
        $(".areaItems li:eq(0)").addClass("on");
        if(area == '不限'){
            var region = $(".area li.on").html();
            if(typeof(region) != "undefined" && region != null && region != ''){
                $(".fillter1_item:eq(0) span").html(region).css("color", "#ff5200");
            }
        }else{
            $(".fillter1_item:eq(0) span").html(area).css("color", "#ff5200");
        }
    }
    var subwayStation = $(".subwaylist li.on").html();
    if(typeof(subwayStation) != "undefined" && subwayStation != null && subwayStation != ''){
        $(".areaItems li").removeClass("on");
        $(".areaItems li:eq(1)").addClass("on");
        if(subwayStation == '不限'){
            var subway = $(".subway li.on").html();
            if(typeof(subway) != "undefined" && subway != null && subway != ''){
                $(".fillter1_item:eq(0) span").html(subway).css("color", "#ff5200");
            }
        }else{
            $(".fillter1_item:eq(0) span").html(subwayStation).css("color", "#ff5200");
        }
    }
    var price = $(".type_block li.on").html();
    var minPrice=$(".min_p").val();
    var maxPrice=$(".max_p").val();
    if(typeof(price) != "undefined" && price != null && price != '' && price != '不限'){
        $(".fillter1_item:eq(1) span").html(price).css("color", "#ff5200");
    }else if(minPrice != '' && maxPrice != ''){
        $(".fillter1_item:eq(1) span").html(minPrice+"-"+maxPrice+"万").css("color", "#ff5200");
        $("#confirm_price").removeAttr("disabled");
        $("#confirm_price").css({"background":"#FF5200","color":"#fff"});
    }else if(minPrice != '' && maxPrice == ''){
        $(".fillter1_item:eq(1) span").html(minPrice+"万以上").css("color", "#ff5200");
        $("#confirm_price").removeAttr("disabled");
        $("#confirm_price").css({"background":"#FF5200","color":"#fff"});
    }else if(minPrice == '' && maxPrice != ''){
        $(".fillter1_item:eq(1) span").html(maxPrice == 0?'面议':maxPrice +"万以下").css("color", "#ff5200");
        $("#confirm_price").removeAttr("disabled");
        $("#confirm_price").css({"background":"#FF5200","color":"#fff"});
    }
    var priceType = $(".price_block li.on").html();
    if(typeof(priceType) != "undefined" && priceType != null && priceType != '' && priceType != '不限'){
        $(".fillter1_item:eq(2) span").html(priceType).css("color", "#ff5200");
    }
    var rent = $(".more3 li.active").html();
    var layout = $(".more4 li.active").html();
    if(typeof (rent) != "undefined" && rent !=null && rent !=''){
        $(".fillter1_item:eq(3) span").css("color", "#ff5200");
    }
    if(typeof (layout) != "undefined" && layout !=null && layout !=''){
        $(".fillter1_item:eq(3) span").css("color", "#ff5200");
    }
    //视频看房
    var url_k = window.location.href;
    if(url_k.indexOf('-W4')!= -1){
        $("#videoHouse").addClass("active");
    }

    //新房
    if(url_k.indexOf('-C1')!= -1){
        $("#newHouse").addClass("active");
    }
});
$(".fillter1_item").click(function () {
    var height = $(window).height();
    $(".fillter1").css({ "position": "absolute", "top": "41px" });
    $(".fillter1_select").css("top","127px");
    $("body").css("position","fixed")
    $("body").css("left","0")
    $("body").css("top","0")
    // $("body").css({"height":height,"overflow":"hidden"});
    var index = $(this).index();
    if($(".fillter1_text:eq(" + index + ")").find("span:eq(0)").hasClass("active")){
	   	$(".fillter1_text").find("span:eq(0)").removeClass("active");
	   	$(".fillter1_select").height(height).slideUp();
        // $(".fillter1").css({ "position": "static"});//点击筛选收回定位
	}else{
	   	$(".fillter1_text").find("span:eq(0)").removeClass("active");
	     $(".fillter1_text:eq(" + index + ")").find("span:eq(0)").addClass("active");
	     $(".fillter1_select").height(height).slideDown();
	};   
    switch (index) {
        case 0://区域
            $(".area_block").show();
            var show = $(".areaItems li.on").index();
            switch (show) {
                case 0: $(".area").show();
                    if($(".area li.on").text() == '不限'){
                        $(".area").removeClass("fillter_1").addClass("fillter_3");
                    }else{
                        $(".area").removeClass("fillter_3").addClass("fillter_1");
                        $(".arealist").show();
                    }
                    $(".subwaylist,.subway").hide();break;
                case 1: $(".subwaylist,.subway").show();
                    $(".subway").removeClass("fillter_3").addClass("fillter_1");
                    $(".arealist,.area").hide();break;
            }
            $(".type_block,.price_block,.more_block").hide();
            break;
        case 1://总价
            $(".type_block").show();
            $(".area_block,.price_block,.more_block").hide();
            break;
        case 2://户型
            $(".price_block").show();
            $(".area_block,.type_block,.more_block").hide();
            break;
        case 3://更多
            $(".layout").show();
            $(".more_block").show();
            $(".area_block,.type_block,.price_block").hide();
            break;
    }
    $(".fillter1_select").height(height).slideDown();
    $(".fillter1click").height(height - 320);
})
$(".fillter1click").click(function () {
    $(".fillter1_select").slideUp();
    $(".fillter1").attr("style", "");
    $("body").css("position","static")
    $("body").css("left","0")
    $("body").css("top","0")
    $(".fillter1_text").find("span:eq(0)").removeClass("active");
    $("body").css({"height":"auto","overflow":"auto"});
})
$(".areaItems li").click(function () {
    var index = $(this).index();
    $(".area,.areaItems,.subway").removeClass("wid3");
    $(".areaItems li").removeClass("on");
    $(this).addClass("on");
    $(".arealist,.subwaylist").hide();
    $(".areaItem").hide();
    $(".subwaylist li").removeClass("on");
    $(".subway li").removeClass("on");
    $(".areaItem:eq(" + index + ")").slideDown();
})
var areaclick = true;
$(".area li").on("click", function () {
    $(".area li").removeClass("on");
    if($(this).text() == '不限'){
        $(".arealist").find("li").removeClass("on");
        $(".subwaylist li").removeClass("on");
        $(".subway li").removeClass("on");
        $(".arealist").hide();
        $(this).addClass("on");
        $(".area,.areaItems,.subway").removeClass("wid3");
        return;
    }
    $(this).addClass("on");
    var url = $(this).attr("data");
    if (areaclick == true) {
        $(".area,.areaItems").addClass("wid3");
    }
    loadarea(url, $(this).index());
    if($(this).text() == '不限'){
        $(".arealist").hide();
    }
    $(".arealist").slideDown();
    $(".subwaylist li").removeClass("on");
    $(".subway li").removeClass("on");
});
var subwayclick=true;
$(".subway li").on("click",function(){
    $(".subway li").removeClass("on");
    $(this).addClass("on");
    var subwayId=$(this).attr("data");
    if(subwayclick==true){
        $(".subway,.areaItems").addClass("wid3");;
    }
    loadsubway(subwayId,$(this).index());
    $(".subwaylist").slideDown();
    $(".arealist li").removeClass("on");
    $(".area li").removeClass("on");
})
//加载区域板块名称列表
function loadarea(regionUrl, index) {
    $.ajax({
        type: "POST",
        data: { url: regionUrl,check:2 },
        url: "/plateFilters",
        success: function (data) {
            var areaItems_ul = $('<ul></ul>')
            var areaItems_li = "";
            for (var i = 0; i < data.length; i++) {
                areaItems_li = $('<a alt="'+ data[i].url +'"><li name=' + data[i].id + '>' + data[i].name + '</li></a>');
                areaItems_ul.append(areaItems_li);
            }
            $(".arealist").html(areaItems_ul);
            $(".arealist a:first-child li").addClass("on")
            $(".area").find("li:eq(" + index + ")").addClass("on");
        }
    })
}
//加载地铁站名称列表
function loadsubway(subWayId,index){
    $.ajax({
        type: "POST",
        data: {url:subWayId,check:2},
        url: "/subwaysFilters",
        success: function (data) {
            var areaItems_ul = $('<ul></ul>')
            var areaItems_li = "";
            for(var i=0;i<data.length;i++){
                areaItems_li = $('<a alt="'+ data[i].url +'"><li name=' + data[i].id + '>' + data[i].name + '</li></a>');
                areaItems_ul.append(areaItems_li);
            }
            $(".subwaylist").html(areaItems_ul);
            $(".subwaylist a:first-child li").addClass("on")
            $(".subway").find("li:eq("+index+")").addClass("on");
        }
    });
}
$(".more1 li,.more2 li,.more6 li").on("click", function () {
    if ($(this).hasClass("active")) {
        $(this).removeClass("active");
    }else {
        $(this).addClass("active");
    }
});


$(".more5 li").on("click", function () {
    var id = $(this).attr("data-id");
    if ($(this).hasClass("active")) {
        $(this).removeClass("active");
    }else {
        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');
    }
});

$(".more3 li,.more4 li").on("click", function () {
    if ($(this).hasClass("active")) {
        $(this).removeClass("active");
    }else {
        $(this).siblings('li').removeClass('active');
        $(this).addClass("active");
    }
});
//清空更多
$("#empty_more").on("click",function(){
    $(".layout ul li").removeClass("active").removeClass("on");
})

//更多确认
$("#confirm_more").on("click",function(){
    var url = window.location.href;
    if(url.indexOf('fang2/') == -1) url +='/';
    var link = '';
    if(url.indexOf('search=') != -1){
        link = url.substr(url.indexOf("search=") + 7)
        url = url.substr(0,url.indexOf("search=")).replace(/-$/,'');
    }
    url = url.replace(/,/g,'').replace(/-u\d+/,'').replace(/-f\d+/,'')
        .replace(/-d\d+/,'').replace(/-y\d+/,'').replace(/-g\d+/,'').replace(/-a\d+/,'');
    var u1 = '', u2 = '',u3 = '',u4 = '', u5 = '',u6 = '';
    $(".more1 li").each(function () {
        if($(this).hasClass("active")){
            u1 += $(this).attr('data-id')+','
        }
    });
    u1 = u1.replace(/,$/,'');
    $(".more2 li").each(function () {
        if($(this).hasClass("active")){
            u2 += $(this).attr('data-id')+','
        }
    });
    u2 = u2.replace(/,$/,'');
    $(".more3 li").each(function () {
        if($(this).hasClass("active")){
            u3 = $(this).attr('data-id')
        }
    });
    $(".more4 li").each(function () {
        if($(this).hasClass("active")){
            u4 = $(this).attr('data-id')
        }
    });
    $(".more5 li").each(function () {
        if($(this).hasClass("active")){
            u5 += $(this).attr('data-id')+','
        }
    });
    u5 = u5.replace(/,$/,'');
    $(".more6 li").each(function () {
        if($(this).hasClass("active")){
            u6 += $(this).attr('data-id')+','
        }
    });
    u6 = u6.replace(/,$/,'');
    if(u1 != ''){
        url = url + '-u' + u1;
    }
    if(u2 != ''){
        url = url + '-f' + u2;
    }
    if(u3 != ''){
        url = url + '-d' + u3;
    }
    if(u4 != ''){
        url = url + '-y' + u4;
    }
    if(u5 != ''){
        url = url + '-g' + u5;
    }
    if(u6 != ''){
        url = url + '-a' + u6;
    }
    if(link != undefined && link != null && link != ''){
        url = url + '-search=' + link;
    }
    window.location = url;
});
$(window).scroll(function () {//滑动
      if (status == "true") {
          if ($(document).scrollTop() >= $(document).height() - $(window).height() - 100) {
                status == "false";
                page = page + 1;
                loadlist(page);
            }
     }
});
//$(window).scroll(function(){//滑动加载
//  var scrollTop = $(document).scrollTop();
//  var scrollHeight = $(document).height();
//  var windowHeight = $(this).height();
//  if (status == "true") {
//      if(scrollTop + windowHeight >= scrollHeight){
//          status == "false";
//          //status = "true";
//          page = page + 1;
//          loadlist(page);
//      }
//  }
//});
function loadlist(page) {
    var url = document.location.pathname;
    url = decodeURIComponent(decodeURIComponent(url));
    $(".fillter1_select").slideUp();
    // $(".filter").attr("style", "");
//  $("body").css({"height":"auto","overflow":"auto"});
    $(".loading").show();
    // $(".list").append("<div class='no_info'><p>没有符合条件的结果，换个条件试试？</p><a href='/normalsale.htm'>帮您找房</a></div>");
    $.ajax({
        type: "POST",
        data: {page: page,url: url,auction:1},
        url: "/saleHouseLists",
        success: function (data) {
            loadlistdata(data);
        }
    })
}
function loadlistdata(data) {
    if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
            var cl = $('<div class="cl"></div>');
            var zhuzhai = $('<a href="/fang2/' + data[i].houseId + '.htm" class="zhuzhai"></a>');
            var esfJcD = $('<div class="esfJcD"></div>')
            var left_tu = "";
            if (data[i].pic != ""&&data[i].pic!=null) {
                left_tu = $('<img src="' + data[i].pic + '" class="left_tu"/>')
            } else {
                left_tu = $('<img src="https://static.fangxiaoer.com/m/images/sload.jpg" class="left_tu"/>')
            }
            if(data[i].isXiQue==1){
                xique=$('<img src="https://static.fangxiaoer.com/m/static/images/privilege/com_bg.png" class="ui-v" width="100%">')
            }else{
                xique="";
            }
            //视频看房图标 or VR图标
            var videoPicture = '';
            if(data[i].mediaID != null && data[i].PanID != null){
                videoPicture = $('<div class="listIconTwo"><s  class="ListIconVr"></s><s  class="ListIconVideo"></s></div>');
            }else if(data[i].mediaID != null || data[i].PanID != null){
                if(data[i].mediaID != null){
                    videoPicture = $('<div class="listIconOne"><s  class="ListIconVideo"></s></div>');
                }else if(data[i].PanID != null){
                    videoPicture = $('<div class="listIconOne"><s  class="ListIconVr"></s></div>');
                }
            }else{
                videoPicture ="";
            }

            if(data[i].stickOrder==-1){
                stickOrder=$("<div class='esfJx'>置顶好房</div>");
            }else{
                stickOrder="";
            }
            var right_info = $('<div class="right_info"></div>');

            var title = $('<div class="title">' + data[i].title + '</div>');
            //var dist_price = $('<div class="dist_price"></div>');
            var dist = "";
            if (data[i].distance != "") {
                var dist = $('<div class="dist"><img src="https://static.fangxiaoer.com/m/images/distance.png"/>' + data[i].distance + 'km</div>');
            }
            //var price = $('<div class="price"><span>' + data[i].price + '</span>万</div>')

            //dist_price.append(price,dist);
            if(data[i].unitPrice==0){
                pr="";
            }else{
                pr=data[i].unitPrice + "元/㎡";
            }
            var regionName=data[i].regionName;
            var subName=data[i].subName
            if(data[i].price==0){
                usprice="面议";
            }else{
                var usprice=parseFloat(data[i].price)+"<i>万</i>";
            }

            if(data[i].regionName==null&&data[i].regionName==undefined){
                regionName=" ";
            }else{
                regionName=data[i].regionName+"&nbsp;";
            }
            if(data[i].subName==null&&data[i].subName==undefined){
                subName=" ";
            }else{
                subName=data[i].subName+"&nbsp;";
            }
            var area=data[i].area;
            var layout=data[i].layout;
            var favourable = $('<div class="address"><div class="address_left"><span class="address_main">' +regionName +' '+ subName+'</div></div>');
            var spanTime=data[i].spanTime;
            if(parseInt(spanTime)>90){
                spanTime="";
            }else{
                spanTime;
            }


            var charact = $('<ul class="charact"><!--<i>' + spanTime + '</i>--></ul>');
            var charact_dist=$('<div class="charact_dist"></div>');
            var addlist = $('<div class="address"><span class="esfPrice esfPrice2">' + usprice + '</span><div class="address_span"><span> ' + layout +' </span><span>' + area +'㎡ </span><span> ' +data[i].forward+' </span></div></div>')
            var isGoodHouse = data[i].isGoodHouse;
           /* if(isGoodHouse == -1){
                isGoodHouse =  charact.append($('<i class="is_good_house">优质</i>'));
            }else{
                isGoodHouse = "";
            }
            if(data[i].houseTrait==undefined){
                var houseTrait = "";
            }else{
                var houseTrait = data[i].houseTrait;
                houseTrait = houseTrait.split(",");
                for (var j = 0; j < 3; j++) {
                    if (houseTrait[j] != ""&&houseTrait[j] !=null) {
                        charact.append($('<li class="em' +[j+1]+ ' ">' + houseTrait[j] + '</li>'));
                    } else {
                        continue;
                    }
                }
            }*/
            if(data[i].houseTrait==undefined){
                var houseTrait = "";
            }else{
                var houseTrait = data[i].houseTrait;
                houseTrait = houseTrait.split(",");
                if(isGoodHouse == -1){
                    isGoodHouse =  charact.append($('<i class="emIcon emIcon-good"></i>'));
                    for (var j = 0; j < 2; j++) {
                        if (houseTrait[j] != ""&&houseTrait[j] !=null) {
                            charact.append($('<li class="em' +[j+1]+ ' ">' + houseTrait[j] + '</li>'));
                        } else {
                            continue;
                        }
                    }
                }else{
                    isGoodHouse = "";
                    for (var j = 0; j < 3; j++) {
                        if (houseTrait[j] != ""&&houseTrait[j] !=null) {
                            charact.append($('<li class="em' +[j+1]+ ' ">' + houseTrait[j] + '</li>'));
                        } else {
                            continue;
                        }
                    }
                }
            }
            //charact_dist.append(charact, dist)
            charact_dist.append(charact)
            right_info.append(title, favourable, charact_dist,addlist, cl);
            esfJcD.append(left_tu,stickOrder)
            zhuzhai.append(esfJcD,xique,videoPicture, right_info, cl);
            $(".no_info").hide();
            $(".list").append(zhuzhai);
            status = "true";
            $(".loading").hide();
            var width = $("body").width()
            $(".right_info .title,.zz_info").css("width", width-148)
        }
    } else {
        if ($(".zhuzhai").length == 0 )  {
            console.log("无数据");
            $(".no_info").show();
        }else{
            $(".no_info").hide();
        };
        status = "false";
        $(".loading").hide();
        return;
    }
}
function mn(){
    var btn_mn=$(".total .min_p").val();
    var btn_mx=$(".total .max_p").val();
    var url = "";
    $(".price_block li").each(function () {
        if($(this).hasClass("on")){
            url = $(this).parent().attr('alt')
        }
    });
    if(btn_mn!="" || btn_mx!=""){
        $(".price_block li").removeClass("on")
    }
}

$(document).keydown(function (event) {
    var evt = window.event || evt;
    if (evt.keyCode == 13 && $("#search").val() != "") {
        search_uhouse();
    }
});
$(".searchicon").click(function () {
    if ($("#search").val() != "") {
        search_uhouse();
    }
});
function search_uhouse() {
    subName = $("#search").val();
    var url = window.location.href;
    if(url.indexOf('fang2/') == -1) url +='/';
    if(url.indexOf('search=') != -1){
        url = url.substr(0,url.indexOf("search=")).replace(/-$/,'');
    }
    if(subName != undefined && subName != null && subName != ''){
        url = url + '-search=' + subName;
    }
    window.location = url;
}
//自定义价格
$("#confirm_price").on("click",function(){
    var minPrice=$(".min_p").val();
    var maxPrice=$(".max_p").val();
    var url = window.location.href;
    if(minPrice == ''){
        url = url.replace(/-k\d+/,'').replace(/k\d+/,'');
    }
    if(maxPrice == ''){
        url = url.replace(/-x\d+/,'').replace(/x\d+/,'');
    }
    if (minPrice != '' || maxPrice != ''){
        subName = $("#search").val();

        if(url.indexOf('fang2/') == -1) url +='/';
        if(url.indexOf('search=') != -1){
            url = url.substr(0,url.indexOf("search=")).replace(/-$/,'');
        }
        if(minPrice != ''){

            url = url + '-k' + minPrice;
            url = url.replace(/-p\d+/,'').replace(/p\d+/,'');
        }
        if(maxPrice != ''){
            url = url.replace(/-x\d+/,'').replace(/x\d+/,'');
            url = url + '-x' + maxPrice;
            url = url.replace(/-p\d+/,'').replace(/p\d+/,'');
        }
        if(subName != undefined && subName != null && subName != ''){
            url = url + '-search=' + subName;
        }
        if(maxPrice != '' && Number(minPrice)>Number(maxPrice)){
            alert("总价的最大值不能小于总价的最小值！");
        }else{
            window.location = url;
        }
    }else {
        var url="";
        $(".type_block li").each(function () {
            if($(this).hasClass("on")){
                url += $(this).parent().attr('alt')
            }
        });
        if(url != '')
            window.location = window.location.origin
                +url.replace(/-k\d+/,'').replace(/k\d+/,'').replace(/-x\d+/,'').replace(/x\d+/,'');
        else {
            window.location = window.location.href.replace(/-p\d+/,'').replace(/p\d+/,'')
                .replace(/-k\d+/,'').replace(/k\d+/,'').replace(/-x\d+/,'').replace(/x\d+/,'');
        }
    }
});

//清空所有查询条件
$("#empty_all").on("click",function(){
    var url = window.location.href;
    if(url.indexOf('fang2/') == -1) url +='/';
    var link = '';
    if(url.indexOf('search=') != -1){
        link = url.substr(url.indexOf("search=") + 7)
        url = url.substr(0,url.indexOf("search=")).replace(/-$/,'');
    }
    url = url.replace(/,/g,'').replace(/-u\d+/,'').replace(/-f\d+/,'')
        .replace(/-d\d+/,'').replace(/-y\d+/,'').replace(/-g\d+/,'').replace(/-a\d+/,'').replace(/-j\d+/,'').replace(/-l\d+/,'')
        .replace(/-p\d+/,'').replace(/-r\d+/,'').replace(/-q\d+/,'').replace(/-b\d+/,'').replace(/-i\d+/,'').replace(/j\d+/,'')
        .replace(/q\d+/,'').replace(/l\d+/,'').replace(/p\d+/,'').replace(/-k\d+/,'').replace(/-x\d+/,'').replace('-W4','');

    if(link != undefined && link != null && link != ''){
        link = '';
        url = url  + link;
    }
    window.location = url;

});

//外部地铁房筛选
function sub() {
    var u = '';
    if ($(".more1 li:eq(3)").hasClass("active")) {
        $(".more1 li:eq(3)").removeClass("active");
    }else {
        $(".more1 li:eq(3)").addClass("active");
        u +=$(".more1 li:eq(3)").attr("data-id");
    }
    $("#confirm_more").click();
}
//外部南北通透筛选
function ns() {
    var u = '';
    if ($(".more1 li:eq(1)").hasClass("active")) {
        $(".more1 li:eq(1)").removeClass("active");
    }else {
        $(".more1 li:eq(1)").addClass("active");
        u +=$(".more1 li:eq(1)").attr("data-id");
    }
    $("#confirm_more").click();
}
//外部精装房筛选
function hardCover() {
    var u = '';
    if ($(".more3 li:eq(2)").hasClass("active")) {
        $(".more3 li:eq(2)").removeClass("active");
    }else {
        // $(".more3 li:eq(2)").addClass("active");
        // u +=$(".more3 li:eq(2)").attr("data-id");
        // $(".more3 li").each(function () {
        //     if(!$(".more3 li:eq(2)").hasClass("active")){
        //         $(this).removeClass('active');
        //     }
        //
        // });
        $(".more3 li:eq(2)").siblings('li').removeClass('active');
        $(".more3 li:eq(2)").addClass("active");
    }
    $("#confirm_more").click();
}
//新房
function newHouse(){
    var url = window.location.href;
    if(url.indexOf('fang2/') == -1){
        url +='/';
    }
    if($("#newHouse").hasClass("active")){
        $("#newHouse").removeClass("active");
        url = url.replace("-C1","");
    }else{
        // $(".outside div:eq(0)").addClass("active");
        $("#newHouse").addClass("active");
        $("#newHouse").css("color","red")
        var link = '';
        if(url.indexOf('search=') != -1){
            link = url.substr(url.indexOf("search=") + 7)
            url = url.substr(0,url.indexOf("search=")).replace(/-$/,'');
            if(link != undefined && link != null && link != ''){
                url = url + "-C1" + '-search=' + link;
            }
        }else{
            url = url + "-C1";
        }
    }
    window.location = url;
    // $(".confirm").click();
}
//视频看房
function videoHouse(){
    var url = window.location.href;
    if(url.indexOf('fang2/') == -1){
        url +='/';
    }
    if($("#videoHouse").hasClass("active")){
        $("#videoHouse").removeClass("active");
        url = url.replace("-W4","");
    }else{
        // $(".outside div:eq(0)").addClass("active");
        $("#videoHouse").addClass("active");
        $("#videoHouse").css("color","red")
        var link = '';
        if(url.indexOf('search=') != -1){
            link = url.substr(url.indexOf("search=") + 7)
            url = url.substr(0,url.indexOf("search=")).replace(/-$/,'');
            if(link != undefined && link != null && link != ''){
                url = url + "-W4" + '-search=' + link;
            }
        }else{
            url = url + "-W4";
        }
    }
    window.location = url;
    // $(".confirm").click();
}

//重置站点，板块 清空站点，板块的选中状态
$("#empty_place").on("click",function(){
    $(".fillter_2 li").removeClass("on");
    $(".area li").removeClass("on");
    $(".subway li").removeClass("on");
    $(".area a li").addClass("on")
    $(".area").show();
    $(".subway").hide();
    $(".arealist").hide();
    $(".subwaylist").hide();
    $(".areaItems li").each(function () {
        if($(this).text() == '区域'){
            $(this).addClass("on")
        }else {
            $(this).removeClass("on")
        }
    });

})

//选中板块，站点后点击确认按钮
$("#confirm_place").on("click",function(){
    var u1="", u2="", u3="", u4="";
    $(".arealist li").each(function () {
        if($(this).hasClass("on")){
            u1 = $(this).parent().attr('alt')
        }
    });
    $(".subwaylist li").each(function () {
        if($(this).hasClass("on")){
            u2 = $(this).parent().attr('alt')
        }
    });
    $(".area li").each(function () {
        if($(this).hasClass("on")){
            u3 = $(this).attr('alt')
        }
    });
    $(".subway li").each(function () {
        if($(this).hasClass("on")){
            u4 = $(this).attr('alt')
        }
    });
    if(u1 != ''){
        window.location = window.location.origin+u1;
    }else if(u2 != ''){
        window.location = window.location.origin+u2;
    }
    else if(u3 != ''){
        window.location = window.location.origin+u3;
    }else if(u4 != ''){
        window.location = window.location.origin+u4
    }
    else {
        var a = window.location.href.replace(/-l\d+/,'').replace(/l\d+/,'')
        window.location = a;
    }
})

//给站点，板块加选中状态，清空原来的
$(".price_block li").on("click",function() {
    $(this).parent().parent().find("li").removeClass("on");
    $(this).addClass("on");

    var node = $(this).parent().parent().parent().parent();
    if(node.hasClass('type_block')){
        $(".max_p").val("");
        $(".min_p").val("");
    }
})
$(".type_block li").on("click",function() {
    $(this).parent().parent().find("li").removeClass("on");
    $(this).addClass("on");

    var node = $(this).parent().parent().parent().parent();
    if(node.hasClass('type_block')){
        $(".max_p").val("");
        $(".min_p").val("");
    }
})

//给站点，板块加选中状态，清空原来的
$(".fillter_2 li").on("click",function() {
    $(".arealist").find("li").removeClass("on");
    $(".subwaylist").find("li").removeClass("on");
    $(this).addClass("on");
})

//选中户型后点击确认按钮
$("#confirm_layout").on("click",function() {
    var url="";
    $(".price_block li").each(function () {
        if($(this).hasClass("on")){
            url += $(this).parent().attr('alt')
        }
    });
    if(url != ''){
        window.location = window.location.origin+url;
    }else {
        var a = window.location.href.replace(/-l\d+/,'').replace(/l\d+/,'')
        window.location = a;
    }
})

//户型重置
$("#empty_layout").on("click",function() {
    $(".price_block li").removeClass("on");
})

//价格重置
$("#empty_price").on("click",function() {
    $(".type_block li").removeClass("on");
    $(".min_p").val("");
    $(".max_p").val("");
})

$("#selectRegin").click(function () {
    if ($(this).html() != "区域"){
        $(".area,.areaItems,.subway").addClass("wid3");
    }
})
var width = $("body").width() - 58;
$(".right_info .title,.zz_info").css("width", width-90)



