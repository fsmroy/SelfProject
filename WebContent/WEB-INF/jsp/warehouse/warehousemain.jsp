<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="x-ua-compatible" content="IE=edge" />


<link href="../jsFramework/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="../jsFramework/jquery-easyui-1.4.2/themes/ui-sunny/easyui.css">
<link rel="stylesheet" type="text/css"
	href="../jsFramework/jquery-easyui-1.4.2/themes/icon.css">
<link rel="stylesheet"
	href="../jsFramework/jquery-ui-1.11.4.custom/jquery-ui.css" />

<link rel="stylesheet"
	href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/start/jquery-ui.css"
	id="theme">

<link rel="stylesheet" href="../common/css/table1.css" />


<link rel="stylesheet"
	href="../jsFramework/jquery-FileUpload/css/jquery.fileupload.css">
<link rel="stylesheet"
	href="../jsFramework/jquery-FileUpload/css/jquery.fileupload-ui.css">



<script src="../jsFramework/jquery/jquery-1.11.2.min.js"></script>
<script src="../jsFramework/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../jsFramework/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../jsFramework/jquery-easyui-1.4.2/plugins/datagrid-filter.js"></script>

<script type="text/javascript"
	src="../jsFramework/jquery-ui-1.11.4.custom/jquery-ui.js"></script>







<script
	src="../jsFramework/jquery-FileUpload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="../jsFramework/jquery-FileUpload/js/jquery.fileupload.js"></script>


<title>成亮公司庫存管理</title>


