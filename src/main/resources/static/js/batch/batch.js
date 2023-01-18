$(function(){
	
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
			getPath(grpId, "insert");
			getPrmList(grpId, "view");
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
			// 서버와 연결이 되어있고
			if(!$(this).closest(".group").find(".group-conn span").hasClass('conn_disabled')){
				let grpId = $(this).closest(".group").find(".group-id span").text();
				let length = getPrmList(grpId, "length");
				//그룹안에 등록된 프로그램이 1개 이상인 경우 Job 실행 및 중단
				if(length != 0){
					//active 클래스가 있는 경우 해당 그룹은 Job 실행 중으로 판단
					var execute = false;
					if($(this).hasClass('active')){
						execute = true;
					}
					$.ajax({
						url: "/batch/Job/" + grpId,
						data: {
							execute : execute
						},
						method: "POST",
						success : function(result){
							$(this).toggleClass('active');
						}
					});
				}
			}
		});
	});
	
	/* cron 등록 박스 Event */
	$("#option-week").hide();
		$("#option-month").hide();
		
		$("input[name='cycle']").change(function(){
			$(this).parent().find("input, select").attr("disabled", "disabled");
			$("input[name='cycle']").removeAttr("disabled");
			$(this).next().next().find("input, select").removeAttr("disabled");
		});
				
		$("#cron-box").change(function(){
			const option = $(this).val();
			if(option == 'week'){
				$("#option-week").show();
				$("#option-month").hide();		
			}else if(option == 'month'){
				$("#option-week").hide();
				$("#option-month").show();
			}else{
				$("#option-week").hide();
				$("#option-month").hide();		
			}
		});
});

/* 그룹, 프로그램 상세페이지 세팅 */
function readGroupInfo(grpId){
	//내용 채우기
	$.ajax({
		url: "/batch/group/detail?grpId=" + grpId,
		method: "GET",
		success: function(result){
			$("#detail-batch-group input[name=batGrpId]").val(result.batGrpId);
			$("#detail-batch-group input[name=batGrpNm]").val(result.batGrpNm);
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
		}
	});
	//css
	const obj = $("#detail-batch-group").find(".modal-footer");
	obj.empty();
	var frm = $('.active');
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//select disabled 제거
	$(".inactive").attr("disabled", true);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="button" onclick="groupModify(this)" class="btn btn-primary">수정</button>
	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">목록</button>`;
	obj.append(view);
}
function readProgramInfo(prmId){
	//내용 채우기
	$.ajax({
		url: "/batch/program/detail?prmId=" + prmId,
		method: "GET",
		success: function(result){
			$("#detail-batch-program input[name=batPrmId]").val(result.batPrmId);
			$("#detail-batch-program input[name=batPrmNm]").val(result.batPrmNm);
			$("#detail-batch-program input[name=batGrpId]").val(result.batGrpId);
			$("#detail-batch-program input[name=param]").val(result.param);
			$("#detail-batch-program textarea[name=paramDsc]").val(result.paramDsc);
			$("#detail-batch-program input[name=excnOrd]").val(result.excnOrd);
			
			let name = $('#prmPath').prop('tagName');
			if(name == "INPUT"){
				$("#detail-batch-program #prmPath").val(result.path);
			}else if(name == "SELECT"){
				$("#detail-batch-program #prmPath").val(result.path).prop("selected", true);
			}
		}
	});
	//css
	const obj = $("#detail-batch-program").find(".modal-footer");
	obj.empty();
	var frm = $('.active');
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//select disabled 제거
	$(".inactive").attr("disabled", true);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="button" onclick="programModify(this)" class="btn btn-primary">수정</button>
	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">목록</button>`;
	obj.append(view);
}


/* 프로그램 관련 함수 */

