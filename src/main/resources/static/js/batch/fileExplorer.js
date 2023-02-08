
const grpId = opener.$(".sub-content .grp").prop("id");

$(function(){
	getPath("C:\\");
});

// 클릭시 배경색 변경
function activeExpBox(e){
	$("#file-explorer .exp-box").css("background-color", "white");
	$(e).css("background-color", "rgb(0 0 255 / 10%)");
}
// 파일 클릭시 부모창으로 값 전송 및 close 
function selectFile(e){
	opener.$(".modal #path").val(e);
	window.close();
}

// dir 클릭시 하위 폴더 및 파일 조회
function getPath(path){
 //let path="C:\\";
	$.ajax({
		url: "/batch/path",
		type: "GET",
		data:{
			grpId: grpId,
			path: path
	},
	success: function(result){
		if(result == '' || result == null){
			swal({
				  title: "접근 불가",
				  text: "해당 폴더에 접근이 불가능합니다.",
				  icon: "error",
				  button: "확인"
			});
		}
	let view = `<h3><input id="current-path" type="text" value="` + path + `"></h3>`;
	   
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
				<img class="exp-img" src="/image/fileExplorer/folder.png"><br>
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
				<img class="exp-img" src="/image/fileExplorer/folder.png"><br>
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
		 	<div class="exp-box" onclick="activeExpBox(this)" ondblclick="selectFile('`+ file +`')">
				<img class="exp-img" src="/image/fileExplorer/file.png"><br>
				<span class="exp-name">` + realFile + `</span>
		 	</div>
		 `;				 
	 });
	 
	 
	 $("#file-explorer").html(view);
	 $("#current-path").keyup(function(e){
		console.log("test");
		if(e.keyCode == 13) getPath($(this).val());
	});
	},
	error: function(error){
	 alert(error);
	}
	});
}