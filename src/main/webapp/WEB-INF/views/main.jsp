<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">


</script>
<title>Insert title here</title>
</head>
<body>
<a href="<c:url value='/batch/group'/>">배치그룹보기</a>
<a href="<c:url value='/batch/searchPage'/>">배치그룹검색</a>

<form action="/batch/path" enctype="multipart/form-data" method="POST" id="fform">
<input type="file" id="file" value="" name="file" onchange="this.select(); document.getElementById('file_path').value=document.selection.createRange().text.toString();">
<input type="text" name="file_path" size="100">
<button type="submit">제출</button>
</form>
<br>
<br>
<table class="group-table table table-borderless align-middle bg-white" 
style="width:400px; height:200px; margin:auto;" border=2>
	<tr><td>1</td>
		<td>가</td>
		<td>a</td></tr>
	<tr><td>2</td>
		<td>나</td>
		<td>b</td></tr>
	<tr><td>3</td>
		<td>다</td>
		<td>c</td></tr>
	<tr><td>4</td>
		<td>라</td>
		<td>d</td></tr>
	<tr><td>5</td>
		<td>마</td>
		<td>e</td></tr>
</table>
</body>
</html>