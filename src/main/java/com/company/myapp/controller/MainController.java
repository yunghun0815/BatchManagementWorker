package com.company.myapp.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.company.myapp.batch.code.BatchStatusCode;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.service.ILogService;

@Controller
public class MainController {
	
	@Autowired
	ILogService logService;
	
	@GetMapping("/")
	public String main(Model model) {
		model.addAttribute("menu", "home");
		return "main";
	}
	
	@GetMapping("/download/excel")
	public void downloadExcel(@RequestParam(value = "date") String date, HttpServletResponse response) throws Exception{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Workbook workbook = new SXSSFWorkbook();
		
		CellStyle style = workbook.createCellStyle();
		
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		List<BatGrpLog> batGrpLogList = logService.getBatGrpLogListByDate(date); // 특정 일자에 해당하는 그룹 로그 전체 조회
		
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setBorderTop(BorderStyle.THIN);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		Font headerFont = workbook.createFont();
		headerFont.setBold(true);
		headerStyle.setFont(headerFont);
		 
		// 메인 시트
		Sheet mainSheet = workbook.createSheet("전체그룹");
		mainSheet.setColumnWidth(0, 15*256);
		mainSheet.setColumnWidth(1, 15*256);
		mainSheet.setColumnWidth(2, 24*256);
		mainSheet.setColumnWidth(5, 24*256);
		mainSheet.setColumnWidth(6, 24*256);
		int rowNo = 0;
		
		
		// 메인 시트 헤더
		Row mainHeader = mainSheet.createRow(rowNo);
		mainHeader.createCell(0).setCellValue("로그ID");
		mainHeader.createCell(1).setCellValue("그룹ID");
		mainHeader.createCell(2).setCellValue("그룹명");
		mainHeader.createCell(3).setCellValue("실행차수");
		mainHeader.createCell(4).setCellValue("결과");
		mainHeader.createCell(5).setCellValue("배치시작시간");
		mainHeader.createCell(6).setCellValue("배치종료시간");
		
		for(int i=0; i<7; i++) {
			mainHeader.getCell(i).setCellStyle(headerStyle);
		}
		rowNo++;
		
		Set<String> batGrpIdSet = new HashSet<>();
		
		for(BatGrpLog batGrpLog : batGrpLogList) {
			batGrpIdSet.add(batGrpLog.getBatGrpId()); // 그룹 아이디 중복 제거
			
			Row mainRow = mainSheet.createRow(rowNo);
			mainRow.createCell(0).setCellValue(batGrpLog.getBatGrpLogId());
			mainRow.createCell(1).setCellValue(batGrpLog.getBatGrpId());
			mainRow.createCell(2).setCellValue(batGrpLog.getBatGrpNm());
			mainRow.createCell(3).setCellValue(batGrpLog.getBatGrpRtyCnt()+1);
			mainRow.createCell(4).setCellValue(BatchStatusCode.codeToTitle(batGrpLog.getBatGrpStCd()));
			mainRow.createCell(5).setCellValue(sdf.format(batGrpLog.getBatBgngDt()));
			mainRow.createCell(6).setCellValue(sdf.format(batGrpLog.getBatEndDt()));
			
			for(int i=0; i<7; i++) {
				mainRow.getCell(i).setCellStyle(style);
			}
			rowNo++;
		} 
		rowNo = 0;
		for(String batGrpId : batGrpIdSet) {
			List<BatPrmLog> batPrmLogList = logService.getBatPrmLogListByGrpIdAndDate(batGrpId, date); // 그룹아이디 + 특정 일자 해당하는 프로그램 로그 전체 조회 -- 프로그램명도
			//시트 생성
			Sheet sheet = workbook.createSheet(batGrpId);
			sheet.setColumnWidth(0, 15*256);
			sheet.setColumnWidth(2, 15*256);
			sheet.setColumnWidth(3, 24*256);
			sheet.setColumnWidth(4, 15*256);
			sheet.setColumnWidth(6, 24*256);
			sheet.setColumnWidth(7, 24*256);
			
			Row header = sheet.createRow(rowNo);
			header.createCell(0).setCellValue("로그ID");
			header.createCell(1).setCellValue("실행차수");
			header.createCell(2).setCellValue("프로그램ID");
			header.createCell(3).setCellValue("프로그램명");
			header.createCell(4).setCellValue("파라미터");
			header.createCell(5).setCellValue("결과");
			header.createCell(6).setCellValue("배치시작시간");
			header.createCell(7).setCellValue("배치종료시간");
			
			for(int i=0; i<8; i++) {
				header.getCell(i).setCellStyle(headerStyle);
			}
			rowNo++;
			
			for(BatPrmLog batPrmLog : batPrmLogList) {
				Row row = sheet.createRow(rowNo);
				row.createCell(0).setCellValue(batPrmLog.getBatGrpLogId());
				row.createCell(1).setCellValue(batPrmLog.getBatGrpRtyCnt()+1);
				row.createCell(2).setCellValue(batPrmLog.getBatPrmId());
				row.createCell(3).setCellValue(batPrmLog.getBatPrmNm());
				row.createCell(4).setCellValue(batPrmLog.getParam());
				row.createCell(5).setCellValue(BatchStatusCode.codeToTitle(batPrmLog.getBatPrmStCd()));
				row.createCell(6).setCellValue(sdf.format(batPrmLog.getBatBgngDt()));
				row.createCell(7).setCellValue(sdf.format(batPrmLog.getBatEndDt()));
				
				for(int i=0; i<8; i++) {
					row.getCell(i).setCellStyle(style);
				}
				rowNo++;
			}
			rowNo = 0;
		}
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=log-" + date + ".xls");
		workbook.write(response.getOutputStream());
		workbook.close();
		
	}
}