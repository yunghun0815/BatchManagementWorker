<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/batch/batch.css">

<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<script>
   	//차트 색상 랜덤
	$(function() {
		function randomColor(labels) {
			var colors = [];
			for (let i = 0; i < labels.length; i++) {
				colors.push("#" + Math.round(Math.random() * 0xffffff).toString(16));
			}
			return colors;
		}
		function makeChart(ctx, type, labels, data) {
			var myChart = new Chart(ctx, {
			    type: type,
			    data: {
			        labels: labels,
			        datasets: [{
			            label: '날짜별 게시글 등록 수',
			            data: data,
			            backgroundColor: randomColor(labels)
			        }]
			    },
			    options: {
				    responsive: false,
			        scales: {
			            yAxes: [{
			                ticks: {
			                    beginAtZero: true
			                }
			            }]
			        }
			    }
			});
		}
		
		$.ajax({
			
			type: "GET",
			url: "/log/pieChart",
			dataType : "json",
			success: function(result) {
				
				console.log(result);
				
				
				var labels = [];
				var myData = [];
				
				for(let i=0;i<result.length;i++)
				//맵안에 list 였으니 for문으로 돌린다
				/* $.each(data.list,function (k,v){
					
					labels.push(v.reg_date);
					myData.push(v.count);
				});

				var newLabels = labels.slice(-5);
				var newMyData = myData.slice(-5);
				// Chart.js 막대그래프 그리기
				var ctx = $('#myChart');
				// Chart.js 원그래프 그리기
				ctx = $('#myChart3');
				makeChart(ctx, 'pie', newLabels, newMyData); */
			}
		});
		
	});
</script>
</head>

<main id="main">
	<div class="title">
		<h1>일일점검관리</h1>
	</div>
	<div class="content">
		<div class="main-content">
			<h1>게시물데이터그래프화</h1>
			
			
				<canvas id="myChart3"></canvas>
				<canvas id="myChart4"></canvas>
		</div>
	</div>
</main>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>