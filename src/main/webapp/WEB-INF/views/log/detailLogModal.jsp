<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="detail-log-modal" class="modal" tabindex="-1">
	<form action="/batch/app/posts" method="post">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"><span class="batPrmId"></span>상세보기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      		<table class="table table-bordered align-middle bg-white log-detail">
	      			<tr>
	      				<th>프로그램ID</th>
	      				<td class="batPrmId"></td>
	      			</tr>
	      			<tr>
	      				<th>프로그램명</th>
	      				<td class="batPrmNm"></td>
	      			</tr>
	      			<tr>
	      				<th>배치결과</th>
	      				<td class="batPrmStCd"></td>
	      			</tr>
	      			<tr>
	      				<th>메세지</th>
	      				<td>
	      					<textarea class="form-control rsltMsg" rows="10" cols="40" readonly></textarea>
	      				</td>
	      			</tr>
	      			<tr>
	      				<th>파라미터</th>
	      				<td class="param"></td>
	      			</tr>
	      			<tr>
	      				<th>배치시작시간</th>
	      				<td class="batBgngDt"></td>
	      			</tr>
	      			<tr>
	      				<th>배치종료시간</th>
	      				<td class="batEndDt"></td>
	      			</tr>
	      		</table>
	      </div>
	    </div>
	  </div>
  </form>
</div>