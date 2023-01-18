package com.company.myapp.dto;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 배치그룹 테이블 Dto
 * @author 김나영
 *
 */
@ToString
@Getter
@Setter
@NoArgsConstructor
public class BatGrp {
	private String batGrpId;	// 배치 그룹 아이디
	private String batGrpNm;	// 배치 그룹명
	private String batGrpDsc;	// 배치 그룹 설명
	private String hostId;		// 호스트 아이디
	private String autoExcnYn;	// 자동 실행 유무
	private String cron;		// 크론 표현식
	private String useYn;			// 사용 유무
	private String lastMdfrNm;	// 최종 수정자명
	private Date lastMdfcnDttm;	// 최종 수정 일자
	private String cronDsc;		// 크론 설명		
	
	/* 호스트 테이블 정보 */
	private String hostNm;	// 호스트명
	private String hostIp;	// 호스트 아이피
	private String hostPt;	// 호스트 포트
	
	private String conn; // Agent 연결 상태 on/off
	
	private List<BatPrm> prmList;	// 그룹에 등록된 배치 프로그램 리스트
	private boolean runCheck;		// JOB 등록 여부 체크
}
