package com.company.myapp.dto;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * 배치 그룹 로그 Dto
 * @author 정영훈
 *
 */
@Setter
@Getter
public class BatGrpLog {
	private String batGrpLogId;	// 배치 그룹 로그 아이디
	private int batGrpRtyCnt;	// 배치 재실행 차수
	private String batGrpId;	// 배치 그룹 아이디
	private String batGrpStCd;	// 배치 결과 상태 코드
	private Date batBgngDt;		// 배치 시작 일자
	private Date batEndDt;		// 배치 종료 일자
	private String lastMdfrNm;	// 최종 수정자명
	private Date lastMdfcnDttm;	// 최종 수정 일자
	private String frstRegNm;	// 최초 등록자명
	private Date frstRegDttm; 	// 최초 등록 일자
	
	private List<BatPrmLog> prmLogList;	// 해당 그룹 로그를 참조하는 프로그램 로그 리스트
	
	// 시간 검색용 필드
	private String batBgngDtStart;
	private String batBgngDtEnd;
	private String batEndDtStart;
	private String batEndDtEnd;
}
