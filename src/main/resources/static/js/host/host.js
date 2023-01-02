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
	
	//상세페이지 -> 수정페이지
	$("#update-host-button").click(function(e){
		$("#host-update-form input:not(input[name='hostId'])").removeAttr("readonly");
	})
	
	//호스트 업데이트 함수
	$("#host-update-form").submit(function(e){
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
				if( util.browserValid('update-' + target[i].name, key, target[name]['value']) == false) count += 1;					
			}
		}
		// 유효성 검사 결과 하나라도 실패할시 false
		if(count != 0) return false; 
		
		$.ajax({
			url: "/host/update",
			method: "post",
			data: {
				hostId: e.target.hostId.value,
				hostNm: e.target.hostNm.value,
				hostIp: e.target.hostIp.value,
				hostPt: e.target.hostPt.value
			},
			success: function(result){
				console.log(result);
				util.serverValid(result);
				location.reload();
			}
		});			
	})
	
	//호스트 삭제
	$(".host-delete-button").click(function(e){
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
				url: "/host/delete",
				method: "post",
				data: {
					hostId: e.target.id
				},
				success: function(result){
					location.reload();
				}
			});
		};
	});
});

