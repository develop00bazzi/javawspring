package com.spring.javawspring.errorTest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
//	에러 연습 폼 이동
	
	@RequestMapping(value ="/error" , method=RequestMethod.GET)
	public String errorGet() {
		
		return "errorPage/errorMain";
	}
	
//	JSP 파일에서의 에러 발생 대처 연습
	
	@RequestMapping(value ="/error1" , method=RequestMethod.GET)
	public String error1Get() {
		
		return "errorPage/error1";
	}
	
//	웹에서 400, 404, 405, 500 에러가 발생시 이동할 경로 설정
	
	@RequestMapping(value ="/errorOk" , method=RequestMethod.GET)
	public String errorOkGet() {
		
		return "errorPage/errorMsg2";
	}
	
//	서블릿에서 예외 오류 발생
	
	@RequestMapping(value ="/error3" , method=RequestMethod.GET)
	public String error3Get() {
		
		String str=null;
		
		System.out.println("str: "+str.toString());
		
//		Exception 예외에 대한 오류 처리
		
		return "errorPage/errorMain";
	}
	
	
}
