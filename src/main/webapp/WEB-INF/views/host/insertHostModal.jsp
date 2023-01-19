<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="insert-host-modal" class="modal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">호스트 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form:form id="host-insert-form" modelAttribute="host">
				<div class="modal-body">
					<table class="table table-bordered align-middle bg-white">
						<tr>
							<th>호스트명</th>
							<td>
								<form:input path="hostNm" class="form-control" />
								<span id="error-insert-hostNm" class="error-message"></span>
							</td>						
						</tr>
						<tr>
							<th>아이피</th>
							<td>
								<form:input path="hostIp" class="form-control" />
								<span id="error-insert-hostIp" class="error-message"></span>
							</td>						
						</tr>
						<tr>
							<th>포트</th>
							<td>
								<form:input path="hostPt" class="form-control" type="number" min="1" max="65535"/>
								<span id="error-insert-hostPt" class="error-message"></span>
							</td>						
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="submit-btn">등록</button>
					<button type="reset" class="reset-btn" data-bs-dismiss="modal">취소</button>
				</div>
			</form:form>
		</div>
	</div>
</div>