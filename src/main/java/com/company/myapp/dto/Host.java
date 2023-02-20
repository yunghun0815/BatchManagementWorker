package com.company.myapp.dto;

import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;

/**
 * 호스트 테이블 Dto
 * @author 정영훈
 * 
 */
@Getter
@Setter
public class Host {
   private String hostId; // 호스트 아이디	
   
   @Pattern(regexp = "^(([1-9]?\\d|1\\d{2}|2([0-4]\\d)|25[0-5])\\.){3}([1-9]?\\d|1\\d{2}|2([0-4]\\d)|25[0-5])$", message = "아이피 형식을 확인해주세요.")
   private String hostIp;	// 호스트 아이피	
   
   @NotNull(message = "포트 번호를 입력해주세요.")
   @Max(value = 65535, message = "포트번호를 확인해주세요.")
   @Min(value = 0, message = "포트번호를 확인해주세요.")
   private int hostPt;	// 호스트 포트		
   
   @Pattern(regexp = "^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9| ]{1,50}$", message = "50자 이하의 한글, 영어, 숫자만 사용 가능합니다.")
   private String hostNm;	// 호스트명         
   
   private String useYn; // 사용유무         
   
   private String lastMdfrNm;	// 최종 수정자명	      
   
   private Date lastMdfcnDttm; // 최종 수정 일자    
   
   private String frstRegNm;	// 최초 등록자명
	
   private Date frstRegDttm; 	// 최초 등록 일자
	
	//검색용 필드
   private String searchPt;
}