<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배치 관리 시스템</title>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common/common.css">
</head>
<script type="text/javascript">
$(function(){
	// 페이지별 메뉴 색 변경
	const menu = '${menu}';
	console.log(menu);
 	$("#" + menu).parent().css("background-color","#13c3dc");
	$("#" + menu).prop("src", "/image/common/nav/"+ $("#" + menu).prop("id") +".png"); 		
	// 메뉴 마우스오버 이벤트
	 $(".icon-box").hover(function(){
		$(this).css("background-color","#13c3dc");
		$(this).find(".menu-icon").prop("src", "/image/common/nav/"+ $(this).find(".menu-icon").prop("id") +".png");
	},function(){
		if($(this).find(".menu-icon").prop("id") != menu){
			$(this).css("background-color","white");
			$(this).find(".menu-icon").prop("src", "/image/common/nav/"+ $(this).find(".menu-icon").prop("id") +"-gray.png");
		}
	})
	
	$(".action-icon").hover(function(){
		$(this).prop("src", "/image/common/action/" + $(this).prop("id")+"_after.png");
	},function(){
		$(this).prop("src", "/image/common/action/" + $(this).prop("id")+".png");
	});
	
	// 검색
	$("#search").click(function(){
		$("#search-box").show();
	});
	$("#search-action input[type='reset']").click(function(){
		$("#search-box").hide();
	});
}); 
</script>
<body>
	<section id="app" class="d-flex">
		<nav id="lnb">
			<a id="logo" href="/">
				<img src="/image/common/nav/logo.png">
			</a>
			<ul id="menu-bar">
				<li>
					<a class="icon-box" href="/host">
						<img id="host" class="menu-icon" src="/image/common/nav/host-gray.png">
					</a>
				</li>		 
				<li>
					<a class="icon-box" href="/batch">
						<img id="batch" class="menu-icon" src="/image/common/nav/batch-gray.png">
					</a>
				</li>		
				<li>
					<a class="icon-box" href="/log">
						<img id="log" class="menu-icon" src="/image/common/nav/log-gray.png">
					</a>
				</li>		
			</ul>
		</nav>
