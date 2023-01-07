<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script type="module" src="/js/host/host.js"></script>
<style>
/* 공통 부분 */
	@font-face {
	    font-family: 'NanumSquareNeo-Variable';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	*{
		font-family: 'NanumSquareNeo-Variable';
	}
	.title{
		margin: 30px; /* 20 -> 30으로 수정 */
		margin-top: 30px;
	}
	.title h1{  /* 추가했음 */
		font-weight: bold;
	}
	.content{
		margin: 10px;
		margin-left: 40px;
	}
/* 호스트 부분 */
	.content{
		width: 1000px;
	}
	.row-header{
		font-weight: bold;
	}
	.content-header{
	    height: 50px;
	    line-height: 50px;
	    justify-content: space-around;
	    padding: 0 30px;
	}
	.content-header>span{
		width: calc(100% / 5);
		text-align: center;
	}
	.content-main{
		height: 70px;
		justify-content: space-around;
		padding: 0 30px;
		background-color: white;
		margin: 10px 0;
		line-height: 70px;
		border-radius: 20px; 
		/* font-size: 0.8em; */
	}
	.content-main>div{
		width: calc(100% / 5);
		text-align: center;
	}
	.content-main:hover {
		cursor: pointer;
		border: 2px solid #79c2cc;
		box-shadow: 
	}
	
	
	/* 임시 */
	.content-main>div:first-child{
		font-weight: bold;
	}
</style>
<main id="main">
	<div class="title">
		<h1>호스트 관리</h1>
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
						<span class="detail-host" data-bs-toggle="modal" data-bs-target="#detail-host-modal">${host.hostId}</span>
					</div>
					<div>
						<span>${host.hostNm}</span>
					</div>
					<div>
						<span>${host.hostIp}</span>
					</div>
					<div>
						<span>${host.hostPt}</span>
					</div>
					<div>
						<span id="${host.hostId}" class="host-delete-button">삭제</span>
					</div>
					<%-- /host/detail?hostId=${host.hostId} --%>
				</li>
			</c:forEach>
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

<div id="detail-host-modal" class="modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">호스트 상세페이지</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<form:form id="host-update-form" modelAttribute="host">
	      		호스트ID: <form:input path="hostId" readonly="true" /><span id="error-update-hostId" class="error-message"></span><br>
		      	호스트명: <form:input path="hostNm" readonly="true" /><span id="error-update-hostNm" class="error-message"></span><br>
	      		아이피: <form:input path="hostIp" readonly="true" /><span id="error-update-hostIp" class="error-message" ></span><br>
	      		포트: <form:input path="hostPt" readonly="true" type="number" min="0" max="65535"/><span id="error-update-hostPt" class="error-message"></span><br>
	      		<input type="submit" value="전송">
			</form:form>	      	
	      	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" id="update-host-button">수정</button>
	        <button type="submit" class="btn btn-primary">저장</button>
	      </div>
	    </div>
	  </div>
</div>