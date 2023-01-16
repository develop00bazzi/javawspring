package com.spring.javawspring;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javawspring.common.SecurityUtil;
import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.PdsService;
import com.spring.javawspring.vo.PdsVO;

@Controller
@RequestMapping("/pds")

public class PdsController {
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	PageProcess pageProcess;
	
//	자료실 리스트 이동
	
	@RequestMapping(value = "/pdsList", method = RequestMethod.GET)
	public String pdsListGet(Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name = "search", defaultValue = "", required = false) String search,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part
			) {	
		
		int totRecCnt=pdsService.getSearchTotRecCnt(part, search, searchString);
		
		PageVO pageVO=pageProcess.pageNation(pag, pageSize, totRecCnt);
		
		ArrayList<PdsVO> vos=pdsService.getPdsList(pageVO.getStartIndexNo(), pageVO.getPageSize(), part, search, searchString);
		
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVO);
		
		return "pds/pdsList";
	}
	
//	자료실 글쓰기 페이지 이동
	
	@RequestMapping(value = "/pdsInput", method = RequestMethod.GET)
	public String pdsInputGet() {
		return "pds/pdsInput";
	}
	
//	자료실 글쓰기 처리
	
//	multifile 자료 처리시에는 MultipartHttpServletRequest 객체 사용
	
	@RequestMapping(value = "/pdsInput", method = RequestMethod.POST)
	public String pdsInputPost(PdsVO vo, MultipartHttpServletRequest file) {
		
		String pwd=vo.getPwd();
		
		pwd=SecurityUtil.encryptSHA256(pwd);
		
		vo.setPwd(pwd);
		
//		멀티 파일을 서버에 저장시키고 정보를 DB에 저장
		
		pdsService.setPdsInput(file, vo);
		
		return "redirect:/msg/pdsInputOk";
	}
	
//	자료실 파일 다운로드 횟수 증가 처리
	
	@ResponseBody
	@RequestMapping(value = "/pdsDownNum", method = RequestMethod.POST)
	public String pdsDownNumPost(int idx) {
		
		pdsService.setPdsDownNum(idx);
		
		return "";
	}
	
}
