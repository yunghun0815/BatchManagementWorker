
/**
 * 배치 관련 자바스크립트
 */
//import * as util from '../util.js';

$(function(){
	$(".group-nm").tooltip();
	$(".group-host").tooltip();
	$(".group-cron").tooltip();
	
	$("#cron-guide").click(function(){
		if($("#cron-guide-img").css("display") == 'none'){
			$("#cron-guide-img").show();
		}else{
			$("#cron-guide-img").hide();
		}
	})
	
	/* group별 프로그램 목록 출력 Event */
	const group = $(".group");
	group.each(function(){
		$(this).click(function(){
			group.removeClass("group-hover");
			$(this).addClass("group-hover");
			const grpId = $(this).find(".group-id span").text();
			const grpNm = $(this).find(".group-nm span").text();
			let target = $(".sub-content .grp");
			target.empty();
			target.append(grpNm);
			 
			let use = true;
			if($(".group-rollback").length!=0) use = false;
			getPrmList(grpId, "view", use);
			target.prop("id", grpId);
			let conn = false;
			if ($(this).find(".group-conn").find(".conn_enabled").length != 0) conn=true;
			hidePath(conn);
			$(".modal-body input[name=batGrpId]").val(grpId);
		});
	});

	/* actions Events */
	// action 메뉴 아이콘 색 변경하는 마우스 이벤트
	 $(".group-active div").mouseover(function(){
		$(this).css("border","1.5px solid #0CA3B9");
		$(this).find(".menu-box").prop("src", "/image/common/action/"+ $(this).find(".menu-box").prop("id") +"_after.png");
	})
	$(".group-active div").mouseleave(function(){
		$(this).css("border","1.5px solid #acb9c7");
		$(this).find(".menu-box").prop("src", "/image/common/action/"+ $(this).find(".menu-box").prop("id") +".png");
	})
	
	// actions 메뉴 눌렀을 때 부모 이벤트 버블링 제거
	const active = $(".group-active");
	active.each(function(){
		active.click(function(){
			event.stopPropagation();
		});
	});
	
	/* running Events*/
	const toggle = $(".toggleSwitch");
	toggle.each(function(){
		$(this).click(function(){
			let grpId = $(this).closest(".group").find(".group-id span").text();
			//등록된 프로그램 개수
			let length = getPrmList(grpId, "length");
			//현재 실행 여부
			var execute = $(this).hasClass('active');
			//연결 상태
			var conn = $(this).closest(".group").find(".group-conn img").hasClass('conn_enabled');
			
			if(execute || conn){
				if(execute || length != 0){
					$(this).toggleClass('active');
					$.ajax({
						url: "/batch/Job/" + grpId,
						data: {
							execute : execute
						},
						method: "POST",
						success : function(result){
						}
					});
				}else{
					swal({
						  title: "실행 불가능",
						  text: "실행할 프로그램이 없습니다.",
						  icon: "error",
						  button: "확인"
					});
				}
			}else{
				swal({
					title: "실행 불가능",
					text: "서버 연결 상태를 확인해주세요",
					icon: "error",
					button: "확인"
				});
			}
		});
	});
	
	/* cron 등록 박스 Event */
	$("select[name=cycleMF]").each(function(){
		$("select[name=cycleMF]").attr("disabled", true);
	});
	$("input[name=cycleDay]").each(function(){
		$("input[name=cycleDay]").attr("disabled", true);
	});
	
	$("input[name='cycle']:not(:checked)").next().next().find("input, select").attr("disabled", true);
	$("input[name='cycle']:not(:checked)").parent().find("input[name='selectCron']").attr("disabled", true);
	
	$("input[name='cycle']").change(function(){
		console.log($(this).val());
		$(this).parent().find("input, select").attr("disabled", true);
		$("input[name='cycle']").removeAttr("disabled");
		$(this).next().next().find("input, select").removeAttr("disabled");
		if($(this).val() == 3) $(this).parent().find("input[name='selectCron']").removeAttr("disabled"); 
		$(this).siblings().find("select[name=cycleMF]").attr("disabled", true);
		$(this).siblings().find("input[name=cycleDay]").attr("disabled", true);
		
	});
	
	
	$("select[name=cycle1]").each(function(){
		$(this).change(function(){
			const option = $(this).val();
			if(option == 'week'){
				$(this).next("#option-week").attr("disabled", false);
				$(this).next().next("#option-month").attr("disabled", true);		
			}else if(option == 'month'){
				$(this).next("#option-week").attr("disabled", true);
				$(this).next().next("#option-month").attr("disabled", false);
			}else if(option == 'day'){
				$(this).next("#option-week").attr("disabled", true);
				$(this).next().next("#option-month").attr("disabled", true);		
			}
		});
	});
	
	
});


