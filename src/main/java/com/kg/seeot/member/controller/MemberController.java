package com.kg.seeot.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.logging.Logger;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.LogException;
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

import com.google.gson.Gson;
import com.kg.seeot.common.SessionName;
import com.kg.seeot.member.dto.MemberDTO;
import com.kg.seeot.member.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController implements SessionName{	
	@Autowired MemberService ms;
	
	@Autowired 
	private JavaMailSender mailSender;

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
			return "admin/admin";
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
		return "redirect:login";
	}
	@GetMapping("register_form")
	public String register_form() {
		return "member/register";
	}
	@PostMapping("register")
	public String register(MemberDTO dto) {
		
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		
		int result = ms.register(dto);
		
		System.out.println(result);
		
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
	@GetMapping("memberlist")
	public String infolist(Model model) {
		ms.memberlist(model);
		return "admin/memberlist";
	}
	@GetMapping("delete")
	public String delete(String id) {
		ms.delete(id);
		return "redirect:memberlist";
	}
	
	@GetMapping("memberIdChk.do")
	@ResponseBody
	public void memberIdChk(HttpServletResponse response, @RequestParam String id) throws Exception {
		Gson gson = new Gson();
		
		int result = ms.idCheck(id);
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		data.put("result", result);
		
		response.getWriter().print(gson.toJson(data));
	}
	
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {
		
		Random random = new Random();
		//인증번호 랜덤 숫자 1~9까지 6자리 생성
		int checkNum = random.nextInt(888888) + 111111;
		
		String setFrom = "zpokk@naver.com";
        String toMail = email;
        String title = "SeeoT 회원가입 인증 이메일 입니다.";
        String content = 
                "SeeoT을 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 <b>" + checkNum + "</b>입니다." + 
                "<br><br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        try {
        	MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        //checkNum 형변환
        String num = Integer.toString(checkNum);
        return num;
	
	}
	/*
	@GetMapping("find_form")
	public String find_form() {
		return "find_form";
	}
	@PostMapping("find_id_form")
	public String find_id_form(String id) {
		
		return "member/find_form";
	}
	@PostMapping("modify")
	public String modify(HttpServletRequest request,MemberDTO dto) {
		
		System.out.println(request.getParameter("id"));
		
		int result = ms.modify(request,dto);
		
		System.out.println(result);
		
		return "redirect:info?id="+request.getParameter("id");
	}
	@PostMapping("find_pw_form")
	public String find_pw_form() {
		return "";
	}
	*/
}













