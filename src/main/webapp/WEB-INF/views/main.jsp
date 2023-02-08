
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/common/main.css">

<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<script type="text/javascript" src="/js/common/main.js"></script>


<!-- 버전 2 (특정 버전) -->
</head>
<main id="main">
	<div class="title">
		<h1><span></span>
				<img id="search" class="date-search" src="/image/common/action/calendar.png">
				<div id="search-box">
					<form id="search-action">
						<input type="date" name="calendar">
						<input type="submit" value="조회">
						<input type="reset" value="취소">
					</form>
				</div>
		</h1>
	</div>
	<div class="content chart">
		<h3>스케줄 JOB 상태별현황</h3>
		<div class="status-btn-wrap">
			<ul>

				<li class="status-btn total"><span></span></li>
				<li class="status-btn running"><span></span></li>
				<li class="status-btn success"><span></span></li>
				<li class="status-btn fail"><span></span></li>
			</ul>
		</div>
		<div class="status-chart-board">
			<ul>
				<li><canvas id="runningChart" width="200" height="100"></canvas></li>
				<li><canvas id="successChart" width="200" height="100"></canvas></li>
				<li><canvas id="failChart" width="200" height="100"></canvas></li>
			</ul>
		</div>
		<h3>
			일일점검
			<a class="report-download-btn">보고서 다운로드</a>
		</h3>
		<div class="total-chart-board">
			<canvas id="totalChart" width="700" height="350"></canvas>
		</div>
	</div>
</main>

<%@ include file="common/footer.jsp" %>



