/**
 *  main 페이지 자바스크립트
 */

 $(function() {

	var now = new Date();
	var yesterday = new Date(now.setDate(now.getDate() - 1));
	let year = yesterday.getFullYear();
	let month = yesterday.getMonth() + 1;
	let day = yesterday.getDate();
	$(".title h1 span").append(
			year + "년 " + month + "월 " + day + "일자 배치 현황");
	var param = '';
	let paramYear = String(year).substr(2);
	let paramMonth = String(month);
	let paramDay = String(day);
	
	
	if(paramMonth.length==1) paramMonth = "0" + paramMonth; 
	if(paramDay.length==1) paramDay = "0" + paramDay; 
	
	param = paramYear + paramMonth + paramDay;
	
	makeChart(param);
	
	$(".report-download-btn").attr("href","/download/excel?date="+year+"-"+paramMonth+"-"+paramDay);

	$("#search-action").submit(
		function(e) {
			e.preventDefault();
			
			var date = $("input[name=calendar]").val();
			let titleYear = date.split("-")[0];
			let titleMonth = date.split("-")[1];
			let titleDay = date.split("-")[2];
			
			if(titleMonth[0] == '0') titleMonth = titleMonth.substr(1);
			if(titleDay[0] == '0') titleDay = titleDay.substr(1);
			$(".title h1 span").empty().append(titleYear + "년 " + titleMonth + "월 " + titleDay + "일자 배치 현황");
			param = date.replaceAll("-","").substr(2);
			
			makeChart(param);
			
			$(".report-download-btn").attr("href","/download/excel?date="+date);

	})
	function makeStatusChart(ctx, type, status, data) {
		let color = "";
		if (status == "running")
			color = "#076df8";
		else if (status == "success")
			color = "#686868";
		else if (status == "fail")
			color = "#e60012";

		let statusRate = Math.round(data[0] / (data[0] + data[1]) * 100)
		console.log(statusRate)

		var myChart = new Chart(ctx, {
			type : type,
			data : {
				labels : [ status, "" ],
				datasets : [ {
					label : [ status, "" ],
					data : data,
					backgroundColor : [ color, "#f4f4f4" ]
				} ]
			},
			options : {
				tooltips : {
					enabled : false
				},
				responsive : false,
				legend : {
					display : false
				},
				cutoutPercentage : 70,
				animation : {
					onProgress : function() {
						this.chart.ctx.font = "bold 1.2em Verdana";
						this.chart.ctx.textBaseline = "middle";
						if (statusRate < 10)
							this.chart.ctx.fillText(statusRate + "%", 85,
									50);
						else
							this.chart.ctx.fillText(statusRate + "%", 76,
									50);
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
				datasets : [ {
					label : labels,
					data : data,
					backgroundColor : [ "#076df8", "#e60012", "#686868" ]
				} ]
			},
			options : {
				responsive : false,
				legend : {
					position : 'right',
					offsetY : 0,
					height : 230,
				},
				cutoutPercentage : 55,
				animation : {
					onProgress : function() {
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
	function makeChart(date) {
		
		$.ajax({
			type : "GET",
			url : "/log/pieChart?date=" + date,
			dataType : "json",
			success : function(result) {
				$(".status-chart-board").empty();
				$(".total-chart-board").empty();
				if (result["total"] == 0) {
					$(".status-chart-board")
							.append(
									"<div class='non-data div1'><div>실행된 배치 프로그램이 없습니다.</div></div>");
					$(".total-chart-board")
							.append(
									"<div class='non-data div2'><div>실행된 배치 프로그램이 없습니다.</div></div>");
					$(".report-download-btn").hide();
				} else {
					$(".report-download-btn").show();
					$(".status-chart-board")
						.append(
							`<ul>
								<li><canvas id="runningChart" width="200" height="100"></canvas></li>
								<li><canvas id="successChart" width="200" height="100"></canvas></li>
								<li><canvas id="failChart" width="200" height="100"></canvas></li>
							</ul>`);
					$(".total-chart-board")
						.append(
							`<canvas id="totalChart" width="700" height="350"></canvas>`);
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
					ctx.empty();
					makeTotalChart(ctx, 'doughnut', newLabels,
							newMyData, result["total"]);
					ctx = $('#runningChart');
					ctx.empty();
					makeStatusChart(ctx, 'doughnut', "running", [
							result["running"],
							result["total"] - result["running"] ]);
					ctx = $('#successChart');
					ctx.empty();
					makeStatusChart(ctx, 'doughnut', "success", [
							result["success"],
							result["total"] - result["success"] ]);
					ctx = $('#failChart');
					ctx.empty();
					makeStatusChart(ctx, 'doughnut', "fail", [
							result["fail"],
								result["total"] - result["fail"] ]);

					}
					$(".total span").empty().append("Total JOBs: " + result["total"]);
					$(".success span").empty().append("작업 완료: " + result["success"]);
					$(".fail span").empty().append("작업 오류: " + result["fail"]);
					$(".running span").empty().append("실행중: " + result["running"]);
				}
		});
	}

});