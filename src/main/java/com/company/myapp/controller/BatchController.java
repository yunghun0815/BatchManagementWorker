package com.company.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IBatchService;

@RequestMapping("/batch")
@Controller
public class BatchController {

	@Autowired
	IBatchService batchService;
	
	/**
	 * 처음에 배치관리 메뉴로 들어갔을때
	 * @param pageNo 페이지 수
	 *
	 * @return 배치관리페이지
	 */
	
//	@PostMapping("/test")
//	public String test(@RequestParam String cycle, @RequestParam String cycle1, @RequestParam String cycleMF, @RequestParam String cycleDay,
//			             @RequestParam String cycleTime, Model model) {
//		model.addAttribute("cycle", cycle);
//		model.addAttribute("cycle1", cycle1);
//		model.addAttribute("cycleMF", cycleMF);
//		model.addAttribute("cycleDay", cycleDay);
//		model.addAttribute("cycleTime", cycleTime);
//		return "main2";
//	}
	@GetMapping("")
	public String getBatchGroupList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		//데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalGroupNum();
		Pager pager = new Pager(5, 5, totalRows, pageNo);
		
		//현재 페이지에 맞는 데이터 가져오기
		List<BatGrp> batGrpList = batchService.getBatchGroupList(pager);
		
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", batGrpList);
		
		return "batchManagment";
	}
	
	/**
	 * 배치그룹 상세페이지 모달창 -> json으로 return(비동기)
	 * @param grpId 그룹아이디
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping("/detail")
	public BatGrp getBatchGroupDetail(@RequestParam(value="grpId") String grpId, Model model) {
		BatGrp batGrp = batchService.getBatchGroupDetail(grpId);
		
		return batGrp;
	}
	
	@PostMapping("/insert")
	public void insertBatchGroup(BatGrp vo) {
		batchService.insertBatchGroup(vo);
	}
	
	@PostMapping("/update")
	public void updateBatchGroup(BatGrp vo) {
		batchService.updateBatchGroup(vo);
	}
	
	@PostMapping("/delete")
	public void deleteBatchGroup(String grpId) {
		batchService.deleteBatchGroup(grpId);
	}
	
	/**
	 * 배치그룹별 스케쥴러 실행 체크후 실행 및 중단
	 * @param grpId
	 */
	@PostMapping("/Job/{grpId}")
	public void schedule(String grpId) {
		boolean check = batchService.checkJob(grpId);
		if (check == true) batchService.startJob(grpId);
		else batchService.stopJob(grpId);
	}
	
	/**
	 * 검색 결과 return하는 메서드. 뷰->체크박스로 값 전달, mybatis->foreach,choose사용해서 필터링 
	 * @param keyword 검색값
	 * @param checkBox 검색할 컬럼
	 * @return
	 */
	@ResponseBody
	@PostMapping("/search")
	public List<BatGrp> searchBatGrp(@RequestParam(value="keyword") String keyword,
			                             @RequestParam List<String> checkBox){
		List<BatGrp> searchResult = new ArrayList<BatGrp>();
		if(checkBox.get(0).equals("all")) {
			searchResult = batchService.searchBatGrp(keyword);
		}else {
			searchResult = batchService.searchBatGrp(keyword, checkBox);	
		}
		
		return searchResult;
	}
	
}
