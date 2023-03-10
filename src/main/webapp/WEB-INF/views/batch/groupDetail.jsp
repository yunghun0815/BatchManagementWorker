<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="detail-batch-group" class="modal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<form id="update-group"  method="POST"><div class="modal-content">
			<div class="modal-header">
	        	<h5 id="log-app-id" class="modal-title">그룹 정보</h5>
	        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      	</div>
	      	<div class="modal-body" style="max-height: 690px; overflow: auto;">
	      		<h6>상세정보</h6>
	      		<table class="table table-bordered align-middle bg-white">
					<tr>
	      				<th>그룹ID</th>
	      				<td>
	      					<input name="batGrpId" class="onlyread form-control inactive" type="text" readonly disabled>    					
	      				</td>
	      			</tr>
					<tr>
						<th>그룹명</th>
						<td style="width: 80%;">
							<input name="batGrpNm" class="readwrite form-control inactive" type="text" disabled>
							<button type="button" class="duplication-btn">중복 확인</button>
							<span id="error-detail-batGrpNm" class="error-message"></span>
							<input name="hiddenBatGrpNm" class="readwrite form-control inactive" type="hidden" disabled>
							<input type="hidden" name="checkGrpNm" value="check">
						</td>
					</tr>
					<tr>
						<th>그룹설명</th>
						<td><input name="batGrpDsc" class="readwrite form-control inactive"  type="text" disabled></td>
					</tr>
					<tr>
						<th>호스트명(IP)</th>
						<td><select name="hostId" class="readwrite form-control inactive" disabled>
								<c:forEach var="host" items="${hostList}">
									<option value="${host.hostId}">${host.hostNm} - ${host.hostIp}:${host.hostPt}</option>
								</c:forEach>
							</select></td>
					</tr>
					<tr>
						<th>자동실행</th>
						<td>
						<select name="autoExcnYn" class="readwrite form-control inactive" disabled>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<th>cron</th>
						<td>
							<input class="onlyread form-control inactive" type="text" name="cronView" readonly disabled>
							<button type="button" class="show-cron" onclick="showCronInput()">주기 재등록</button>
							<div class="insert-cron">
								<input class="form-check-input" type="radio" name="cycle" id="cycle-date" value="1" checked> 
								<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-date">일자 반복</label>
								<div class="cron-date-select">
								   <select class="form-select ib width-20per" id="cron-box" name="cycle1">
								      <option value="day">매일</option>
								      <option value="week">매주</option>
								      <option value="month">매월</option>
								   </select> 
								   <select class="form-select ib width-20per" id="option-week" name="cycleMF">
								      <option value="MON">월요일</option>
								      <option value="TUE">화요일</option>
								      <option value="WED">수요일</option>
								      <option value="THU">목요일</option>
								      <option value="FRI">금요일</option>
								      <option value="SAT">토요일</option>
								      <option value="SUN">일요일</option>
								   </select> 
								   <input class="form-control ib width-40per" id="option-month" type="text" placeholder="일자를 입력하세요 ex)17" name="cycleDay">
								   <input class="form-control ib width-30per" type="time" name="cycleTime"><br>
								</div> 
								
								<input class="form-check-input" type="radio" name="cycle" id="cycle-time" value="2"> 
								<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-time">시간 반복</label>
								<div id="add-time-box" style="margin-bottom: 15px;">
								   <input class="form-check-input align-baseline" type="radio" name="time" id="hour" value="hour" > 
								   <label class="form-check-label" for="hour"> 시 </label> 
								   <input class="form-check-input align-baseline" type="radio" name="time" id="min" value="min" > 
								   <label class="form-check-label" for="min"> 분 </label> 
								   <input class="form-check-input align-baseline" type="radio" name="time" id="sec" value="sec" > 
								   <label class="form-check-label" for="sec"> 초 </label> 
								   <input class="form-control ib width-40per" type="text" name="timeNumber" placeholder="반복할 시간을 입력해주세요" >
								</div> 
								
								<input class="form-check-input" type="radio" name="cycle" id="cycle-cron" value="3"> 
								<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-cron">크론 표현식</label>
								<div id="add-time-box">
								   <input class="form-control ib width-50per" name="selectCron" type="text" placeholder="ex) 0/5 * * * * ?" >
								</div>
								<span id="error-detail-cron" class="error-message"></span>
							</div>
							<input type="hidden" name="cron"><input type="hidden" name="cronDsc">
						</td></tr>
	      		</table>
	    	</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="groupModify(this)">수정</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">목록</button>
			</div>
		</div></form>		
	</div>
</div>