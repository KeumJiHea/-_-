package com.kg.seeot.common;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.kg.seeot.member.dto.MemberDTO;
import com.kg.seeot.member.service.MemberService;

public class AutoLogin extends HandlerInterceptorAdapter{
@Autowired MemberService ms;
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
	Cookie cookie = WebUtils.getCookie(request, "loginCookie");
	if(cookie != null) {
		MemberDTO dto = ms.getCookieUser(cookie.getValue());
		if(dto != null ) {
			request.getSession().setAttribute("loginUser", dto.getId());
		}
	}
return true;	
}
}
