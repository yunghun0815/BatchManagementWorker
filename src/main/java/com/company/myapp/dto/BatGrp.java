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
	private String batGrpId;
	private String batGrpNm;
	private String batGrpDsc;
	private String hostId;
	private char autoExcnYn;
	private String cron;
	private char useYn;
	private String lastMdfrNm;
	private Date lastMdfcnDttm;
	
	private String hostNm;
	private String hostIp;
	private String hostPt;
	private String conn; // Agent 연결 상태 on/off
	
	private String cronDsc;
	
	private List<BatPrm> prmList;
	private boolean runCheck;

}
