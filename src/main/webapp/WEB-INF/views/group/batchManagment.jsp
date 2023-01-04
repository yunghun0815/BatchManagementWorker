<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function batPrmList(grp){
	const grpId = $(grp).children("#groupId").text();
	
	$.ajax({
		url: "/batch/program?grpId=" + grpId;
	
				
	});
}
</script>
</head>
<body>
<table border=1>
	<tr>
		<th>그룹ID</th>
		<th>그룹명</th>
		<th>그룹설명</th>
		<th>호스트명</th>
		<th>IP</th>
		<th>주기</th>
		<th class="text-center button-td">상세보기</th>
		<th class="text-center button-td">삭제하기</th>
	</tr>
	<c:forEach var="item" items="${ batGrpList}">
		<tr onclick="batPrmList(this)">
			<td id="groupId">${item.batGrpId}</td>
			<td>${item.batGrpNm }</td>
			<td>${item.batGrpDsc }</td>
			<td>${item.hostNm}</td>
			<td>${item.hostIp }</td>
			<td>${item.cron }</td>
			<td><a href="<c:url value='/batch/group/detail?grpId=${item.batGrpId}'/>">상세보기</a>
			<td><a href="<c:url value='/batch/group/delete?grpId=${item.batGrpId}'/>">삭제</a>
		</tr>
	</c:forEach>
</table>
</body>
</html>