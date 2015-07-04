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








<title>成亮公司庫存管理</title>


<script language="javascript">
	$(document).ready(function() {
		ini_datagrid();
		setFilter();

	});
	function setFilter() {

		$('#ItemData').datagrid('enableFilter');

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
		} ];

		$('#ItemData').datagrid({
			url : "querySupplier",

			singleSelect : true,
			rownumbers : true,

			//onClickRow : onClickRow,
			idField : 'pk',
			singleSelect : true,
			selectOnCheck : true,
			checkOnSelect : true,
			pagination : true,
			pageSize : 15,

			pageList : [ 10, 15, 20, 25 ],
			columns : [ [ {
				field : 'ck',
				checkbox : true
			},

			{
				title : '供應商編號',
				field : 'supplier_id',
				width : 80,
				editor : 'text',
				sortable : "true"
			}, {
				title : '供應商名稱',
				field : 'supplier_name',
				width : 160,
				editor : 'text',
				sortable : "true"
			}, {
				title : '供應商連絡人',
				field : 'supplier_contact',
				width : 120,
				editor : 'text',
				sortable : "true"
			}, {
				title : '供應商電話',
				field : 'supplier_phone',
				width : 120,
				editor : 'text'
			} ] ],
			toolbar : toolbar
		});

	}

	function insert() {
		openadddd();
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

	function addData() {
		var data = $("#addForm").serialize();

		$.ajax({
			async : false,
			type : "POST",
			url : "insertSupplier",
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
				url : "querySupplyByPk?pk=" + row.pk,
				encoding : "UTF-8",

				//contentType : "text/html; charset=UTF-8",
				dataType : "json",
				success : function(rtn) {
					setData(rtn);
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

	function setData(jsonObj) {

		$("#u_pk").val(jsonObj["pk"]);
		$("#u_supplier_id").val(jsonObj["supplier_id"]);
		$("#u_supplier_name").val(jsonObj["supplier_name"]);
		$("#u_supplier_phone").val(jsonObj["supplier_phone"]);
		$("#u_supplier_contact").val(jsonObj["supplier_contact"]);
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
	
	function updateData() {
		var data = $("#editForm").serialize();
		
		$.ajax({
			async : false,
			type : "POST",
			url : "updateSupplier",
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

	function deleteData() {
		var data = $("#deleteForm").serialize();
		$.ajax({
			async : false,
			type : "POST",
			url : "deleteSupplier",
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

	function deleteDate() {
		var checkedItems = $('#ItemData').datagrid('getChecked');

		$("#deleteTable").html("");
		var hasDelete = false;
		$("#deleteTable")
				.append(
						"<tr><td align='center'>供應商編號</td><td align='center'>供應商名稱</td></tr>");
		$
				.each(
						checkedItems,
						function(index, item) {
							hasDelete = true;

							$("#deleteTable")
									.append(
											"<tr><td>"
													+ item.supplier_id
													+ "<input type='hidden' name='deleteId' value='"+item.pk+"'></td><td>"
													+ item.supplier_name
													+ "</td></tr>");

						});
		if (hasDelete) {
			openDeletedd();
		} else {
			alert("至少選擇一筆");
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
					<table width="95%">
						<tr>
							<td><label>供應商管理</label></td>
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
		<div id="adddd">
			<form id='addForm'>
				<table class="tablecss1">
					<tr>
						<td colspan="2" align="center"><label>供應商</label> <input
							type="hidden" name='pk' id='pk' value="" maxlength="5"></td>
					</tr>
					<tr>
						<td width="160" align="right"><label>供應商編號</label></td>
						<td><input type="text" name='supplier_id' id='supplier_id'
							value="" maxlength="5"></td>

					</tr>
					<tr>
						<td width="160" align="right"><label>供應商名稱</label></td>
						<td><input type="text" name='supplier_name'
							id='supplier_name' value="" maxlength="50"></td>

					</tr>
					<tr>
						<td width="160" align="right"><label>供應商聯絡人</label></td>
						<td><input type="text" name='supplier_contact'
							id='supplier_contact' value="" maxlength="20"></td>

					</tr>
					<tr>
						<td width="160" align="right"><label>供應商電話</label></td>
						<td><input type="text" name='supplier_phone'
							id='supplier_phone' value="" maxlength="20"></td>

					</tr>

				</table>
			</form>
		</div>

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
						<td>
							<table class="tablecss1">
								<tr>
									<td colspan="2" align="center"><label>供應商</label> <input
										type="hidden" name='pk' id='u_pk'></td>
								</tr>

								<tr>
									<td width="160" align="right"><label>供應商編號</label></td>
									<td> <input type="text" name='supplier_id' id='u_supplier_id' maxlength='5'></td>
								</tr>
								<tr>
									<td width="160" align="right"><label>供應商名稱</label></td>
									<td> <input type="text" name='supplier_name' id='u_supplier_name'></td>
								</tr>
								<tr>
									<td width="160" align="right"><label>供應商連絡人</label></td>
									<td> <input type="text" name='supplier_phone' id='u_supplier_phone'></td>
								</tr>
								<tr>
									<td width="160" align="right"><label>供應商連絡電話</label></td>
									<td> <input type="text" name='supplier_contact' id='u_supplier_contact'></td>
								</tr>
					
							</table>
						</td>


					</tr>

				</table>

			</form>
		</div>

	</div>


</body>
</html>