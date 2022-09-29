package com.kg.seeot.member.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.logging.Logger;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.LogException;
import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UrlPathHelper;

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
			request.setAttribute("msg","아이디 또는 비밀번호를 확인해주세요");
			request.setAttribute("url","login");
			return "member/alert";
	}
	@GetMapping("successLogin")
	public String successLogin(@RequestParam String id,
			@RequestParam(required = false) String autoLogin,
			HttpSession session, HttpServletResponse response, Model model) {
		MemberDTO member = ms.getUser(model, id);
		
		if( autoLogin != null ) {
			int time = 60*60*24*90;
			Cookie cookie = new Cookie("loginCookie", id);
			cookie.setMaxAge(time);
			cookie.setPath("/");
			response.addCookie(cookie);

			ms.keepLogin(id, id);
		}
		if(id.equals("admin")) {
			session.setAttribute(LOGIN, id);
			session.setAttribute(NAME, member.getName());
			session.setMaxInactiveInterval(24*60*60);
			return "redirect:memberlist.admin";
		}
		session.setAttribute(LOGIN, id);
		session.setAttribute(NAME, member.getName());
		session.setMaxInactiveInterval(24*60*60);
		return "redirect:/home.page";
		
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
	public String register(HttpServletRequest request, MemberDTO dto) {
		
		int result = ms.register(dto);
		
		//회원가입 alert
		if(1 == result) {
			request.setAttribute("msg","회원가입 완료되었습니다");
			request.setAttribute("url","login");
			return "member/alert";
		}
			request.setAttribute("msg","입력 정보를 다시 확인해주세요");
			request.setAttribute("url","register");
			return "member/alert";
	}
	
	@GetMapping("info")
	public String info(Model model, String id) {
		
		ms.getUser(model,id);
		
		return "member/info";
	}
	@GetMapping("memberlist")
	public String infolist(Model model) {
		ms.memberlist(model);
		return "admin/memberlist.admin";
	}
	@GetMapping("delete")
	public String delete(String id) {
		ms.delete(id);
		return "redirect:memberlist";
	}
	@PostMapping("member_delete")
	public String member_delete(HttpServletRequest request, MemberDTO dto) {
		int result = ms.member_delete(dto);
		
		if(1 == result) {
			request.setAttribute("msg","회원 탈퇴되었습니다");
			request.setAttribute("url","login");
			return "member/alert";
		}
			request.setAttribute("msg","비밀번호를 다시 확인해주세요");
			request.setAttribute("url","info?id="+request.getParameter("id"));
			return "member/alert";
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
	@PostMapping("edit_addr")
	public String edit_addr(HttpServletRequest request,MemberDTO dto) {
		
		int result = ms.edit_addr(request,dto);
		
		//배송지 수정 alert
				if(1 == result) {
					request.setAttribute("msg","배송지 수정이 완료되었습니다");
					request.setAttribute("url","info?id="+request.getParameter("id"));
					return "member/alert";
				}
					request.setAttribute("msg","정보를 다시 확인해주세요");
					request.setAttribute("url","info?id="+request.getParameter("id"));
					return "member/alert";
	}
	
	@RequestMapping(value = "/modify",method = RequestMethod.POST)
	public String modify(HttpServletRequest request,MemberDTO dto) {
		
		int result = ms.modify(request,dto);
		
		//정보 수정 alert
		if(1 == result) {
			request.setAttribute("msg","정보 수정이 완료되었습니다");
			request.setAttribute("url","info?id="+request.getParameter("id"));
			return "member/alert";
		}
			request.setAttribute("msg","정보를 다시 확인해주세요");
			request.setAttribute("url","info?id="+request.getParameter("id"));
			return "member/alert";
	}
	@GetMapping("id_find_form")
	public String id_find_form() {
			return "member/id_find_form";
	}
	
	@RequestMapping(value = "/id_find",method = RequestMethod.POST)
	@ResponseBody
	public String id_find(@RequestParam("name") String name , @RequestParam("email") String email) {
		
		String result = ms.id_find(name, email);
		
		return result;
	}
	
	@GetMapping("pw_find_form")
	public String pw_find_form() {
		return "member/pw_find_form";
	}
	
	@RequestMapping(value = "/pw_find",method = RequestMethod.POST)
	@ResponseBody
	public String pw_find(@RequestParam("id") String id , @RequestParam("email") String email) {
		
		String result = ms.pw_find(id, email);
		
		return result;
	}
	
	@RequestMapping(value = "change_pw" , method = RequestMethod.POST)
	public String change_pw(HttpServletRequest request , MemberDTO dto) {
		
		int result = ms.change_pw(request,dto);
		
		System.out.println(result);
		
		//정보 수정 alert
		if(1 == result) {
			request.setAttribute("msg","비밀번호 설정이 완료되었습니다");
			request.setAttribute("url","login");
			return "member/alert";
		}
			request.setAttribute("msg","정보를 다시 확인해주세요");
			request.setAttribute("url","pw_find_form");
			return "member/alert";
	}
	
	@RequestMapping( value = "kakaoLoginPro.do", method = RequestMethod.POST )
	public void kakaoLoginPro(HttpServletResponse response, @RequestParam Map<String, Object> paramMap, HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap : "+paramMap);
		
		Gson gson = new Gson();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int kakaoConnectionCheck = ms.kakaoConnectionCheck(paramMap);
		if(kakaoConnectionCheck == 0) {
			session.setAttribute(LOGIN, paramMap.get("id"));
			session.setMaxInactiveInterval(24*60*60);
			resultMap.put("id", "kakao_" + paramMap.get("id"));
			resultMap.put("JavaData", "login");
		}if(kakaoConnectionCheck == 1) {
			session.setAttribute(LOGIN, paramMap.get("id"));
			session.setMaxInactiveInterval(24*60*60);
			resultMap.put("id", "kakao_" + paramMap.get("id"));
			resultMap.put("JavaData", "newlogin");
		}
		
		response.getWriter().print(gson.toJson(resultMap));
	}
}
