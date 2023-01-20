/**
 * 공통 필드 및 함수
 
 * 유효성 검사 후 에러메세지 출력할 태그 아이디 "error-컬럼명" 추가해야 함
 * ex) <span id="error-hostIp"></span>
 */
 
// 유효성 검사용 정규표현식
export const regexp = {
	'blank': {
		'regexp': /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]{1,50}$/,
		'message': '50자 이하의 한글, 영어, 숫자만 사용 가능합니다.'
	},
	'ip': {
		'regexp': /^(([1-9]?\d|1\d{2}|2([0-4]\d)|25[0-5])\.){3}([1-9]?\d|1\d{2}|2([0-4]\d)|25[0-5])$/,
		'message': '아이피 형식을 확인해주세요.'
	},
	'file': {
		'regexp': /.bat|.jar$/,
		'message': '파일 확장자명을 확인해주세요.'
	}
}; 

// 브라우저에서 유효성검사 후 메세지 출력
export function browserValid(field, key, value){
	// 받아온 값 정규표현식 체크 후 메세지 출력
	if( !regexp[key]['regexp'].test(value) ){
		$("#error-"+ field).html(regexp[key]['message']);
		return false;
	}
	return true;
}

// 서버 유효성검사 후 메세지 출력
export function serverValid(result){
	// 서버 유효성 검사 실패한 수만큼 반복해서 메세지 출력
	if(result.length > 0){
		result.forEach(data=> {
			$("#error-"+ data['field']).html(data['defaultMessage']);
		});
	}
}