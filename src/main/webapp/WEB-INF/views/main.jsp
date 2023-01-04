<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<script type="text/javascript">
function changePath(obj){
	
	document.getElementById('file').value=document.selection.createRange().text.toString();
    alert(document.getElementById('file').value)
}
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
        reader.onload = function (e) {
        //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
            $('#productImg').attr('src', e.target.result);
            //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
            //(아래 코드에서 읽어들인 dataURL형식)
        }                   
        reader.readAsDataURL(input.files[0]);
        //File내용을 읽어 dataURL형식의 문자열로 저장
    }
}//readURL()--

</script>
<title>Insert title here</title>
</head>
<body>
<a href="<c:url value='/batch/group'/>">배치그룹보기</a>
<a href="<c:url value='/batch/searchPage'/>">배치그룹검색</a>

<form action="#" method="GET" id="fform">
<input type="file" id="file" value="" name="file" onchange="this.select(); document.getElementById('file_path').value=document.selection.createRange().text.toString();">
<input type="hidden" value="" name="path">
<button type="submit">제출</button>
</form>
<span class="a"></span>
</body>
</html>