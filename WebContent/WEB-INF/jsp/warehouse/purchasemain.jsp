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
<script type="text/javascript"
	src="../jsFramework/jquery-ui-1.11.4.custom/datepicker_zh_TW.js"></script>






<title>成亮公司庫存管理</title>


<script language="javascript">
	$(document).ready(function() {

		$("#startDate").datepicker({
			defaultDate : "-1m",
			changeMonth : true,
			numberOfMonths : 2,
			showOn: "both",
			buttonImage: "../common/img/calendar.png",
			buttonImageOnly: true,
			maxDate : "-1d",
			dateFormat : "yy-mm-dd",
			onClose : function(selectedDate) {
				$("#endDate").datepicker("option", "minDate", selectedDate);
			}
		});

		$("#startDate").datepicker("setDate", "-1m");

		$("#endDate").datepicker({
			defaultDate : "0d",
			maxDate : "0d",
			buttonImage: "../common/img/calendar.png",
			showOn: "both",
			buttonImageOnly: true,
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			numberOfMonths : 2,
			onClose : function(selectedDate) {
				$("#startDate").datepicker("option", "maxDate", selectedDate);
			}
		});
		
		$("#endDate").datepicker("setDate", "0d");
		
		query();

	});

	function setFilter() {
		$('#tt').datagrid('enableFilter');
	}

	function query() {
		if($("#startDate").val()=="" || $("#endDate").val()==""){
			
			alert("請填入開始與結束日期，謝謝~");
			
		}else{
			
			var data = $("#queryForm").serialize();
			$.ajax({
				async : true,
				type : "POST",
				url : "queryPurchaseByDate",
				encoding : "UTF-8",
				data : data,
				//contentType : "text/html; charset=UTF-8",
				dataType : "json",
				success : function(data) {

					iniTreegrid(data);
					setFilter();
				},
				error : function(a, b, c) {
					alert(a + "\n" + b + "\n" + c);
				}
			});
		}
		
	}

	function iniTreegrid(data) {

		$('#tt').treegrid({

			idField : 'jsonId',
			treeField : 'purchase_id',
			data : data,
			pagination : "true",

			columns : [ [ {
				field : 'signer',
				title : '進貨人',
				width : 100,
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'createDate',
				title : '進貨日期',
				width : 200,
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'purchase_id',
				title : '進貨編號',
				width : 200
			}, {
				field : 'total',
				title : '總額',
				width : 100,
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'p_num',
				title : '產品編號',
				align : "center",
				dataalign : "right"
			}, {
				field : 'p_name',
				title : '產品名稱',
				width : 300,
				align : "center"
			}, {
				field : 'p_count_in',
				title : '進貨數量',
				align : 'right'
			}, {
				field : 'p_price',
				title : '進貨單價',
				align : 'right'
			}, {
				field : 'p_source_id',
				title : '供應商號',
				align : 'right'
			},

			] ],
			animate : false,
			rownumbers : true
		});

	}
</script>


</head>
<body>

	<jsp:include page="/top.jsp" />

	<div id='content'>

		<table width="100%">

			<tr>

				<td align="center">
					<table width="80%">
						<tr>
							<td align="left"><label
								style="font-size: 26px; font-weight: bold;">進貨列表</label></td>
						</tr>

						<tr>
							<td><hr /></td>
						</tr>

						<tr>
							<td><form id="queryForm">
									開始:<input type="text" id="startDate" name="startDate">
									結束:<input type="text" id="endDate" name="endDate"> <a
										id="btn" href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-search'" onclick="query();">查詢</a>
								</form></td>
						</tr>

						<tr>
							<td><hr /></td>
						</tr>

						<tr>

							<td align="center">
								<table id="tt" style="width: 100%;"></table>
							</td>
						</tr>

					</table>
				</td>
			</tr>

		</table>

	</div>





</body>
</html>