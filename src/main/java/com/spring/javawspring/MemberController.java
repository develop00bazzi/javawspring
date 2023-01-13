package com.spring.javawspring;

import java.util.ArrayList;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.vo.MemberVO;

@Controller
@RequestMapping("/member")

public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
//	로그인 페이지 이동
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {	
		
//		로그인 폼 호출시 저장된 쿠키가 있다면 해당 mid 쿠키 가져가기
		
		Cookie[] cookies = request.getCookies();
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				request.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
		
		return "member/memberLogin";
	}
	
//	회원 로그인 처리
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session, 
		@RequestParam(name = "mid", defaultValue = "", required = false) String mid, 
		@RequestParam(name = "pwd", defaultValue = "", required = false) String pwd, 
		@RequestParam(name = "idCheck", defaultValue = "", required = false) String idCheck 
		
		) {
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		if(vo!=null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("no")) {
			
//			회원 인증 처리된 경우 처리 내용 / strLevel 처리, session에 필요한 자료들 저장, 쿠키 값 처리, 방문자수 증가, 방문 포인트 증가.. 등등
			
			String strLevel="";
			
			if(vo.getLevel()==0) strLevel="관리자";
			else if (vo.getLevel()==1) strLevel="운영자";
			else if (vo.getLevel()==2) strLevel="우수회원";
			else if (vo.getLevel()==3) strLevel="정회원";
			else if (vo.getLevel()==4) strLevel="준회원";
			
			session.setAttribute("sStrLevel", strLevel);
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());

//			if(idCheck.equals("on")) {
//				Cookie cookie=new Cookie("cMid", mid);
//				cookie.setMaxAge(60*60&24*7);
//				response.addCookie(cookie);
//			}
//			else {
//				Cookie[] cookies=request.getCookies();
//				for(int i=0; i<cookies.length; i++) {
//					if(cookies[i].getName().equals("cMid")) {
//						cookies[i].setMaxAge(60*60&24*7);
//						response.addCookie(cookies[i]);
//						break;
//					}
//				}
//			}
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
//			로그인한 사용자의 방문 횟수 증가 처리 및 방문 포인트 증가 처리
			
			memberService.setMemberVisitProcess(vo);
			
			return "redirect:/msg/memberLoginOk?mid="+mid;
		}
		
		else {
			return "redirect:/msg/memberLoginNo";			
		}
	}
	
//	회원 메인 페이지 이동
	
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet(HttpSession session, Model model) {		
		
		String mid=(String)session.getAttribute("sMid");
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo",vo);
		
		return "member/memberMain";
	}
	
	/*
	 * @RequestMapping(value = "/adminLogout", method = RequestMethod.GET) public
	 * String adminLogoutGet(HttpSession session) {
	 * 
	 * String mid=(String)session.getAttribute("sAMid"); session.invalidate();
	 * 
	 * return "redirect:/msg/memberLogout?mid="+mid; }
	 */
	
//	로그아웃
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		
		String mid=(String)session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/msg/memberLogout?mid="+mid;
	}
	
//	회원 가입 폼 
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
//	회원 가입 처리
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MultipartFile fName,MemberVO vo) {
		
//		System.out.println("memberVO: "+vo+"  !");
		
//		아이디 체크
		
		if(memberService.getMemberIdCheck(vo.getMid())!=null) {
			return "redirect:/msg/memberIdCheckNo";
		}
		
//		닉네임 체크
		
		if(memberService.getMemberNickNameCheck(vo.getNickName())!=null) {
			return "redirect:/msg/memberNickNameCheckNo";
		}
		
//		비밀번호 암호화(BCryptPasswordEncoder)
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
//		체크가 완료되면 vo에 담긴 자료를 DB에 저장처리 (회원 가입)
//		사진 파일도 서버에 업로드 처리
//		서비스 객체에서 수행 처리
		
		int res=memberService.setMemberJoinOk(fName, vo);
		
		if(res==1) return "redirect:/msg/memberJoinOk";
		
		else return "redirect:/msg/memberJoinNo";
	}
	
