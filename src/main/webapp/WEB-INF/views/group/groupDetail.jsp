<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table border=1>
	<tr><th>그룹ID</th>
		<td>${grp.batGrpId}</td>
	</tr>
	<tr><th>그룹이름</th>
		<td>${grp.batGrpNm}</td>
	</tr>
	<tr><th>그룹설명</th>
		<td>${grp.batGrpDsc}</td>
	</tr>
	<tr><th>호스트이름</th>
		<td>${grp.hostNm}</td>
	</tr>
	<tr><th>IP</th>
		<td>${grp.hostIp}</td>
	</tr>
	<tr><th>Port</th>
		<td>${grp.hostPt}</td>
	</tr>
	<tr><th>자동여부</th>
		<td>${grp.autoExcnYn}</td>
	</tr>
	<tr><th>cron</th>
		<td>${grp.cron}</td>
	</tr>
	<tr><th>cron설명</th>
		<td>${grp.cronDsc}</td>
	</tr>
</table>
</body>
</html>