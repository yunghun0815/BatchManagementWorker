package com.company.myapp.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 배치 프로그램 로그 DTO
 * @author 정영훈
 *
 */
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
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
