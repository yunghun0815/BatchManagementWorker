package com.company.myapp.batch.code;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * 배치 결과 상태코드 
 * @author 정영훈, 김나영
 *
 */
@Getter
@RequiredArgsConstructor
public enum BatchStatusCode {
	
	SUCCESS("BSSC","성공"),
	FAIL("BSFL", "실패"),
	RUNNING("BSRN", "실행중"),
	WAIT("BSWT", "대기");
	
	private final String code;
	private final String title;
	
	/**
	 * 코드를 타이틀로 변경
	 * ex) 'BSSC' -> '성공'
	 * @param code 상태코드
	 * @return
	 */
	public static String codeToTitle(String code) {
		String title = null;
		
		for(BatchStatusCode type : BatchStatusCode.values()) {
			if(type.getCode().equals(code)) {
				title = type.getTitle();
			}
		}
		return title;
	}
}