<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

</style>
<div id="insert-batch-program" class="modal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<form id="insert-program" action="/batch/program/insert" method="post"> <div class="modal-content">
			<div class="modal-header">
				<h5 id="log-add-id" class="modal-title">프로그램 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h6>상세정보</h6>
				<table class="table table-bordered align-middle bg-white">
					<tr>
						<th>프로그램명</th>
						<td><input class="form-control" type="text" name="batPrmNm">
						<span id="error-insert-batPrmNm" class="error-message"></span></td>
					</tr>
					<tr>
						<th>그룹ID</th>
						<td><input class="onlyread form-control" type="text" name="batGrpId" readonly></td>
					</tr>
					<tr>
						<th>경로</th>
						<td style="position: relative;">
							<input id="path" class="form-control" type="text" name="path">
							<span id="error-insert-path" class="error-message"></span>
							<button class="path-btn" type="button" onclick="getPath()">파일 찾기</button>
						</td>
					</tr>
					<tr>
						<th>파라미터(Default)</th>
						<td><input class="form-control" type="text" name="param">
						<span id="error-insert-param" class="error-message"></span></td>
					</tr>
					<tr>
						<th>파라미터 설명</th>
						<td><textarea class="form-control" cols="20" rows="10" name="paramDsc"></textarea>
						<span id="error-insert-paramDsc" class="error-message"></span></td>
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