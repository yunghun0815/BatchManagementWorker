package com.company.myapp.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 배치그룹 테이블 Dto
 * @author 김나영
 *
 */
@Getter
@Setter
@NoArgsConstructor
public class BatGrp {
	private String batGrpId;
	private String batGrpNm;
	private String batGrpDsc;
	private String hostId;
	private char autoExcnYn;
	private String cron;
	private char useYn;
	private String lastMdfrNm;
	private Date lastMdfcnDttm;

}
