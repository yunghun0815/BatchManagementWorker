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
<input type="checkBox" name="selectAll" onclick="selectAll(this)" value="all">전체
<input type="checkBox" name="filtering" value="ID">그룹id
<input type="checkBox" name="filtering" value="NAME">그룹명
<input type="checkBox" name="filtering" value="DSC">그룹설명
<input type="checkBox" name="filtering" value="HNM">호스트명
<input type="checkBox" name="filtering" value="HPT">포트번호
<input type="search" name="keyword">
<button type="submit">제출</button>

</form>
</body>
</html>