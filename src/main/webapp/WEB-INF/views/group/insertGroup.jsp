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
<script type="text/javascript">

function insert(btn){
	//btn.preventDefault();

	//const batGrpNm = $("input[name=batGrpNm]");
	//const batGrpDsc = $("input[name=batGrpDsc]");
	//const hostId = $("input[name=hostId]");
	//const autoExcnYn = $("select[name=autoExcnYn]").val();

	var sec = '*';
	var min = '*';
	var hour = '*';
	var day = '*';
	var mon = '*';	//선택x
	var year = '*';	//선택x
	var week = '*'; 

	const method = $("input[name=cycle]:checked").val();
	var cron = '';
	var cronDsc = '';
	//const id = obj.closest(".group-tr").attr("id");
        if(method == "1") {	//일자반복
		var cycle = $("select[name=cycle1]").val();
		if(cycle=="day"){
			cronDsc += '매일 ';
		}else if(cycle=="week"){
			week = $("select[name=cycleMF]").val();
			cronDsc += ('매주 ' + $("#option-week option:selected").text() + ' ');
		}else if(cycle=="month"){
		  	day = $("input[name=cycleDay]").val();
			cronDsc +=('매월 ' + $("#option-month").val() + '일 ');
		}
		var time_h = $("input[name=cycleTime]").val().split(":")[0];
		var time_m = $("input[name=cycleTime]").val().split(":")[1];
		cronDsc += time_h + '시 ' + time_m + '분';
		min = time_m;
		hour = time_h;
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + year + ' ' + week;
	}else if(method=="2"){
		var number = $("input[name==timeNumber]").val();
		if($("input[name==time]").val()=="hour"){
			hour = '/' + number;
			cronDsc += number + '시간마다';
		}else if($("input[name==time]").val()=="min"){
			min = '/' + number;
			cronDsc += number + '분마다';
		}else if($("input[name==time]").val()=="sec"){
			sec = '/' + number;
			cronDsc += number + '초마다';
		}
		cron = sec + ' ' + min + ' ' + hour + ' ' + day + ' ' + mon + ' ' + year + ' ' + week;	
	}else if(method=="3"){
		cron = $("input[name=cycleTime]").val();
		cronDsc = '';
	}
       alert(method);
        alert(cron);
        alert(cronDsc);
  	 $("input[name=cron]").val(cron);
  	 $("input[name=cronDsc]").val(cronDsc);   
}

</script>
<title>Insert title here</title>
</head>
<body>
	
	
	
	<form action="/batch/group/insert" method="post" onsubmit="insert(this)">
	<h6>그룹 등록</h6>
	<table class="table table-bordered align-middle bg-white">
		<tr>
			<th>그룹명</th>
			<td style="width: 80%;"><input class="form-control" type="text" name="batGrpNm">
			</td>
		</tr>
		<tr>
			<th>그룹설명</th>
			<td><input class="form-control" type="text" name="batGrpDsc"></td>
		</tr>
		<tr>
			<th>호스트ID</th>
			<td><input class="form-control" type="text" name="hostId"></td>
		</tr>
		<tr>
			<th>자동설정</th>
			<td><select class="form-select ib width-20per" name="autoExcnYn">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
		</tr>
		<tr>
			<th>주기설정</th>
			<td><input type="hidden" name="cron" value=""><input type="hidden" name="cronDsc" value=""> 
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
						<input class="form-control ib width-50per" type="text" placeholder="ex) 0/5 * * * * ?" disabled>
					</div></td>
		</tr>
		<tr>
			<th>버튼</th>
			<td><button type="submit">저장</button></td>
		</tr>
	</table>
	</form>
</body>
</html>