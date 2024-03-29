<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="../jsFramework/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="../jsFramework/jquery-easyui-1.4.2/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="../jsFramework/jquery-easyui-1.4.2/themes/icon.css">
<link rel="stylesheet"
	href="../jsFramework/jquery-ui-1.11.4.custom/jquery-ui.css" />

<link rel="stylesheet" href="../common/css/table1.css" />



<script src="../jsFramework/jquery/jquery-1.11.2.min.js"></script>
<script src="../jsFramework/jquery/jquery.confirm.js"></script>
<script src="../jsFramework/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../jsFramework/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../jsFramework/jquery-easyui-1.4.2/plugins/datagrid-filter.js"></script>

<script type="text/javascript"
	src="../jsFramework/jquery-ui-1.11.4.custom/jquery-ui.js"></script>




<title>成亮公司庫存管理</title>


<script language="javascript">
	var count = 0;

	var inData = [];
	$(document).ready(function() {

	});

	function deleteThisELement(object) {
		$(object).parent().parent().remove();
		count--;
		$("#count").html(count);
	}

	function queryDataByBarcode() {
		var pbarcode = $("#barcodeStr").val();
		$("#barcodeStr").val("");
		if (pbarcode.length == 8 || pbarcode.length == 13) {

			$.ajax({
				async : false,
				type : "POST",
				url : "queryDataByPbarcode?pbarcode=" + pbarcode,
				encoding : "UTF-8",

				//contentType : "text/html; charset=UTF-8",
				dataType : "json",
				success : function(rtn) {
					insertDataToTable(rtn);

				},
				error : function(a, b, c) {
					alert(a + "\n" + b + "\n" + c);
				}
			});

		}

	}
	function queryDataByPnum() {

		var pnumStr = $("#queryStr").val().match(/\(([0-9]+)\)/g);

		if (pnumStr != null) {
			var pnum = pnumStr[0].replace("(", "").replace(")", "");

			$.ajax({
				async : false,
				type : "POST",
				url : "queryDataByPnum?pnum=" + pnum,
				encoding : "UTF-8",

				//contentType : "text/html; charset=UTF-8",
				dataType : "json",
				success : function(rtn) {
					insertDataToTable(rtn);

				},
				error : function(a, b, c) {
					alert(a + "\n" + b + "\n" + c);
				}
			});

		}
	}

	function checkNum(object) {
		var data = $(object).val();
		if ($.isNumeric(data) == false) {
			alert("請輸入數字，謝謝!");
			$(object).val("");
		}
	}

	function insertDataToTable(rtn) {

		if (typeof $("#" + rtn["p_id"]).val() === "undefined") {
			count++;
			$("#count").html(count);
			var html = "";
			html = html + "<tr>";

			html = html
					+ "<td>"
					+ rtn["p_barcode"]
					+ "<input type='hidden' value='"+rtn["p_id"]+"' name='p_id' id='"+rtn["p_id"]+"'></td>";
			html = html + "<td>" + rtn["p_num"] + "</td>";
			html = html + "<td>" + rtn["p_name"] + "</td>";
			html = html + "<td>" + rtn["p_unit"] + "</td>";
			html = html + "<td>" + rtn["p_size"] + "</td>";
			html = html
					+ "<td>"
					+ rtn["p_count"]
					+ "<input type='hidden' value='"+rtn["p_count"]+"' name='"+ rtn["p_id"]+ "p_count' id='"+ rtn["p_id"]+ "p_count'></td>";
			html = html
					+ "<td><input type='text' value='' size='10' name='"
					+ rtn["p_id"]
					+ "p_count_out' onkeyup='checkNum(this);' class='p_count'></td>";
			html = html + "<td>$<input type='text' value='' size='10' name='"
					+ rtn["p_id"] + "p_price' onkeyup='checkNum(this);'></td>";
			html = html
					+ "<td><a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-cancel' onclick='deleteThisELement(this);'>移除</a></td>";
			html = html + "</tr>";

			$("#outTable").append(html);

		} else {
			alert("已加入過!!");
		}

		//inData.push(rtn);
		//alert(inData);
		//接著要插入form做動作
	}

	function submitData() {
		var checkok = true;
		$(".p_count").each(function(index, element) {
			if ($(this).val() == "") {

				checkok = false;

			}

		});

		if (!checkok) {
			alert("請確認每個項目皆有填入數量，謝謝。");
		}

		if ($("#signer").val() == "") {
			checkok = false;
		}
		if (!checkok) {
			alert("請填入驗收人，謝謝。");
		}

		if (checkok) {
			$
					.confirm({
						text : "<span style='font-size: large; color:red'>是否確定新增出貨單?</span>",
						confirm : function() {
							var data = $("#outForm").serialize();

							$.ajax({
								async : false,
								type : "POST",
								url : "addDeliver",
								encoding : "UTF-8",
								data : data,
								//contentType : "text/html; charset=UTF-8",
								dataType : "json",
								success : function(rtn) {
									alert("完成!!");
									location.reload();
								},
								error : function(a, b, c) {
									alert(a + "\n" + b + "\n" + c);
								}
							});
						},
						cancel : function() {
							// nothing to do
						},
						title : "注意!!",
						confirmButton : "確定",
						cancelButton : "取消",
						confirmButtonClass : "btn-warning",
						cancelButtonClass : "btn-default",
						dialogClass : "modal-dialog"
					});
		} else {

		}

	}

	function autocomplateQuery() {

		var inputStr = $("#queryStr").val();

		if (inputStr.length >= 3) {

			$("#queryInput").val(inputStr);

			var data = $("#autoComplateForm").serialize();
			$.ajax({
				async : false,
				type : "POST",
				url : "autocomplateProduct",
				encoding : "UTF-8",
				data : data,
				//contentType : "text/html; charset=UTF-8",
				dataType : "json",
				success : function(rtn) {

					$("#queryStr").autocomplete({
						source : rtn,
						open : function() {
							$('#queryStr').autocomplete("widget").width(300);
						},
						select : function(event, ui) {

							//因為要讓事件發生在select之後，所以先塞資料
							var value = ui.item.value;
							$("#queryStr").val(value);

							queryDataByPnum();
						}
					});

				},
				error : function(a, b, c) {
					alert(a + "\n" + b + "\n" + c);
				}
			});
		}

	}