//	회원 정보 수정 폼 이동
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(HttpSession session, Model model) {
		
		String mid=(String)session.getAttribute("sMid");
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		
		// JSP Form에 출력을 위한 분리작업 처리
		// email분리(@)
		String[] email = vo.getEmail().split("@");
		model.addAttribute("email1", email[0]);
		model.addAttribute("email2", email[1]);
		
		// 전화번호 분리(-)
		String[] tel = vo.getTel().split("-");
		if(tel[1].equals(" ")) tel[1] = "";
		if(tel[2].equals(" ")) tel[2] = "";
		model.addAttribute("tel1", tel[0]);
		model.addAttribute("tel2", tel[1]);
		model.addAttribute("tel3", tel[2]);
		
		// 주소분리("/")
		String[] address = vo.getAddress().split("/");
		if(address[0].equals(" ")) address[0] = "";
		if(address[1].equals(" ")) address[1] = "";
		if(address[2].equals(" ")) address[2] = "";
		if(address[3].equals(" ")) address[3] = "";
		model.addAttribute("postcode", address[0]);
		model.addAttribute("roadAddress", address[1]);
		model.addAttribute("detailAddress", address[2]);
		model.addAttribute("extraAddress", address[3]);
		
		// 취미는 통째로 넘긴다.
		model.addAttribute("hobby", vo.getHobby());
		
		// 생일(년-월-일) : 앞에서부터 10자리를 넘긴다.
		model.addAttribute("birthday", vo.getBirthday().subSequence(0, 10));
		
		
		model.addAttribute("vo", vo);
		return "member/memberUpdate";
	}
	
//	회원 정보 수정 처리
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(HttpSession session, MultipartFile fName, MemberVO vo, String oldFName) {
		
		String mid=(String)session.getAttribute("sMid");
		
		int res=memberService.setMemberUpdateOk(fName, vo, oldFName, mid);
		
//		System.out.println("oldFName: "+oldFName);
		
		if(res==1) return "redirect:/msg/memberUpdateOk";
		
		else return "redirect:/msg/memberUpdateNo";
	}
	
//	아이디 중복 체크
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method=RequestMethod.POST)
	public String memberIdCheckGet(String mid) {
		String res = "0";
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null) res = "1";
		
		return res;
	}
	
//	닉네임 중복 체크
	
	@ResponseBody
	@RequestMapping(value = "/memberNickNameCheck", method=RequestMethod.POST)
	public String memberNickNameCheckGet(String nickName) {
		String res = "0";
		MemberVO vo = memberService.getMemberNickNameCheck(nickName);
		
		if(vo != null) res = "1";
		
		return res;
	}
	
//	회원 리스트 조회 / 전체 리스트와 검색 리스트를 하나의 메소드로 처리 / 동적 쿼리 적용
	
//	선생님 방식 페이지네이션 적용
	
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model,
			@RequestParam(name="search", defaultValue="", required = false) String search,
			@RequestParam(name="searchString", defaultValue="", required = false) String searchString,
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required = false) int pageSize) {
		
//		PageVO pageVO=pageProcess.getTotRecCnt(pag, pageSize, "member", "", "");
		
		int totRecCnt=memberService.getMemberTotRecCnt2(search, searchString);
		
		PageVO pageVO=pageProcess.pageNation(pag, pageSize, totRecCnt);
		
		ArrayList<MemberVO> vos=memberService.getMemberList2(pageVO.getStartIndexNo(),pageVO.getPageSize(), search, searchString);
		
		model.addAttribute("pageVo", pageVO);
		model.addAttribute("vos", vos);
		
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);

		return "member/memberList";
	}
	
//	회원 리스트 검색
	
//	@RequestMapping(value = "/memberList", method = RequestMethod.POST)
//	public String memberListPost(Model model,
//			String search, String searchString,
//			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue="5", required = false) int pageSize) {
//		
//		int totRecCnt=memberService.getMemberSearchTotRecCnt(search, searchString);
//		
//		PageVO vo=PageProcess.pageNation(pag, pageSize, totRecCnt);
//		
//		ArrayList<MemberVO> vos=memberService.getMemberSearchList(vo.getStartIndexNo(),vo.getPageSize(),search,searchString);
//		
//		model.addAttribute("pageVo", vo);
//		model.addAttribute("vos", vos);
//		
//		return "member/memberList";
//	}
	
//	회원 개별 정보 조회
	
	@RequestMapping(value = "/memberInfor", method = RequestMethod.GET)
	public String memberInfor(Model model, String mid) {
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo",vo);
		
		return "member/memberInfor";
	}
	
//	회원 개별 정보 조회 ajax - modal 연습
	
	@ResponseBody
	@RequestMapping(value = "/getMemberInfor", method = RequestMethod.POST)
	public MemberVO getMemberInfor(String mid) {
		
		System.out.println("통과");
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		return vo;
	}
	
//	회원 아이디 찾기 폼 접근
	
	@RequestMapping(value = "/memberMidSearch", method = RequestMethod.GET)
	public String memberMidSearchGet() {
		return "member/memberMidSearch";
	}
	
