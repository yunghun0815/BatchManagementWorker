
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="common/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">

<head>

<style type="text/css">
/* 공통 부분 */
@font-face {
	font-family: 'NanumSquareNeo-Variable';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}
* {
	font-family: 'NanumSquareNeo-Variable';
}
.title {
	margin: 30px;
}
.title h1{  /* 추가했음 */
		font-weight: bold;
}
.content {
	margin: 10px;
	margin-left: 40px;
}

/* 그룹 부분 - 메인 */
.main-content {
	float: left;
	width:70%;
}

.main-list {
	
}

.main-list ul {
	padding-left: 5px;
	text-align: center;
}

.list-header{
	height: 50px;
	line-height: 50px;
	justify-content: space-around;
	padding: 0 30px;
}
/* .list-header span{
	text-align: center;
}
 */
.group {
	justify-content: space-around;
	padding: 0 30px;
	background-color: white;
	line-height: 50px;
	border-radius: 20px; 
	line-height: 45px;
	display: flex;
	margin: 6px;
	height: 50px;
	text-align: center;
	margin-bottom:15px;
	font-size: 0.9em;
}

.group div {
	text-align: center;
}
.group:hover {
	cursor: pointer;
	border: 2px solid #79c2cc;
	box-shadow: 1px 4px 5px 3px #79c2cc36;
}

.group-id{
	width:13%;
}
.group-nm{
	width:13%;
}
.group-host{
	width:22%;
}
.group-cron{
	width:22%;
}

.group-conn{
	width:10%;
}
.group-conn .conn_enabled{
	color: green;
}
.group-conn .conn_disabled{
	color: red;
}
.group-running {
	width:10%;
}

.group-running label {
	margin: auto;
	margin-top:10px;
}

.group-active {
	width:10%;
}

.group-active div {
	border:1.5px solid #acb9c7;
	height: 28px;
	width:28px;
	display:inline-block;
	vertical-align:middle;
	margin:3px;
	border-radius:5px;
	margin-top:6px;
}



.group-active img {
	width: 20px;
	vertical-align:super;
	padding-top:2.5px;
}

.insert-grp-btn{
    width: 26px;
    height: 26px;
    border-radius: 6px;
    background-color: #13c3dc;
    font-size: 0.7em;
    text-align: center;
    line-height: 25px;
    font-weight: bold;
    border: none;
    color: white;
    vertical-align: text-top;
}


/* 그룹 부분 - 서브 */
.sub-content{
	float: right;
	width:29%;
	background-color: #374c70;
	border-radius: 30px;
	height: 670px;
	margin-left: 8px;
}

.sub-content ul{
	height:640px;
	overflow: auto;
	padding: 1px;
    margin: 17px auto;
	-ms-overflow-style: none;
}

.sub-content ul::-webkit-scrollbar{
  display:none;
}
.program{
	position: relative;
	background-color: white;
    width: 90%;
    margin: 10px auto;
    height: 140px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    padding: 5px;
    padding-top: 10px;
    padding-left: 14px;
    margin-top: 14px;
}
.program .program-id{
	font-size: 0.3em;
	height: 15px;
}
.program .program-nm{
	font-size: 1.6em;
	font-weight: bold;
	height: 40px;
}
.program .program-ord{
	font-size: 1.5em;
    margin-left: 287px !important;
    position: absolute !important;
    width: 59px;
    height: 36px;
    text-align: center;
    background-color: #374c709e;
    color: white;
    border-radius: 5px !important;
    line-height: 36px;
    margin-top: 11px;
	
}
.program .program-path{
	font-size: 0.8em;
	height: 30px;
	
	padding-top: 1px;
    padding-left: 3px;
    color: #908c8c;
}
.program .program-active{
	display: flex;
    flex-direction: row;
}
.program .program-active div{
	border: 1.5px solid #acb9c7;
	padding:2.5px;
	display:inline-block;
	vertical-align:middle;
	margin:4px;
	border-radius:5px;
	margin-top:6px;
	margin-right: 5px;
}
.program .program-active div:hover{
	cursor: pointer;
}
.program .program-active img{
	width:23px;
	height: 23px;
}
.sub-content .warning{
	line-height:650px;
	font-size: 2.5em;
	color:white;
	vertical-align:middle;
	margin-left: 18px;
	
}

