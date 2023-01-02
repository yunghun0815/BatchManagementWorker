<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" ></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script type="module" src="/js/host/host.js"></script>
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<span data-bs-toggle="modal" data-bs-target="#insert-host-modal">호스트등록</span>
	<ul>
		<c:forEach var="host" items="${hostList}">
			<li>
				<span class="detail-host" data-bs-toggle="modal" data-bs-target="#detail-host-modal">${host.hostId}</span>
				<span id="${host.hostId}" class="host-delete-button">삭제</span>
				<%-- /host/detail?hostId=${host.hostId} --%>
			</li>
		</c:forEach>
	</ul>
</body>

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
</html>