package com.company.myapp.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 배치 프로그램 DTO
 * @author 김나영
 * 
 */
@ToString
@Getter
@Setter
public class BatPrm {
	private String batPrmId;	// 배치 프로그램 아이디
	private String batPrmNm;	// 배치 프로그램명
	private String batGrpId;	// 배치 그룹 아이디
	private String path;		// 배치 파일 경로
	private int excnOrd;		// 실행 순서
	private String param;		// 파라미터
	private String paramDsc;	// 파라미터 설명
	private char useYn;			// 사용 유무
	private String lastMdfrNm;	// 최종 수정자명
	private Date lastMdfcnDttm;	// 최종 수정 일자
}
