
// 날짜 yyyy-mm-dd hh:mm:ss 형식으로 변경
function dateFormat(date){
	function pad(n) { return n<10 ? "0" + n : n}
	
	if(date == null){
		return "-";
	}else{
		const d = new Date(date);
		
		return d.getFullYear()+"-"+
	    pad(d.getMonth()+1)+"-"+
	    pad(d.getDate())+" "+
	    pad(d.getHours())+":"+
	    pad(d.getMinutes())+":"+
	    pad(d.getSeconds())	
	}
	
}

// 재실행 회차 클릭시 해당 프로그램 로그 슬라이드 토글형식으로 출력
function toggleProgram(e){
	const target = $(e);
	
	const batGrpLogId = $(".sub-content-title").text();
	let batGrpRtyCnt = target.find(".retry-cnt").text();
	batGrpRtyCnt -= 1;
	
	// 값을 이미 불러왔으면 사라지게하기
	if(target.find("ol li").length != 0){
		
		target.find("ol").slideToggle();
		
		return false;
	}
	
	let view = '';
	$.ajax({
		url: "/log/group/detail/retry?batGrpLogId="+batGrpLogId+"&batGrpRtyCnt="+batGrpRtyCnt,
		type: "GET",
		success: function(result){
			for(var i=0; i<result.length; i++){
				const batPrmLog = result[i];
				
				view += `
					<li class="d-flex program">
						<table style="font-size: 0.8em;">
							<tr>
								<th>프로그램ID</th>
								<td class="batPrmId">`+ batPrmLog['batPrmId'] +`</td>
							</tr>
							<tr>
								<th>프로그램명</th>
								<td>` + batPrmLog['batPrmNm'] + `</td>
							</tr>
							<tr>
								<th>실행결과</th>
								<td>` + batPrmLog['batPrmStCd'] + `</td>
							</tr>
							<tr>
								<th>파라미터</th>
								<td>` + batPrmLog['param'] + `</td>
							</tr>
							<tr>
								<th>배치시작시간</th>
								<td>` + dateFormat(batPrmLog['batBgngDt']) + `</td>
							</tr>
							<tr>
								<th>배치종료시간</th>
								<td>` + dateFormat(batPrmLog['batEndDt']) + `</td>
							</tr>
						</table>
						<div class="program-ord"><span>` + batPrmLog['excnOrd'] + `</span></div>
						<div class="program-active">
							<div data-bs-toggle="modal" data-bs-target="#detail-log-modal" onclick="programDetail(this)">
								<img src="/image/detail.png" class="menu-box action-icon" id="detail">
							</div>
						</div> 
					</li>`;
			}
			
			target.find("ol").html(view); // view에 만들고
			target.find("ol").slideToggle(); // 슬라이드 토글 이벤트
		}
	});
}

