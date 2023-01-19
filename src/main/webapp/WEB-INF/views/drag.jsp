<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	

function activeExpBox(e){
	$("#file-explorer .exp-box").css("background-color", "white");
	$(e).css("background-color", "rgb(0 0 255 / 10%)");
}
function getPath(path){
 //let path="C:\\";
	$.ajax({
		url: "/path",
		type: "GET",
		data:{
		hostIp: "127.0.0.1",
		hostPt: 50001,
		path: path
	},
	success: function(result){
		if(result == '' || result == null){
			alert("접근 불가");
		}
	let view = `<h3>` + path + `</h3>`;
	   
	// 이전 경로 가져옴
	let idxP = path.lastIndexOf("\\");
	let lastPath = path.substring(0, idxP);
	lastPath = lastPath.replaceAll("\\", "\\\\");
	
	// 이전 경로가 C: 면 C:\\로 변경
	if(lastPath == 'C:') lastPath = 'C:\\\\';
	
	// 현재 폴더가 C드라이브면 이전폴더 없앰
	if(path != 'C:\\'){
		view += `
			<div class="exp-box" onclick="activeExpBox(this)" ondblclick="getPath('`+ lastPath +`')">
				<img class="exp-img" src="/image/folder.png"><br>
				<span class="exp-name">이전폴더</span>
			</div>
		`;
	}
		 
	 // 폴더 생성
	 result['dir'].forEach((dir)=>{
		 let idxD = dir.lastIndexOf("\\");
		 let realDir = dir.substring(idxD+1);
		 dir = dir.replaceAll("\\", "\\\\");
		 view += `
		 	<div class="exp-box" onclick="activeExpBox(this)" ondblclick="getPath('`+ dir +`')">
				<img class="exp-img" src="/image/folder.png"><br>
				<span class="exp-name">` + realDir + `</span>
		 	</div>
		 `;				 
	 });
	 
	 // 파일 생성
	 result['file'].forEach((file)=>{
		 let idxF = file.lastIndexOf("\\");
		 let realFile = file.substring(idxF+1);
		 file = file.replaceAll("\\", "\\\\");
		 
		 view += `
		 	<div class="exp-box" onclick="activeExpBox(this)">
				<img class="exp-img" src="/image/file.png"><br>
				<span class="exp-name">` + realFile + `</span>
		 	</div>
		 `;				 
	 });
	 
	 
	 $("#file-explorer").html(view);
	},
	error: function(error){
	 alert(error);
	}
	});
}
  </script>
<style>
#file-explorer {
	width: 900px;
	height: 700px;
	border: 1px solid black;
	padding: 20px;
	overflow: hidden;
}

#file-explorer .exp-img {
	width: 50px;
	height: 50px;
}

#file-explorer .exp-box:hover {
	background-color: #0000ff0f !important;
	cursor: pointer;
}

#file-explorer .exp-name {
	display: inline-block;
	width: 80px;
	height: 40px;
	overflow: hidden;
}

#file-explorer .exp-box {
	display: inline-block;
	width: 100px;
	height: 100px;
	font-size: 10px;
	text-align: center;
	vertical-align: middle;
	padding-top: 10px;
	border-radius: 5px;
	margin-bottom: 10px;
}

h4 {
	padding-left: 20px;
}
</style>
<body>
	<button onclick="getPath('C:\\')">파일 탐색기</button>
	<div id="file-explorer">
		<h3>C:\</h3>
	</div>
</body>
</html>