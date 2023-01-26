const wsAgent = new WebSocket("ws://" + location.host + "/ws/agent"); 
const wsManagement = new WebSocket("ws://" + location.host + "/ws/management");

wsAgent.onmessage = (message) => {
	$("#agent-console ul").append("<li>"+ message['data'] +"</li>");
}  
wsManagement.onmessage = (message) => {
	$("#management-console ul").append("<li>"+ message['data'] +"</li>");
}