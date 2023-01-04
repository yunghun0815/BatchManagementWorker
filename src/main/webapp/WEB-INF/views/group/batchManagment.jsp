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
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function batPrmList(grp){
	const grpId = grp.closest("#groupId").text();
	alert(grpId);
	
	//$.ajax({
	//	url: "/batch/program?grpId=" + grpId
	//});
}
</script>
</head>
<body>
<table border=1>
	<tr>
		<th>�׷�ID</th>
		<th>�׷��</th>
		<th>�׷켳��</th>
		<th>ȣ��Ʈ��</th>
		<th>IP</th>
		<th>�ֱ�</th>
		<th class="text-center button-td">�󼼺���</th>
		<th class="text-center button-td">�����ϱ�</th>
	</tr>
	<c:forEach var="item" items="${ batGrpList}">
		<tr onclick="batPrmList(this)">
			<td id="groupId">${item.batGrpId}</td>
			<td>${item.batGrpNm }</td>
			<td>${item.batGrpDsc }</td>
			<td>${item.hostNm}</td>
			<td>${item.hostIp }</td>
			<td>${item.cron }</td>
			<td><a href="<c:url value='/batch/group/detail?grpId=${item.batGrpId}'/>">�󼼺���</a>
			<td><a href="<c:url value='/batch/group/delete?grpId=${item.batGrpId}'/>">����</a>
		</tr>
	</c:forEach>
</table>
</body>
</html>