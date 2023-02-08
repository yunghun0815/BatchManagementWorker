<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/log/log.css">
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
									</td>
									<td>
										<input type="text" name="batGrpLogId" value="${param.batGrpLogId}">
									</td>
								</tr>
								<tr>
									<td>
										<span>그룹명</span>
									</td>
									<td>
										<input type="text" name="batGrpNm" value="${param.batGrpNm}">
									</td>
								</tr>
								<tr>
									<td>
										<span>배치결과</span>
									</td>
									<td>
										<select name="batGrpStCd">
											<option value="">전체</option>
											<option value="BSSC" <c:if test="${param.batGrpStCd eq 'BSSC'}">selected</c:if>>성공</option>
											<option value="BSFL" <c:if test="${param.batGrpStCd eq 'BSFL'}">selected</c:if>>실패</option>
											<option value="BSRN" <c:if test="${param.batGrpStCd eq 'BSRN'}">selected</c:if>>실행중</option>
											<option value="BSWT" <c:if test="${param.batGrpStCd eq 'BSWT'}">selected</c:if>>대기</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span>배치시작시간</span>
									</td>
									<td>
										<input type="datetime-local" name="batBgngDtStart" value="${param.batBgngDtStart}">&nbsp;&nbsp;~&nbsp;
										<input type="datetime-local" name="batBgngDtEnd" value="${param.batBgngDtEnd}">
									</td>
								</tr>
								<tr>
									<td>
										<span>배치종료시간</span>
									</td>
									<td>
										<input type="datetime-local" name="batEndDtStart" value="${param.batEndDtStart}">&nbsp;&nbsp;~&nbsp;
										<input type="datetime-local" name="batEndDtEnd" value="${param.batEndDtEnd}">
									</td>
								</tr>
								<tr>
									<td>정렬</td>
									<td>
										<select name="filter">
											<option value="">기본값(최신등록로그)</option>
											<option value="batBgngDtASC" <c:if test="${param.filter eq 'batBgngDtDESC'}">selected</c:if>>배치시작시간(최신순)</option>
											<option value="batBgngDtDESC" <c:if test="${param.filter eq 'batBgngDtASC'}">selected</c:if>>배치시작시간(오래된순)</option>
											<option value="batEndDtASC" <c:if test="${param.filter eq 'batEndDtDESC'}">selected</c:if>>배치종료시간(최신순)</option>
											<option value="batEndDtDESC" <c:if test="${param.filter eq 'batEndDtASC'}">selected</c:if>>배치종료시간(오래된순)</option>
										</select>
									</td>
								</tr>
								<tr>
									<td id="search-action" colspan="2">
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
						<div><span>그룹명</span></div>
						<div><span>배치결과</span></div>
						<div><span>배치시작시간</span></div>
						<div><span>배치종료시간</span></div>
					</li>
					<c:forEach var="log" items="${batGrpLogList}">
						<li class="d-flex group" onclick="groupDetail(this)">
							<div>
								<span>${log.batGrpLogId}</span>
							</div>
							<div class="grpNm" title="${log.batGrpNm}">
								<span >${log.batGrpNm}</span>
							</div>
							<div>
								<c:choose>
									<c:when test="${log.batGrpStCd == '성공'}">
										<c:set var="color" value="green"/>
									</c:when>
									<c:when test="${log.batGrpStCd == '실패'}">
										<c:set var="color" value="red"/>
									</c:when>
									<c:otherwise>
										<c:set var="color" value="black"/>
									</c:otherwise>
								</c:choose>
								<span style="color: ${color}">${log.batGrpStCd}</span>
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
					<c:if test="${pager.totalRows == 0}">
						<c:if test="${empty search}">
							<li id="empty-rows">
								<div>등록된 호스트가 없습니다.</div>
							</li>
						</c:if>
						<c:if test="${not empty search }">
							<li id="empty-rows">
								<div>검색하신 조건의 로그가 존재하지 않습니다.</div>
							</li>
						</c:if>
					</c:if>
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
<%@ include file="/WEB-INF/views/log/detailLogModal.jsp" %>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>