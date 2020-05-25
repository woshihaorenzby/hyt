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
			"mobileSale.free":1,
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