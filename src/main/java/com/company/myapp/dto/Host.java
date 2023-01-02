package com.company.myapp.dto;

import java.sql.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

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
   private String hostId;         // PK -> HOST + 8자리 숫자
   
   @NotBlank(message = "아이피를 입력해주세요.")
   private String hostIp;         // 호스트 아이피
   
   @NotNull(message = "포트 번호를 입력해주세요.")
   @Max(value = 65535, message = "포트번호를 확인해주세요.")
   @Min(value = 0, message = "포트번호를 확인해주세요.")
   private int hostPt;         // 호스트 포트
   
   @NotBlank(message = "호스트명을 입력해주세요.")   
   private String hostNm;         // 호스트명
   
   private char useYn;         // 사용유무
   
   private String lastMdfrNm;      // 최종 수정자명
   
   private Date lastMdfcnDttm;      // 최종 수정 일자
}