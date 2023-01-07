<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script type="module" src="/js/host/host.js"></script>
<link rel="stylesheet" type="text/css" href="/css/host/host.css">
<style>
	#title-action-box{
		font-size: 16px;
		height: 100%;
		position: relative;
	}
	#title-action-box #search-box{
		display: none;
		position: absolute;
		width: 700px;
		right: 38px;
	    bottom: -80px;
	    border: 1px solid black;
	    background-color: white;
	    padding: 15px;
	}
	#title-action-box #search-box input{
		width: 150px;
	}
	#title-action-box{
		line-height: 48px;
	}
	#title-action-box table{
		width: 100%;
	}
	#title-action-box table td{
		text-align: right;
		padding-top: 15px;
	}
	#title-action-box #search-action input{
		width: 50px
	}
</style>
<main id="main">
	<div class="title">
		<h1>
			<span>호스트 관리</span>
			<div id="title-action-box">
				<img id="search" class="action-icon" src="/image/common/action/search_before.png">
				<div id="search-box" >
					<form action="#">
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
									<input type="submit" value="검색"> 
									<input type="reset" value="취소">
								</td>
							</tr>
						</table>
					</form>
				</div>	
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
			<div id="page-box"><!-- #79c2cc -->
				<c:if test="${pager.groupNo>1}">
					<a class="page-button" href="host?pageNo=${pager.startPageNo-1}"><</a>
				</c:if>
				
				<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
					<c:if test="${pager.pageNo != i}">
						<a class="page-button" href="host?pageNo=${i}">${i}</a>
					</c:if>
					<c:if test="${pager.pageNo == i}">
						<a class="page-button this-page" href="host?pageNo=${i}">${i}</a>
					</c:if>
				</c:forEach>
				
				<c:if test="${pager.groupNo<pager.totalGroupNo}">
					<a class="page-button" href="host?pageNo=${pager.endPageNo+1}">></a>
				</c:if>
			</div>
			</li>
		</ul>	
	</div>

</main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<div id="insert-host-modal" class="modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">호스트 추가</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<form:form id="host-insert-form" modelAttribute="host">
		      	호스트명: <form:input path="hostNm"/><span id="error-insert-hostNm" class="error-message"></span><br>
	      		아이피: <form:input path="hostIp"/><span id="error-insert-hostIp" class="error-message" ></span><br>
	      		포트: <form:input path="hostPt" type="number"/><span id="error-insert-hostIp" class="error-message"></span><br>
	      		<input type="submit" value="전송">
			</form:form>	      	
	      	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary">저장</button>
	      </div>
	    </div>
	  </div>
</div>