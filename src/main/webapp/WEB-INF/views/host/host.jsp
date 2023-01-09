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
				<img id="search" class="action-icon" src="/image/common/action/search_before.png">
				<div id="search-box" >
					<form action="/host/search">
						<table>
							<tr>
								<td>
									<span>호스트ID</span>
									<input type="text" name="hostId">
								</td>
								<td>
									<span>호스트명</span>
									<input type="text" name="hostNm">
								</td>
								<td>
									<span>아이피</span>
									<input type="text" name="hostIp">
								</td>	
							</tr>
							<tr>
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
						<input type="text" name="hostNm" value="${host.hostNm}" readonly="readonly">
					</div>
					<div>
						<input id="error-update-hostIp" type="text" name="hostIp" value="${host.hostIp}" readonly="readonly">
					</div>
					<div>
						<input id="error-update-hostPt" type="text" name="hostPt" value="${host.hostPt}" readonly="readonly">
					</div>
					<div>
						<img src="/image/common/action/update_before.png" id="update" class="action-icon host-update">
						<img src="/image/common/action/check_before.png" id="check" class="action-icon host-update-complete" style="display: none;">
						<img src="/image/common/action/delete_before.png" id="delete" class="action-icon host-delete">
 						<input type="hidden" name="hostId" value="${host.hostId}">
					</div>
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
		</ul>	
	</div>

</main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<div id="insert-host-modal" class="modal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">호스트 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form:form id="host-insert-form" modelAttribute="host">
				<div class="modal-body">
					<table class="table table-bordered align-middle bg-white">
						<tr>
							<th>호스트명</th>
							<td>
								<form:input path="hostNm" class="form-control" />
								<span id="error-insert-hostNm" class="error-message"></span>
							</td>						
						</tr>
						<tr>
							<th>아이피</th>
							<td>
								<form:input path="hostIp" class="form-control" />
								<span id="error-insert-hostIp" class="error-message"></span>
							</td>						
						</tr>
						<tr>
							<th>포트</th>
							<td>
								<form:input path="hostPt" class="form-control" type="number" min="1" max="65535"/>
								<span id="error-insert-hostPt" class="error-message"></span>
							</td>						
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="submit-btn">등록</button>
					<button type="reset" class="reset-btn" data-bs-dismiss="modal">취소</button>
				</div>
			</form:form>
		</div>
	</div>
</div>