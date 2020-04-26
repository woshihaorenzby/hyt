/*
 * 分页设置函数
 */
function fenPage(totalPage, totalRecords, condition){
	//var totalPage = 10;
	//var totalRecords = 390;
	var pageNo = getParameter('pno');
	if(!pageNo){
		pageNo = 1;
	}
	//生成分页
	//有些参数是可选的，比如lang，若不传有默认值
	kkpager.generPageHtml({
		pno : pageNo,
		mode : 'click',
		total : totalPage,//总页码
		totalRecords : totalRecords,//总数据条数
		click : function(n){
	        //这里可以做自已的处理
	        //处理完后可以手动条用selectPage进行页码选中切换
	        this.selectPage(n);
	        $("#kkpager_btn_go_input").val(n);
	        loadData(n, condition);
	    },
		lang : {
			firstPageText : '首页',
			lastPageText : '尾页',
			prePageText : '上一页',
			nextPageText : '下一页',
			totalPageBeforeText : '共',
			totalPageAfterText : '页',
			totalRecordsAfterText : '条数据',
			gopageBeforeText : '转到',
			gopageButtonOkText : '确定',
			gopageAfterText : '页',
			buttonTipBeforeText : '第',
			buttonTipAfterText : '页'
		}
	});
}
function getParameter(name) { 
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r!=null) return unescape(r[2]); return null;
}
//单击一行表格
function clickRow(obj){
	var headCheck = ($(obj).children().eq(0).children().eq(0))[0];
	if(headCheck.checked==true){
		headCheck.checked = false;
		$(obj).removeClass("info");
	}else{
		headCheck.checked = true;
		$(obj).addClass("info");
	}
}
//鼠标移上表格一行
function mouseon(obj){
	$(obj).addClass("info");
}
//鼠标移出表格一行
function mouseout(obj){
	$(obj).removeClass("info");
}
//选择表格的所有行
function selTotalRow(obj, id){
	if(obj.checked == true){
		$("#"+id).children().each(function(){
			$(this).children().eq(0).children()[0].checked = true;
			$(this).addClass("info");
		});
	}else{
		$("#"+id).children().each(function(){
			$(this).children().eq(0).children()[0].checked = false;
			$(this).removeClass("info");
		});
	}
}
function nodata(tag){
	if(tag==1){
		$("#noPaper").css({
			"display":"block"
		});
	}else{
		$("#noPaper").css({
			"display":"none"
		});
	}
}
function resetForm(){
	location.reload();
}
function updateTag(obj, col, table){
	var id = $(obj).parent().parent().attr("id");
	var sendTag = 0;
	var tag = $(obj).attr("hidetag");
	if(tag == "0") sendTag = 1;
	$.ajax({
		type: "post",
		url: cxtPath + "/util/updateTag",
		dataType: "json",
		data: "utilVo.id=" + id + "&utilVo.col=" + col + "&utilVo.table=" + table + "&utilVo.tag=" + sendTag,
		success: function(data){
			if(data.code == "1"){
				if(tag == "0"){
					$(obj).attr("hidetag", "1");
					$(obj).attr("src", cxtPath+"/images/button/check_alt.png");
				}else{
					$(obj).attr("hidetag", "0");
					$(obj).attr("src", cxtPath+"/images/button/x_alt.png");
				}
			}else{
				msgError("修改失败，请稍后重试！");
			}
		},error: function(XMLHttpRequest, textStatus, errorThrown) {
			alert(XMLHttpRequest.status);
			alert(XMLHttpRequest.readyState);
			alert(textStatus);
		}
	});
}
//上传图片
function uploadImg(fileType, obj){
	showProcess("上传中");
	$(obj).parent().parent().ajaxSubmit({
		type: "post",
		url: ctxPath + "/fileUpload",
		dataType: "json",
		success: function(data){
			closeProcess();
			if(data.path != ""){
				if(fileType == "image") {
					var appStr = "<div style='float:left;margin-left:10px;' imgfile='"+data.path+"'><img src='"+ctxPath+"/images/button/minusred_alt.png' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+ctxPath+data.path+"' style='width:200px;' /></div>";
					$(obj).parent().parent().append(appStr);
					
					$(obj).text("已上传");
					$(obj).removeClass("btn-info");
					$(obj).addClass("btn-success");
					$(obj).attr("filePath", data.path);
				} else if(fileType == "file") {
					
				}
			}else{
				msgError("上传图片，请稍后重试！");
			}
		}
	});
}
function uploadExcel(fileType, obj,moudole){
	showProcess("上传中");
	$(obj).parent().parent().ajaxSubmit({
		type: "post",
		url: ctxPath + "/excelFileUpload",
		dataType: "json",
		success: function(data){
			closeProcess();
			if(data.path != ""){
				if(fileType == "excel") {
					var appStr = "<div style='float:left;margin-left:10px;' imgfile='"+data.path+"'><img src='"+ctxPath+"/images/button/minusred_alt.png' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+ctxPath+data.path+"' style='width:200px;' /></div>";
					$(obj).parent().parent().append(appStr);

					$(obj).text("已上传");
					$(obj).removeClass("btn-info");
					$(obj).addClass("btn-success");
					$(obj).attr("filePath", data.path);
				} else if(fileType == "file") {

				}
			}else{
				msgError("上传图片，请稍后重试！");
			}
		}
	});
}
//上传七牛
function uploadFileQiniu(fileType, obj){
	showProcess("上传中");
	$(obj).parent().parent().ajaxSubmit({
		type: "post",
		url: ctxPath + "/fileUploadQiniu",
		dataType: "json",
		success: function(data){
			closeProcess();
			if(data.path != ""){
				if(fileType == "image") {
					var appStr = "<div style='float:left;margin-left:10px;' imgfile='"+data.path+"'><img src='"+ctxPath+"/images/button/minusred_alt.png' style='position:absolute;margin-top:0px;margin-left:180px;width:18px;cursor:pointer;' onclick='removeImg(this)'/><img src='"+ctxPath+data.path+"' style='width:200px;' /></div>";
					$(obj).parent().parent().append(appStr);
				} else if(fileType == "file") {
					$(obj).text("已上传");
					$(obj).removeClass("btn-info");
					$(obj).addClass("btn-success");
					$(obj).attr("filePath", data.path);
					$(obj).attr("fileSize", data.fileSize);
					$("#appDownUrl").val(data.path);
				}
			}else{
				msgError("上传图片，请稍后重试！");
			}
		}
	});
}
//移除图片
function removeImg(obj) {
	$(obj).parent().remove();
}
//校验方法
function validateInput(ID, TEXT, validateInput){
	if(TEXT==""){
		$("#"+ID).parent().addClass("has-error");
		$("#"+ID).siblings("div").css({
			"display":"block"
		});
		return false;
	}else{
		if(validateInput == false){
			return false;
		}else{
			return true
		}
	}
}
//清除所有校验错误
function resetMsg(){
	$(".has-error").each(function(){
		$(this).removeClass("has-error");
	});
	$(".errormsg").each(function(){
		$(this).css({
			"display":"none"
		});
	});
}
function showProcess(msg){
	$("body").append("<div id='mainhidediv' class='ui-widget-overlay ui-front'></div>");
	$("body").append("<div id='dialogprocess' class='ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable' style='position:absolute;left:50%;top:50%;width:300px;height:60px;margin:-30px 0 0 -150px'><div id='progressbar' style='margin-top:10px;'></div><div style='text-align:center;'>"+msg+"</div></div>");
	$("#progressbar").progressbar({
		value: false
	});
}
function closeProcess(){
	$("#mainhidediv").remove();
	$("#dialogprocess").remove();
}