<script language="javascript">
	function querySupplier() {

		$.ajax({
			async : false,
			type : "POST",
			url : "querySupplier",
			encoding : "UTF-8",
			dataType : "json",
			success : function(rtn) {
				$.each(rtn, function(index, item) {
					$("#barcodeSupplier_id").append(
							"<option value='"+item.supplier_id+"'>"
									+ item.supplier_name + "</option>");

				});

			},
			error : function(a, b, c) {
				alert(a + "\n" + b + "\n" + c);
			}
		});

	}

	function iniUpload(pnum) {

		$("#files").html("");
		$('#progress .progress-bar').css('width', '0%');

		$('#fileupload').fileupload({
			url : "upload?pnum=" + pnum,
			dataType : 'json',
			done : function(e, data) {
				$("#files").html("完成!");
				$("#p_img").attr("src", "../productImg/" + pnum + ".jpg");
				$("#p_img").show();
			},
			progressall : function(e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				$('#progress .progress-bar').css('width', progress + '%');
			}
		}).prop('disabled', !$.support.fileInput).parent().addClass(
				$.support.fileInput ? undefined : 'disabled');

	}

	$(document).ready(function() {
		ini_datagrid();
		setFilter();
		querySupplier();

	});

	function setFilter() {

		$('#ItemData').datagrid('enableFilter');

	}
	function insert() {
		openadddd();
	}

	function getRowIndex(target) {
		var tr = $(target).closest('tr.datagrid-row');
		return parseInt(tr.attr('datagrid-row-index'));
	}

	function deleteDate() {
		var checkedItems = $('#ItemData').datagrid('getChecked');

		$("#deleteTable").html("");
		var hasDelete = false;
		$("#deleteTable")
				.append(
						"<tr><td align='center'>產品編號</td><td align='center'>產品名稱</td><td align='center'>BARCODE</td></tr>");
		$
				.each(
						checkedItems,
						function(index, item) {
							hasDelete = true;

							$("#deleteTable")
									.append(
											"<tr><td>"
													+ item.p_num
													+ "<input type='hidden' name='deleteId' value='"+item.p_num+"'></td><td>"
													+ item.p_name + "</td><td>"
													+ item.p_barcode
													+ "</td></tr>");

						});
		if (hasDelete) {
			openDeletedd();
		} else {
			alert("至少選擇一筆");
		}

	}

	function ini_datagrid() {

		var toolbar = [ {
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				insert();
			}
		}, {
			text : '修改',
			iconCls : 'icon-edit',
			handler : function() {
				queryDataBykeyAndEdit();
			}
		}, '-', {
			text : '刪除',
			iconCls : 'icon-cut',
			handler : function() {
				deleteDate();
			}
		}, '-', {
			text : '廠商條碼',
			iconCls : 'icon-tip',
			handler : function() {
				openBarcodedd();
			}
		} ];

		$('#ItemData').datagrid({
			url : "queryData",

			singleSelect : true,
			rownumbers : true,

			//onClickRow : onClickRow,
			idField : 'p_id',
			singleSelect : true,
			selectOnCheck : true,
			checkOnSelect : true,
			pagination : true,
			pageSize : 15,

			pageList : [ 10, 15, 20, 25 ],
			//columns :  [propertiesColumn],
			columns : [ [ {
				field : 'ck',
				checkbox : true
			},

			{
				title : '產品編號',
				field : 'p_num',
				width : 80,
				editor : 'text',
				sortable : "true"
			}, {
				title : '名稱',
				field : 'p_name',
				width : 160,
				editor : 'text',
				sortable : "true"
			}, {
				title : '縮寫',
				field : 'p_abbreviation',
				width : 120,
				editor : 'text'
			}, {
				title : '條碼',
				field : 'p_barcode',
				width : 120,
				editor : 'text',
				sortable : "true"
			}, {
				title : '目前數量',
				field : 'p_count',
				width : 60,
				editor : 'text'
			}, {
				title : '規格',
				field : 'p_size',
				width : 80,
				editor : 'text'
			}, {
				title : '單位',
				field : 'p_unit',
				width : 40,
				editor : 'text'
			}, {
				title : '類別',
				field : 'p_class_id',
				width : 40,
				editor : 'text',
				sortable : "true"
			}, {
				title : '成本',
				field : 'p_cost',
				width : 40,
				editor : 'text'
			}, {
				title : '售價',
				field : 'p_price',
				width : 40,
				editor : 'text'
			}/*, {
										title : '上架',
										field : 'p_actival',
										width : 40,
										editor : 'text'
									}*/, {
				title : '倉庫位置',
				field : 'p_address',
				width : 80,
				editor : 'text'
			}, {
				title : '認證',
				field : 'p_license',
				width : 40,
				editor : 'text'
			}, {
				title : '資訊',
				field : 'p_info',
				width : 40,
				editor : 'text'
			} ] ],
			toolbar : toolbar
		});

	}

	function deleteData() {
		var data = $("#deleteForm").serialize();
		$.ajax({
			async : false,
			type : "POST",
			url : "deleteData",
			encoding : "UTF-8",
			data : data,
			//contentType : "text/html; charset=UTF-8",
			dataType : "json",
			success : function(rtn) {

				$('#ItemData').datagrid('reload');
				$("#ItemData").datagrid('clearSelections').datagrid(
						'clearChecked');

			},
			error : function(a, b, c) {
				alert(a + "\n" + b + "\n" + c);
			}
		});

	}

	function updateData() {
		var data = $("#editForm").serialize();
		$.ajax({
			async : false,
			type : "POST",
			url : "updateData",
			encoding : "UTF-8",
			data : data,
			//contentType : "text/html; charset=UTF-8",
			dataType : "json",
			success : function(rtn) {
				$('#ItemData').datagrid('reload');
				$("#ItemData").datagrid('clearSelections').datagrid(
						'clearChecked');

			},
			error : function(a, b, c) {
				alert(a + "\n" + b + "\n" + c);
			}
		});

	}

	function addData() {
		var data = $("#addForm").serialize();

		$.ajax({
			async : false,
			type : "POST",
			url : "addProductData",
			encoding : "UTF-8",
			data : data,
			//contentType : "text/html; charset=UTF-8",
			dataType : "json",
			success : function(rtn) {
				$('#ItemData').datagrid('reload');
				$("#ItemData").datagrid('clearSelections').datagrid(
						'clearChecked');

			},
			error : function(a, b, c) {
				alert(a + "\n" + b + "\n" + c);
			}
		});

	}

	function queryDataBykeyAndEdit() {
		var row = $('#ItemData').datagrid('getSelected');
		if (row) {

			$.ajax({
				async : false,
				type : "POST",
				url : "queryDataBykey?pid=" + row.p_id,
				encoding : "UTF-8",

				//contentType : "text/html; charset=UTF-8",
				dataType : "json",
				success : function(rtn) {
					setData(rtn);

					iniUpload(rtn["p_num"]);
					openeditdd();

				},
				error : function(a, b, c) {
					alert(a + "\n" + b + "\n" + c);
				}
			});

		} else {
			alert("請選擇一筆");
		}

	}

	function openDeletedd() {

		$('#deletedd').dialog(
				{
					title : '刪除項目列表',
					width : 600,
					height : 400,
					closed : false,
					cache : false,
					modal : true,
					resizable : true,
					close : function(event, ui) {
						$("#ItemData").datagrid('clearSelections').datagrid(
								'clearChecked');
					},
					buttons : {
						'確認刪除' : function() {
							deleteData();
							$(this).dialog('close');
						}
					}
				});

	}

	function openBarcodedd() {

		var row = $('#ItemData').datagrid('getSelected');
		$("#barcodeItem").html(row.p_name);
		$("#barcodeP_num").val(row.p_num);

		querySupplierItem();

		$('#barcodedd').dialog(
				{
					title : '廠商條碼',
					width : 600,
					height : 400,
					closed : false,
					cache : false,
					modal : true,
					resizable : true,
					close : function(event, ui) {
						$("#ItemData").datagrid('clearSelections').datagrid(
								'clearChecked');
					},
					buttons : {
						'關閉' : function() {
							//deleteData();
							$(this).dialog('close');
						}
					}
				});

	}

	function addSupplierItem() {
		var data = $("#supplierItemForm").serialize();

		$.ajax({
			async : false,
			type : "POST",
			url : "insertSupplierItem",
			encoding : "UTF-8",
			data : data,
			//contentType : "text/html; charset=UTF-8",
			dataType : "json",
			success : function(rtn) {
				querySupplierItem();

			},
			error : function(a, b, c) {
				alert(a + "\n" + b + "\n" + c);
			}
		});

	}

	function querySupplierItem() {

		$("#supplierItemList").html("");
		$("#supplierItemList")
				.append(
						"<tr><th align='center'><label>&nbsp;廠商</label></th><th align='center'><label>&nbsp;編號</label></th><th align='center'><label>&nbsp;動作</label></th></tr>");
		$
				.ajax({
					async : false,
					type : "POST",
					url : "querySupplierItem?p_num=" + $("#barcodeP_num").val(),
					encoding : "UTF-8",

					//contentType : "text/html; charset=UTF-8",
					dataType : "json",
					success : function(rtn) {
						$
								.each(
										rtn,
										function(index, item) {

											$("#supplierItemList")
													.append(
															"<tr><td>"
																	+ item.supplier_name
																	+ "</td><td>"
																	+ item.supplier_p_num
																	+ "</td><td><a href=\"#\" class=\"uiButton\" onclick=\"deleteSupplierItem('"
																	+ item.pk
																	+ "');\">刪除</a></td></tr>");

										});
						$(".uiButton").each(function() {
							$(this).linkbutton({
								iconCls : "icon-cancel"
							});
						});

					},
					error : function(a, b, c) {
						alert(a + "\n" + b + "\n" + c);
					}
				});

	}

	function openeditdd() {

		$('#editdd').dialog(
				{
					title : '修改項目',
					width : 1000,
					height : 400,
					closed : false,
					cache : false,
					modal : true,
					resizable : true,
					close : function(event, ui) {
						$("#ItemData").datagrid('clearSelections').datagrid(
								'clearChecked');
					},
					buttons : {
						'確認更新' : function() {
							updateData();
							$(this).dialog('close');

						}
					}
				});

	}

	function openadddd() {

		$('#adddd').dialog({
			title : '新增項目',
			width : 600,
			height : 400,
			closed : false,
			cache : false,
			modal : true,
			resizable : true,
			buttons : {
				'確認新增' : function() {
					addData();
					$(this).dialog('close');
				}
			},
			open : function(event, ui) {

			}
		});

	}

	function setData(jsonObj) {

		$("#p_id").val(jsonObj["p_id"]);
		$("#p_num").val(jsonObj["p_num"]);
		$("#p_my_num").val(jsonObj["p_my_num"]);
		$("#p_name").val(jsonObj["p_name"]);
		$("#p_abbreviation").val(jsonObj["p_abbreviation"]);
		$("#p_barcode").val(jsonObj["p_barcode"]);
		$("#p_unit").val(jsonObj["p_unit"]);
		$("#p_size").val(jsonObj["p_size"]);
		$("#p_count").val(jsonObj["p_count"]);
		$("#p_class_id").val(jsonObj["p_class_id"]);
		$("#p_cost").val(jsonObj["p_cost"]);
		$("#p_price").val(jsonObj["p_price"]);
		$("#p_source_id").val(jsonObj["p_source_id"]);
		$("#p_pic").val(jsonObj["p_pic"]);
		$("#p_actival").children().each(function() {
			if ($(this).val() == jsonObj["p_actival"]) {
				//jQuery給法
				$(this).attr("selected", "selected"); //或是給"selected"也可

			}
		});

		//$("#p_actival").val(jsonObj["p_actival"]);
		$("#p_info").val(jsonObj["p_info"]);
		$("#p_address").val(jsonObj["p_address"]);
		$("#p_licnese").val(jsonObj["p_licnese"]);

		if (imageExists("../productImg/" + jsonObj["p_num"] + ".jpg")) {

			$("#p_img").attr("src",
					"../productImg/" + jsonObj["p_num"] + ".jpg");
			$("#p_img").show();
		} else {
			$("#p_img").hide();
		}

	}

	function imageExists(image_url) {

		var http = new XMLHttpRequest();

		http.open('HEAD', image_url, false);
		http.send();

		return http.status != 404;

	}
	function deleteSupplierItem(pk) {

		$.ajax({
			async : false,
			type : "POST",
			url : "deleteSupplierItem?pk=" + pk,
			encoding : "UTF-8",
			dataType : "json",
			success : function(rtn) {
				querySupplierItem();
			},
			error : function(a, b, c) {
				alert(a + "\n" + b + "\n" + c);
			}
		});

	}
