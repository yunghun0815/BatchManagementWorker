<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/log/monitor.css">
<script type="text/javascript" src="/js/log/log.js"></script>
<script type="text/javascript" src="/js/log/monitor.js"></script>
<main id="main">
	<div class="title">
		<h1>모니터링</h1>
	</div>
	<div class="content">
		<div id="console-box" class="d-flex justify-content-around">
			<div id="management-console" class="console">
				<h5>Management Server Console</h5>
				<ul>
					<%-- <li>
						<% pageContext.setAttribute("newLine", "\n"); %>
						${fn:replace(management, newLine, "<br/>")}
					</li> --%>
					<c:forEach items="${management}" var="item">
						<li>${item}</li>
					</c:forEach>
				</ul>
			</div>
			<div id="agent-console" class="console">
				<h5>Agent Server Console</h5>
				<ul>
					<%-- <li>
						<% pageContext.setAttribute("newLine", "\n"); %>
						${fn:replace(agent, newLine, "<br/>")}
					</li> --%>
					<c:forEach items="${agent}" var="item">
						<li>${item}</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</main>
<script type="text/javascript">
	
</script>
<%@ include file="/WEB-INF/views/log/detailLogModal.jsp" %>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>