.sub-content .grpId{
	backgroud-color:none;
	font-size:1.2em;
	font-weight: bold;
	color : white;
	text-align: center;
}
.ord-btn-wrap{
	background-color: white;
    width: 90%;
    margin: 10px auto;
    height: 50px;
    border-radius: 10px;
    padding: 5px;
    padding-top: 10px;
    padding-left: 14px;
    margin-top: 14px;
    
    padding: 0px;
    line-height: 48px;
    margin: auto;
    text-align: center;
    background-color: #79c2cc;
    color: white;
    font-size: 1.8em;
    font-weight: bold;
    cursor: pointer;
}
.ord-btn{
}
.change-ord{
	cursor:move;
}
.insert-prm-btn{
	color:white;
	border: 1.5px solid white;
	border-radius:50%;
	font-size:1.2em;
	width:30px;
	height:30px;
	line-height:26px;
	margin-left:25px;
	text-align:center;
}
/* 토글 */
.toggleSwitch {
	width: 47px;
	margin: 3px;
	height: 24px;
	display: block;
	position: relative;
	border-radius: 30px;
	background-color: #fff;
	box-shadow: 0 0 16px 3px rgb(0 0 0/ 15%);
	cursor: pointer;
}

.toggleSwitch .toggleButton {
	width: 18px;
	height: 18px;
	position: absolute;
	top: 50%;
	left: 4px;
	transform: translateY(-50%);
	border-radius: 50%;
	background: #79c2cc;
}

.toggleSwitch.active {
	background: #79c2cc;
}

.toggleSwitch.active .toggleButton {
	left: calc(100% - 22px);
	background: #fff;
}

.toggleSwitch, .toggleButton {
	transition: all 0.2s ease-in;
}


/* 모달 */
.inactive{
	border: none;
	background: none !important;
}

