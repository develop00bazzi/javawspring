package com.spring.javawspring;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.BoardService;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.vo.BoardReplyVO;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.GoodVO;
import com.spring.javawspring.vo.MemberVO;

@Controller
@RequestMapping("/board")

public class BoardController {
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
//	게시판 리스트 페이지 이동
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
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
		
		return "board/boardList";
	}
	
//	게시판 글쓰기 페이지 이동
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet(HttpSession session, Model model,int pag, int pageSize) {
		
		String mid=(String)session.getAttribute("sMid");
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		model.addAttribute("email", vo.getEmail());
		model.addAttribute("homePage", vo.getHomePage());
		
		return "board/boardInput";
	}
	
//	게시판 글쓰기 처리
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		
//		vo.setContent(vo.getContent().replaceAll(vo.getContent().substring(vo.getContent().indexOf("), 0), null));
		
//		content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/ 폴더에 저장시켜준다.
		
		boardService.imgCheck(vo.getContent());
		
//		이미지 복사 작업이 끝나면, board 폴더에 실제로 저장된 파일명을 DB에 저장 처리 ( /resources/data/ckeditor/ ==> /resources/data/board/ )
		
		vo.setContent(vo.getContent().replaceAll("/data/ckeditor/", "/data/ckeditor/board/"));
		
		int res=boardService.setBoardInput(vo);
		
		if(res==1) return "redirect:/msg/boardInputOk";
		else return "redirect:/msg/boardInputNo";
		
	}
	
//	게시판 게시글 조회
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(Model model,HttpSession session, int idx, int pag, int pageSize) {
		
// 		글 조회수 1회 증가시키기.(조회수 중복방지처리 - 세션 사용 : 'board+고유번호'를 객체배열에 추가시킨다.)
		
		@SuppressWarnings("unchecked")
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			boardService.setReadNumPlus(idx);
			contentIdx.add(imsiContentIdx);
		}
		
// 		해당글에 좋아요 버튼을 클릭하였었다면 '좋아요세션'에 아이디를 저장시켜두었기에 찾아서 있다면 sSw값을 1로 보내어 하트색을 빨강색으로 변경유지하게한다.
		
		@SuppressWarnings("unchecked")
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("sGoodIdx");
		if(goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "boardGood" + idx;
		if(goodIdx.contains(imsiGoodIdx)) {
			session.setAttribute("sSw", "1");		// 로그인 사용자가 이미 좋아요를 클릭한 게시글이라면 빨강색으로 표시가히위해 sSW에 1을 전송하고 있다.
		}
		else {
			session.setAttribute("sSw", "0");
		}
		
		session.setAttribute("sContentIdx", contentIdx);
		
		BoardVO vo= boardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
//		접속시에 해당 접속자의 좋아요 정보 생성
		
//		boardService.setBoardGoodInfor(idx, "board", mid);
		
//		게시글 조회 시 좋아요를 눌렀는지 안 눌렀는지 확인 (DB: good)

		String mid=(String)session.getAttribute("sMid");
		
		GoodVO goodVO=boardService.getBoardGoodCheck(idx,"board",mid);
		
		model.addAttribute("goodVO",goodVO);
		
//		이전글 / 다음글 가져오기
		
		ArrayList<BoardVO> pnVOS =boardService.getPrevNext(idx);
		
//		System.out.println("pnVOS: "+pnVOS);
		
		model.addAttribute("pnVOS", pnVOS);
		
//		게시글의 댓글 가져오기
		
		List<BoardReplyVO> replyVOS=boardService.getBoardReply(idx);
		
		model.addAttribute("replyVOS", replyVOS);
		
		return "board/boardContent";
		
	}
	
//	DB 좋아요 처리
	
	@ResponseBody
	@RequestMapping(value = "/dbLike", method = RequestMethod.POST)
	public String dbLikePost(int idx, String mid, String part) {
		String res="";
		
		GoodVO goodVO=boardService.getBoardGoodCheck(idx, part, mid);
		
		if(goodVO==null) {
			boardService.setDbLike(idx, mid, part);
			boardService.setClickLike(idx);
		}
		else {
			boardService.setDbLikeDelete(idx, mid, part);
			boardService.setUnClickLike(idx);
		}
		
		return res;
	}
	
//	좋아요 처리
	
	@ResponseBody
	@RequestMapping(value = "/clickLike", method = RequestMethod.POST)
	public String clickLike(int idx, HttpSession session) {
		
		// 좋아요수 증가처리
		
		int res = 0; // 기본은 0으로 설정

		@SuppressWarnings({ "unchecked", "rawtypes" })
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("sGoodIdx");
		if(goodIdx == null) {
			goodIdx = new ArrayList<String>();
			
		}
		String imsiGoodIdx = "boardGood" + idx;
		if(!goodIdx.contains(imsiGoodIdx)) {
			boardService.setClickLike(idx);
			goodIdx.add(imsiGoodIdx);
			res = 1;	// 처음으로 좋아요 버튼을 클릭하였기에 '1'을 반환
		}
		session.setAttribute("sGoodIdx", goodIdx);
		
		return res+"";
	}
	
