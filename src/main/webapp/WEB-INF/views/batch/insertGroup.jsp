<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
th {
	text-align: center;
}
</style>
<div id="insert-batch-group" class="modal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<form action="/batch/group/insert" method="post" onsubmit="changeCron(this)"><div class="modal-content">
			<input type="hidden" name="cron"><input type="hidden" name="cronDsc">
			<div class="modal-header">
				<h5 id="log-app-id" class="modal=title">그룹 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h6>Form</h6>
				<table class="table table-bordered align-middle bg-white">
					<tr>
						<th>그룹명</th>
						<td style="width: 80%;">
							<input class="form-control" type="text" name="batGrpNm">
						</td>
					</tr>
					<tr>
						<th>그룹설명</th>
						<td><input class="form-control"  type="text" name="batGrpDsc"></td>
					</tr>
					<tr>
						<th>호스트명(IP)</th>
						<td><select class="form-control" name="hostId">
							<c:forEach var="host" items="${hostList}">
								<option value="${host.hostId}">${host.hostNm}(${host.hostIp})</option>
							</c:forEach>
							</select></td>
					</tr>
					<tr>
						<th>자동실행</th>
						<td>
						<select class="readwrite form-control" name="autoExcnYn">
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<th>주기설정</th>
						<td>
							<input class="form-check-input" type="radio" name="cycle" id="cycle-date" value="1" checked> 
							<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-date">일자 반복</label>
							<div style="margin-bottom: 15px;">
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
								<input class="form-check-input align-baseline" type="radio" name="time" id="hour" value="hour" disabled> 
								<label class="form-check-label" for="hour"> 시 </label> 
								<input class="form-check-input align-baseline" type="radio" name="time" id="min" value="min" disabled> 
								<label class="form-check-label" for="min"> 분 </label> 
								<input class="form-check-input align-baseline" type="radio" name="time" id="sec" value="sec" disabled> 
								<label class="form-check-label" for="sec"> 초 </label> 
								<input class="form-control ib width-40per" type="text" name="timeNumber" placeholder="반복할 시간을 입력해주세요" disabled>
							</div> 
					
							<input class="form-check-input" type="radio" name="cycle" id="cycle-cron" value="3"> 
							<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-cron">크론 표현식</label>
							<div id="add-time-box">
								<input class="form-control ib width-50per" name="selectCron" type="text" placeholder="ex) 0/5 * * * * ?" disabled>
							</div>
							
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-primary">저장</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div>
		</div></form>
	</div>
</div>
