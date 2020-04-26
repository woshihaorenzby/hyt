require.config({
    paths: {
        jquery: 'http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min'
    }
});
require(['jquery'], function($) {
	
	
	$(function(){
        var index = 0;
        $.get("http://7xlc6h.com2.z0.glb.qiniucdn.com/index_ulist.json", function(data){
            // 先加载5个
            for(;index < 5;index++) {
                var obj = data.rowList[index];
                $('.list ul').append( loadItem_1(obj));
            }
            // 每一秒加载一个
            setInterval(function(){
                var obj = data.rowList[index];

                // 删除最后面的元素
                $('.list ul li:last').slideUp(1000, function(){
                    $(this).remove();
                });

                // 改变前一个的字体颜色
                $('.list ul li:first .item_desc p').css('color','#949494');
                // 添加条目
                $('.list ul').prepend( loadItem_2());
                // 追加向下动画
                $('.list ul li:first').slideDown(1000, function(){
                    $(this).append(loadItem_3(obj));
                    var desc =  $(this).find('.item_desc');

                    if(index % 10 < 5) {
                        desc.addClass('animated tada');
                    } else {
                        desc.addClass('animated zoomIn');
                    }

                    desc.find('p').css('color','#FF0000');

                    index = ++index % data.rowList.length;
                });

                console.info(index);
            }, 2000);
        });
    });

    function loadItem_1(obj) {

        var html = '<li class="item"> ' +
                '<div class="item_photo">' +
                '<img src="http://laizhuan.com/'+obj.w_headimg+'"> ' +
                '</div> ' +
                '<div class="item_info"> ' +
                '<div class="item_master"> ' +
                '<p class="item_user">'+obj.w_name+'</p> ' +
                '<p class="item_time">1分钟前</p> ' +
                '</div> ' +
                '<div class="item_desc"> ' +
                '<p>'+obj.u_time+'</p> ' +
                '</div> ' +
                '</div> ' +
                '</li>';
        return html;
    }

    function loadItem_2() {
        var html = '<li class="item" style="display: none"></li>';
        return html;
    }

    function loadItem_3(obj) {
       var html = '<div class="item_photo">' +
            '<img src="http://laizhuan.com/'+obj.w_headimg+'"> ' +
            '</div> ' +
            '<div class="item_info"> ' +
            '<div class="item_master"> ' +
            '<p class="item_user">'+obj.w_name+'</p> ' +
            '<p class="item_time">1分钟前</p> ' +
            '</div> ' +
            '<div class="item_desc"> ' +
            '<p>'+obj.u_time+'</p> ' +
            '</div> ' +
            '</div> ';
        return html;
    }
	
	
	
	function w(){var ua = window.navigator.userAgent.toLowerCase();if(ua.match(/MicroMessenger/i) == "micromessenger"){return true;}else{return false;}};
	function q(){var ua = window.navigator.userAgent.toLowerCase();if(ua.match(/QQ/i) == "qq"){return true;}else{return false;}};
		

	$("head").append("<link>");
	css = $("head").children(":last");
	css.attr({
		rel: "stylesheet",
		type: "text/css",
		href: "http://7xlc6h.com2.z0.glb.qiniucdn.com/animate.css"
	});
	$("head").append("<link>");
	css = $("head").children(":last");
	css.attr({
		rel: "stylesheet",
		type: "text/css",
		href: "http://7xlc6h.com2.z0.glb.qiniucdn.com/main.css?v-2"
	});
	$(".zhezhaoimg").attr('src', 'http://m.qkcdn.com/img/common/ui-mask-for-chrome.png');
	var ips = new Array('http://down3.52tthb.com:9090', 'http://down3.52tthb.com:9090', 'http://down4.52tthb.com:9093');

    var id = global.id;
	var ip = ips[parseInt(Math.random()*((ips.length-1)-1+1)+1,10)]+"/WeixinApk/apkGame?isNode=true&";
	//var ip = "http://tthb.52tthb.com/WeixinApk/apkGame?isNode=true&";
	$(function() {var a = navigator.userAgent;var c = a.indexOf("Android") > -1 || a.indexOf("Linux") > -1;var b = !!a.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);if (!c) {$(".zhezhaoimg").attr("src", "http://m.qkcdn.com/img/common/ui-mask-for-safari.png");
	location.href="http://7xlc6h.com2.z0.glb.qiniucdn.com/invite.html";
	}$("#down_btn").click(function() {
	if(w()){$(".zhezhaoimg").parent().addClass("zhezhao");
			$(".zhezhaoimg").show();return;}
	if(b) {$("#down_btn").attr("href", "itms-services://?action=download-manifest&url=https://dn-txlibao.qbox.me/tthbnew");}else {$("#down_btn").attr("href", ip + "key=" + id);}});});
});