//	회원 아이디 찾기 결과
	
	@RequestMapping(value = "/memberMidSearch", method = RequestMethod.POST)
	public String memberMidSearchPost(Model model, String email) {
		
		ArrayList<MemberVO> vos=memberService.getMemberMidSearch(email);
		
		model.addAttribute("vos",vos);
		
		return "member/memberMidSearchOk";
	}
	
//	회원 탈퇴 폼
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDeleteGet() {
		return "member/memberDelete";
	}
	
//	회원 탈퇴 처리
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDeletePost(HttpSession session, String pwd) {
		
		String mid=(String)session.getAttribute("sMid");
		
		session.invalidate();
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			
			memberService.setMemberDeleteOk(mid);
			
			return "redirect:/msg/memberDeleteOk";
		}
		else {
			return "redirect:/msg/memberDeletePwdNo";
		}
		
	}
	
//	회원 비밀번호 찾기 폼 이동
	
	@RequestMapping(value = "/memberPwdSearch", method = RequestMethod.GET)
	public String memberPwdSearchGet() {
		
		return "member/memberPwdSearch";
	}
	
//	회원 임시 비밀번호 발급 처리
	
	@RequestMapping(value = "/memberPwdSearch", method = RequestMethod.POST)
	public String memberPwdSearchPost(String mid, String toMail) {
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		if(vo.getEmail().equals(toMail)) {
			
//			회원 정보가 일치하다면 UUID를 통하여 8자리 임시 비밀번호를 생성
			
			UUID uid=UUID.randomUUID();
			String pwd=uid.toString().substring(0,8);
			
//			발급받은 임시 비밀번호를 암호화 처리시켜서 DB에 저장
			
			memberService.setMemberPwdUpdate(mid,passwordEncoder.encode(pwd));
			
//			발급받은 임시 비밀번호를 메일로 전송처리한다.
			
			String res=mailSend(toMail,pwd);
			
			if(res.equals("1")) return "redirect:/msg/memberImsiPwdOk";
			else return "redirect:/msg/memberImsiPwdNo";
			
		}
		else {
			return "redirect:/msg/memberImsiPwdNo";
		}
		
	}
	
//	비밀번호 수정 폼
	
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.GET)
	public String memberPwdUpdateGet() {
		return "member/memberPwdUpdate";
	}
	
//	비밀번호 수정 처리
	
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
	public String memberPwdUpdatePost(String pwd, HttpSession session) {
		
		String mid=(String)session.getAttribute("sMid");
		
		memberService.setMemberPwdUpdate(mid,passwordEncoder.encode(pwd));
		
		return "redirect:/msg/memberPwdUpdateOk";
	}
	
	
//	임시 비밀번호 발급 이메일 전송 메소드

	public String mailSend(String toMail, String pwd) {
		String res="";
		
		try {
			
			String title="임시 비밀번호 발급 결과입니다!";
			String content="임시 비밀번호 발급 결과입니다! 임시 비밀번호는 "+pwd+"입니다!";
						
//			메일을 전송하기 위한 객체 : MimeMessage(), MimeMessageHelper()
			
			MimeMessage message=mailSender.createMimeMessage();
			MimeMessageHelper messageHelper=new MimeMessageHelper(message, true, "UTF-8");
			
//			메일 보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
//			메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송 처리
			
			content=content.replace("\n", "<br/>");
			content+="<br><hr><h3>배지훈의 홈페이지에서 메일을 보냈습니다.</h3><hr><br>";
			content+="<p><img src=\"cid:main.png\" width='100%'></p>";
			content+="<hr>";
			content+="<p>방문하기  : <a href='http://49.142.157.251:9090/green2209J_07/'>여기어때 충전어때</a></p>";
			content+="<hr>";
			
			messageHelper.setText(content, true);
			
//			본문에 기재된 그림 파일의 경로를 따로 표시시켜준다. 그리고, 보관함에 다시 저장 처리
			
			FileSystemResource fileSystemResource=new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\main.png");
			
			messageHelper.addInline("main.png", fileSystemResource);	// 그림을 넣을때
			
//			첨부파일 추가하기 (서버 파일 시스템에 있는 파일만 전송 가능)
			
//			fileSystemResource=new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\new.gif");
//			messageHelper.addAttachment("new.gif", fileSystemResource);
			
//			fileSystemResource=new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\arrowTop.gif");
//			messageHelper.addAttachment("arrowTop.gif", fileSystemResource);
			
//			fileSystemResource=new FileSystemResource(request.getRealPath("/resources/images/coding.png"));
//			fileSystemResource=new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/coding.png"));
//			messageHelper.addAttachment("coding.png", fileSystemResource);
			
			
//			메일 전송하기
			
			mailSender.send(message);
			
			return "1";
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		
		return "0";
	}
	
}
