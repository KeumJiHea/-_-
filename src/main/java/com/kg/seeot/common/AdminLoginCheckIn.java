package com.kg.seeot.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminLoginCheckIn extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if( session.getAttribute("loginUser") == null ) {
			//response.sendRedirect("login");
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('로그인 먼저 진행!!!');"+
						"location.href='"+ 
						request.getContextPath() +
						"/member/login';</script>");
			return false;
		}else {
			if( session.getAttribute("loginUser").equals("admin") ) {
					return true;
			}else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('관리자만 접속이 가능합니다!!!');"+
							"location.href='"+ 
							request.getContextPath() +
							"/home';</script>");
				return false;
			}
		}
	}
	
}




