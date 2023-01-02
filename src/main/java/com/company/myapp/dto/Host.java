package com.company.myapp.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 호스트 테이블 DTO
 * @author 정영훈
 * 
 */
@Getter
@Setter
public class Host {
	private String hostId;			// PK -> HOST + 8자리 숫자
	private String hostIp;			// 호스트 아이피
	private String hostPt;			// 호스트 포트
	private String hostNm;			// 호스트명
	private String useYn;			// 사용유무
	private String lastMdfrNm;		// 최종 수정자명
	private Date lastMdfcnDttm;		// 최종 수정 일자
}
