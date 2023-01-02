<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
th {
	text-align: center;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<form action="/batch/test" method="post">

		<h6>그룹 등록</h6>
		<table class="table table-bordered align-middle bg-white">

			<tr>
				<th>주기설정</th>
				<td><input class="form-check-input" type="radio" name="cycle" id="cycle-date"  value="1" checked> 
				<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-date">일자 반복</label>
					<div style="margin-bottom: 15px;">
						<select class="form-select ib width-20per" id="cron-box" name="cycle1">
							<option value="day">매일</option>
							<option value="week">매주</option>
							<option value="month">매월</option>
						</select>
						<select class="form-select ib width-20per" id="option-week" name="cycleMF">
							<option>월요일</option>
							<option>화요일</option>
							<option>수요일</option>
							<option>목요일</option>
							<option>금요일</option>
							<option>토요일</option>
							<option>일요일</option>
						</select> 
						<input class="form-control ib width-40per" id="option-month" type="text" placeholder="일자를 입력하세요 ex)17" name="cycleDay"> 
						<input class="form-control ib width-30per" type="time" name="cycleTime"><br>
					</div> 
					
					<input class="form-check-input" type="radio" name="cycle" id="cycle-time" value="2" > 
					<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-time">시간 반복</label>
					<div id="add-time-box" style="margin-bottom: 15px;">
						<input class="form-check-input align-baseline" type="radio" name="time" id="hour" disabled> 
						<label class="form-check-label" for="hour"> 시 </label> 
						<input class="form-check-input align-baseline" type="radio" name="time" id="min" disabled> 
						<label class="form-check-label" for="min"> 분 </label> 
						<input class="form-check-input align-baseline" type="radio" name="time" id="sec" disabled> 
						<label class="form-check-label" for="sec"> 초 </label> 
						<input class="form-control ib width-40per" type="text" placeholder="반복할 시간을 입력해주세요" disabled>
					</div> 
					
					<input class="form-check-input" type="radio" name="cycle" id="cycle-cron" value="3" > 
					<label style="font-size: 14px; vertical-align: text-bottom; color: darkblue;" for="cycle-cron">크론 표현식</label>
					<div id="add-time-box">
						<input class="form-control ib width-50per" type="text" placeholder="ex) 0/5 * * * * ?" disabled>
					</div></td>
			</tr>
		</table>
		<br>
		<br>
		<button type="submit">등록</button>
	</form>
</body>
</html>