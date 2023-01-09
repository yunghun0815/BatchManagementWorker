
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="common/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
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

.insert-btn{
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
				view = `<span style="margin-left: 20px;line-height:670px;font-size: 2.5em;color:white;vertical-align:middle;">프로그램이 없습니다.</span>`;
			}else{
				view = `<ul>`;
				for(var i=0;i<result.length;i++){
					let obj = result[i];
					view += `<li class="d-flex program">
								<div class="program-id"><span>` + obj['batPrmId'] + `</span></div>
								<div class="program-nm"><span>` + obj['batPrmNm'] + `</span></div>
								<div class="program-path"><span>` + obj['path'] + `</span></div>
								<div class="program-active">
									<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
										onclick="" data-bs-toggl="modal" data-bs-target="#detail-batch-program">
									<img src="/image/detail.png" class="menu-box" id="detail">
								</div> 
								<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)"
									onclick="prmDelete(` + obj['batPrmId'] + `)">
									<img src="/image/delete.png" class="menu-box" id="delete">
								</div></div>
								<div class="program-ord"><span>` + obj['excnOrd'] + `</span></div>
							</li>`;
				}
				view += `</ul>`;
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
	$(obj).find(".menu-box").prop("src", "/image/"+ $(obj).find(".menu-box").prop("id") +"_after2.png");
}
function iconMouseLeave(obj){
	$(obj).css("border","1.5px solid #acb9c7");
	$(obj).find(".menu-box").prop("src", "/image/"+ $(obj).find(".menu-box").prop("id") +".png");
}

window.onload = function(){
	const $toggle = document.querySelector(".toggleSwitch");
	const $active = document.querySelector(".group-active");
	
	$toggle.onclick = () => {
		event.stopPropagation();
	  $toggle.classList.toggle('active');
	}
	$active.onclick = () => {
		event.stopPropagation();
	}
}

//삭제확인
function grpDelete(grpId){
	event.stopPropagation();
	if(window.confirm('정말 삭제하시겠습니까?')){
		alert(grpId);
		location.href='http://localhost:8080/';
	}
}


