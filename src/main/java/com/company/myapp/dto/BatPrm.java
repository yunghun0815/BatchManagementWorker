package com.company.myapp.dto;

import java.sql.Date;

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
	private String batPrmId;
	private String batPrmNm;
	private String batGrpId;
	private String path;
	private int excnOrd;
	private String param;
	private String paramDsc;
	private char useYn;
	private String lastMdfrNm;
	private Date lastMdfcnDttm;
}
