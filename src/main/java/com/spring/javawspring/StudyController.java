package com.spring.javawspring;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
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

import com.spring.javawspring.common.ARIAUtil;
import com.spring.javawspring.common.SecurityUtil;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.service.StudyService;
import com.spring.javawspring.vo.GuestVO;
import com.spring.javawspring.vo.MailVO;
import com.spring.javawspring.vo.MemberVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
//	aJax 메뉴 페이지 이동
	
	@RequestMapping(value = "/ajax/ajaxMenu", method = RequestMethod.GET)
	public String ajaxMenuGet() {
		return "study/ajax/ajaxMenu";
	}
	
//	@ResponseBody / String 형식의 자료를 주고 받을 수 있도록 하는 어노테이션
	@ResponseBody
	
//	일반 String 값의 전달 1 (숫자 / 영문자)
	@RequestMapping(value = "/ajax/ajaxTest1_1",method =RequestMethod.POST)
	public String ajaxTest1_1Post(int idx) {
		
		idx=(int)(Math.random()*idx)+1;
		
		String res=idx+" : Happy a Good Time !!! ";
		
	
		return res;
	}
	
//	일반 String 값의 전달 2 (숫자 / 영문자)
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1_2", method =RequestMethod.POST, produces = "application/text; charset=utf8")
	public String ajaxTest1_2Post(int idx) {
		
		idx=(int)(Math.random()*idx)+1;
		
		String res=idx+" : 안녕하세요!!! Happy a Good Time !!! ";
		
		return res;
	}
	
//	일반 배열 값의 전달 처리 폼
	
	@RequestMapping(value = "/ajax/aJaxTest2_1", method = RequestMethod.GET)
	public String ajaxTest2_1Get() {
		return "study/ajax/aJaxTest2_1";
	}
	
//	일반 배열 값의 전달 처리
	
	@ResponseBody
	@RequestMapping(value = "/ajax/aJaxTest2_1", method = RequestMethod.POST)
	public String[] ajaxTest2_1Post(String dodo) {
		
//		String[] strArr=new String[100];
//		strArr=studyService.getCityStringArr(dodo);
//		return strArr;
		
		return studyService.getCityStringArr(dodo);
	}
	
//	객체 배열 값의 전달 처리 폼 (ArrayList)
	
	@RequestMapping(value = "/ajax/aJaxTest2_2", method = RequestMethod.GET)
	public String ajaxTest2_2Get() {
		return "study/ajax/aJaxTest2_2";
	}
	
//	객체 배열 값의 전달 처리 (ArrayList)
	
	@ResponseBody
	@RequestMapping(value = "/ajax/aJaxTest2_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest2_2Post(String dodo) {
		
		return studyService.getCityArrayListArr(dodo);
	}
	
//	Map 값의 전달 처리 폼 (HashMap<k,v>)
	
	@RequestMapping(value = "/ajax/aJaxTest2_3", method = RequestMethod.GET)
	public String ajaxTest2_3Get() {
		return "study/ajax/aJaxTest2_3";
	}
	
//	Map 값의 전달 처리 처리 (HashMap<k,v>)
	
	@ResponseBody
	@RequestMapping(value = "/ajax/aJaxTest2_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest2_3Post(String dodo) {
		
//		키와 값에 Object 작성해주면 어떤 값이 넘어오더라도 상관이 없다
		
		ArrayList<String> vos=new ArrayList<String>();
		
		vos=studyService.getCityArrayListArr(dodo);
		
		HashMap<Object, Object> map=new HashMap<Object, Object>();
		
		map.put("city", vos);
		
		return map;
	}
	
//	DB를 활용한 값의 전달 연습 폼
	
	@RequestMapping(value = "/ajax/aJaxTest3", method = RequestMethod.GET)
	public String ajaxTest3Get() {
		return "study/ajax/aJaxTest3";
	}
	
