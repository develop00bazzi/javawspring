package com.spring.javawspring;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.GuestService;
import com.spring.javawspring.vo.GuestVO;

@Controller
@RequestMapping("/guest")

public class GuestController {
	
	@Autowired
	GuestService guestService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/guestList", method = RequestMethod.GET)
	public String guestListGet(
			Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize
			) {

		
		int totRecCnt=guestService.getGuestTotRecCnt();
		
		PageVO vo=pageProcess.pageNation(pag, pageSize, totRecCnt);
		
//		int totPage=(totRecCnt%pageSize)==0? totRecCnt/pageSize: (totRecCnt/pageSize)+1;
//		int startIndexNo=(pag-1)*pageSize;
//		int curScrStartNo=totRecCnt-startIndexNo;
//		
//		int blockSize=3;
//		int curBlock=(pag-1)/blockSize;
//		int lastBlock=(totPage-1)/blockSize;
		
		ArrayList<GuestVO> vos=guestService.getGuestList(vo.getStartIndexNo(),vo.getPageSize());
		
		model.addAttribute("pageVo", vo);
		model.addAttribute("vos", vos);
		
//		model.addAttribute("pageSize", pageSize);
//		model.addAttribute("pag", pag);
//		model.addAttribute("totPage", totPage);
//		model.addAttribute("curScrStartNo", curScrStartNo);
//		model.addAttribute("blockSize", blockSize);
//		model.addAttribute("curBlock", curBlock);
//		model.addAttribute("lastBlock", lastBlock);		
		
		return "guest/guestList";
	}
	
	@RequestMapping(value = "/guestInput", method = RequestMethod.GET)
	public String guestInputGet() {
		
		return "guest/guestInput";
	}
	
	@RequestMapping(value = "/guestInput", method = RequestMethod.POST)
	public String guestInputPost(GuestVO vo) {
		
		guestService.setGuestInput(vo);
		
		return "redirect:/msg/guestInputOk";
	}
	
	@RequestMapping(value = "/guestDelete", method = RequestMethod.GET)
	public String guestInputGet(int idx) {
		
		guestService.setGuestDelete(idx);
		return "redirect:/msg/guestDeleteOk";
	}
	
	@RequestMapping(value = "/guestUpdate", method = RequestMethod.GET)
	public String guestUpdateGet(Model model, int idx) {
		GuestVO vo=guestService.getGuestContent(idx);
		model.addAttribute("vo",vo);

		return "guest/guestUpdate";
	}
	
	@RequestMapping(value = "/guestUpdate", method = RequestMethod.POST)
	public String guestUpdatePost(GuestVO vo) {
		
		guestService.setGuestUpdateOk(vo);
		
		return "redirect:/msg/guestUpdateOk";
	}
	
}
