<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script type="module" src="/js/host/host.js"></script>
<link rel="stylesheet" type="text/css" href="/css/host/host.css">
<main id="main">
	<div class="title">
		<h1>
			<span>호스트 관리</span>
			<div id="title-action-box">
				<img id="search" class="action-icon" src="/image/common/action/search.png">
				<div id="search-box" >
					<form action="/host/search">
						<table>
							<tr>
								<td>
									<span>호스트명</span>
								</td>
								<td>
									<input type="text" name="hostNm" value="${param.hostNm}">
								</td>
								<td>
									<span>아이피</span>
								</td>	
								<td>
									<input type="text" name="hostIp" value="${param.hostIp}">
								</td>
							</tr>
							<tr>
								<td>
									<span>포트</span>
								</td>
								<td>
									<input type="number" name="searchPt" value="${param.searchPt}">
								</td>
								<td>
									<span>사용유무</span>
								</td>
								<td>
									<select name="useYn">
										<option value="Y">Y</option>
										<option value="N" <c:if test="${param.useYn eq 'N'}">selected</c:if>>N</option>
									</select>
								</td>
								<td colspan="3" id="search-action">
									<input class="submit-btn" type="submit" value="검색"> 
									<input class="reset-btn" type="reset" value="취소">
								</td>
							</tr>
						</table>
					</form>
				</div>	
				<button class="insert-btn" data-bs-toggle="modal" data-bs-target="#insert-host-modal">+</button>
			</div>
		</h1>
	</div>
	<!-- <span data-bs-toggle="modal" data-bs-target="#insert-host-modal">호스트등록</span> -->
	<div class="content">
		<ul>
			<li class="d-flex content-header">
				<span>호스트ID</span>
				<span>호스트명</span>
				<span>아이피</span>
				<span>포트</span>
				<span>Action</span>
			</li>
			<c:forEach var="host" items="${hostList}">
				<li class="d-flex content-main">
					<div>
						<span>${host.hostId}</span>
					</div>
					<div>
						<input type="text" name="hostNm" value="${host.hostNm}" title="${host.hostNm}" readonly="readonly">
					</div>
					<div>
						<input id="error-update-hostIp" type="text" name="hostIp" value="${host.hostIp}" readonly="readonly">
					</div>
					<div>
						<input id="error-update-hostPt" type="text" name="hostPt" value="${host.hostPt}" readonly="readonly">
					</div>
					<c:if test="${empty param.useYn or param.useYn eq 'Y'}">
						<div>
							<div class="action-icon-box">
								<img src="/image/common/action/update.png" id="update" class="action-icon host-update">
								<img src="/image/common/action/check.png" id="check" class="action-icon host-update-complete" style="display: none;">
							</div>
							<div class="action-icon-box">
								<img src="/image/common/action/delete.png" id="delete" class="action-icon host-delete">
							</div>
	 						<input type="hidden" name="hostId" value="${host.hostId}">
						</div>
					</c:if>
					<c:if test="${not empty param.useYn and param.useYn eq 'N'}">
						<div>
							<button class="rollback-btn" onclick="rollback(this)">복구</button>
						</div>
					</c:if>
				</li>
			</c:forEach>
			<li>
				<c:if test="${pager.totalRows > 0}">
					<div id="page-box">
						<c:set var="url" value="/host"/>
						<c:if test="${not empty search}">
							<c:set var="url" value="/host/search" />
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
						<div>검색하신 조건의 호스트가 존재하지 않습니다.</div>
					</li>
				</c:if>
			</c:if>
		</ul>	
	</div>

</main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/host/insertHostModal.jsp" %>
