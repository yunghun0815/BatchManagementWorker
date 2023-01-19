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
								<td class="batPrmNm">` + batPrmLog['batPrmNm'] + `</td>
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
								<img src="/image/common/action/detail.png" class="menu-box action-icon" id="detail">
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
	$(e).parent().find(".group").removeClass("group-hover");
	$(e).addClass("group-hover");
	
	
	$(".sub-content .warning").hide();
	
	const batGrpLogId = $(e).find("div:first-child span").text();
	$.ajax({
		url: "/log/group/detail?batGrpLogId=" + batGrpLogId,
		type: "GET",
		success: function(result){
			const batPrmLogList = result['batPrmLogList'];
			const batGrpLog = result['batGrpLog'];
			
			let btn = '<img class="restart-btn" src="/image/common/action/restart.png" onclick="restart(this)">';
			// 마지막차수 실패면 재실행버튼 생성
			btn = batGrpLog[batGrpLog.length-1]['batGrpStCd'] == '실패' ? btn : btn='';  
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
							<td class="batPrmNm">`+ batPrmLogList[i]['batPrmNm'] +`</td>
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
							<img src="/image/common/action/detail.png" class="menu-box action-icon" id="detail">
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
				
				// 해당 그룹 로그의 0회차 프로그램 리스트
				let batPrmLogList = getBatPrmLogListByGrpLog(batGrpLogId,0);
				
				restartFailLog(batGrpLogId, batPrmLogList, 'all');
      		break;
 
			case "onlyFail":
				let batGrpRtyCnt = $(".rty-list").length;
				batGrpRtyCnt = batGrpRtyCnt == 0 ? 0 : batGrpRtyCnt-1;
				// 해당 그룹 로그의 0회차 프로그램 리스트
				let failPrmLogList = getBatPrmLogListByGrpLog(batGrpLogId,batGrpRtyCnt);
				
				restartFailLog(batGrpLogId, failPrmLogList, 'fail');
			
	      		break;
	      		
		}
	});
}

/**
	재실행 요청 함수
	@param batGrplogId = 배치 그룹 로그 아이디
	@param failPrmLogList = 원하는 회차의 프로그램 로그 리스트
 */
function restartFailLog(batGrpLogId, failPrmLogList, cmd){
	// 파라미터 입력 form 생성
	let failDiv = document.createElement("div");
	failDiv.id = "param-box";
	failPrmLogList.forEach((e)=>{
		let p = document.createElement("p");
		let span = document.createElement("span");
		span.innerText = e.batPrmNm;
		let input = document.createElement("input");
		input.id = e.batPrmId;
		input.value = e.defaultParam != null ? e.defaultParam : '';
		p.append(span, input);
		failDiv.append(p);
	});
	
	
	swal({
	  title: "파라미터를 입력해주세요.",
	  text: "현재 입력된 값은 프로그램에 등록된 파라미터입니다.",
	  icon: "info",
	  content: failDiv,
	  buttons: {
		  재실행: {
			  value: "restart"
		  },
		  취소: {
			  value: "cancel"
		  }
	  }
	  
	})
	.then((value) => {
		if(value == "restart"){
			let param = {batGrpLogId: batGrpLogId};
			
			$("#param-box p").each((index, element)=>{
				let id = $(element).find("input").prop("id");
				let val = $(element).find("input").val();
				param[id] = val;	
			});
			console.log(param);
			$.ajax({
			 	url: "/batch/retry/"+cmd,
			 	type: "POST",
			 	contentType: "application/json; charset=utf-8",
			 	data: JSON.stringify(param),	 
			 	success: function(result){
					console.log(result);
		 			} 
	  		});
			swal("", "그룹이 재실행되었습니다.", "success")
  			.then(() => {
				location.reload();  
  			});
			
			swal("", "재실행이 완료되었습니다.", "success").then(() => {
				location.reload();
			});
		}
	});
}

// 그룹 로그 회차별 배치 프로그램 리스트
function getBatPrmLogListByGrpLog(batGrpLogId, batGrpRtyCnt){
	let programList;
	
	$.ajax({
		url: "/log/group/detail/retry?batGrpLogId="+batGrpLogId+"&batGrpRtyCnt="+batGrpRtyCnt,
		type: "GET",
		async: false,
		success: function(result){
			programList = result;
		}
	});
	return programList;
}