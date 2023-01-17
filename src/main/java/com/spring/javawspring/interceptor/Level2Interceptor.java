package com.spring.javawspring.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level2Interceptor extends HandlerInterceptorAdapter {
	
//	postHandle은 따로 할 사람은 해도 된다.
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session=request.getSession();
		int level=session.getAttribute("sLevel")==null?99:(int)session.getAttribute("sLevel");
		
		RequestDispatcher dispatcher;
		
		if(level>2) {
			if(level==99) {	// 비회원인 경우
				dispatcher=request.getRequestDispatcher("/msg/memberNo");
							}
			else {	// 준회원 / 정회원인 경우 (level=3,4) 
				dispatcher=request.getRequestDispatcher("/msg/levelCheckNo");
			}
			dispatcher.forward(request, response);				
			return false;
		}
		
		return true;
	}
	
	
}
