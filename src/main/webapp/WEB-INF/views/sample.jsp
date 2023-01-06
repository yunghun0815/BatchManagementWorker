<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
	body{
		background-color: #e8eef2;
		height: 100%;
	}
	*{
		list-style: none;
	}
	#app{
		width: 1600px;
 		height: 850px; 
		margin: 25px auto 25px;
		border-radius: 50px;
		background-color: white;
	}
	#logo{
		display: block;
		margin: 0 auto;
		width: 60px;	
	}
	#logo img{
		width: 60px;
		height: 60px;
	}
	#lnb .menu-icon{
		width: 40px;
	}
	#lnb{
		width: 10%;
		padding-top: 35px;
	}
	#main{
		background-color: #f8fafb;
		width: 90%;
		height: 820px;
		margin: 15px 15px 15px 0;
		border-radius: 50px;
	}
	#menu-bar{
		padding: 0;
		margin: 0;
		height: 700px;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	#menu-bar li{
		text-align: center; 
		margin: 20px 0;
	}
	#menu-bar .icon-box{
		height: 65px;
	    line-height: 60px;
	    width: 65px;
	    display: inline-block;
	    border-radius: 15px;
	}
	#menu-bar .icon-box img:last-child {
		display: none;
	}
		
</style>
<script type="text/javascript">
	$(function(){
/* 		 $(".icon-box .menu-icon").hover(function(){
			$(this).parent().css("background-color","#13c3dc");
			$(this).hide();
			$(this).next().show();
		}), function(){
			$(this).().parent().css("background-color","white");
			$(this).show();
		} 
	}); */
	
	function mOver(e){
		const target = $(e);
		target.parent().css("background-color", "#13c3dc");
		target.next().show();
		target.hide();
	}
	
	function mOut(e){
		
	}
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
						<img class="menu-icon" src="/image/common/nav/host-gray.png" onmouseover="mOver(this)">
						<img class="menu-icon" src="/image/common/nav/host.png" onmouseout="">
					</a>
				</li>		 
				<li>
					<a class="icon-box" href="/batch">
						<img class="menu-icon" src="/image/common/nav/batch-gray.png">
						<img class="menu-icon" src="/image/common/nav/batch.png">
					</a>
				</li>		
				<li>
					<a class="icon-box" href="/log/group/list">
						<img class="menu-icon" src="/image/common/nav/log-gray.png">
						<img class="menu-icon" src="/image/common/nav/log.png">
					</a>
				</li>		
			</ul>
		</nav>
		<main id="main">
				
		</main>
	</section>
</body>
</html>