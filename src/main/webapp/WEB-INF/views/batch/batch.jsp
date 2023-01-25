<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/batch/batch.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="/js/batch/batch.js"></script>
<script type="module" src="/js/batch/batchValid.js"></script>
<head>

</head>

<main id="main">
	<div class="title">
		<h1>배치 관리</h1>
	</div>
	<div class="content">
		<!-- <div class="search-content">검색</div> -->
		<div class="main-content">
			<h3>배치 그룹 관리
				<div id="title-action-box">
					<img id="search" class="action-icon" src="/image/common/action/search.png">
					<div id="search-box" >
						<form action="/batch/group/search" method="GET">
							<table>
								<tr>
									<td>
										<span>그룹명</span>
									</td>
									<td colspan="3">
										<input type="text" name="batGrpNm" value="${param.batGrpNm}">
									</td>
								</tr>
								<tr>
									<td>
										<span>그룹설명</span>
									</td>
									<td colspan="3">
										<input type="text" name="batGrpDsc" value="${param.batGrpDsc}">
									</td>
								</tr>
								<tr>
									<td>
										<span>호스트</span>
									</td>
									<td colspan="3">
										<input type="text" name="hostNm" value="${param.hostNm}">
									</td>
								</tr>
								<tr>
									<td>
										<span>주기</span>
									</td>
									<td colspan="3">
										<input type="text" name="cronDsc" value="${param.cronDsc}">
									</td>
								</tr>
								<tr>
									<td>
										<span>자동실행</span>
									</td>
									<td>
										<select name="autoExcnYn" value="${param.autoExcnYn}">
											<option value="">All</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select>
									</td>
									<td>
										<span>사용유무</span>
									</td>
									<td>
										<select name="useYn" value="${param.useYn}">
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="4" id="search-action">
										<input class="submit-btn" type="submit" value="검색"> 
										<input class="reset-btn" type="reset" value="취소">
									</td>
								</tr>
							</table>
						</form>
					</div>
					<button class="insert-grp-btn" data-bs-toggle="modal" data-bs-target="#insert-batch-group">+</button>
				</div>
			</h3>
			<div class="main-list">
				<ul>
					<c:if test="${useYn == 'Y' or empty useYn}">
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
							<li class="d-flex group">
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
										<img src="/image/common/action/conn.png" onclick="checkHealth(this)" class="conn_enabled">
									</c:if>
									<c:if test="${group.conn == 'off'}">
										<img src="/image/common/action/disConn.png" onclick="checkHealth(this)" class="conn_disabled">
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
									<div onclick="startGrp(this,'${group.batGrpId}')">
										<img src="/image/common/action/play.png" class="menu-box" id="play">
									</div> 
									<div onclick="getUpdateGrpInfo(this)"
										data-bs-toggle="modal" data-bs-target="#detail-batch-group">
										<img src="/image/common/action/detail.png" class="menu-box" id="detail">
									</div> 
									<div onclick="grpDelete('${group.batGrpId}')">
										<img src="/image/common/action/delete.png" class="menu-box" id="delete">
									</div>
								</div>
							</li>
						</c:forEach>
					</c:if>
					<c:if test="${useYn == 'N'}">
						<li class="d-flex list-header">
							<div class="group-id"><span>그룹ID</span></div>
							<div class="group-nm"><span>그룹명</span></div>
							<div class="group-host"><span>호스트명(IP)</span></div>
							<div class="group-cron"><span>주기</span></div>
							<div class="group-info"><span>정보</span></div>
							<div class="group-rollback"><span>Action</span></div>
						</li>
						<c:forEach var="group" items="${batGrpList}">
							<li class="d-flex group">
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
								<div class="group-active">
									<div onclick="getUpdateGrpInfo(this)"
										data-bs-toggle="modal" data-bs-target="#detail-batch-group">
										<img src="/image/common/action/detail.png" class="menu-box" id="detail">
									</div> 
								</div> 
								<div class="group-rollback">
										<button class="rollback-btn" onclick="rollback(this)">복구</button>
							
								</div>
							</li>
						</c:forEach>
					</c:if>
					<li>
						<c:if test="${pager.totalRows > 0}">
							<div id="page-box">
								<c:set var="url" value="/batch"/>
									<c:if test="${not empty search}">
									<c:set var="url" value="/batch/group/search" />
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
				</ul>
			</div>
		</div>
		<div class="sub-content" value="">
			<div class="grp" style="height: 28.8px"></div>
			<div class="prmList"><span class="warning">그룹을 선택해주세요.</span></div>
			<div class="btn-wrap"></div>
		</div>
	</div>
</main>


<%@ include file="/WEB-INF/views/batch/groupDetail.jsp" %>
<%@ include file="/WEB-INF/views/batch/programDetail.jsp" %>
<%@ include file="/WEB-INF/views/batch/insertGroup.jsp" %>
<%@ include file="/WEB-INF/views/batch/insertProgram.jsp" %>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>