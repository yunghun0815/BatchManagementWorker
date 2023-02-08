<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배치 관리 시스템</title>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common/common.css">
</head>
<body>
	<section id="app" class="d-flex">
		<nav id="lnb">
			<a id="logo" href="/">
				<img src="/image/common/nav/logo.png">
				<input type="hidden" id="menu" value="${menu}">
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
				<li>
					<a class="icon-box" href="/log/monitor">
						<img id="monitor" class="menu-icon" src="/image/common/nav/monitor-gray.png">
					</a>
				</li>	
			</ul>
		</nav>
