<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#main{
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
.toggleSwitch {
    width: 47px;
    margin: 3px;
    height: 24px;
    display: block;
    position: relative;
    border-radius: 30px;
    background-color: #fff;
    box-shadow: 0 0 16px 3px rgb(0 0 0 / 15%);
    cursor: pointer;
}

.toggleSwitch .toggleButton {
	width: 18px;
    height: 18px;
    position: absolute;
    top: 50%;
    left: 4px;
    transform: translateY(-50%);
    border-radius: 50%;
    background: #f03d3d;
}

.toggleSwitch.active {
  background: #f03d3d;
}

.toggleSwitch.active .toggleButton {
  left: calc(100% - 22px);
  background: #fff;
}

.toggleSwitch, .toggleButton {
  transition: all 0.2s ease-in;
}

li{
	display: flex;
}
</style>
<script type="text/javascript">
window.onload = function(){
	const $toggle = document.querySelector(".toggleSwitch");

	$toggle.onclick = () => {
	  $toggle.classList.toggle('active');
	}
}
</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div id="main">
	<div class="title"><h1>배치 관리</h1></div>
	<div class="search_content"></div>
	<div class="managment_content">
		<h2>배치 그룹 관리</h2>
		<div class="batch_list">
			<ul>
				<c:forEach var="group" items="${batGrpList}">
					<li class="">
						<div class="group_id"><span>${group.batGrpId}</span></div>
						<div class="group_id"><span>${group.batGrpNm}</span></div>
						<div class="group_id"><span>${group.hostNm}(${group.hostIp})</span></div>
						<div><span>
								<c:if test="${empty group.cronDsc}">
									${group.cron}
							</c:if>
								<c:if test="${not empty group.cronDsc}">
									${group.cronDsc}
								</c:if></span></div>
						<div>
							<c:if test="${group.conn == 'on'}">
								<span class="conn_enabled">enabled</span>
							</c:if>
							<c:if test="${group.conn == 'off'}">
								<span class="conn_disabled">disabled</span>
							</c:if></div>
						<div>
							<c:if test="${group.runCheck eq true}">
								<label for="toggle" class="toggleSwitch">
								<span class="toggleButton"></span></label>
							</c:if>
							<c:if test="${group.runCheck eq false}">
								<label for="toggle" class="toggleSwitch">
								<span class="toggleButton"></span></label>
							</c:if></div>
					</li>
				</c:forEach>
			<ul>
		</div>
	</div>
</div>
</body>
</html>