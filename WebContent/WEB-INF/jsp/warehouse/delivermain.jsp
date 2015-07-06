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
<style>
  .datagrid-cell{
   font-size: 18px;
	line-height: 30px;
	text-shadow: 1px 1px 1px #fff;
  }
</style>

<script language="javascript">
	$(document).ready(function() {
		$("#startDate").datepicker({
			defaultDate : "-1m",
			changeMonth : true,
			showOn : "both",
			buttonImage : "../common/img/calendar.png",
			buttonImageOnly : true,
			numberOfMonths : 2,
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
			dateFormat : "yy-mm-dd",
			showOn : "both",
			buttonImage : "../common/img/calendar.png",
			buttonImageOnly : true,
			changeMonth : true,
			numberOfMonths : 2,
			onClose : function(selectedDate) {
				$("#startDate").datepicker("option", "maxDate", selectedDate);
			}
		});

		$("#endDate").datepicker("setDate", "0d");

		query();
	});

	function query() {

		var data = $("#queryForm").serialize();
		$.ajax({
			async : true,
			type : "POST",
			url : "queryDeliverByDate",
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

	function setFilter() {
		$('#tt').datagrid('enableFilter');
	}

	function iniTreegrid(data) {

		$('#tt').datagrid({

			singleSelect : true,
			rownumbers : true,
			data : data,
			

			idField : 'jsonId',
			singleSelect : true,

			pagination : true,
			pageSize : 10,

			pageList : [ 10, 15, 20, 25 ],
			//columns :  [propertiesColumn],
			columns : [ [ {
				field : 'deliver_id',
				title : '出貨編號',
				align : "cneter",
				
			}, {
				field : 'customer',
				title : '客戶',
			
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'total',
				title : '出貨總額',
				
				align : "right",
				dataalign : "right"
			}, {
				field : 'createDate',
				title : '出貨日期',
				
				align : "cneter",
				
			}, {
				field : 'p_num',
				title : '產品編號',
				align : "center",
				
			}, {
				field : 'p_name',
				title : '產品名稱',
				width : 300,
				align : "center"
			}, {
				field : 'p_count_out',
				title : '出貨數量',
				align : 'right'
			}, {
				field : 'p_price',
				title : '出貨單價',
				align : 'right'
			}, {
				field : 'signer',
				title : '出貨人',
			
				align : "cneter",
				dataalign : "right"
			},

			] ],
		});

		/*$('#tt').treegrid({

			idField : 'jsonId',
			treeField : 'deliver_id',
			pagination : "true",
			data : data,
			columns : [ [ {
				field : 'signer',
				title : '出貨人',
				width : 100,
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'customer',
				title : '客戶',
				width : 100,
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'createDate',
				title : '出貨日期',
				width : 200,
				align : "cneter",
				dataalign : "right"
			}, {
				field : 'deliver_id',
				title : '出貨編號',
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
				field : 'p_count_out',
				title : '出貨數量',
				align : 'right'
			}, {
				field : 'p_price',
				title : '出貨單價',
				align : 'right'
			},

			] ],
			animate : false,
			rownumbers : true
		});*/

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
							<td align="left"><label
								style="font-size: 26px; font-weight: bold;">出貨列表</label></td>
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