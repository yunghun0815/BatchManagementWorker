
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="common/header.jsp"%>

<head>

<style type="text/css">
@font-face {
	font-family: 'NanumSquareNeo-Variable';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

.toggleSwitch {
	width: 47px;
	margin: 3px;
	height: 24px;
	display: block;
	position: relative;
	border-radius: 30px;
	background-color: #fff;
	box-shadow: 0 0 16px 3px rgb(0 0 0/ 15%);
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

.title {
	margin: 30px;
	margin-top: 20px;
}

.content {
	margin: 10px;
	margin-left: 40px;
}

.main-content {
	
}

.main-list {
	
}

.main-list ul {
	
}


* {
	font-family: 'NanumSquareNeo-Variable';
}

h1, h3 {
	font-weight: bold;
}

.group{
	line-height: 45px;
	display: flex;
	background-color: white;
	margin: 6px;
	height : 50px; 
	text-align: center;
}
.group-id{
	width: 20%;
}
.group-nm{
	width: 10%;

}
.group-host{
	width: 15%;
}
.group-cron{
	width: 15%;

}
.group-conn{
	width: 10%;

}
.group-running{
	width: 10%;
	margin-top: 10px;
}
.group-running label{
	margin: auto;
}
.group-active{
	width: 20%;

}
.group-active a{
	text-decoration: none;
}
.group-active img{
	width:20px;
}

.main-list ul {
    padding-left: 8px;
}
.group div{
	border: 1px solid black;}
	

</style>
<script type="text/javascript">
function prmList(grp){
	const grpId = $(grp).find("$(group-id)").attr("id");
	alert(grpId);
	
}
window.onload = function(){
	const $toggle = document.querySelector(".toggleSwitch");

	$toggle.onclick = () => {
	  $toggle.classList.toggle('active');
	}
}
</script>
</head>

<main id="main">
	<div class="title">
		<h1>배치 관리</h1>
	</div>
	<div class="content">
		<!-- <div class="search-content">검색</div> -->
		<div class="main-content">
			<h3>배치 그룹 관리</h3>
			<div class="main-list">
				<ul>
					<c:forEach var="group" items="${batGrpList}">
						<li class="group" onclick="prmList(this)" style="border: 1px solid black;">
							<div class="group-id">
								<span>${group.batGrpId}</span>
							</div>
							<div class="group-nm">
								<span>${group.batGrpNm}</span>
							</div>
							<div class="group-host">
								<span>${group.hostNm}(${group.hostIp})</span>
							</div>
							<div class="group-cron">
								<span> <c:if test="${empty group.cronDsc}">
									${group.cron}
							</c:if> <c:if test="${not empty group.cronDsc}">
									${group.cronDsc}
								</c:if></span>
							</div>
							<div class="group-conn">
								<c:if test="${group.conn == 'on'}">
									<span class="conn_enabled">enabled</span>
								</c:if>
								<c:if test="${group.conn == 'off'}">
									<span class="conn_disabled">disabled</span>
								</c:if>
							</div>
							<div class="group-running">

								<c:if test="${group.runCheck eq true}">
									<label for="toggle" class="toggleSwitch active"> <span
										class="toggleButton"></span></label>
								</c:if>
								<c:if test="${group.runCheck eq false}">
									<label for="toggle" class="toggleSwitch"> <span
										class="toggleButton"></span></label>
								</c:if>
							</div>
							<div class="group-active">
								<a href="<c:url value='/batch/group/detail?grpId=${item.batGrpId}'/>">
									<img src="/image/detail_before.png">
								</a>
								<a href="<c:url value='/batch/group/delete?grpId=${item.batGrpId}'/>">
									<img src="/image/delete_before.png">
								</a>
							</div>
						</li>
					</c:forEach>
					<ul>
			</div>
		</div>
		<div class="sub-content">
			<!-- 프로그램리스트 -->
		</div>
	</div>
</main>

<%@ include file="common/footer.jsp"%>