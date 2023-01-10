
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">

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
	margin: 6px 0;
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

.group-running label {
	margin: auto;
	margin-top:10px;
}

.group-active {
	width:10%;
}

.group-active div {
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


/* 그룹 부분 - 서브 */
.sub-content{
	float: right;
	width:29%;
	background-color: #374c70;
	border-radius: 30px;
	height: 670px;
	margin-left: 8px;
}

.sub-content ul{
	height:640px;
	overflow: auto;
	padding: 1px;
    margin: 17px auto;
	-ms-overflow-style: none;
}

.sub-content ul::-webkit-scrollbar{
  display:none;
}
.program{
	position: relative;
	background-color: white;
    width: 90%;
    margin: 10px auto;
    height: 145px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    padding: 10px 5px 10px 15px;
    margin-top: 14px;
}
.program .program-id{
	font-size: 0.3em;
	height: 15px;
}
.program .program-nm{
	font-size: 1.6em;
	font-weight: bold;
	height: 40px;
}
.program .program-ord{
	font-size: 1.5em;
    margin-left: 287px !important;
    position: absolute !important;
    width: 59px;
    height: 36px;
    text-align: center;
    background-color: #374c709e;
    color: white;
    border-radius: 5px !important;
    line-height: 36px;
    margin-top: 11px;
	
}
.program .program-path{
	font-size: 0.8em;
	height: 30px;
	
	padding-top: 1px;
    padding-left: 3px;
    color: #908c8c;
}
.program .program-active{
	display: flex;
    flex-direction: row;
}
.program .program-active div{
	border: 1.5px solid #acb9c7;
	padding:2.5px;
	display:inline-block;
	vertical-align:middle;
	margin:4px;
	border-radius:5px;
	margin-top:6px;
	margin-right: 5px;
	position: relative;
	left: 302px;
	bottom: 35px;
	
}
.program .program-active div:hover{
	cursor: pointer;
}
.program .program-active img{
	width:23px;
	height: 23px;
}
.program .program-active>div:hover{
	border: 1.5px solid #79c2cc;
}
#title-action-box{
	right: 25px;
}
.sub-content-title{
	font-size: 1.2em;
	color: white;
	text-align: center;
	font-weight: bold;
}
.main-list>ul>li{
	width: 970px;
}
.main-list>ul>li>div{
	width: 20%;
}
.main-list>ul>li>div:nth-child(3){
	width: 14%;
}
.main-list>ul>li>div:nth-child(4), .main-list>ul>li>div:nth-child(5){
	width: 23%;
}
.program th{
	text-align: left;
}
.list-header>div, .group>div{
	width: calc(100%/5);
}
#page-box{
	margin: 0 auto;
}

