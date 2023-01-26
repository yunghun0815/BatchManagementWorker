<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/log/log.css">
<script type="text/javascript" src="/js/log/log.js"></script>
<script type="text/javascript">
	/* const wsAgent = new WebSocket("ws://" + location.host + "/ws/agent"); */
	const wsManagement = new WebSocket("ws://" + location.host + "/ws/management");
	
	/* wsAgent.onmessage = (message) => {
		console.log(message['data']);
	}  */
	console.log(wsManagement);
	wsManagement.onmessage = (message) => {
		console.log(message['data']);
	}
</script>
<main id="main">
	<div class="title">
		<h1>MONITORING</h1>
	</div>
	<div class="content">
		<div class="main-content">
			<span>
			
			</span>
		</div>
	</div>
</main>
<%@ include file="/WEB-INF/views/log/detailLogModal.jsp" %>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>