//	게시글 삭제 처리
	
	@RequestMapping(value = "/boardDeleteOk", method = RequestMethod.GET)
	public String boardDeleteOkGet(int idx, int pag, int pageSize, Model model) {
		
//		게시글에 사진이 존재한다면 서버에 있는 사진 파일을 먼저 삭제
		
		BoardVO vo=boardService.getBoardContent(idx);
		
		if(vo.getContent().indexOf("src=\"/")!=-1) boardService.imgDelete(vo.getContent());
		
//		DB에서 실제로 존재하는 게시글을 삭제 처리한다.
		
		boardService.setBoardDeleteOk(idx);
		
		model.addAttribute("flag","?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/boardDeleteOk";
	}
	
//	게시글 수정 폼 이동
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(Model model, int idx, int pag, int pageSize) {
		
//		수정 창으로 이동시에 먼저 원본 파일에 그림 파일이 있다면, 현재 폴더의 그림 파일을 ckeditor로 옮겨놓기
		
		BoardVO vo=boardService.getBoardContent(idx);
		
		if(vo.getContent().indexOf("src=\"/")!=-1) boardService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		
		return "board/boardUpdate";
	}
	
//	게시글 수정 처리 그림 포함
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(Model model, BoardVO vo, int pag, int pageSize) {
		
//		수정된 자료가 원본 자료와 완전히 동일하다면 수정할 필요가 없기에, DB에 저장된 원본 자료를 불러와서 저장처리한다.
		
		BoardVO originalVO=boardService.getBoardContent(vo.getIdx());
		
//		content의 내용이 조금이라도 변경된 것이 있다면 아래 내용을 수행 처리 시킨다.
		
		if(!originalVO.getContent().equals(vo.getContent())) {
			
//			실제로 수정하기 버튼을 클릭하게 되면 기존의 board 폴더에 저장된 현재 content의 그림 파일 모두를 삭제 처리
			
			if(originalVO.getContent().indexOf("src=\"/")!=-1) boardService.imgDelete(originalVO.getContent());
			
//			vo.getContent()에 들어있는 파일의 경로는 'ckeditor/board' 경로를 'ckeditor'로 바꿔야 한다.
			
			vo.setContent(vo.getContent().replace("/data/ckeditor/board/", "/data/ckeditor/"));
			
//			앞의 모든 준비가 끝나면, 파일을 처음 업로드한 것과 같은 작업을 처리한다.
			
//			이 작업은 처음 게시글을 올릴 때의 파일 복사 작업과 동일한 작업을 진행한다.
			
			boardService.imgCheck(vo.getContent());
			
//			파일 업로드가 끝나면 다시 경로를 수정한다. 'ckeditor' 경로를 'ckeditor/board'로 바꿔야 한다. 즉, 변경된 vo.getContent()를 vo.setContent() 처리
			
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		}
		
//		잘 정비된 VO를 DB에 업데이트시켜준다.
		
		boardService.setBoardUpdateOk(vo);
		
		model.addAttribute("flag","?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/boardUpdateOk";
		
	
	}
	
//	댓글 작성 처리
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		
		int res=0;
		
		int level=0;
		int levelOrder=0;
		
		String strLevelOrder=boardService.getMaxLevelOrder(replyVO.getBoardIdx());
		
		if(strLevelOrder!=null) levelOrder=Integer.parseInt(strLevelOrder)+1;
		
		System.out.println(levelOrder);
		
		replyVO.setLevelOrder(levelOrder);
		
		/*--- 다녀 갔다옴  by 괴도 kid ---*/
		
//		replyVO.setLevel(level);
//		replyVO.setLevelOrder(levelOrder);
		
		res=boardService.setBoardReplyInput(replyVO);
		
		return res+"";
	}
	
//	대댓글 작성 처리
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput2", method = RequestMethod.POST)
	public String boardReplyInput2Post(BoardReplyVO replyVO) {
		
//		System.out.println("replyVO: "+replyVO);
		
//		먼저 부모글의 levelOrder보다 큰 levelOrder들을 다 +1 작업한다.
		
		System.out.println(replyVO.getIdx());
		
		boardService.setLevelOrderPlusUpdate(replyVO);
		
		replyVO.setLevel(replyVO.getLevel()+1);
		replyVO.setLevelOrder(replyVO.getLevelOrder()+1);
		
		boardService.setBoardReplyInput2(replyVO);
		
	
		
		return "";
	}
	
//	댓글 삭제 처리
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyDeleteOk", method = RequestMethod.POST)
	
	public String boardReplyDeleteOkPost(int idx) {
		int res=0;
		
		res=boardService.setBoardReplyDeleteOk(idx);
		
		return res+"";
	}
	
//	댓글 수정 처리
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyUpdate", method = RequestMethod.POST)
	public String boardReplyUpdatePost(BoardReplyVO vo) {
		
		boardService.setBoardReplyUpdate(vo);
		
		return "";
	}
	
}
