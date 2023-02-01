/**
 * 
 */

import * as util from '../util.js';

$(function(){
	//그룹 등록 함수
	var checkingInsert = $("#insert-batch-group input[name=batGrpNm]");
	checkingInsert.change(function(){
		checkingInsert.removeClass("correct");
		checkingInsert.removeClass("incorrect");
		$("#insert-batch-group input[name=checkGrpNm]").val("uncheck");
	})
	var checkingUpdate = $("#detail-batch-group input[name=batGrpNm]");
	checkingUpdate.change(function(){
		checkingUpdate.removeClass("correct");
		checkingUpdate.removeClass("incorrect");
		$("#detail-batch-group input[name=checkGrpNm]").val("uncheck");
	})
	
	
	$("#insert-group").submit(function(e){
		// 에러 메세지 초기화
		$(".error-message").html('');
		// 동작 중지
		e.preventDefault();
		// 이벤트 객체
		const target = e.target;
		// 유효성 검사 카운트
		let count = 0;
		
		// 전송된 input의 name 값
		const name = "batGrpNm"; 
		let key = 'blank';
		// 서버로 보내기 전 유효성 검사, 실패시 카운트 1증가
		if(util.browserValid('insert-' + name, key, target[name]['value']) == false){
			count += 1;
		}else{
			if($("#insert-batch-group input[name=checkGrpNm]").val()=="uncheck"){
				$("#error-insert-batGrpNm").html('중복확인 해주세요');
				count+=1;
			}
		}					
		
		const method = $("#insert-batch-group input[name=cycle]:checked").val();
		if(cycleCheck(method,'insert')){
			$("#insert-batch-group #error-insert-cron").html('입력한 값을 다시 확인해주세요');
			count+=1;
		}
		
		// 유효성 검사 결과 하나라도 실패할시 false
		if(count != 0) return false;
		
		$.ajax({
			url: "/batch/group/insert",
			type: "post",
			data: {
				batGrpNm: e.target.batGrpNm.value,
				batGrpDsc: e.target.batGrpDsc.value,
				hostId: e.target.hostId.value,
				autoExcnYn: e.target.autoExcnYn.value,
				cron: e.target.cron.value,
				cronDsc: e.target.cronDsc.value
			},
			success: function(result){
				
				util.serverValid(result);
				location.reload();
			}
		});
	})
	//프로그램 등록 함수
	$("#insert-program").submit(function(e){
		// 에러 메세지 초기화
		$(".error-message").html('');
		// 동작 중지
		e.preventDefault();
		// 이벤트 객체
		const target = e.target;
		// 유효성 검사 카운트
		let count = 0;
		
		// 전송된 input의 name 값
		const name = "batPrmNm"; 
		let key = 'blank';
		// 서버로 보내기 전 유효성 검사, 실패시 카운트 1증가
		if(util.browserValid('insert-' + name, key, target[name]['value']) == false) count += 1;					
		
		const path = "path";
		key =  'file';
		if(util.browserValid('insert-' + path, key, target[path]['value']) == false) count += 1;					
		
		
		// 유효성 검사 결과 하나라도 실패할시 false
		if(count != 0) return false;
		
		$.ajax({
			url: "/batch/program/insert",
			type: "post",
			data: {
				batPrmNm: e.target.batPrmNm.value,
				batGrpId: e.target.batGrpId.value,
				path: e.target.path.value,
				param: e.target.param.value,
				paramDsc: e.target.paramDsc.value,
			},
			success: function(result){
				
				util.serverValid(result);
				location.reload();
			}
		});
	})
	
	
	$("#update-group").submit(function(e){
		// 에러 메세지 초기화
		$(".error-message").html('');
		// 동작 중지
		e.preventDefault();
		// 이벤트 객체
		const target = e.target;
		// 유효성 검사 카운트
		let count = 0;
		
		// 전송된 input의 name 값
		const name = "batGrpNm"; 
		let key = 'blank';
		// 서버로 보내기 전 유효성 검사, 실패시 카운트 1증가
		if(util.browserValid('detail-' + name, key, target[name]['value']) == false){
			count += 1;
		}else{
			if($("#detail-batch-group input[name=checkGrpNm]").val()=="uncheck"){
				$("#error-detail-batGrpNm").html('중복확인 해주세요');
				count+=1;
			}
		}					
		
		if($("#detail-batch-group input[name=cronView]").val()==''){
			
			const method = $("#detail-batch-group input[name=cycle]:checked").val();
			if(cycleCheck(method,'detail')){
				$("#detail-batch-group #error-detail-cron").html('입력한 값을 다시 확인해주세요');
				count+=1;
			}
		}
		
		// 유효성 검사 결과 하나라도 실패할시 false
		if(count != 0) return false;
		
		$.ajax({
			url: "/batch/group/update",
			type: "post",
			data: {
				batGrpId: e.target.batGrpId.value,
				batGrpNm: e.target.batGrpNm.value,
				batGrpDsc: e.target.batGrpDsc.value,
				hostId: e.target.hostId.value,
				autoExcnYn: e.target.autoExcnYn.value,
				cron: e.target.cron.value,
				cronDsc: e.target.cronDsc.value
			},
			success: function(result){
				util.serverValid(result);
				location.reload();
			}
		});
	})
	//프로그램 업데이트 함수
	$("#update-program").submit(function(e){
		// 에러 메세지 초기화
		$(".error-message").html('');
		// 동작 중지
		e.preventDefault();
		// 이벤트 객체
		const target = e.target;
		// 유효성 검사 카운트
		let count = 0;
		
		// 전송된 input의 name 값
		const name = "batPrmNm"; 
		let key = 'blank';
		// 서버로 보내기 전 유효성 검사, 실패시 카운트 1증가
		if(util.browserValid('insert-' + name, key, target[name]['value']) == false) count += 1;					
		
		const path = "path";
		key =  'file';
		if(util.browserValid('insert-' + path, key, target[path]['value']) == false) count += 1;					
		
		
		// 유효성 검사 결과 하나라도 실패할시 false
		if(count != 0) return false;
		
		$.ajax({
			url: "/batch/program/update",
			type: "post",
			data: {
				batPrmId: e.target.batPrmId.value,
				batPrmNm: e.target.batPrmNm.value,
				batGrpId: e.target.batGrpId.value,
				path: e.target.path.value,
				param: e.target.param.value,
				paramDsc: e.target.paramDsc.value,
			},
			success: function(result){
				
				util.serverValid(result);
				location.reload();
			}
		});
	})
}) 
function cycleCheck(method, type){
	var error = false;
	let check = /^[0-9]+$/; 
	const target = $("#" + type + "-batch-group");
	if(method == "1") {	
		if(target.find("input[name=cycleTime]").val()==''){
			error = true;
		}				
		let cycle = target.find("select[name=cycle1]").val();
		let day = target.find("input[name=cycleDay]").val();
		if(cycle=="month" && check.test(day)==false){
			error = true;
		}else if(cycle=="month" && check.test(day)==true){
			if(!(day>=1 && day<=31)){
				error = true;
			}
		}
	}else if(method=="2"){
		var number = target.find("input[name=timeNumber]").val();
		var time = target.find("input[name=time]:checked").val();
		if(!check.test(number) || number == '') error=true;
		else{
			if(time=="hour" && !(number>=0 && number<=23)){
				error = true;
			}else if((time=="min" || time=="sec") && !(number>=0 && number<=59)){
				error = true;
			}
		}
		if(time == null) error = true;
	}
	else if(method=="3"){
		if(target.find("input[name=selectCron]").val()=='') error=true;
	}
	return error;	
}
