<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function selectAll(selectAll){
	$("input[name=filtering]").prop("checked", true);
}
</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="/batch/search">
<input type="checkBox" name="selectAll" onclick="selectAll(this)" value="all">��ü
<input type="checkBox" name="filtering" value="ID">�׷�id
<input type="checkBox" name="filtering" value="NAME">�׷��
<input type="checkBox" name="filtering" value="DSC">�׷켳��
<input type="checkBox" name="filtering" value="HNM">ȣ��Ʈ��
<input type="checkBox" name="filtering" value="HPT">��Ʈ��ȣ
<input type="search" name="keyword">
<button type="submit">����</button>

</form>
</body>
</html>