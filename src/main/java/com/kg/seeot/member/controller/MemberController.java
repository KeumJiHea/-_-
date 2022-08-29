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
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@Autowired JavaMailSender mailSender;
	
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
		if(result == 1)
			return "redirect:login";
			return "redirect:register_form";
	}
	//ID중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String id) throws Exception{
		
		int result = ms.idCheck(id);
		if(result != 0) {
			return "fail";
		}
		else {
			return "success";
		}
	}
	//이메일 인증
	@RequestMapping(value="/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email)throws Exception{
		
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		
		/* 이메일 보내기 */
        String setFrom = "zpokk@naver.com";
        String toMail = email;
        String title = "SeeoT 회원가입 인증 이메일 입니다.";
        String content =
        		"안녕하세요"+"<br>"+
                "SeeoT을 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String num = Integer.toString(checkNum);
        
        return num;
	}
}














