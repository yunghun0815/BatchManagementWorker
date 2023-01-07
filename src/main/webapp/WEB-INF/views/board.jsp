
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="common/header.jsp"%>

<head>

<style type="text/css">
/* 공통 부분 */
@font-face {
	font-family: 'NanumSquareNeo-Variable';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}
* {
	font-family: 'NanumSquareNeo-Variable';
}
.title {
	margin: 30px;
}
.title h1{  /* 추가했음 */
		font-weight: bold;
}
.content {
	margin: 10px;
	margin-left: 40px;
}

/* 그룹 부분 - 메인 */
.main-content {
	float: left;
	width:70%;
}

.main-list {
	
}

.main-list ul {
	padding-left: 5px;
	text-align: center;
}

.list-header{
	height: 50px;
	line-height: 50px;
	justify-content: space-around;
	padding: 0 30px;
}
/* .list-header span{
	text-align: center;
}
 */
.group {
	justify-content: space-around;
	padding: 0 30px;
	background-color: white;
	line-height: 50px;
	border-radius: 20px; 
	line-height: 45px;
	display: flex;
	background-color: white;
	margin: 6px;
	height: 50px;
	text-align: center;
	margin-bottom:15px;
	font-size: 0.9em;
}

.group div {
	text-align: center;
}
.group:hover {
	cursor: pointer;
	border: 2px solid #79c2cc;
	box-shadow: 1px 4px 5px 3px #79c2cc36;
}

.group-id{
	width:13%;
}
.group-nm{
	width:13%;
}
.group-host{
	width:22%;
}
.group-cron{
	width:22%;
}
.group-conn{
	width:10%;
}
.group-running {
	width:10%;
}

.group-running label {
	margin: auto;
	margin-top:10px;
}

.group-active {
	width:10%;
}

.group-active a {
	text-decoration: none;
	border:1.5px solid #acb9c7;
	height: 28px;
	width:28px;
	display:inline-block;
	vertical-align:middle;
	margin:3px;
	border-radius:5px;
	margin-top:6px;
}



.group-active img {
	width: 20px;
	vertical-align:super;
	padding-top:2.5px;
}

.insert-btn{
    width: 26px;
    height: 26px;
    border-radius: 6px;
    background-color: #13c3dc;
    font-size: 0.7em;
    text-align: center;
    line-height: 25px;
    font-weight: bold;
    border: none;
    color: white;
    vertical-align: text-top;
}


/* 그룹 부분 - 서브 */
.sub-content{
	float: right;
	width:29%;
	background-color: #374c70;
	border-radius: 30px;
	height: 670px;
	margin-left: 8px;
}
.sub-


/* 토글 */
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
$(function(){
	// 페이지별 메뉴 색 변경
	 $(".group-active a").mouseover(function(){
		$(this).css("border","1.5px solid #0CA3B9");
		$(this).find(".menu-box").prop("src", "/image/"+ $(this).find(".menu-box").prop("id") +"_after.png");
	})
	$(".group-active a").mouseleave(function(){
		$(this).css("border","1.5px solid #acb9c7");
		$(this).find(".menu-box").prop("src", "/image/"+ $(this).find(".menu-box").prop("id") +".png");
	})
}); 
function change(img){
	
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
			<h3>배치 그룹 관리&nbsp;
				<button class="insert-btn">+</button></h3>
			<div class="main-list">
				<ul>
					<li class="d-flex list-header">
						<div class="group-id"><span>그룹ID</span></div>
						<div class="group-nm"><span>그룹명</span></div>
						<div class="group-host"><span>호스트명(IP)</span></div>
						<div class="group-cron"><span>주기</span></div>
						<div class="group-conn"><span>연결상태</span></div>
						<div class="group-running"><span>실행</span></div>
						<div class="group-active"><span>Actions</span></div>
					</li>
					<c:forEach var="group" items="${batGrpList}">
						<li class="d-flex group" onclick="prmList(this)">
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
								<a
									href="<c:url value='/batch/group/detail?grpId=${item.batGrpId}'/>">
									<img src="/image/detail.png" class="menu-box" id="detail">
								</a> <a
									href="<c:url value='/batch/group/delete?grpId=${item.batGrpId}'/>">
									<img src="/image/delete.png" class="menu-box" id="delete">
								</a>
							</div>
						</li>
					</c:forEach>
					<ul>
			</div>
		</div>
		<div class="sub-content">
			<span>그룹을 선택해주세요.</span>
		</div>
	</div>
</main>

<%@ include file="common/footer.jsp"%>