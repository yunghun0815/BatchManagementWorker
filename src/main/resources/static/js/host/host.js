/**
 * 호스트 관련 자바스크립트
 */

import * as util from '../util.js';
 
$(function(){
	
	//호스트 등록 함수
	$("#host-insert-form").submit(function(e){
		// 에러 메세지 초기화
		$(".error-message").html('');
		// 동작 중지
		e.preventDefault();
		// 이벤트 객체
		const target = e.target;
		// 유효성 검사 카운트
		let count = 0;
		
		for(var i=0; i<target.length; i++){
			
			// 전송된 input의 name 값
			const name = target[i].name; 
			
			if(name != ''){
				let key = 'blank';
				if(name == 'hostIp') key = 'ip';
				
				// 서버로 보내기 전 유효성 검사, 실패시 카운트 1증가
				if( util.browserValid('insert-' + target[i].name, key, target[name]['value']) == false) count += 1;					
			}
		}
		// 유효성 검사 결과 하나라도 실패할시 false
		if(count != 0) return false;
		
		$.ajax({
			url: "/host/insert",
			method: "post",
			data: {
				hostNm: e.target.hostNm.value,
				hostIp: e.target.hostIp.value,
				hostPt: e.target.hostPt.value
			},
			success: function(result){
				util.serverValid(result);
				location.reload();
			}
		});			
	})
	
	
	//호스트 상세보기
	$(".detail-host").click(function(e){
		const hostId = e.target.textContent;
		$.ajax({
			url: "/host/detail?hostId="+hostId,
			method: "get",
			success: function(result){
				$("#host-update-form input[name='hostId']").val(result['hostId']);
				$("#host-update-form input[name='hostNm']").val(result['hostNm']);
				$("#host-update-form input[name='hostIp']").val(result['hostIp']);
				$("#host-update-form input[name='hostPt']").val(result['hostPt']);
			}
		});
	});
	
	// 수정모드
	$(".host-update").click(function(){
		const input = $(this).closest(".content-main").find("input");
		
		$(this).hide();
		$(this).next().show();
		input.removeAttr("readonly", "false");
		input.css("border", "1px solid black");
	})
	
	// 수정완료
	$(".host-update-complete").click(function(){
		const e = $(this);
		const input = $(this).closest(".content-main").find("input");
		$.ajax({
			url: "/host/update",
			method: "post",
			data: {
				hostNm: input.eq(0).val(),
				hostIp: input.eq(1).val(),
				hostPt: input.eq(2).val(),
				hostId: input.eq(3).val()
			},
			success: function(result){
				if(result.length > 0){
					// 에러메세지
					alert(result[0]['defaultMessage']);
				}else{
					alert("수정에 성공하였습니다.")
					e.hide();
					e.prev().show();
					input.removeAttr("readonly", "true");
					input.css("border", "none");					
				}
			}
		});
	})
	
	// 호스트 삭제
	$(".host-delete").click(function(){
		let hostId = $(this).parent().find("input[type='hidden']").val(); 
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
				url: "/host/delete",
				method: "post",
				data: {
					hostId: hostId
				},
				success: function(result){
					location.reload();
				}
			});
		};
	});
	

});