</style>
</head>
<main id="main">
	<div class="title">
		<h1>로그 관리</h1>
	</div>
	<div class="content">
		<!-- <div class="search-content">검색</div> -->
		<div class="main-content">
			<h3>그룹 로그 관리
				<div id="title-action-box">
					<img id="search" class="action-icon" src="/image/common/action/search_before.png">
					<div id="search-box" >
						<form action="/log/search">
							<table>
								<tr>
									<td>
										<span>로그ID</span>
										<input type="text" name="batGrpLogId">
									</td>
									<td>
										<span>그룹ID</span>
										<input type="text" name="batGrpId">
									</td>
									<td>
										<span>배치결과</span>
										<select name="batGrpStCd">
											<option value="">선택해주세요</option>
											<option value="BSSC">성공</option>
											<option value="BSFL">실패</option>
											<option value="BSRN">실행중</option>
											<option value="BSWT">대기</option>
											<option value="BSRS">재실행</option>
										</select>
									</td>	
								</tr>
								<tr>
									<td colspan="2">
										<span>배치시작시간</span>
										<input type="datetime-local" name="batBgngDtStart">&nbsp;&nbsp;~&nbsp;
										<input type="datetime-local" name="batBgngDtEnd">
									</td>
									<td colspan="3" id="search-action">
										<input class="submit-btn" type="submit" value="검색"> 
										<input class="reset-btn" type="reset" value="취소">
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</h3>			
			<div class="main-list">
				<ul>
					<li class="d-flex list-header">
						<div><span>로그ID</span></div>
						<div><span>그룹ID</span></div>
						<div><span>배치결과</span></div>
						<div><span>배치시작시간</span></div>
						<div><span>배치종료시간</span></div>
					</li>
					<c:forEach var="log" items="${batGrpLogList}">
						<li class="d-flex group" onclick="프로그램로그리스트">
							<div>
								<span>${log.batGrpLogId}</span>
							</div>
							<div>
								<span>${log.batGrpId}</span>
							</div>
							<div>
								<span>${log.batGrpStCd}</span>
							</div>
							<div>
								<span>
									<fmt:formatDate value="${log.batBgngDt}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</span>
							</div> 
							<div>
								<span>
									<fmt:formatDate value="${log.batEndDt}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</span>
							</div> 
						</li>
					</c:forEach>
						<li>
							<c:if test="${pager.totalRows > 0}">
								<div id="page-box">
									<c:set var="url" value="/log"/>
									<c:if test="${not empty search}">
										<c:set var="url" value="/log/search" />
									</c:if>
								
									<c:if test="${pager.groupNo>1}">
										<a class="page-button" href="${url}?pageNo=${pager.startPageNo-1}${search}"><</a>
									</c:if>
									<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
										<c:if test="${pager.pageNo != i}">
											<a class="page-button" href="${url}?pageNo=${i}${search}">${i}</a>
										</c:if>
										<c:if test="${pager.pageNo == i}">
											<a class="page-button this-page" href="${url}?pageNo=${i}${search}">${i}</a>
										</c:if>
									</c:forEach>
									
									<c:if test="${pager.groupNo<pager.totalGroupNo}">
										<a class="page-button" href="${url}?pageNo=${pager.endPageNo+1}${search}">></a>
									</c:if>
								</div>
							</c:if>
						</li>
					<ul>
			</div>
		</div>
		<div class="sub-content">
			<ul>
				<li>
					<div class="sub-content-title">
						BGL00000053
					</div>
				</li>
				<li class="d-flex program">
					<table style="font-size: 0.8em;">
						<tr>
							<th>로그ID</th>
							<td>BPL00000022</td>
						</tr>
						<tr>
							<th>프로그램ID</th>
							<td>PRM00000012</td>
						</tr>
						<tr>
							<th>실행결과</th>
							<td>성공</td>
						</tr>
						<tr>
							<th>파라미터</th>
							<td></td>
						</tr>
						<tr>
							<th>배치시작시간</th>
							<td>2023-01-09 00:00:00</td>
						</tr>
						<tr>
							<th>배치종료시간</th>
							<td>2023-01-09 00:00:00</td>
						</tr>
					</table>
					<div class="program-ord"><span>1</span></div>
					<div class="program-active">
						<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="" 
							data-bs-toggl="modal" data-bs-target="#detail-program-log">
							<img src="/image/detail.png" class="menu-box action-icon" id="detail">
						</div>
					</div> 
				</li>
				<li class="d-flex program">
					<div class="program-id"><span>PRM000000001</span></div>
					<div class="program-nm"><span>프로그램 이름</span></div>
					<div class="program-path"><span>C:/dev/batch-agent/test-app1.bat</span></div>
					<div class="program-active">
						<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="" 
							data-bs-toggl="modal" data-bs-target="#detail-batch-program">
							<img src="/image/detail.png" class="menu-box" id="detail">
						</div> 
						<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="prmDelete(` + obj['batPrmId'] + `)">
							<img src="/image/delete.png" class="menu-box" id="delete">
						</div>
						
					</div>
					<div class="program-ord"><span>2</span></div>
				</li>
			</ul>
			<!-- <span style="line-height:670px;font-size: 2.5em;color:white;vertical-align:middle;">그룹을 선택해주세요.</span> -->
		</div>
	</div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<%@ include file="/WEB-INF/views/modal/groupDetail.jsp" %>