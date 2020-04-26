<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title></title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
<style>
#main-nav{
	margin-left: 1px;
}
#main-nav.nav-tabs.nav-stacked > li > a{
	padding: 10px 8px;
	margin-right:0px;
	font-size: 12px;
	font-weight: 600;
	color: #FFFFFF;
	border-radius: 4px;
}
#main-nav.nav-tabs.nav-stacked > li > a > span{
	color: #FFFFFF;
}
#main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover {
	color: #FFF;
	background: #3C4049;
	background: -moz-linear-gradient(top, #FCD71D 0%, #FCD71D 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FCD71D), color-stop(100%,#FCD71D));
	background: -webkit-linear-gradient(top, #FCD71D 0%,#FCD71D 100%);
	background: -o-linear-gradient(top, #FCD71D 0%,#FCD71D 100%);
	background: -ms-linear-gradient(top, #FCD71D 0%,#FCD71D 100%);
	background: linear-gradient(top, #FCD71D 0%,#FCD71D 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FCD71D', endColorstr='#FCD71D');
	-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#FCD71D', endColorstr='#FCD71D')";
	border-color: #FCD71D;
}
#main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover > span {
	color: #FFF;
}
#main-nav.nav-tabs.nav-stacked > li {
	margin-bottom: 4px;
	padding:0px;
	margin-right:0px;
}
/*定义二级菜单样式*/
.secondmenu a {
	font-size: 12px;
	color: #FFFFFF;
	text-align: center;
}
.navbar-static-top {
	background-color: #212121;
	margin-bottom: 5px;
}
.navbar-brand {
	background: url('') no-repeat 10px 8px;
	display: inline-block;
	vertical-align: middle;
	padding-left: 50px;
	color: #fff;
}
.nav li a:hover{
	background:#FCD71D;
}
.nav li a:focus{
	background:#FCD71D;
}
.chli{
	background:#FCD71D;
}
</style>
<script>
$(function(){
	$.ajax({
		type: "POST",
		url: "<%=path%>/admin/leftTree",
		data: "",
		success: function(data){
			for(var i=0;i<data.length;i++){
				var id = data[i].id;
				var pId = data[i].pId;
				var isleaf = data[i].isleaf;
				var chlink = "link"+i;
				var display = data[i].disPlay;
				if(data[i].name=="意见反馈"){
                    console.log(data[i].name);
                }
				if(display==0){
                    if(isleaf=="1" && pId!="0") continue;
                    var appstr = "";
                    if(isleaf=="0"){
                        appstr += "<li><a href='#"+chlink+"' class='nav-header collapsed sela' data-toggle='collapse'>";
                    }else{
                        appstr += "<li><a href='javascript:void(0);' class='sela' onclick='toPage(this, \""+data[i].path+"\")'>";
                    }
                    appstr += "<i class='"+data[i].icon+"'></i>&nbsp;&nbsp;"+data[i].name;
                    if(isleaf=="0"){
                        appstr+= "<span class='pull-right glyphicon glyphicon-chevron-down'></span>";
                    }
                    appstr += "</a>";
                    if(isleaf=="0"){
                        appstr+= "<ul id='"+chlink+"' class='nav nav-list secondmenu collapse' style='background:#37b3E0;'>";
                    }
                    for(var k=0;k<data.length;k++){
                        if(id == data[k].pId){
                            if(data[k].icon.length > 0){
                                appstr += "<li><a href='javascript:void(0);' onclick='toPage(this, \""+data[k].path+"\")'><i class='"+data[i].icon+"'></i>&nbsp;&nbsp;"+data[k].name+"</a></li>";
                            }else{
                                appstr += "<li><a href='javascript:void(0);' onclick='toPage(this, \""+data[k].path+"\")'>"+data[k].name+"</a></li>";
                            }
                        }
                    }
                    if(isleaf=="0"){
                        appstr += "</ul>";
                    }
                    appstr += "</li>";

				//var k = window.open();
				//k.document.write(appstr);
				$("#main-nav").append(appstr);
                }
			}
		}
	});
	
	$(".sela").click(function(){
		$(".sela").each(function(){
			$(this).parent().removeClass("active");
		});
		$(this).parent().addClass("active");
		$(".chli").each(function(){
			$(this).removeClass("chli");
		});
// 		$(".in").each(function(){
// 			$(this).removeClass("in");
// 		});
	});
});
function toPage(obj, url){
	$(".sela").each(function(){
		$(this).parent().removeClass("active");
	});
	$(".chli").each(function(){
		$(this).removeClass("chli");
	});
	$(obj).parent().addClass("chli");
	window.parent.document.getElementById("mainAreaFrame").src = "<%=path%>/"+url;
}
</script>
</head>
<body style="background:#0F1F2F;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2" style="padding:0px;">
                <ul id="main-nav" class="nav nav-tabs nav-stacked" style="border:0px;">
                    <li class="active">
                       	<a href="#" class="sela">
                            <i class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;首页
                        </a>
                    </li>
					<!-- <li class="active">
                        <a href="#systemSetting" class="nav-header collapsed sela" data-toggle="collapse">
                            <i class="glyphicon glyphicon-cog"></i>&nbsp;&nbsp;系统管理
							<span class="pull-right glyphicon glyphicon-chevron-down"></span>
                        </a>
                        <ul id="systemSetting" class="nav nav-list secondmenu collapse" style="background:#37b3E0;">
                            <li><a href="javascript:void(0);" onclick="toPage('system/user.php')"><i class="glyphicon glyphicon-user"></i>  用户管理</a></li>
                            <li><a href="javascript:void(0);" onclick="toPage('system/role.php')"><i class="glyphicon glyphicon-asterisk"></i>  角色管理</a></li>
                            <li><a href="#"><i class="glyphicon glyphicon-edit"></i>  修改密码</a></li>
                            <li><a href="#"><i class="glyphicon glyphicon-eye-open"></i>  日志查看</a></li>
                        </ul>
                    </li> -->
                </ul>
            </div>
        </div>
    </div>
</body>
</html>