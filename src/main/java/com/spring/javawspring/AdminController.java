package com.spring.javawspring;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.LinkedTransferQueue;

import javax.management.MalformedObjectNameException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.AdminService;
import com.spring.javawspring.service.BoardService;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.MemberVO;

@Controller
@RequestMapping("/admin")

public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
//	관리자 메인 페이지 이동
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {	
		return "admin/adminMain";
	}
	
//	관리자 메인 페이지 메뉴 컨트롤러 등록
	
	@RequestMapping(value = "/adminLeft", method = RequestMethod.GET)
	public String adminLeftGet() {	
		return "admin/adminLeft";
	}
	
//	관리자 메인 페이지 이동
	
	@RequestMapping(value = "/adminContent", method = RequestMethod.GET)
	public String adminContentGet() {	
		return "admin/adminContent";
	}
	
//	회원 관리 페이지 이동
	
	@RequestMapping(value = "/member/adminMemberList", method = RequestMethod.GET)
	public String adminMemberListGet(Model model,
			@RequestParam(name="search", defaultValue="", required = false) String search,
			@RequestParam(name="searchString", defaultValue="", required = false) String searchString,
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required = false) int pageSize) {
		
		int totRecCnt=memberService.getMemberTotRecCnt2(search, searchString);
		
		PageVO pageVO=pageProcess.pageNation(pag, pageSize, totRecCnt);
		
		ArrayList<MemberVO> vos=memberService.getMemberList2(pageVO.getStartIndexNo(),pageVO.getPageSize(), search, searchString);
		
		model.addAttribute("pageVo", pageVO);
		model.addAttribute("vos", vos);
		
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);

		return "admin/member/adminMemberList";
	}
	
//	회원 등급 변경 처리
	
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberLevel", method = RequestMethod.POST)
	public String adminMemberLevelPost(int idx, int level) {
		
		int res=adminService.setMemberLevelCheck(idx, level);
		
		return res+"";
	}
	
//	회원 탈퇴 처리
	
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberDeleteOk", method = RequestMethod.POST)
	public String adminMemberDeleteOkPost(int idx) {
		int res=adminService.setAdminMemberDeleteOk(idx);
		
		return res+"";
	}
	
//	파일 리스트 조회 (ckeditor 폴더 파일 리스트)
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/file/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		
		String realPath=request.getRealPath("/resources/data/ckeditor/");
		
		String[] files=new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/file/fileList";
	}
	
//	관리자 메뉴 선택 파일 삭제
	
	@ResponseBody
	@RequestMapping(value = "/file/fileSelectDelete", method = RequestMethod.POST)
	public String fileSelectDeletePost(HttpServletRequest request, String deletePhotos) {
		String realPath=request.getRealPath("/resources/data/ckeditor/");
		String[] deletePhoto=deletePhotos.split("/");
		
		int res=0;
		
		for(int i=0; i<deletePhoto.length; i++) {
			File deleteFile=new File(realPath+deletePhoto[i]);
			if(deleteFile.exists()) deleteFile.delete();
		}
		
		res=1;
		
		return res+"";
	}
	
//	관리자 일주일 이내 작성한 글 조회
	
	@RequestMapping(value = "/board/newBoardList", method = RequestMethod.GET)
	public String adminNewBoardList(Model model) {
		
		ArrayList<BoardVO> vos=boardService.getNewBoardList();
		
		model.addAttribute("vos",vos);
		
		return "admin/board/newBoardList";
	}
	
//	관리자 게시판 관리 리스트 조회
	
	@RequestMapping(value = "/board/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name = "pag", defaultValue = "1") int pag,
			@RequestParam(name = "pageSize", defaultValue = "5") int pageSize,
			@RequestParam(name = "search", defaultValue = "") String search,
			@RequestParam(name = "searchString", defaultValue = "") String searchString
			) {
		
		int totRecCnt=boardService.getSearchTotRecCnt(search, searchString);
		
		PageVO pageVO=pageProcess.pageNation(pag, pageSize, totRecCnt);
		
		List<BoardVO> vos=boardService.getBoardList(pageVO.getStartIndexNo(), pageVO.getPageSize(),search,searchString);
		
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVO);
		
		return "admin/board/adminBoardList";
	}
	
//	관리자 메뉴 게시판 선택 게시글 삭제
	
	@ResponseBody
	@RequestMapping(value = "/board/boardSelectDelete", method = RequestMethod.POST)
	public String fileSelectDeletePost(String deleteBoards) {
		String[] deleteBoard=deleteBoards.split("/");
		
		int res=0;
		
		for(int i=0; i<deleteBoard.length; i++) {
			boardService.setBoardDeleteOk(Integer.parseInt(deleteBoard[i]));
		}
		
		res=1;
		
		return res+"";
	}
	
	
}