/* 프로그램 리스트 가져오는 ajax 함수 
// grpId: 프로그램 리스트 가져올 그룹Id
// method: 결과값이 html인지(view), 프로그램 리스트의 길이인지(length)
*/
function getPrmList(grpId, method){
	let len;
	$.ajax({
		url: "/batch/program?grpId=" + grpId,
		method: "GET",
		async: false,
		success: function(result){
			len = result.length;
			
			if(method=='view'){
				getPath(grpId, "detail");
				var target = $(".prmList");
				target.empty();
				let btnWrap = $(".btn-wrap");
				btnWrap.empty();
				var view = ``;
				let btn = `<div class="insert-btn" data-bs-toggle="modal" data-bs-target="#insert-batch-program"><span>프로그램 등록</span></div>`;
				if(result.length==0){
					view += `<span class='warning'">프로그램이 없습니다.</span>`;
				}else{
					view += `<ul id="sortable">`;
					for(var i=0;i<result.length;i++){
						let obj = result[i];
						view += `<li class="d-flex program">
									<div class="program-id"><span>` + obj['batPrmId'] + `</span></div>
									<div class="program-nm"><span>` + obj['batPrmNm'] + `</span></div>
									<div class="program-path"><span>` + obj['path'] + `</span></div>
									<div class="program-active">
										<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="getUpdatePrmInfo(this)"
											data-bs-toggle="modal" data-bs-target="#detail-batch-program">
										<img src="/image/common/action/detail.png" class="menu-box" id="detail">
									</div> 
									<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
										onclick="prmDelete(this)">
										<img src="/image/common/action/delete.png" class="menu-box" id="delete">
									</div></div>
									<div class="program-ord"><span>` + obj['excnOrd'] + `</span></div>
								</li>`;
					}
					view += `</ul>`;
					btn += `<div class="ord-btn" onclick="possibleChangeOrd(this)"><span>순서 변경</span></div>`
				}
				target.append(view);
				btnWrap.append(btn);
			}
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return len;
}

//그룹별 등록 가능한 프로그램 경로 가져오기
function getPath(grpId, type){
	$.ajax({
		url: "/batch/path?grpId=" + grpId, 
		method: "GET",
		success: function(result){
			$("#" + type + "-batch-program input[name=batGrpId]").val(grpId);
			var view = ``;
			var target = $("#" + type + "-batch-program select[name=path]");	
			if(result.length == 1 && result[0] == "연결 실패"){
				target.replaceWith($('<input />').attr({
					type: 'text',
					id: target.attr('id'),
					name: target.attr('name'),
					class: 'form-control',
					placeholder: "경로 직접 입력"
				}));
				if(type=="insert"){
					$("#" + type + "-batch-program #prmPath").attr("placeholder", "연결 실패로 직접 경로를 입력해주세요.");
				}else if(type=="detail"){
					$("#" + type + "-batch-program #prmPath").attr("disabled", true);
					$("#" + type + "-batch-program #prmPath").addClass("inactive");
				}
			}else{		
				target.empty();
				for(var i=0;i<result.length;i++){
					let obj = result[i];
					view = `<option value="`+ obj + `">` + obj + `</option>`;
					target.append(view);
				}
			}
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}

// 프로그램 insert 
/*function getInsertInfo(btn){
	//grpId, 프로그램 경로 목록 받아와서 화면에 삽입
	const grpId = $(".sub-content .grpId").text();
	getPath(grpId, "insert");
}*/

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
	$(".program").toggleClass('change-ord');
	$(".ord-btn").attr("onclick", "saveChangedOrd(this)");
	$(".ord-btn").text("저장하기");
	$( "#sortable" ).sortable( {
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
	const grpId = $(".grpId").text();
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
	console.log(prmList);
 	 $.ajax({
		url: "/batch/program/update/ord" ,
		type: "POST",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(vo),
		success: function(result){
			getPrmList(grpId, "view");
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
	const grpId=$(".grpId").text();
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
	const grpId = $(btn).parent().siblings(".group-id").text();
	 readGroupInfo(grpId);
} 
function getUpdatePrmInfo(btn){
	//prmId가져오기
	const prmId = $(btn).parent().siblings(".program-id").text();
	readProgramInfo(prmId);
} 

//상세 화면에서 [수정] 버튼 누르면 수정 화면으로 변경
function groupModify(table){
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
        <button type="reset" onclick="groupDetail(this)" class="btn btn-secondary">Back</button>
        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	
    obj.append(view);
}
function programModify(table){
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
}




/* 입력한 주기를 크론으로 변경하는 함수 */
function changeCron(btn){
	var sec = '*';
	var min = '*';
	var hour = '*';
	var day = '*';
	var mon = '*';	//선택x
	var week = '?'; 
	const method = $("#insert-batch-group input[name=cycle]:checked").val();
	var cron = '';
	var cronDsc = '';
	if(method == "1") {	//일자반복
		var cycle = $("#insert-batch-group select[name=cycle1]").val();
		if(cycle=="day"){
			cronDsc += '매일 ';
		}else if(cycle=="week"){
			day = '?';
			week = $("#insert-batch-group select[name=cycleMF]").val();
			cronDsc += ('매주 ' + $("#insert-batch-group #option-week option:selected").text() + ' ');
		}else if(cycle=="month"){
			week = '?';
			day = $("#insert-batch-group input[name=cycleDay]").val();
			cronDsc +=('매월 ' + $("#insert-batch-group #option-month").val() + '일 ');
		}
		var time_h = $("#insert-batch-group input[name=cycleTime]").val().split(":")[0];
		var time_m = $("#insert-batch-group input[name=cycleTime]").val().split(":")[1];
		cronDsc += time_h + '시 ' + time_m + '분';
		min = time_m;
		hour = time_h;
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + week;
	}else if(method=="2"){
		var number = $("#insert-batch-group input[name=timeNumber]").val();
		if($("#insert-batch-group input[name=time]:checked").val()=="hour"){
			hour = '/' + number;
			cronDsc += number + '시간마다';
		}else if($("#insert-batch-group input[name=time]:checked").val()=="min"){
			min = '/' + number;
			cronDsc += number + '분마다';
		}else if($("#insert-batch-group input[name=time]:checked").val()=="sec"){
			sec = '/' + number;
			cronDsc += number + '초마다';
		}
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + week;	
	}else if(method=="3"){
		cron = $("#insert-batch-group input[name=selectCron]").val();
		cronDsc = '';
	}
	$("#insert-batch-group input[name=cron]").val(cron);
	$("#insert-batch-group input[name=cronDsc]").val(cronDsc);   
	
}