$(function(){
	// 페이지별 메뉴 색 변경
	 $(".group-active div").mouseover(function(){
		$(this).css("border","1.5px solid #0CA3B9");
		$(this).find(".menu-box").prop("src", "/image/"+ $(this).find(".menu-box").prop("id") +"_after.png");
	})
	$(".group-active div").mouseleave(function(){
		$(this).css("border","1.5px solid #acb9c7");
		$(this).find(".menu-box").prop("src", "/image/"+ $(this).find(".menu-box").prop("id") +".png");
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
//수정 누르면 수정버전으로 변경
function groupModify(table){
	const obj = $(table);
	var frm = $('.inactive');
	const id = obj.attr("id")
	//class 변경 inacive->active
	frm.removeClass('inactive');
	frm.addClass('active');
	//readonly 제거
	$('.readwrite').prop('readonly', false);
	//select readonly 제거
	$(".readwrite option").not(":selected").attr("disabled", "");
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="submit" class="btn btn-secondary">저장</button>
        <button type="button" onclick="groupDetail(this)" class="btn btn-secondary">Back</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	obj.closest(".modal-footer").html(view);
}
//수정화면에사 취소 누르면 상세 페이지러 변경
function groupDetail(table){
	const obj = $(table);
	var frm = $('.active');
	const id = obj.attr("id")
	//class 변경
	frm.removeClass('active');
	frm.addClass('inactive');
	//readonly 추가
	$('.readwrite').prop('readonly', true);
	//select readonly 제거
	$(".readwrite option").not(":selected").attr("disabled", "disabled");
	//버튼 변경(수정삭제목록 -> 저장이전목록)
	var view =`<button type="button" onclick="appModify(this)" class="btn btn-secondary">수정</button>
	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">삭제</button>
	<button type="button" class="btn btn-primary" data-bs-dismiss="modal">목록</button>`;
	obj.closest(".modal-footer").html(view);
}
//수정화면에서 저장 누르면 저장된 상세 페이지로 변경
//수정화면에서 크론의 경우 변경 버튼을 눌러야 변경 가능
//일단 호스트는 셀렉트
//맨밑에 프로그램 순서 변경



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
				<button class="insert-btn">+</button></h3>
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
								<div 
									data-bs-toggle="modal" data-bs-target="#detail-batch-group">
									<img src="/image/detail.png" class="menu-box" id="detail">
								</div> 
								<div onclick="grpDelete(${group.batGrpId})">
									<img src="/image/delete.png" class="menu-box" id="delete">
								</div>
							</div>
						</li>
					</c:forEach>
					<ul>
			</div>
		</div>
		<div class="sub-content">
			<ul>
			<li class="d-flex program">
								<div class="program-id"><span>PRM000000001</span></div>
								<div class="program-nm"><span>프로그램 이름</span></div>
								<div class="program-path"><span>C:/dev/batch-agent/test-app1.bat</span></div>
								<div class="program-active">
									<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="" 
										data-bs-toggl="modal" data-bs-target="#detail-batch-program">
										<img src="/image/detail.png" class="menu-box" id="detail">
									</div> 
									<div onmouseenter="iconMouseOver(this)" onmouseleave="iconMouseLeave(this)" onclick="prmDelete(` + obj['batPrmId'] + `)">
										<img src="/image/delete.png" class="menu-box" id="delete">
									</div>
								</div>
								<div class="program-ord"><span>1</span></div>
			</li>
			<li class="d-flex program">
								<div class="program-id"><span>PRM000000001</span></div>
								<div class="program-nm"><span>프로그램 이름</span></div>
								<div class="program-path"><span>C:/dev/batch-agent/test-app1.bat</span></div>
								<div class="program-ord"><span>1</span></div>
								<div class="program-active">
									<div onclick="" data-bs-toggl="modal" data-bs-target="#detail-batch-program">
										<img src="/image/detail.png" class="menu-box" id="detail">
									</div> 
									<div onclick="prmDelete(` + obj['batPrmId'] + `)">
										<img src="/image/delete.png" class="menu-box" id="delete">
									</div>
								</div>
			</li>
			<li class="d-flex program">
								<div class="program-id"><span>PRM000000001</span></div>
								<div class="program-nm"><span>프로그램 이름</span></div>
								<div class="program-path"><span>C:/dev/batch-agent/test-app1.bat</span></div>
								<div class="program-ord"><span>1</span></div>
								<div class="program-active">
									<div onclick="" data-bs-toggl="modal" data-bs-target="#detail-batch-program">
										<img src="/image/detail.png" class="menu-box" id="detail">
									</div> 
									<div onclick="prmDelete(` + obj['batPrmId'] + `)">
										<img src="/image/delete.png" class="menu-box" id="delete">
									</div>
								</div>
			</li>
			<li class="d-flex program">
								<div class="program-id"><span>PRM000000001</span></div>
								<div class="program-nm"><span>프로그램 이름</span></div>
								<div class="program-path"><span>C:/dev/batch-agent/test-app1.bat</span></div>
								<div class="program-ord"><span>1</span></div>
								<div class="program-active">
									<div onclick="" data-bs-toggl="modal" data-bs-target="#detail-batch-program">
										<img src="/image/detail.png" class="menu-box" id="detail">
									</div> 
									<div onclick="prmDelete(` + obj['batPrmId'] + `)">
										<img src="/image/delete.png" class="menu-box" id="delete">
									</div>
								</div>
			</li>
			<li class="d-flex program">
								<div class="program-id"><span>PRM000000001</span></div>
								<div class="program-nm"><span>프로그램 이름</span></div>
								<div class="program-path"><span>C:/dev/batch-agent/test-app1.bat</span></div>
								<div class="program-ord"><span>1</span></div>
								<div class="program-active">
									<div onclick="" data-bs-toggl="modal" data-bs-target="#detail-batch-program">
										<img src="/image/detail.png" class="menu-box" id="detail">
									</div> 
									<div onclick="prmDelete(` + obj['batPrmId'] + `)">
										<img src="/image/delete.png" class="menu-box" id="delete">
									</div>
								</div>
			</li>
			</ul>
			<!-- <span style="line-height:670px;font-size: 2.5em;color:white;vertical-align:middle;">그룹을 선택해주세요.</span> -->
		</div>
	</div>
</main>


<%@ include file="/WEB-INF/views/modal/groupDetail.jsp" %>

<%@ include file="common/footer.jsp"%>