</script>


</head>
<body>

	<jsp:include page="/top.jsp" />

	<div id='content'>

		<table width="100%">

			<tr>

				<td align="center">
					<form id='outForm'>
						<table width="80%">
							<tr>
								<td align="left"><label
									style="font-size: 26px; font-weight: bold;">產品出貨</label></td>
							</tr>
							<tr height="60">
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<table border="0">
										<tr>

											<td align="left"><div class="row">

													<div class="col-lg-6">
														<div class="input-group">

															<input type="text" class="form-control" id="barcodeStr"
																onchange="queryDataByBarcode();"
																onkeyup="queryDataByBarcode();"> <span
																class="input-group-btn">
																<button class="btn btn-default" type="button"
																	onclick="queryDataByBarcode();">掃描出貨</button>
															</span>
														</div>
														<!-- /input-group -->
													</div>
													<!-- /.col-lg-6 -->
												</div></td>
											<td><div class="row">

													<div class="col-lg-6">
														<div class="input-group">

															<input type="text" class="form-control" id="queryStr"
																onkeyup="autocomplateQuery();"> <span
																class="input-group-btn">
																<button class="btn btn-default" type="button"
																	onclick="queryDataByPnum();">搜尋出貨</button>
															</span>
														</div>
														<!-- /input-group -->
													</div>
													<!-- /.col-lg-6 -->
												</div></td>
										</tr>



									</table>
								</td>
							</tr>
							<tr>
								<td><hr /></td>
							</tr>
							<tr>
								<td><label>目前筆數:</label><label id='count'>0</label>




									<table class='tablecss1' id='outTable'>
										<tr>

											<td><label>BARDCODE</label></td>
											<td><label>商品編號</label></td>
											<td><label>商品名稱</label></td>
											<td><label>產品單位</label></td>
											<td><label>規格</label></td>
											<td><label>現存數量</label></td>
											<td><label>出貨數量</label></td>
											<td><label>出貨單價</label></td>
											<td><label>操作</label></td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right"><label>出貨人:</label><input type="text"
									id="signer" name="signer" size="15"><label>客戶:</label><input type="text"
									id="customer" name="customer" size="15">
									&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
									class="easyui-linkbutton c4" onclick="submitData();"
									style="width: 60px; height: 30px;"><span
										style="font-size: 16px; font-weight: bold;">確定</span></a></td>
							</tr>

						</table>
					</form>
				</td>
			</tr>

		</table>

	</div>



	<form id='autoComplateForm'>
		<input type="hidden" name="queryInput" id="queryInput">
	</form>






</body>
</html>