/* 그룹, 프로그램 상세페이지 세팅 */
function readGroupInfo(grpId){
	$(".error-message").html('');
	$("#detail-batch-group .duplication-btn").hide();
	$("#detail-batch-group .show-cron").hide();
	$("#detail-batch-group .insert-cron").hide();
	$("#detail-batch-group input[name=cronView]").show();
	//내용 채우기
	$.ajax({
		url: "/batch/group/detail?grpId=" + grpId,
		method: "GET",
		success: function(result){
			const obj = $("#detail-batch-group").find(".modal-footer");
			obj.empty();
			$("#detail-batch-group input[name=batGrpId]").val(result.batGrpId);
			$("#detail-batch-group input[name=batGrpNm]").val(result.batGrpNm);
			$("#detail-batch-group input[name=hiddenBatGrpNm]").val(result.batGrpNm);
			$("#detail-batch-group input[name=batGrpDsc]").val(result.batGrpDsc);
			$("#detail-batch-group input[name=cron]").val(result.cron);
			$("#detail-batch-group input[name=cronDsc]").val(result.cronDsc);
			if(result.cronDsc == null || result.cronDsc == ''){
				$("#detail-batch-group input[name=cronView]").val(result.cron);
			}else{
				$("#detail-batch-group input[name=cronView]").val(result.cronDsc);
			}
			$("#detail-batch-group select[name=hostId]").val(result.hostId).prop("selected", true);
			$("#detail-batch-group select[name=autoExcnYn]").val(result.autoExcnYn).prop("selected", true);
			
			if(result.useYn == 'Y'){
				var view =`<button type="button" onclick="groupModify(this)" class="btn btn-primary">수정</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">목록</button>`;
				obj.append(view);
			}
		}
	});
	//css
	var frm = $('.active');
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//select disabled 제거
	$(".inactive").attr("disabled", true);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	
}
function readProgramInfo(prmId){
	//내용 채우기
	$.ajax({
		url: "/batch/program/detail?prmId=" + prmId,
		method: "GET",
		success: function(result){
			const obj = $("#detail-batch-program").find(".modal-footer");
			obj.empty();
			$("#detail-batch-program input[name=batPrmId]").val(result.batPrmId);
			$("#detail-batch-program input[name=batPrmNm]").val(result.batPrmNm);
			$("#detail-batch-program input[name=batGrpId]").val(result.batGrpId);
			$("#detail-batch-program input[name=param]").val(result.param);
			$("#detail-batch-program textarea[name=paramDsc]").val(result.paramDsc);
			$("#detail-batch-program input[name=excnOrd]").val(result.excnOrd);
			$("#detail-batch-program input[name=path]").val(result.path);
			$("#detail-batch-program .path-btn").hide(); // 파일 찾기 버튼 숨김 
			if(result.useYn=="Y"){
				var view =`<button type="button" onclick="programModify(this)" class="btn btn-primary">수정</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">목록</button>`;
				obj.append(view);
			}
		}
	});
	//css
	
	var frm = $('.active');
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//select disabled 제거
	$(".inactive").attr("disabled", true);
}

// 프로그램 등록 클릭 시 모달 초기화
function initModal(){
	const grpId = $(".sub-content .grp").prop("id");
	$(".modal input:not(table tr:last-child() input)").val("");
	$("#insert-batch-program input[name=batGrpId]").val(grpId);
	$(".error-message").html("");
	$("input").removeClass("incorrect");
	$("input").removeClass("correct");
}

/* 프로그램 관련 함수 */

