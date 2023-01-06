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

<style type="text/css">
.main_content{
	width:1600px;
	height: 700px;
	border: 1px solid black;
	margin:auto;
	
}
.search_content{
	width: 100%;
	height:150px;
	border:1px solid black;
}
</style>
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

<ul></ul>

</body>
</html>