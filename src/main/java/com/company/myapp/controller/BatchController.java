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
	public String home() {
		return "main";
	}
	@GetMapping("/group")
	public String getBatGrpList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		//데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalGroupNum();
		Pager pager = new Pager(5, 5, totalRows, pageNo);
		
		//현재 페이지에 맞는 데이터 가져오기
		List<BatGrp> batGrpList = batchService.getBatGrpList(pager);
		
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", batGrpList);
		
		return "group/batchManagment";
	}
	
	/**
	 * 배치그룹 상세페이지 모달창 -> json으로 return(비동기)
	 * @param grpId 그룹아이디
	 * @param model
	 * @return
	 */
//	@ResponseBody
//	@GetMapping("/group/detail")
//	public BatGrp getBatGrpDetail(@RequestParam(value="grpId") String grpId, Model model) {
//		BatGrp batGrp = batchService.getBatGrpDetail(grpId);
//		
//		return batGrp;
//	}
	@GetMapping("/group/detail")
	public String getBatGrpDetail(@RequestParam(value="grpId") String grpId, Model model) {
		BatGrp batGrp = batchService.getBatGrpDetail(grpId);
		model.addAttribute("grp", batGrp);
		return "group/groupDetail";
	}
	
	
	@PostMapping("/group/insert")
	public String insertBatGrp(BatGrp vo) {
		System.out.println(vo);
		//vo.setCronDsc("");
		batchService.insertBatGrp(vo);
		return "redirect:/batch";
	}
	
	@PostMapping("/group/update")
	public void updateBatGrp(BatGrp vo) {
		batchService.updateBatGrp(vo);
	}
	
	@GetMapping("/group/delete")
	public String deleteBatGrp(String grpId) {
		batchService.deleteBatGrp(grpId);
		return "redirect:/batch/group";
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
	@GetMapping("/group/search")
	public String searchBatGrp(@RequestParam(defaultValue = "1") int pageNo, 
			                          @RequestParam(value="keyword") String keyword,
			                             @RequestParam List<String> filtering, Model model){
		
		//데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalSearchNum(keyword, filtering);
		Pager pager = new Pager(5, 5, totalRows, pageNo);

		List<BatGrp> searchResult = batchService.searchBatGrp(pager, keyword, filtering);	
		
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", searchResult);
		return "group/batchManagment";
	}

	
	@GetMapping("/searchPage")
	public String searchBatGrp(){
		
		return "group/search";
	}
}
