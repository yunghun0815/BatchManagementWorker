package com.company.myapp.dto;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
	private String batPrmId;	// 배치 프로그램 아이디
	
	@NotBlank(message = "프로그램명을 입력해주세요.")
	@Size(min = 1, max = 50, message = "프로그램명은 50자를 넘을 수 없습니다.")
	private String batPrmNm;	// 배치 프로그램명
	
	@NotBlank
	private String batGrpId;	// 배치 그룹 아이디
	
	@NotBlank(message = "경로를 입력해주세요.")
	private String path;		// 배치 파일 경로
	
	private int excnOrd;		// 실행 순서
	
	@Size(min = 0, max = 100, message = "파라미터값은 100자를 넘을 수 없습니다.")
	private String param;		// 파라미터
	@Size(min = 0, max = 2000, message = "설명은 2000자를 넘을 수 없습니다.")
	private String paramDsc;	// 파라미터 설명
	
	private char useYn;			// 사용 유무
	private String lastMdfrNm;	// 최종 수정자명
	private Date lastMdfcnDttm;	// 최종 수정 일자
}
