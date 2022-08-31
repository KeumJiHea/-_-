package com.kg.seeot.member.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kg.seeot.common.SessionName;
import com.kg.seeot.member.dto.MemberDTO;
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
	@GetMapping("successLogin")
	public String successLogin(@RequestParam String id,
			@RequestParam(required = false) String autoLogin,
			HttpSession session, HttpServletResponse response) {
		if(id.equals("admin")) {
			return "member/admin";
		}

		if( autoLogin != null ) {
			int time = 60*60*24*90;
			Cookie cookie = new Cookie("loginCookie", id);
			cookie.setMaxAge(time);
			cookie.setPath("/");
			response.addCookie(cookie);

			ms.keepLogin(id, id);
		}
		session.setAttribute(LOGIN, id);
		return "member/successLogin";
	}
	@GetMapping("logout")
	public String logout( HttpSession session,
	@CookieValue(required = false)Cookie loginCookie,
	HttpServletResponse response ) {
		
		if( loginCookie != null ) {
			loginCookie.setMaxAge(0);
			loginCookie.setPath("/");
			response.addCookie(loginCookie);
			ms.keepLogin( (String)session.getAttribute(LOGIN), "nan");
		}
		session.invalidate();
		return "redirect:/index";
	}
	@GetMapping("register_form")
	public String register_form() {
		return "member/register";
	}
	@PostMapping("register")
	public String register(MemberDTO dto) {
		int result = ms.register(dto);
		if(result == 1) {
			return "redirect:login";
		}
			return "redirect:register_form";
	}
	@GetMapping("info")
	public String info(Model model, String id) {
		ms.getUser(model,id);
		
		return "member/info";
	}
}














