function msgSuccessReload(msg){
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 500,
        beforeHide: function(){
        	location.reload();
        }
    });
}
function msgSuccessUrl(msg, page){
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 500,
        beforeHide: function(){
        	location.replace(page);
        }
    });
}
function msgSuccess(msg){
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 1500,
        beforeHide: function(){
        }
    });
}
function msgError(msg){
	$.msgbox.show({
        message: msg,
        icon: 'no',
        timeOut: 2000,
        beforeHide: function(){
        }
    });
}
function showProcess(msg){
	$("body").append("<div id='mainhidediv' class='ui-widget-overlay ui-front'></div>");
	$("body").append("<div id='dialogprocess' class='ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable' style='position:absolute;left:50%;top:50%;width:300px;height:70px;margin:-30px 0 0 -150px'><div id='progressbar' style='margin-top:10px;'></div><div style='text-align:center;'>"+msg+"</div></div>");
	$("#progressbar").progressbar({
		value: false
	});
}
function closeProcess(){
	$("#mainhidediv").remove();
	$("#dialogprocess").remove();
}