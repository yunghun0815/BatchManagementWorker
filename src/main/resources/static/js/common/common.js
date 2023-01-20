$(function(){
	// 페이지별 메뉴 색 변경
	const menu = $("#menu").val();
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