//	DB를 활용한 값의 전달 1 (vo를 이용한 갑의 전달)
	@ResponseBody
	@RequestMapping(value = "/ajax/aJaxTest3_1", method = RequestMethod.POST)
	public GuestVO ajaxTest3_1Post(String mid) {
		
		
//		 GuestVO vo=studyService.getGuestMid(mid);
//		 
//		 return vo;
		
		return studyService.getGuestMid(mid);
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/aJaxTest3_2", method = RequestMethod.POST)
	public ArrayList<GuestVO> ajaxTest3_2Post(String mid) {
		
		return studyService.getGuestNames(mid);
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/aJaxTest3_3", method = RequestMethod.POST)
	public ArrayList<GuestVO> ajaxTest3_3Post(String search, String searchString) {
		
		return studyService.getGuestSearch(search, searchString);
	}
	
//	암호화 연습 (SHA256 방식) 페이지 이동
	
	@RequestMapping(value = "/password/sha256", method = RequestMethod.GET)
	public String sha256Get() {
		return "study/password/sha256";
	}
	
//	암호화 연습 (SHA256) 결과 처리
	
	@ResponseBody
	@RequestMapping(value = "/password/sha256", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String sha256Post(String pwd) {
		String encPwd=SecurityUtil.encryptSHA256(pwd);
		
		pwd="원본 비밀번호: "+pwd+" / 암호화된 비밀번호: "+encPwd + "<br/>";
		
		return pwd;
	}
	
//	암호화 연습 (ARIA) 페이지 이동
	
	@RequestMapping(value = "/password/aria", method = RequestMethod.GET)
	public String ariaGet() {
		return "study/password/aria";
	}
	
//	암호화 연습 (ARIA) 결과 처리
	
	@ResponseBody
	@RequestMapping(value = "/password/aria", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String ariaPost(String pwd) {
		
		String encPwd="";
		String decPwd="";
		
		try {
			encPwd = ARIAUtil.ariaEncrypt(pwd);	// 암호화
			decPwd = ARIAUtil.ariaDecrypt(encPwd);	// 복호화
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		pwd="원본 비밀번호: "+pwd+" / 암호화된 비밀번호: "+encPwd+" / 복호화된 비밀번호: "+decPwd+"<br/>";
		
		return pwd;
	}
	
//	암호화 연습 (bCryptPassword) 페이지 이동
	
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.GET)
	public String bCryptPasswordGet() {
		return "study/password/security";
	}
	
//	암호화 연습 (bCryptPassword) 결과 처리
	
	@ResponseBody
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) {
		
		String encPwd="";
		
		encPwd = passwordEncoder.encode(pwd);	// 암호화
		
		pwd="원본 비밀번호: "+pwd+" / 암호화된 비밀번호: "+encPwd+" <br/>";
		
		return pwd;
	}
	
//	SMTP를 사용한 메일 보내기
	
//	메일 전송 폼 
	
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.GET)
	public String mailFormGet(Model model, String email) {
		
		ArrayList<MemberVO> vos=studyService.getEmailList();
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", vos.size());
		model.addAttribute("email", email);
		
		return "study/mail/mailForm";
	}
	
//	주소록 호출하기
	
	
	
//	메일 전송
	
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailFormPost(MailVO vo, HttpServletRequest request) {
		
		try {
			
			String toMail=vo.getToMail();
			String title=vo.getTitle();
			String content=vo.getContent();
			
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
			
			fileSystemResource=new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\new.gif");
			messageHelper.addAttachment("new.gif", fileSystemResource);
			
			fileSystemResource=new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\arrowTop.gif");
			messageHelper.addAttachment("arrowTop.gif", fileSystemResource);
			
//			fileSystemResource=new FileSystemResource(request.getRealPath("/resources/images/coding.png"));
			fileSystemResource=new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/coding.png"));
			messageHelper.addAttachment("coding.png", fileSystemResource);
			
			
//			메일 전송하기
			
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/mailSendOk";
	}
	
//	UUID 입력 폼
	
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	
//	UUID 처리
	
	@ResponseBody
	@RequestMapping(value = "/uuid/uuidProcess", method = RequestMethod.POST)
	public String uuidFormPost() {
		
		UUID uid=UUID.randomUUID();
		
		return uid.toString();
	}
	
//	파일 업로드 폼 이동
	
	@RequestMapping(value = "/fileUpload/fileUploadForm", method = RequestMethod.GET)
	public String fileUploadFormGet() {
		return "study/fileUpload/fileUploadForm";
	}
	
//	파일 업로드 처리
	
	@RequestMapping(value = "/fileUpload/fileUploadForm", method = RequestMethod.POST)
	public String fileUploadFormPost(MultipartFile fName) {
		
		int res=studyService.fileUpload(fName);
		
		if(res==1) {
			return "redirect:/msg/fileUploadOk";			
		}
		else {
			return "redirect:/msg/fileUploadNo";						
		}
		
	}
	
//	달력 내역 가져오기
	
	@RequestMapping(value = "/calendar/calendar", method = RequestMethod.GET)
	public String calenderGet() {
		studyService.getCalendar();
		return "study/calendar/calendar";
	}
	
//	QR 코드 작성 폼
	
	@RequestMapping(value = "/qrCode", method = RequestMethod.GET)
	public String qrCodeGet(HttpSession session,Model model) {
		
		String mid=(String)session.getAttribute("sMid");
		
		MemberVO vo=memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "study/qrCode/qrCode";
	}
	
//	QR 코드 생성
	
	@ResponseBody
	@RequestMapping(value = "/qrCode", method = RequestMethod.POST)
	public String qrCodePost(HttpServletRequest request, 
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid, 
			@RequestParam(name = "moveFlag", defaultValue = "", required = false) String moveFlag) {
		
		String realPath=request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		
		String qrCodeName=studyService.qrCreate(mid, moveFlag, realPath);
		
		return qrCodeName;
	}
	
//	QR 코드 생성 DB 연동
	
	@ResponseBody
	@RequestMapping(value = "/qrCodeDB", method = RequestMethod.POST)
	public String qrCodeDBPost(HttpServletRequest request, 
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid, 
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName, 
			@RequestParam(name = "bigo", defaultValue = "", required = false) String bigo) {
		
		String realPath=request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		
		String qrCodeName=studyService.qrCreateDB(mid, nickName, bigo, realPath);
		
		return qrCodeName;
	}
	
//	QR 코드 조회 결과
	
	@RequestMapping(value = "/qrCodeRes", method = RequestMethod.GET)
	public String qrCodeRes(Model model, String idx) {
		
		System.out.println(idx);
		
		String bigo=studyService.getQrCodeDB(idx);
		
		System.out.println(bigo);
		
		model.addAttribute("bigo",bigo);
		
		return "study/qrCode/qrCodeRes";
	}
	
	
}
