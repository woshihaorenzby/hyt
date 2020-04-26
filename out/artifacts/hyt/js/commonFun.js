//当前时间倒计时
function showDT() {
	var days=new  Array ("日", "一", "二", "三", "四", "五", "六");
	var currentDT = new Date();
	var y,m,date,day,hs,ms,ss,theDateStr;
	y = currentDT.getFullYear(); //四位整数表示的年份
	m = currentDT.getMonth()+1; //月
	if(m<10) m = "0"+ m;
	date = currentDT.getDate(); //日
	if(date<10) date = "0"+ date;
	day = currentDT.getDay(); //星期
	hs = currentDT.getHours(); //时
	if(hs<10) hs = "0"+ hs;
	ms = currentDT.getMinutes(); //分
	if(ms<10) ms = "0"+ ms;
	ss = currentDT.getSeconds(); //秒
	if(ss<10) ss = "0"+ ss;
	theDateStr = y+"年"+  m +"月"+date+"日 星期"+days[day]+" "+hs+":"+ms+":"+ss;
	document.getElementById("theClock"). innerHTML =theDateStr;
	window.setTimeout( showDT, 1000);
}
//去除字符串结尾空格
String.prototype.trim = function() {
	var r = this.replace(/(^\s*)|(\s*$)/g, "");
	r = Lremoveblank(r);
	r = Rremoveblank(r);
	return r;
} 
function Lremoveblank(s) { 
	if (s.length == 1 && s.charCodeAt(0) == 160)
		return "";
	if (s.charCodeAt(0) == 160) {
		s = s.substr(1, s.length - 1);
		return Lremoveblank(s);
	}else {
		return s;
	}
}
function Rremoveblank(s) {
	if (s.length == 1 && s.charCodeAt(0) == 160)
		return "";
	if (s.charCodeAt(s.length-1) == 160) {
		s = s.substr(0, s.length - 1);
		return Rremoveblank(s);
	} else {
		return s;
	}
}
//给String增加replaceAll方法
String.prototype.replaceAll = function (s1, s2) { 
	return this.replace(new RegExp(s1,"gm"),s2);
};
//给String增加startWidth方法
String.prototype.startWith=function(str){  
    if(str==null||str==""||this.length==0||str.length>this.length)  
      return false;  
    if(this.substr(0,str.length)==str)  
      return true;  
    else  
      return false;  
    return true;  
};
//给String增加endWidth方法
String.prototype.endWith=function(str){  
    if(str==null||str==""||this.length==0||str.length>this.length)  
      return false;  
    if(this.substring(this.length-str.length)==str)  
      return true;  
    else  
      return false;  
    return true;  
};
//判断微信访问
function is_weixn() {
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) == "micromessenger") {
		return true;
	} else {
		return false;
	}
}
//判断是电脑访问还是手机端访问
function IsPC() {
	var userAgentInfo = navigator.userAgent;
	var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod");
	var flag = true;
	for (var v = 0; v < Agents.length; v++) {
		if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }
	}
	return flag;
}
function unHtml(s){
    s = s.replace(/&lt;/g,"<");
    s = s.replace(/&gt;/g,">");
    s = s.replace(/    /g,"\t");
    s = s.replace(/\n/g,"\r\n");
    s = s.replace(/<br>/g,"\n");
    s = s.replace(/&nbsp;/g," ");
    s = s.replace(/&#39;/g,"'");
    s = s.replace(/&#92;/g,"\\");
	s = s.replace(/&quot;/g,"\"");
	return s;
}