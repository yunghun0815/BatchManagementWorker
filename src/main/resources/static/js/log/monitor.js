const wsAgent = new WebSocket("ws://" + location.host + "/ws/agent"); 
const wsManagement = new WebSocket("ws://" + location.host + "/ws/management");

wsAgent.onmessage = (message) => {
	$("#agent-console ul").append("<li>"+ message['data'] +"</li>");
}  
wsManagement.onmessage = (message) => {
	$("#management-console ul").append("<li>"+ message['data'] +"</li>");
}


$(function(){
	fixedScrollBottom();
});

function fixedScrollBottom(){
	$(".console").each((index, element) => {
		let height = 0;			
		
		$(element).find("ul li").each((index, li) => {
			height += $(li).height();
		});
		
		$(element).find("ul").scrollTop(height);
		console.log(height);
	});
}