/* 프로그램 리스트 가져오는 ajax 함수 
// grpId: 프로그램 리스트 가져올 그룹Id
// method: 결과값이 html인지(view), 프로그램 리스트의 길이인지(length)
*/
function getPrmList(grpId, method, use){
	let len;
	$.ajax({
		url: "/batch/program?grpId=" + grpId,
		method: "GET",
		async: false,
		success: function(result){
			len = result.length;
			
			if(method=='view'){
				var target = $(".prmList");
				target.empty();
				let btnWrap = $(".btn-wrap");
				btnWrap.empty();
				var view = ``;
				let btn = `<div class="program-btn insert-btn" data-bs-toggle="modal" data-bs-target="#insert-batch-program" onclick="initModal()"><span>프로그램 등록</span></div>`;
				if(result.length==0){
					view += `<span class='warning'">프로그램이 없습니다.</span>`;
				}else{
					view += `<ul id="sortable">`;
					for(var i=0;i<result.length;i++){
						let obj = result[i];
						view += `<li class="d-flex program">
									<div class="program-id"><span>` + obj['batPrmId'] + `</span></div>
									<div class="program-nm" title="` + obj['batPrmNm'] + `"><span>` + obj['batPrmNm'] + `</span></div>
									<div class="program-path" title="` + obj['path'] + `"><span>` + obj['path'] + `</span></div>
									<div class="program-active">
										<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="getUpdatePrmInfo(this)"
											data-bs-toggle="modal" data-bs-target="#detail-batch-program">
										<img src="/image/common/action/detail.png" class="menu-box" id="detail">
									</div>`
						if(use==true){ 
							view +=	`<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
										onclick="prmDelete(this)">
										<img src="/image/common/action/delete.png" class="menu-box" id="delete">
									</div>`;
						}
						view+= `</div>
									<div class="program-ord"><span>` + obj['excnOrd'] + `</span></div>
								</li>`;
					}
					view += `</ul>`;
					btn = `<div class="program-btn left-insert-btn" data-bs-toggle="modal" data-bs-target="#insert-batch-program" onclick="initModal()"><span>프로그램 등록</span></div>
						<div class="program-btn ord-btn" onclick="possibleChangeOrd(this)"><span>순서 변경</span></div>`
				}
				target.append(view);
				if(use==false) btn = ``;
				btnWrap.append(btn);
			}
			
			$(".program-nm").tooltip();
			$(".program-path").tooltip();
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return len;
}

/**
	@description path 호출 함수 수정했음
	@author 정영훈
	@since 2023-01-19 10:11
 */
//그룹별 등록 가능한 프로그램 경로 가져오기
function getPath(){
	let left = (window.screen.width / 2) - (900/2);
	let top = (window.screen.height / 2) - (700/2);
	window.open("/batch/popup/path", "배치 파일 등록", "width=900px, height=700px, left="+ left +", top="+ top +"");
}

/* 프로그램 actions 아이콘 색 변경하는 마우스 Event */
function iconMouseOver(obj){
	$(obj).css("border","1.5px solid #374c70");
	$(obj).find(".menu-box").prop("src", "/image/common/action/"+ $(obj).find(".menu-box").prop("id") +"_after2.png");
}
function iconMouseLeave(obj){
	$(obj).css("border","1.5px solid #acb9c7");
	$(obj).find(".menu-box").prop("src", "/image/common/action/"+ $(obj).find(".menu-box").prop("id") +".png");
}

/* 프로그램 순서 변경 */
// 프로그램 순서 변경 가능하도록
function possibleChangeOrd(btn){
	const grpId = $(".sub-content").find(".grp").attr("id");
	$(".program").toggleClass('change-ord');
	$(".ord-btn").attr("onclick", "saveChangedOrd(this)");
	$(".ord-btn").text("저장");
	$(".left-insert-btn").attr("onclick","getPrmList('" + grpId+ "'     ,'view', true)");
	$(".left-insert-btn").attr("data-bs-toggle","");
	$(".left-insert-btn").attr("data-bs-target","");
	$(".left-insert-btn").text("취소");
	
	$( "#sortable" ).sortable({
    	stop: function(e){
    		const li = $(".program");
    		li.each(function(index){
    			const target = $(this);
    			target.find(".program-ord span").text(index+1);
    		});
    	}
    });
}

// 변경한 프로그램 실행 순서 저장
function saveChangedOrd(btn){
	const grpId = $(btn).closest(".sub-content").find(".grp").attr("id");
	console.log(grpId);
	var prmList = [];
	var prmCnt = $(".program").length;

	for(var i=0;i<prmCnt;i++){
		let id = $($(".program")[i]).find(".program-id span").text();
		let ord = $($(".program")[i]).find(".program-ord span").text();
		var BatPrm = {
				'batPrmId' : id,
				'excnOrd' : ord
		}
		prmList.push(BatPrm);
	} 
	var vo = {
			'batGrpId': grpId,
			'prmList': prmList
	};
 	 $.ajax({
		url: "/batch/program/update/ord" ,
		type: "POST",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(vo),
		success: function(result){
			getPrmList(grpId, "view", true);
		},
		error: function(e){
			console.log(e);
		}
	});  
} 


/* Delete 재확인 Event */
function grpDelete(grpId){
	swal({
		  title: "정말로 삭제하시겠습니까?",
		  text: "삭제시 복구가 불가능합니다.",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
	})
	.then((willDelete) => {
 		if (willDelete) {
	     $.ajax({
			url: "/batch/group/delete",
			method: "post",
			data: {
				grpId: grpId
			},
			success: function(result){
				console.log(result);
			}
		});
		swal("", "삭제가 완료되었습니다.", "success").then(() => {
			location.reload();
		});
	  }
	}); 
}

function prmDelete(btn){
	event.stopPropagation();
	const prmId=$(btn).parent().siblings(".program-id").text();
	const grpId=$("#detail-batch-program input[name=batGrpId]").val();
	swal({
		  title: "정말로 삭제하시겠습니까?",
		  text: "삭제시 복구가 불가능합니다.",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			  $.ajax({
					url : "/batch/program/delete?prmId=" + prmId + "&&grpId=" + grpId,
					method : "POST",
					success : function(result){
						getPrmList(grpId, "view");
					},
					error: function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
			}); 
			swal("", "삭제가 완료되었습니다.", "success");
		  }
	}); 
}  



/* 모달창 Event */
function getUpdateGrpInfo(btn){
	initModal();
	const grpId = $(btn).parent().siblings(".group-id").text();
	 readGroupInfo(grpId);
} 
function getUpdatePrmInfo(btn){
	//prmId가져오기
	const prmId = $(btn).parent().siblings(".program-id").text();
	readProgramInfo(prmId);
	$("#update-program .error-message").html("");
} 

//상세 화면에서 [수정] 버튼 누르면 수정 화면으로 변경
function groupModify(table){
	$("#detail-batch-group .duplication-btn").show();
	$("#detail-batch-group .show-cron").show();
	const obj = $(table).closest(".modal-footer");
	obj.empty();
	var frm = $('.inactive');
	
	//모든 작성칸 disabled 제거
	frm.attr("disabled", false);
	//class 변경 inacive->active
	frm.removeClass('inactive');
	frm.addClass('active');
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="submit" id="grp-update-submit" class="btn btn-primary">저장</button>
        <button type="reset" onclick="groupDetail(this)" class="btn btn-secondary">Back</button>
        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	
    obj.append(view);
    
}
function programModify(table){
	let conn = $("#detail-batch-program input[name=path]").hasClass("onlyread");
	if(conn==true) $("#detail-batch-program .path-btn").show(); // 파일 찾기 버튼 생김
	const obj = $(table).closest(".modal-footer");
	obj.empty();
	var frm = $('.inactive');
	//모든 작성칸 disabled 제거
	frm.attr("disabled", false);
	//class 변경 inacive->active
	frm.removeClass('inactive');
	frm.addClass('active');
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="submit" class="btn btn-primary">저장</button>
        <button type="reset" onclick="programDetail(this)" class="btn btn-secondary">Back</button>
        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	
    obj.append(view);
}

//수정 화면에서 [취소] 버튼 누르면 상세 화면으로 변경
function groupDetail(table){
	const grpId = $("#detail-batch-group input[name=batGrpId").val();
	readGroupInfo(grpId);
}
function programDetail(table){
	const prmId = $("#detail-batch-program input[name=batPrmId").val();
	readProgramInfo(prmId);
	$("#update-program .error-message").html("");
}

/* 입력한 주기를 크론으로 변경하는 함수 */
function changeCron(type){
	var sec = '0';
	var min = '*';
	var hour = '*';
	var day = '*';
	var mon = '*';	//선택x
	var week = '?'; 
	const target = $("#" + type + "-batch-group");
	const method = target.find("input[name=cycle]:checked").val();
	var cron = '';
	var cronDsc = '';
	if(method == "1") {	//일자반복
		var cycle = target.find("select[name=cycle1]").val();
		if(cycle=="day"){
			cronDsc += '매일 ';
		}else if(cycle=="week"){
			day = '?';
			week = target.find("select[name=cycleMF]").val();
			cronDsc += ('매주 ' + target.find("#option-week option:selected").text() + ' ');
		}else if(cycle=="month"){
			week = '?';
			day = target.find("input[name=cycleDay]").val();
			cronDsc +=('매월 ' + target.find("#option-month").val() + '일 ');
		}
		var time_h = target.find("input[name=cycleTime]").val().split(":")[0];
		var time_m = target.find("input[name=cycleTime]").val().split(":")[1];
		cronDsc += time_h + '시 ' + time_m + '분';
		min = time_m;
		hour = time_h;
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + week;
	}else if(method=="2"){
		var number = target.find("input[name=timeNumber]").val();
		if(target.find("input[name=time]:checked").val()=="hour"){
			hour = '/' + number;
			min = '0';
			cronDsc += number + '시간마다';
		}else if(target.find("input[name=time]:checked").val()=="min"){
			min = '0/' + number;
			cronDsc += number + '분마다';
		}else if(target.find("input[name=time]:checked").val()=="sec"){
			sec = '/' + number;
			cronDsc += number + '초마다';
		}
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + week;	
	}else if(method=="3"){
		cron = target.find("input[name=selectCron]").val();
		cronDsc = '';
	}
	target.find("input[name=cron]").val(cron);
	target.find("input[name=cronDsc]").val(cronDsc);   
	
}

function startGrp(e,batGrpId){
	
	let length = getPrmList(batGrpId, "length");
	var conn = $(e).closest(".group").find(".group-conn img").hasClass('conn_enabled');
	if(length == 0){
		swal({
			title: "실행 불가능",
			text: "실행할 프로그램이 없습니다.",
			icon: "error",
			button: "확인"
		});
	}else if(conn && length>0){
		$.ajax({
			url: "/batch/group/run?batGrpId="+batGrpId,
			type: "POST",
			success: function(){
				swal({
						title: "실행 완료",
						text: "실행이 성공적으로 완료되었습니다.",
						icon: "success",
						button: "확인"
					});
			},
			error: function(){
				swal({
					title: "실행 불가능",
					text: "서버 연결 상태를 확인해주세요",
					icon: "error",
					button: "확인"
				});	
			}
		});
	}else{
		swal({
				title: "실행 불가능",
				text: "서버 연결 상태를 확인해주세요",
				icon: "error",
				button: "확인"
		});	
	}

}

function checkHealth(btn){
	var grpId = $(btn).closest(".group").find(".group-id").text();
	let view = ``;
	$.ajax({
		url: "/batch/health?batGrpId=" + grpId,
		type:"GET",
		success: function(result){
			if(result["conn"] == "on"){
				view = `<img src="/image/common/action/conn.png" onclick="checkHealth(this)" class="conn_enabled">`;
				for(var i=0; i<$(".group").length;i++){
					let hostId = $($(".group")[i]).find(".group-host span").attr("id");
					if(hostId == result["hostId"]){
						$($(".group")[i]).find(".group-conn").empty().append(view);
					}
				}
				hidePath(true);
			}else{
				view = `<img src="/image/common/action/disConn.png" onclick="checkHealth(this)" class="conn_disabled">`;
				for(var i=0; i<$(".group").length;i++){
					let hostId = $($(".group")[i]).find(".group-host span").attr("id");
					if(result["hostId"] == hostId){
						$($(".group")[i]).find(".group-conn").empty().append(view);
					}
				}
				hidePath(false);
			}           
		}
	});
}

function hidePath(conn){
	if(conn==true){
		$("input[name='path']").css("padding-right","95px");
		$(".path-btn").show();
		$("input[name=path]").attr("placeholder", "");
	//	$("input[name=path]").attr("readonly", true);
		$("#detail-batch-program input[name=path]").addClass("onlyread");
	}else{
		$(".path-btn").hide();
	//	$("input[name=path]").attr("readonly", false);
		$("#detail-batch-program input[name=path]").removeClass("onlyread");
		$("input[name=path]").attr("placeholder", "직접 경로 입력");
		$("input[name='path']").css("padding-right","0px");
	}
}

function rollback(btn){
	var grpId = $(btn).closest(".group").find(".group-id").text();
	$.ajax({
		url: "/batch/rollback?batGrpId=" + grpId,
		type: "GET",
		success:function(result){
			if(result==false){
				swal({
					title: "복구 불가능",
					text: "호스트가 존재하지 않습니다.",
					icon: "error",
					button: "확인"
				});		
			}else{
				swal({
					title: "복구 완료",
					text: "그룹이 복구되었습니다.",
					icon: "success",
					button: "확인"
				})
				.then((value) => {
					location.reload();
				})
			}
		}
	});
}

function showCronInput(){
	swal({
		title: "주기를 새로 입력하시겠습니까?",
		text: "현재 입력된 정보는 삭제됩니다.",
		icon: "info",
		buttons: true,
		dangerMode: true,
	})
	.then((value) => {
		if(value){
			$("#detail-batch-group input[name=cronView]").val('');
			$("#detail-batch-group input[name=cronView]").hide();
			$("#detail-batch-group .show-cron").hide();
			$("#detail-batch-group .insert-cron").show();
			
			$("#grp-update-submit").attr("onclick", "changeCron('detail')");
		}
	})
}