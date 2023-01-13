package com.spring.javawspring;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="mid", defaultValue = "", required = false) String mid,
			@RequestParam(value="flag", defaultValue = "", required = false) String flag) {
		
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인 되었습니다!");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", mid + "님 로그인에 실패하였습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글이 등록되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "방명록의 게시글이 삭제되었습니다!");
			model.addAttribute("url", "guest/guestList");
		}
		
		else if(msgFlag.equals("guestUpdateOk")) {
			model.addAttribute("msg", "방명록의 게시글이 수정되었습니다!");
			model.addAttribute("url", "guest/guestList");
		}
		
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원 가입 완료!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("msg", "이미 존재하는 회원입니다!");
			model.addAttribute("url", "member/memberJoin");
		}
		
		else if(msgFlag.equals("memberNickNameCheckNo")) {
			model.addAttribute("msg", "이미 존재하는 회원입니다!");
			model.addAttribute("url", "member/memberJoin");
		}
		
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접근 가능합니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "정상적인 접근이 아닙니다! 로그인 후 사용해주시기 바랍니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("levelCheckNo")) {
			model.addAttribute("msg", "준회원은 사용하실 수 없습니다!");
			model.addAttribute("url", "member/memberMain");
		}
		
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일이 발송되었습니다!");
			model.addAttribute("url", "study/mail/mailForm");
		}
		
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", "회원 탈퇴 처리가 완료되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("memberDeletePwdNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다!");
			model.addAttribute("url", "member/memberDelete");
		}
		
		else if(msgFlag.equals("memberImsiPwdOk")) {
			model.addAttribute("msg", "임시 비밀번호를 이메일로 발송하였습니다! \\n 메일을 확인하세요!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("memberImsiPwdNo")) {
			model.addAttribute("msg", "임시 비밀번호 발송에 실패하였습니다!");
			model.addAttribute("url", "member/memberPwdSearch");
		}
		
		else if(msgFlag.equals("memberPwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일을 성공적으로 업로드하였습니다!");
			model.addAttribute("url", "study/fileUpload/fileUploadForm");
		}
		
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원 정보가 성공적으로 수정되었습니다!");
			model.addAttribute("url", "member/memberMain");
		}
		
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 성공적으로 등록되었습니다!");
			model.addAttribute("url", "board/boardList");
		}
		
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글을 등록하는데 실패하였습니다!");
			model.addAttribute("url", "board/boardInput");
		}
		
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다!");
			model.addAttribute("url", "board/boardList"+flag);
		}
		
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다!");
			model.addAttribute("url", "board/boardList"+flag);
		}
		
		return "include/message";
	}
}
