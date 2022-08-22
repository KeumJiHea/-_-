package com.kg.seeot.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kg.seeot.common.SessionName;
import com.kg.seeot.member.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController implements SessionName{
	@Autowired MemberService ms;

	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login_check")
	public String login_check(HttpServletRequest request, 
			       RedirectAttributes rs) {
		int result = ms.login_check(request);
		if(result == 0) {
			rs.addAttribute("id",request.getParameter("id"));
			rs.addAttribute("autoLogin", request.getParameter("autoLogin"));
			
			return "redirect:successLogin";
		}
		return "redirect:login";
	}
	
	
}