</style>
<script type="text/javascript">
//그룹 클릭하면 해당 프로그램 리스트 보여주는 함수
function prmList(grp){
	const grpId = $(grp).find(".group-id span").text();
	$.ajax({
		url: "/batch/program?grpId=" + grpId,
		method: "GET",
		success: function(result){
			var target = $(".sub-content");
			target.empty();
			var view = ``;
			if(result.length==0){
				view = `<div class="grpId">` + grpId + `</div><div onclick="getInsertInfo(this)" data-bs-toggle="modal" data-bs-target="#insert-batch-program" class="insert-prm-btn">+</div><span class='warning'">프로그램이 없습니다.</span>`;
			}else{
				view = `<div class="grpId">` + grpId + `</div><div onclick="getInsertInfo(this)" data-bs-toggle="modal" data-bs-target="#insert-batch-program" class="insert-prm-btn">+</div><ul id="sortable">`;
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
				view += `<li class="ord-btn-wrap"><div class="ord-btn" onclick="possibleChangeOrd(this)"><span>순서 변경</span></div></li></ul>`;
			}
			target.append(view);
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		
	})
}
//프로그램 리스트 아이콘 이벤트
function iconMouseOver(obj){
	$(obj).css("border","1.5px solid #374c70");
	$(obj).find(".menu-box").prop("src", "/image/common/action/"+ $(obj).find(".menu-box").prop("id") +"_after2.png");
}
function iconMouseLeave(obj){
	$(obj).css("border","1.5px solid #acb9c7");
	$(obj).find(".menu-box").prop("src", "/image/common/action/"+ $(obj).find(".menu-box").prop("id") +".png");
}



//삭제확인
function grpDelete(grpId){
	event.stopPropagation();
	if(window.confirm('정말 삭제하시겠습니까?')){
		alert(grpId + "그룹이 삭제되었습니다");
		location.href='http://localhost:8080/batch/group/delete?grpId='  + grpId;
	}
}
function prmDelete(btn){
	event.stopPropagation();
	const prmId=$(btn).parent().siblings(".program-id").text();
	const grpId=$(".grpId").text();
	if(window.confirm('정말 삭제하시겠습니까?')){
		$.ajax({
			url : "/batch/program/delete?prmId=" + prmId + "&&grpId=" + grpId,
			method : "POST",
			success : function(result){
				alert(prmId + "가 삭제되었습니다");
				var target = $(".sub-content");
				target.empty();
				var view = ``;
				if(result.length==0){
					view = `<div class="grpId">` + grpId + `</div><div onclick="getInsertInfo(this)" data-bs-toggle="modal" data-bs-target="#insert-batch-program" class="insert-prm-btn">+</div><span class='warning'">프로그램이 없습니다.</span>`;
				}else{
					view = `<div class="grpId">` + grpId + `</div><div onclick="getInsertInfo(this)" data-bs-toggle="modal" data-bs-target="#insert-batch-program" class="insert-prm-btn">+</div><ul id="sortable">`;
					for(var i=0;i<result.length;i++){
						let obj = result[i];
						view += `<li class="d-flex program">
									<div class="program-id"><span>` + obj['batPrmId'] + `</span></div>
									<div class="program-nm"><span>` + obj['batPrmNm'] + `</span></div>
									<div class="program-path"><span>` + obj['path'] + `</span></div>
									<div class="program-active">
										<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
											onclick="" data-bs-toggle="modal" data-bs-target="#detail-batch-program">
										<img src="/image/common/action/detail.png" class="menu-box" id="detail">
									</div> 
									<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
										onclick="prmDelete(this)">
										<img src="/image/common/action/delete.png" class="menu-box" id="delete">
									</div></div>
									<div class="program-ord"><span>` + obj['excnOrd'] + `</span></div>
								</li>`;
					}
					view += `<li class="ord-btn-wrap"><div class="ord-btn" onclick="possibleChangeOrd(this)"><span>순서 변경</span></div></li></ul>`;
				}
				target.append(view);
			},
			error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); 
	}
}  


$(function(){
	// 페이지별 메뉴 색 변경
	 $(".group-active div").mouseover(function(){
		$(this).css("border","1.5px solid #0CA3B9");
		$(this).find(".menu-box").prop("src", "/image/common/action/"+ $(this).find(".menu-box").prop("id") +"_after.png");
	})
	$(".group-active div").mouseleave(function(){
		$(this).css("border","1.5px solid #acb9c7");
		$(this).find(".menu-box").prop("src", "/image/common/action/"+ $(this).find(".menu-box").prop("id") +".png");
	})
	
	//실행토글
	const active = $(".group-active");
	active.each(function(){
		active.click(function(){
			event.stopPropagation();
		})
	})
		
	//Job실행
	const toggle = $(".toggleSwitch");
	toggle.each(function(){
		$(this).click(function(){
			event.stopPropagation();
			var execute = false;
			const grpId = $(this).parent().siblings(".group-id").text();
			console.log(grpId);
			if($(this).hasClass('active')){
				execute = true;
			}
			$(this).toggleClass('active');
			$.ajax({
				url: "/batch/Job/" + grpId,
				data: {
					execute : execute
				},
				method: "POST",
				success : function(result){
					console.log("성공")
				}
			})
		})
	})
	
	//cron 입력
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

//모달창 함수
function getUpdateGrpInfo(btn){
	//grpId가져오기
	const grpId = $(btn).parent().siblings(".group-id").text();
	console.log(grpId);
	//ajax로 그룹정보 가져와서 심기
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
	})
} 
function getUpdatePrmInfo(btn){
	//prmId가져오기
	const prmId = $(btn).parent().siblings(".program-id").text();
	console.log(prmId);
	//ajax로 프로그램정보 가져와서 심기
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
			
			getPath(result.batGrpId, "detail");
			
			$("#detail-batch-program select[name=path]").val(result.path).prop("selected", true);
		}
	})
} 
//파라미터(grpId, 페이지종류)에 따라 path 받아오기
function getPath(grpId, type){
	$.ajax({
		url: "/batch/path?grpId=" + grpId, 
		method: "GET",
		success: function(result){
			var target = $("#" + type + "-batch-program select[name=path]");		
			target.empty();
			for(var i=0;i<result.length;i++){
				let obj = result[i];
				let view = `<option value="`+ obj + `">` + obj + `</option>`;
				target.append(view);
			}
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}
//수정 누르면 수정버전으로 변경
function groupModify(table){
	const obj = $(table).closest(".modal-footer");
	obj.empty();
	var frm = $('.inactive');
	//const id = obj.attr("id")
	//class 변경 inacive->active
	frm.removeClass('inactive');
	frm.addClass('active');
	//readonly 제거
	$('.readwrite').prop('readonly', false);
	//select readonly 제거
	$(".readwrite").attr("disabled", false);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="submit" class="btn btn-primary">저장</button>
        <button type="reset" onclick="groupDetail(this)" class="btn btn-secondary">Back</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	
    obj.append(view);
}
function programModify(table){
	const obj = $(table).closest(".modal-footer");
	obj.empty();
	var frm = $('.inactive');
	//const id = obj.attr("id")
	//class 변경 inacive->active
	frm.removeClass('inactive');
	frm.addClass('active');
	//readonly 제거
	$('.readwrite').prop('readonly', false);
	//select readonly 제거
	$(".readwrite").attr("disabled", false);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="submit" class="btn btn-primary">저장</button>
        <button type="reset" onclick="programDetail(this)" class="btn btn-secondary">Back</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	
    obj.append(view);
}
//수정화면에사 취소 누르면 상세 페이지러 변경
function groupDetail(table){
	const obj = $(table);
	var frm = $('.active');
	//const id = obj.attr("id")
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//readonly 추가
	$('.readwrite').prop('readonly', true);
	//select readonly 제거
	$(".readwrite").attr("disabled", true);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="button" onclick="groupModify(this)" class="btn btn-primary">수정</button>
	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">삭제</button>
	<button type="button" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	obj.closest(".modal-footer").html(view);
}
function programDetail(table){
	const obj = $(table);
	var frm = $('.active');
	//const id = obj.attr("id")
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//readonly 추가
	$('.readwrite').prop('readonly', true);
	//select readonly 제거
	$(".readwrite").attr("disabled", true);
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="button" onclick="programModify(this)" class="btn btn-primary">수정</button>
	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">삭제</button>
	<button type="button" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	obj.closest(".modal-footer").html(view);
}
//수정화면에서 저장 누르면 저장된 상세 페이지로 변경
//수정화면에서 크론의 경우 변경 버튼을 눌러야 변경 가능
//일단 호스트는 셀렉트


//프로그램 순서 변경 버튼 눌렀을 때(순서 변경 가능한 상태)
function possibleChangeOrd(btn){
	$(".program").toggleClass('change-ord');
	$(".ord-btn-wrap").empty();
	$(".ord-btn-wrap").append(`<div class="ord-btn" onclick="saveChangedOrd(this)"><span>저장하기</span></div>`);
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
//프로그램 순서 저장 버튼 눌렀을 때(순서 변경 저장)
function saveChangedOrd(btn){
	
	const grpId = $("#sortable .grpId").text();
	
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
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(vo),
		success: function(result){
			var target = $(".sub-content");
			target.empty();
			var view = ``;
			if(result.length==0){
				view = `<div class="grpId">` + grpId + `</div><div onclick="getInsertInfo(this)" data-bs-toggle="modal" data-bs-target="#insert-batch-program" class="insert-prm-btn">+</div><span class='warning'">프로그램이 없습니다.</span>`;
			}else{
				view = `<div class="grpId">` + grpId + `</div><div onclick="getInsertInfo(this)" data-bs-toggle="modal" data-bs-target="#insert-batch-program" class="insert-prm-btn">+</div><ul id="sortable">`;
				for(var i=0;i<result.length;i++){
					let obj = result[i];
					view += `<li class="d-flex program">
								<div class="program-id"><span>` + obj['batPrmId'] + `</span></div>
								<div class="program-nm"><span>` + obj['batPrmNm'] + `</span></div>
								<div class="program-path"><span>` + obj['path'] + `</span></div>
								<div class="program-active">
									<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
										onclick="" data-bs-toggle="modal" data-bs-target="#detail-batch-program">
									<img src="/image/common/action/detail.png" class="menu-box" id="detail">
								</div> 
								<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
									onclick="prmDelete(this)">
									<img src="/image/common/action/delete.png" class="menu-box" id="delete">
								</div></div>
								<div class="program-ord"><span>` + obj['excnOrd'] + `</span></div>
							</li>`;
				}
				view += `<li class="ord-btn-wrap"><div class="ord-btn" onclick="possibleChangeOrd(this)"><span>순서 변경</span></div></li></ul>`;
			}
			target.append(view);
		}
	});  
} 
function getInsertInfo(btn){
	//grpId랑 grpId로 Host찾고 path경로(controller) 비동기로 받아와서 insertPrm에 심기
	const grpId = $(".sub-content .grpId").text();
	$.ajax({
		url: "/batch/path?grpId=" + grpId, 
		method: "GET",
		success: function(result){
			$("#insert-batch-program input[name=batGrpId]").val(grpId);
			var target = $("#insert-batch-program select[name=path]");		
			target.empty();
			for(var i=0;i<result.length;i++){
				let obj = result[i];
				let view = `<option value="`+ obj + `">` + obj + `</option>`;
				target.append(view);
			}
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
/*   $( function() {
    $( "#sortable" ).sortable( {
    	stop: function(e){
    		const li = $("ul li");
    		
    		li.each(function(index){
    			const target = $(this);
    			target.find("input[name='excnOrd']").val(index+1);
    		});
    	}
    } );
    
  }); */

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
		if($("#insert-batch-group input[name=time]").val()=="hour"){
			hour = '/' + number;
			cronDsc += number + '시간마다';
		}else if($("#insert-batch-group input[name=time]").val()=="min"){
			min = '/' + number;
			cronDsc += number + '분마다';
		}else if($("#insert-batch-group input[name=time]").val()=="sec"){
			sec = '/' + number;
			cronDsc += number + '초마다';
		}
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + week;	
	}else if(method=="3"){
		cron = $("#insert-batch-group input[name=selectCron]").val();
		cronDsc = '';
	}
	alert(cron);
	$("#insert-batch-group input[name=cron]").val(cron);
	$("#insert-batch-group input[name=cronDsc]").val(cronDsc);   
	
}
</script>
</head>

<main id="main">
	<div class="title">
		<h1>배치 관리</h1>
	</div>
	<div class="content">
		<!-- <div class="search-content">검색</div> -->
		<div class="main-content">
			<h3>배치 그룹 관리&nbsp;
				<button data-bs-toggle="modal" data-bs-target="#insert-batch-group" class="insert-grp-btn">+</button></h3>
			<div class="main-list">
				<ul>
					<li class="d-flex list-header">
						<div class="group-id"><span>그룹ID</span></div>
						<div class="group-nm"><span>그룹명</span></div>
						<div class="group-host"><span>호스트명(IP)</span></div>
						<div class="group-cron"><span>주기</span></div>
						<div class="group-conn"><span>연결상태</span></div>
						<div class="group-running"><span>실행</span></div>
						<div class="group-active"><span>Actions</span></div>
					</li>
					<c:forEach var="group" items="${batGrpList}">
						<li class="d-flex group" onclick="prmList(this)">
							<div class="group-id">
								<span>${group.batGrpId}</span>
							</div>
							<div class="group-nm">
								<span>${group.batGrpNm}</span>
							</div>
							<div class="group-host">
								<span>${group.hostNm}(${group.hostIp})</span>
							</div>
							<div class="group-cron">
								<span> <c:if test="${empty group.cronDsc}">
									${group.cron}
							</c:if> <c:if test="${not empty group.cronDsc}">
									${group.cronDsc}
								</c:if></span>
							</div>
							<div class="group-conn">
								<c:if test="${group.conn == 'on'}">
									<span class="conn_enabled">enabled</span>
								</c:if>
								<c:if test="${group.conn == 'off'}">
									<span class="conn_disabled">disabled</span>
								</c:if>
							</div> 
							<div class="group-running">
								<c:if test="${group.runCheck eq true}">
									<label for="toggle" class="toggleSwitch active"> <span
										class="toggleButton"></span></label>
								</c:if>
								<c:if test="${group.runCheck eq false}">
									<label for="toggle" class="toggleSwitch"> <span
										class="toggleButton"></span></label>
								</c:if>
							</div>
							<div class="group-active">
								<div onclick="getUpdateGrpInfo(this)"
									data-bs-toggle="modal" data-bs-target="#detail-batch-group">
									<img src="/image/common/action/detail.png" class="menu-box" id="detail">
								</div> 
								<div onclick="grpDelete('${group.batGrpId}')">
									<img src="/image/common/action/delete.png" class="menu-box" id="delete">
								</div>
							</div>
						</li>
					</c:forEach>
						<li>
							<c:if test="${pager.totalRows > 0}">
								<div id="page-box">
									<c:set var="url" value="/batch"/>
									<c:if test="${not empty search}">
										<c:set var="url" value="/batch" />
									</c:if>
								
									<c:if test="${pager.groupNo>1}">
										<a class="page-button" href="${url}?pageNo=${pager.startPageNo-1}${search}"><</a>
									</c:if>
									<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
										<c:if test="${pager.pageNo != i}">
											<a class="page-button" href="${url}?pageNo=${i}${search}">${i}</a>
										</c:if>
										<c:if test="${pager.pageNo == i}">
											<a class="page-button this-page" href="${url}?pageNo=${i}${search}">${i}</a>
										</c:if>
									</c:forEach>
									
									<c:if test="${pager.groupNo<pager.totalGroupNo}">
										<a class="page-button" href="${url}?pageNo=${pager.endPageNo+1}${search}">></a>
									</c:if>
								</div>
							</c:if>
						</li>
					<ul>
			</div>
		</div>
		<div class="sub-content" value="">
			<span class="warning">그룹을 선택해주세요.</span>
		</div>
	</div>
</main>


<%@ include file="/WEB-INF/views/batch/groupDetail.jsp" %>
<%@ include file="/WEB-INF/views/batch/programDetail.jsp" %>
<%@ include file="/WEB-INF/views/batch/insertGroup.jsp" %>
<%@ include file="/WEB-INF/views/batch/insertProgram.jsp" %>

<%@ include file="common/footer.jsp"%>