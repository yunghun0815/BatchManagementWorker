
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/css/log/log.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="/js/log/log.js"></script>
<main id="main">
	<div class="title">
		<h1>로그 관리</h1>
	</div>
	<div class="content">
		<div class="main-content">
			<h3>그룹 로그 관리
				<div id="title-action-box">
					<img id="search" class="action-icon" src="/image/common/action/search.png">
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
						<li class="d-flex group" onclick="groupDetail(this)">
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
			<span class="warning">그룹 로그를 선택해주세요.</span>
			<ul>
				
			</ul>
			<!-- <span style="line-height:670px;font-size: 2.5em;color:white;vertical-align:middle;">그룹을 선택해주세요.</span> -->
		</div>
	</div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<%@ include file="/WEB-INF/views/log/detailLogModal.jsp" %>