<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String syInsert = request.getSession().getAttribute("syInsert").toString();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jqueryui/jquery-ui.min.css">
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/js/msgbox/msgbox.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/smartpaginator.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/zTreeStyle/zTreeStyle.css">
    <script>
        var cxtPath = "<%=path%>";
        var ctxPath = "<%=path%>";
    </script>
    <script type="text/javascript" src="<%=path%>/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
    <script type="text/javascript" src="<%=path%>/js/smartpaginator.js"></script>
    <script type="text/javascript" src="<%=path%>/js/commonFun.js"></script>
    <script type="text/javascript" src="<%=path%>/js/common.js"></script>
    <script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
    <script type="text/javascript" src="<%=path%>/js/msgbox/alertmsg.js"></script>
    <script>
        var syInsert = "<%=syInsert%>";
        var mainType = "<s:property value="video.mainType" />";
        var auditTag = "<s:property value="video.auditTag" />";
        var pageRecordCount = 15;
        var selId = "";
        $(function () {
            if (mainType == "2") {
                $("#thlink").remove();
            }
            if (syInsert == "0") {
                $("#thcur").remove();
                $("#thaudit").remove();
                $("#thshen").remove();
            }
            if (auditTag == "1") {
                $("#thaudit").remove();
            }
            loadData(1, true);
            $("#checkAll").click(function () {
                var checkValue=  $("#checkAll").prop("checked") ;
                $(":checkbox.checkbox").each(function(){
                    this.checked=checkValue;
                });
            });
        });

        function loadData(curPage, refTag) {
            $.ajax({
                type: "post",
                url: "<%=path%>/wxMobileSale/list",
                dataType: "json",
                data: "page.curPage=" + curPage + "&page.pageRecordCount=" + pageRecordCount + "&mobileSale.hasSale=-1",
                success: function (json) {
                    var totalRecord = json.totalRecord;
                    var data = json.data;
                    $("#table_tb").children().remove();
                    var appStr = "";
                    for (var i = 0; i < data.length; i++) {
                        appStr += "<tr id='" + data[i].id + "' onmouseover='mouseon(this)' onmouseout='mouseout(this)'>";
                        appStr += "<td><input type='checkbox' class='checkbox' value="+data[i].id+"></input></td>";
                        appStr += "<td>" + ((curPage - 1) * pageRecordCount + i + 1) + "</td>";
                        appStr += "<td>" + data[i].mobileNum + "</td>";
                        appStr += "<td>" + data[i].province + data[i].city + "</td>";
                        appStr += "<td>" + data[i].price + "</td>";
                        appStr += "<td>" + data[i].telephoneBill + "</td>";
                        appStr += "<td>" + data[i].minimumConsumption + "</td>";
                        if (data[i].hasSale == 1) {
                            appStr += "<td>是</td>";
                        } else {
                            appStr += "<td onclick='doSalse(this)'>否</td>";
                        }
                        <%--				if(syInsert == "1") {--%>
                        <%--					var videoSyInsert = data[i].syInsert;--%>
                        <%--					var userName;--%>
                        <%--					if(videoSyInsert == "1") {--%>
                        <%--						userName = data[i].userName;--%>
                        <%--					} else if(videoSyInsert == "0") {--%>
                        <%--						userName = data[i].niName;--%>
                        <%--					}--%>
                        <%--					appStr += "<td>"+userName+"</td>";--%>
                        <%--/*					if(auditTag=="0") {//控制审核是否显示--%>
                        <%--						if(data[i].auditTag=="1"){--%>
                        <%--							appStr += "<td><img src='<%=path%>/images/button/check_alt.png' width=18 style='cursor:pointer;' hidetag='1' onclick='updateTag(this, \"auditTag\", \"hy_video\")'/></td>";--%>
                        <%--						}else{--%>
                        <%--							appStr += "<td><img src='<%=path%>/images/button/x_alt.png' width=18 style='cursor:pointer;'  hidetag='0' onclick='updateTag(this, \"auditTag\", \"hy_video\")'/></td>";--%>
                        <%--						}--%>
                        <%--					}--%>
                        <%--					if(data[i].topShow=="1"){--%>
                        <%--						appStr += "<td><img src='<%=path%>/images/button/check_alt.png' width=18 style='cursor:pointer;' hidetag='1' onclick='updateTag(this, \"topShow\", \"hy_video\")'/></td>";--%>
                        <%--					}else{--%>
                        <%--						appStr += "<td><img src='<%=path%>/images/button/x_alt.png' width=18 style='cursor:pointer;'  hidetag='0' onclick='updateTag(this, \"topShow\", \"hy_video\")'/></td>";--%>
                        <%--					}*/--%>
                        <%--				}--%>
                        appStr += "<td><button onclick='updateOrder(this)' type='button' class='btn btn-info btn-xs'>修改</button>&nbsp;<button onclick='deleteOrder(this)' type='button' class='btn btn-info btn-xs'>删除</button></td></tr>";
                    }
                    $("#table_tb").append(appStr);
                    nodata(0);
                    if (refTag == true) {
                        if (parseInt(totalRecord) > 0) {
                            $("#fenPaper").css({
                                "display": "block"
                            });
                            $("#fenPaper").smartpaginator({
                                totalrecords: totalRecord,
                                recordsperpage: pageRecordCount,
                                length: pageRecordCount,
                                next: '下一页',
                                prev: '上一页',
                                first: '首页',
                                last: '尾页',
                                theme: 'red',
                                controlsalways: true,
                                onchange: function (newPage) {
                                    loadData(newPage, false);
                                }
                            });
                        } else {
                            $("#fenPaper").css({
                                "display": "none"
                            });
                            nodata(1);
                        }
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
			$("#dialog-edit").dialog({
				autoOpen:false,
				width:600,
				modal:true,
				resizable:false,
				buttons:{
					"确定":function(){
						$(this).dialog("close");
					},
					"取消": function(){
						$(this).dialog("close");
					}
				},
				close:function(){
					$(this).dialog("close");
				}
			});
        }

        function importMobileSale() {
            selId = "";
            // $("#typeName").val("");
            $("#excel").attr("filePath", "");
            // $("#rid").val("");
            $("#dialog-edit").dialog("option", "title", "导入手机号").dialog("open");
        }

        function add() {
            window.open("<%=path%>/video/editPage?video.mainType=" + mainType, "_self");
        }

        function updateOrder(obj) {
            selId = $(obj).parent().parent().attr("id");
            window.open("<%=path%>/wxMobileSale/editPage?video.mainType=" + mainType + "&wxMobileSale.id=" + selId, "_self");
        }

        function deleteOrder(obj) {
            var ids = "";
            if(obj!=null){
                ids = $(obj).parent().parent().attr("id");
            }else{
                $(":checkbox.checkbox").each(function () {
                    if($(this).prop("checked")){
                        ids += $(this).prop("value") +",";
                    }
                });
            }
            console.log("ids-----------"+ids);
            if (window.confirm("您确认要删除这些信息吗？")) {
                $.ajax({
                    type: "POST",
                    url: "<%=path%>/wxMobileSale/delete",
                    data: "ids=" + ids,
                    success: function (data) {
                        if (data.code == "1") {
                            msgSuccessReload("删除成功！");
                        } else {
                            msgError("删除错误，请稍后重试！");
                        }
                    }
                });
            }
        }

        function doSalse(obj) {
            var id = $(obj).parent().attr("id");
            $.ajax({
                type: "POST",
                url: "<%=path%>/wxMobileSale/doSalse",
                data: "mobileSale.id=" + id,
                success: function (data) {
                    if (data.code == "1") {
                        msgSuccessReload("卖出成功！");
                    } else {
                        msgError("失败，请稍后重试！");
                    }
                }
            });
        }

    </script>
</head>
<body class="bodyst">
<div class="content_head">
    <font class="head_font">
        <s:if test="video.mainType == '1'.toString()">
            视频列表
        </s:if>
        <s:elseif test="video.mainType == '2'.toString()">
            文章列表
        </s:elseif>
    </font>
    <div style="float:right;">
        <button type="button" class="btn btn-success btn-sm" onclick="importMobileSale()"><span
                class="glyphicon glyphicon-plus"></span>&nbsp;<strong>导入</strong></button>
    </div>
    <div style="float:right;">
        <button type="button" class="btn btn-success btn-sm" onclick="add()"><span
                class="glyphicon glyphicon-plus"></span>&nbsp;<strong>添加</strong></button>
    </div>
    <div style="float:right;">
        <button type="button" class="btn btn-success btn-sm" onclick="deleteOrder()"><span
                class="glyphicon glyphicon-minus"></span>&nbsp;<strong>删除</strong></button>
    </div>
</div>
<div class="table_content" style="margin-top:10px;">
    <table class="table" style="margin-top:5px;">
        <thead class="table_th">
        <tr>
            <th style="width:5%;"> <input type="checkbox" id="checkAll" /></th>
            <th style="width:5%;">序号</th>
            <th style="width:5%;">手机号</th>
            <th style="width:10%;">省-市</th>
            <th style="width:20%;">价格</th>
            <th id="thlink" style="width:20%;">内含话费</th>
            <th style="width:5%;">最低消费</th>
            <th style="width:5%;">是否已经卖出</th>
            <th style="width:15%;">操作</th>
        </tr>
        </thead>
        <tbody id="table_tb">
        </tbody>
    </table>
    <div id="fenPaper" style="padding-right:20px;"></div>
    <div id="noPaper" class="nodata">没有查询到任何数据</div>
</div>
<div id="dialog-edit" title="添加类别" style="width: auto; min-height: 0px; max-height: none; height: 300px;">
	<table class="form_table" style ="height:300px;width:auto">
		<%--		<tr>--%>
		<%--			<td class="table_text">类别名称：</td>--%>
		<%--			<td><input id="typeName" class="form-control" type="text" style="width:200px;"></td>--%>
		<%--		</tr>--%>
		<tr>
			<td class="table_text" style="vertical-align : middle;">Excel：</td>
			<td class="table_textright">
				<form>
					<div class="form-group">
						<input name="file" class="form-control" type="file" style="width:300px;float:left;">
						<button id="excel" filePath="" type="button" class="btn btn-info btn-sm" onclick="uploadExcel('excel', this)" style="margin-left:10px;"><span class="glyphicon glyphicon-upload"></span>&nbsp;<strong>上传</strong></button>
					</div>
				</form>
			</td>
		</tr>
		<%--		<tr>--%>
		<%--			<td class="table_text">跳转外链：</td>--%>
		<%--			<td><input id="webUrl" class="form-control" type="text" style="width:400px;"></td>--%>
		<%--		</tr>--%>
		<%--		<tr>--%>
		<%--			<td class="table_text">排序：</td>--%>
		<%--			<td><input id="rid" class="form-control" type="text" style="width:100px;float:left;" value="<s:property value="lunimg.rid" />" onkeyup="value=value.replace(/[^0-9]/g,'')" onblur="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu="return false"></td>--%>
		<%--		</tr>--%>
	</table>
</div>
</html>