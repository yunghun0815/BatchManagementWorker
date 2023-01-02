<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="insert-host-modal" class="modal" tabindex="-1">
	<form action="/batch/app/posts" method="post">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">배치프로그램 추가</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      		<table style="width: 100%;">
	      			<tr>
	      				<td>
	      					<strong>배치그룹</strong>
	      				</td>
	      				<td>
	      					<select name="batchGroupId">
	      						<c:forEach items="${batchGroupList}" var="list">
	      							<option value="${list.batchGroupId}">${list.jobGroupName}</option>
	      						</c:forEach>
	      					</select>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td>
	      					<strong>프로그램명</strong>
	      				</td>
	      				<td>
							<input type="text" name="appName">	      					
	      				</td>
	      			</tr>
	      			<tr>
	      				<td>
	      					<strong>실행경로</strong>
	      				</td>
	      				<td>
	      					<input type="text" name="path">		
	      				</td>
	      			</tr>
	      		</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary">저장</button>
	      </div>
	    </div>
	  </div>
  </form>
</div>