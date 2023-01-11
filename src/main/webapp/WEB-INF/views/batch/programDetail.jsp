<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.modal-body th{
	text-align:center;
}
</style>
<div id="detail-batch-program" class="modal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<form action="/batch/program/update" method="POST"><div class="modal-content">
			<div class="modal-header">
				<h5 id="log-add-id" class="modal-title">프로그램 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h6>상세정보</h6>
				<table class="table table-bordered align-middle bg-white">
					<tr>
						<th>프로그램ID</th>
						<td><input class="onlyread form-control inactive" type="text" name="batPrmId" readonly></td>
					</tr>
					<tr>
						<th>프로그램명</th>
						<td><input class="readwrite form-control inactive" type="text" name="batPrmNm" readonly></td>
					</tr>
					<tr>
						<th>그룹ID</th>
						<td><input class="onlyread form-control inactive" type="text" name="batGrpId" readonly></td>
					</tr>
					<tr>
						<th>경로</th>
						<td><select class="readwrite form-control inactive" name="path" disabled>
							</select></td>
					</tr>
					<tr>
						<th>파라미터(Default)</th>
						<td><input class="readwrite form-control inactive" type="text" name="param" readonly></td>
					</tr>
					<tr>
						<th>파라미터 설명</th>
						<td><textarea class="readwrite form-control inactive" cols="10" rows="20" name="paramDsc" readonly></textarea></td>
					</tr>
					<tr>
						<th>실행순서</th>
						<td><input class="onlyread form-control inactive" type="text" name="excnOrd" readonly></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="programModify(this)">수정</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">목록</button>
			</div>
		</div></form>
	</div>
</div>