</script>
<!-- 
<style>

 .datagrid-cell{
    font-size:16px;
  }
 
</style>
 -->
</head>
<body>

	<jsp:include page="/top.jsp" />

	<div id='content'>

		<table width="100%">
			<tr>
				<td align="center">
					<table width="95%">
						<tr>
							<td><label>產品管理</label></td>
						</tr>


						<tr>
							<td><table id="ItemData" style="height: 480px; width: 100%"></table></td>
						</tr>

					</table>
				</td>
			</tr>

		</table>

	</div>

	<div style="display: none;">
		<div id="deletedd">
			<form id='deleteForm'>
				<table id='deleteTable' border="1">
				</table>
			</form>
		</div>

	</div>



	<div style="display: none;">
		<div id="editdd">
			<form id='editForm'>

				<table width="100%">
					<tr>
						<td width="50%">
							<table class="tablecss1">
								<tr>
									<td colspan="2" align="center"><label>產品</label> <input
										type="hidden" name='p_id' id='p_id'></td>
								</tr>
								<tr>
									<td width="160" align="right"><label>產品編號</label></td>
									<td><input type="text" name='p_num' id='p_num'></td>

								</tr>
								<tr>
									<td align="right"><label>產品編號(MY)</label></td>
									<td><input type="text" name='p_my_num' id='p_my_num'>
									</td>
								</tr>
								<tr>
									<td align="right"><label>名稱</label></td>
									<td><input type="text" name='p_name' id='p_name'></td>
								</tr>
								<tr>
									<td align="right"><label>縮寫</label></td>
									<td><input type="text" name='p_abbreviation'
										id='p_abbreviation' size="20"></td>
								</tr>
								<tr>
									<td align="right"><label>條碼</label></td>
									<td><input type="text" name='p_barcode' id='p_barcode'>
									</td>
								</tr>
								<tr>
									<td align="right"><label>產品單位</label></td>
									<td><input type="text" name='p_unit' id='p_unit'></td>
								</tr>
								<tr>
									<td align="right"><label>規格</label></td>
									<td><input type="text" name='p_size' id='p_size'></td>
								</tr>
								<tr>
									<td align="right"><label>目前數量</label></td>
									<td><input type="text" name='p_count' id='p_count'></td>
								</tr>
								<tr>
									<td align="right"><label>類別</label></td>
									<td><input type="text" name='p_class_id' id='p_class_id'>
									</td>
								</tr>
								<tr>
									<td align="right"><label>成本</label></td>
									<td><input type="text" name='p_cost' id='p_cost'></td>
								</tr>
								<tr>
									<td align="right"><label>售價</label></td>
									<td><input type="text" name='p_price' id='p_price'></td>
								</tr>
								<!-- <tr>
									<td align="right"><label>供應商</label></td>
									<td><input type="text" name='p_source_id' id='p_source_id'>
									</td>
								</tr>
 								-->
								<tr>
									<td align="right"><label>是否上架</label></td>
									<td><select name='p_actival' id='p_actival'>
											<option value="0">未上架</option>
											<option value="1">上架</option>
									</select></td>
								</tr>

								<tr>
									<td align="right"><label>資訊</label></td>
									<td><input type="text" name='p_info' id='p_info'></td>

								</tr>
								<tr>
									<td align="right"><label>倉庫位置</label></td>
									<td><input type="text" name='p_address' id='p_address'></td>

								</tr>
								<tr>
									<td align="right"><label>認證</label></td>
									<td><input type="text" name='p_license' id='p_license'></td>

								</tr>

							</table>
						</td>

						<td valign="top" width="50%">
							<table width="100%" class="tablecss1">
								<tr>
									<td align="right"><label>圖片位置</label></td>
								</tr>
								<tr>

									<td>
										<!-- The fileinput-button span is used to style the file input field as button -->
										<span class="btn btn-success fileinput-button"> <i
											class="glyphicon glyphicon-plus"></i> <span>圖片上傳</span> <!-- The file input field used as target for the file upload widget -->
											<input id="fileupload" type="file" name="files[]" multiple>
									</span> <br> <br> <!-- The global progress bar -->
										<div id="progress" class="progress">
											<div class="progress-bar progress-bar-success"></div>
										</div> <!-- The container for the uploaded files -->
										<div id="files" class="files"></div>

									</td>
								</tr>

								<tr>
									<td><img src="" id="p_img"></td>
								</tr>

							</table>


						</td>
					</tr>

				</table>

			</form>
		</div>

	</div>

	<div style="display: none;">
		<div id="adddd">
			<form id='addForm'>
				<table class="tablecss1">
					<tr>
						<td colspan="2" align="center"><label>產品</label> <input
							type="hidden" name='p_id' id='addp_id' value="11"></td>
					</tr>
					<tr>
						<td width="160" align="right"><label>產品編號</label></td>
						<td><input type="text" name='p_num' id='addp_num' value="" maxlength="5"></td>

					</tr>
					<tr>
						<td align="right"><label>產品編號(MY)</label></td>
						<td><input type="text" name='p_my_num' id='addp_my_num'
							value=""></td>
					</tr>
					<tr>
						<td align="right"><label>名稱</label></td>
						<td><input type="text" name='p_name' id='addp_name' value=""></td>
					</tr>
					<tr>
						<td align="right"><label>縮寫</label></td>
						<td><input type="text" name='p_abbreviation'
							id='addp_abbreviation' size="20" value=""></td>
					</tr>
					<tr>
						<td align="right"><label>條碼</label></td>
						<td><input type="text" name='p_barcode' id='addp_barcode'
							value=""></td>
					</tr>
					<tr>
						<td align="right"><label>產品單位</label></td>
						<td><input type="text" name='p_unit' id='addp_unit' value=""></td>
					</tr>
					<tr>
						<td align="right"><label>規格</label></td>
						<td><input type="text" name='p_size' id='addp_size' value=""></td>
					</tr>
					<tr>
						<td align="right"><label>目前數量</label></td>
						<td><input type="text" name='p_count' id='addp_count'
							value="0"></td>
					</tr>
					<tr>
						<td align="right"><label>類別</label></td>
						<td><input type="text" name='p_class_id' id='addp_class_id'
							value="1"></td>
					</tr>
					<tr>
						<td align="right"><label>成本</label></td>
						<td><input type="text" name='p_cost' id='addp_cost' value="0"></td>
					</tr>
					<tr>
						<td align="right"><label>售價</label></td>
						<td><input type="text" name='p_price' id='addp_price'
							value="0"></td>
					</tr>
					<!-- <tr>
						<td align="right"><label>供應商</label></td>
						<td><input type="text" name='p_source_id' id='addp_source_id'
							value="0"></td>
					</tr> -->
					<!-- <tr>
						<td align="right"><label>圖片位置</label></td>
						<td><input type="file" name='p_pic' id='addp_pic' value=""></td>
					</tr> -->
					<tr>
						<td align="right"><label>是否上架</label></td>
						<td><select name='p_actival' id='addp_actival'>
								<option value="0">未上架</option>
								<option value="1">上架</option>
						</select></td>
					</tr>
					<tr>
						<td align="right"><label>資訊</label></td>
						<td><input type="text" name='p_info' id='addp_info' value=""></td>

					</tr>
					<tr>
						<td align="right"><label>倉庫位置</label></td>
						<td><input type="text" name='p_address' id='addp_address'></td>

					</tr>
					<tr>
						<td align="right"><label>認證</label></td>
						<td><input type="text" name='p_license' id='addp_license'></td>

					</tr>

				</table>
			</form>
		</div>

	</div>

	<form id='autoComplateForm'>
		<input type="hidden" name="queryInput" id="queryInput">
	</form>

	<div style="display: none;">
		<div id="barcodedd">

			<table class="tablecss1">
				<tr>
					<td align="center"><label>廠商條碼(商品:<span
							id='barcodeItem'></span>)
					</label></td>
				</tr>
				<tr>
					<td>

						<form id='supplierItemForm'>
							<table width="100%">
								<tr>
									<td><input type="hidden" name="p_num" id='barcodeP_num'>
										<select name="supplier_id" id="barcodeSupplier_id">

									</select></td>
									<td><input type="text" name='supplier_p_num'
										id='barCodeSupplier_p_num' value=""></td>
									<td><button type="button" class="btn btn-info"
											onclick="addSupplierItem();">新增</button></td>
								</tr>
							</table>
						</form>

					</td>


				</tr>
				<tr>
					<td>
						<table width="100%" id="supplierItemList">

						</table>
					</td>
				</tr>




			</table>

		</div>

	</div>




</body>
</html>