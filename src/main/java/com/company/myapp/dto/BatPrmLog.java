package com.company.myapp.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 배치 프로그램 로그 DTO
 * @author 정영훈
 *
 */
@Setter
@Getter
public class BatPrmLog {
	private String batGrpLogId;
	private int batGrpRtyCnt;
	private String batPrmId;
	private String param;
	private String batPrmStCd;
	private String rsltMsg;
	private Date batBgngDt;
	private Date batEndDt;
	private int excnOrd;
	private String lastMdfrNm;
	private Date lastMdfcnDttm;
}