// 그룹 클릭 -> 해당 그룹의 프로그램 로그 및 차수별 그룹 로그 출력
function groupDetail(e){
	$(".sub-content .warning").hide();
	
	const batGrpLogId = $(e).find("div:first-child span").text();
	$.ajax({
		url: "/log/group/detail?batGrpLogId=" + batGrpLogId,
		type: "GET",
		success: function(result){
			const batPrmLogList = result['batPrmLogList'];
			const batGrpLog = result['batGrpLog'];
			
			let btn = '<img class="restart-btn" src="/image/reload.png" onclick="restart(this)">';
			
			// 마지막차수 실패면 재실행버튼 생성
			btn = batGrpLog[batGrpLog.length-1]['batGrpStCd'] == '실패' ? btn : btn='a';  
			let view = `
				<li>
					<div class="sub-content-title">`
						+ batGrpLogId  +
					`</div>
					`+ btn +`
				</li>`; 
			if(batGrpLog.length == 1){
				for(var i=0; i<batPrmLogList.length; i++){
					
					view += `<li class="d-flex program">
						<table style="font-size: 0.8em;">
						<tr>
							<th>프로그램ID</th>
							<td class="batPrmId">`+ batPrmLogList[i]['batPrmId'] +`</td>
						</tr>
						<tr>
							<th>프로그램명</th>
							<td>테스트</td>
						</tr>
						<tr>
							<th>실행결과</th>
							<td>`+ batPrmLogList[i]['batPrmStCd'] +`</td>
						</tr>
						<tr>
							<th>파라미터</th>
							<td>`+ batPrmLogList[i]['param'] +`</td>
						</tr>
						<tr>
							<th>배치시작시간</th>
							<td>` + dateFormat(batPrmLogList[i]['batBgngDt']) + `</td>
						</tr>
						<tr>
							<th>배치종료시간</th>
							<td>` + dateFormat(batPrmLogList[i]['batEndDt']) + `</td>
						</tr>
					</table>
					<div class="program-ord"><span>` + batPrmLogList[i]['excnOrd'] + `</span></div>
					<div class="program-active">
						<div data-bs-toggle="modal" data-bs-target="#detail-log-modal" onclick="programDetail(this)">
							<img src="/image/detail.png" class="menu-box action-icon" id="detail">
						</div>
					</div> 
				</li>`;
					
					$(".sub-content ul").html(view);
					
				}
			}else{
				for(var i=0; i<batGrpLog.length; i++){
					let cnt = batGrpLog[i]['batGrpRtyCnt'];
					cnt += 1;
					view += `<li class="rty-list" onclick="toggleProgram(this)"><p><span class="retry-cnt">` + cnt + `</span>회차 실행결과 : ` + batGrpLog[i]['batGrpStCd'] + `</p><ol></ol></li>`;
					$(".sub-content ul").html(view);
				}
			}
		}
	});
}

// 프로그램 로그 상세 정보
function programDetail(e){
	
	const batGrpLogId = $(e).closest(".sub-content").find(".sub-content-title").text(); // 그룹 로그 아이디
	let batGrpRtyCnt = $(e).closest(".rty-list").find(".retry-cnt").text();
	if(batGrpRtyCnt == '' || batGrpRtyCnt == null){
		batGrpRtyCnt = 0;
	}else{
		batGrpRtyCnt -= 1;
	}
	const batPrmId = $(e).closest(".program").find(".batPrmId").text(); // 배치 프로그램 아이디 
	
	event.stopPropagation(); // 버블링 중단
	$.ajax({
		url: "/log/program/detail",
		type: "GET",
		data: {
			batGrpLogId: batGrpLogId,
			batGrpRtyCnt: batGrpRtyCnt,
			batPrmId: batPrmId
		},
		success: function(result){
			console.log(result)
			const table = $("#detail-log-modal .log-detail");
			
			table.find(".batPrmId").text(result['batPrmId']);
			table.find(".batPrmNm").text(result['batPrmNm']);
			table.find(".batPrmStCd").text(result['batPrmStCd']);
			table.find(".rsltMsg").val(result['rsltMsg']);
			table.find(".param").text(result['param']);
			table.find(".batBgngDt").text(dateFormat(result['batBgngDt']));
			table.find(".batEndDt").text(dateFormat(result['batEndDt']));
		}
	});
}

// 배치 재실행 (Sweet Alert 라이브러리 사용)
function restart(e){
	const batGrpLogId = $(e).prev().text();
	console.log(batGrpLogId);
	
	swal("재실행할 범위를 지정해 주세요", {
		buttons: {
			restartAll: {
				text: "프로그램 전체",
				value: "all",
			},
			restartFail: {
				text: "실패한 프로그램만",
				value: "onlyFail"	
			},
				cancel: "취소"
			},
	})
	.then((value) => {
  		switch (value) {
 
			case "all":
				$.ajax({
				 	url: "/batch/retry/all?batGrpLogId=" + batGrpLogId,
				 	type: "POST",
				 	success: function(result){
						console.log(result);
			 			} 
		  		});
				swal("", "그룹이 재실행되었습니다.", "success")
      			.then(() => {
					location.reload();  
	  			});
      		break;
 
			case "onlyFail":
				$.ajax({
				 	url: "/batch/retry/fail?batGrpLogId=" + batGrpLogId,
				 	type: "POST",
				 	success: function(result){
						console.log(result);
			 			} 
		  		});
		      	swal("", "실패한 프로그램이 재실행되었습니다.", "success")
		      	.then(() => {
				  location.reload();
		  		});
	      		break;
	      		
		}
	});
}