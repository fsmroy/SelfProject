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
		
	});

	
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
							<td><label>產品管理</label></td>
						</tr>


						<tr>
							<td><table id="ItemData" style="height: 500px; width: 100%"></table></td>
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
					<tr>
						<td align="right"><label>供應商</label></td>
						<td><input type="text" name='p_source_id' id='p_source_id'>
						</td>
					</tr>
					<tr>
						<td align="right"><label>圖片位置</label></td>
						<td><input type="file" name='p_pic' id='p_pic'></td>
					</tr>
					<tr>
						<td align="right"><label>是否上架</label></td>
						<td><input type="text" name='p_actival' id='p_actival'>
						</td>
					</tr>
					<tr>
						<td align="right"><label>資訊</label></td>
						<td><input type="text" name='p_info' id='p_info'></td>

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
						<td><input type="text" name='p_num' id='addp_num' value=""></td>

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
					<tr>
						<td align="right"><label>供應商</label></td>
						<td><input type="text" name='p_source_id' id='addp_source_id'
							value="0"></td>
					</tr>
					<tr>
						<td align="right"><label>圖片位置</label></td>
						<td><input type="file" name='p_pic' id='addp_pic' value=""></td>
					</tr>
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

				</table>
			</form>
		</div>

	</div>

	<form id='autoComplateForm'>
		<input type="hidden" name="queryInput" id="queryInput">
	</form>



</body>
</html>