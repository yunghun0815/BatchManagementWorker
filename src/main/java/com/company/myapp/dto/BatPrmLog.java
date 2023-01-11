package com.company.myapp.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 배치 프로그램 로그 Dto
 * @author 정영훈
 *
 */
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
@Setter
@Getter
public class BatPrmLog {
	private String batGrpLogId;	// 배치 그룹 로그 아이디
	private int batGrpRtyCnt;	// 배치 그룹 재실행 차수
	private String batPrmId;	// 배치 프로그램 아이디
	private String param;		// 파라미터
	private String batPrmStCd;	// 배치 결과 상태 코드
	private String rsltMsg;		// 결과 메세지
	private Date batBgngDt;		// 배치 실행 시간
	private Date batEndDt;		// 배치 종료 시간
	private int excnOrd;		// 실행 순서
	private String lastMdfrNm;	// 최종 수정자명
	private Date lastMdfcnDttm;	// 최종 수정 일자
	
	/* 배치 프로그램 정보 */
	private String batPrmNm;	// 배치 프로그램명
}
