package com.company.myapp.batch;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum BatchStatusCode {
	
	SUCCESS("BSSC","성공"),
	FAIL("BSFL", "실패"),
	RUNNING("BSRN", "실행중"),
	WAIT("BSWT", "대기"),
	RESTART("BSRS", "재실행");
	
	private final String code;
	private final String message;
}