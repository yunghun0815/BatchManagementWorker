package com.company.myapp.dto;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * 배치 그룹 로그 DTO
 * @author 정영훈
 *
 */
@Setter
@Getter
public class BatGrpLog {
	private String batGrpLogId;
	private int batGrpRtyCnt;
	private String batGrpId;
	private String batGrpStCd;
	private Date batBgngDt;
	private Date batEndDt;
	private String lastMdfrNm;
	private Date lastMdfcnDttm;
	
	private List<BatPrmLog> prmLogList;
}
