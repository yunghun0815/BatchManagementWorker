<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/batch/batch.css">

<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<script>
	//차트 색상 랜덤
	$(function() {
		function randomColor(labels) {
			var colors = [];
			for (let i = 0; i < labels.length; i++) {
				colors.push("#"
						+ Math.round(Math.random() * 0xffffff).toString(16));
			}
			return colors;
		}
		function makeStatusChart(ctx, type, status, data) {
			let color = "";
			if(status == "running") color = "#076df8";
			else if(status == "success") color="#686868";
			else if(status == "fail") color="red";
			
			let statusRate = Math.round(data[0]/(data[0]+data[1])*100)
			console.log(statusRate)
			
			var myChart = new Chart(ctx, {
				type : type,
				data : {
					labels : [status, ""],
					datasets : [{
						label : [status, ""],
						data : data,
						backgroundColor : [color, "#f4f4f4"]
					}]
				},
				options : {
					tooltips : {
						enabled: false
					},
					responsive : false,
					legend : {
						display:false
					},
					cutoutPercentage : 70,
					animation: {
						onProgress: function() {
						      this.chart.ctx.font = "bold 1.2em Verdana";
						      this.chart.ctx.textBaseline = "middle";
						      if(statusRate<10) this.chart.ctx.fillText(statusRate+"%", 85, 50);
						      else this.chart.ctx.fillText(statusRate+"%", 76, 50);
						    }
					}
				}
			});
		}
		function makeTotalChart(ctx, type, labels, data, total) {
			var myChart = new Chart(ctx, {
				type : type,
				data : {
					labels : labels,
					datasets : [{
						label : labels,
						data : data,
						backgroundColor : ["#076df8","red","#686868"]
					}]
				},
				options : {
					responsive : false,
					legend : {
						position : 'right',
						offsetY : 0,
						height : 230,
					},
					cutoutPercentage : 55,
					animation: {
						onProgress: function() {
							  this.chart.ctx.font = "1.4em Verdana";
						      this.chart.ctx.textBaseline = "middle";
						      this.chart.ctx.fillText("전체 Job의 수 :", 215, 170);
						      this.chart.ctx.font = "bold 1.2em Verdana";
						      this.chart.ctx.textBaseline = "middle";
						      this.chart.ctx.fillText(total, 278, 205);
						    }
					}
				}
			});
		}

		$.ajax({

			type : "GET",
			url : "/log/pieChart",
			dataType : "json",
			success : function(result) {

				console.log(result);

				var labels = [];
				var myData = [];

				for ( var key in result) {
					if (key != "total") {

						labels.push(key);
						myData.push(result[key]);
					}
				}
				var newLabels = labels.slice(-3);
				var newMyData = myData.slice(-3);
				// Chart.js 막대그래프 그리기

				
				var ctx = $('#totalChart');
				makeTotalChart(ctx, 'doughnut', newLabels, newMyData, result["total"]);
				ctx = $('#runningChart');
				makeStatusChart(ctx, 'doughnut', "running", [result["running"], result["total"]-result["running"]]);
				ctx = $('#successChart');
				makeStatusChart(ctx, 'doughnut', "success", [result["success"], result["total"]-result["success"]]);
				ctx = $('#failChart');
				makeStatusChart(ctx, 'doughnut', "fail", [result["fail"], result["total"]-result["fail"]]);
				
				$(".total span").append(result["total"]);
				$(".success span").append(result["success"]);
				$(".fail span").append(result["fail"]);
				$(".running span").append(result["running"]);
			}
		});

	});
</script>
<style type="text/css">
.chart ul{
	display: flex;
	position: relative;
}
.status-btn-wrap{
    width: 100%;
    height: 35px;
}

.status-btn-wrap ul{
	float:right;
	margin-right: 20px;
}
.status-btn{
	width: 121px;
    height: 28px;
    border: 1px solid black;
    color: white;
    font-size: 0.8em;
    text-align: center;
    border-radius: 4px;
    margin: 2px;
    
}
.status-btn span{    
	vertical-align: sub;
}
.total{
	background-color: purple;
}
.running{
	background-color: #076df8;
}
.success{
	background-color: #686868;
}
.fail{
	background-color: red;
}

.status-chart-board{
	width: 94%;
    height: 130px;
    margin-top: 12px;
    margin-bottom: 25px;
    margin-left: 27px;
    background-color: white;
}
.status-chart-board ul{
	width: 99%;
    height: 130px;
    margin: 0px auto;
    padding: 0px;
}
.status-chart-board li{
	width: 32%;
    align-self:center;
}
.report-download-btn{
	width: 170px;
    height: 30px;
    background-color: green;
    border-radius: 4px;
    color: white;
    font-size: 0.69em;
    line-height: 25px;
    float: right;
    border: none;
    margin-right: 55px;
}
.total-chart-board{
	width: 94%;
    height: 380px;
    margin-top: 24px;
    margin-bottom: 25px;
    margin-left: 27px;
    background-color: white;
	padding-top: 16px;
}
canvas{
    margin: 0px auto;
}
#total-chart{
	margin: 0px auto;
}
</style>
</head>

<main id="main">
	<div class="title">
		<h1>일일점검관리</h1>
	</div>
	<div class="content chart">
			<h3>스케줄 JOB 상태별현황</h3>
			<div class="status-btn-wrap">
				<ul>

					<li class="status-btn total"><span>Total JOBs: </span></li>
					<li class="status-btn running"><span>실행중: </span></li>
					<li class="status-btn success"><span>작업 완료: </span></li>
					<li class="status-btn fail"><span>작업 오류: </span></li>
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
				<button type="button" class="report-download-btn">보고서 다운로드</button>
			</h3>
			<div class="total-chart-board">
				<canvas id="totalChart" width="700" height="350"></canvas>
			</div>
		</div>
</main>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>