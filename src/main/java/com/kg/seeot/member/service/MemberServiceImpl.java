package com.kg.seeot.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.member.dto.MemberDTO;
import com.kg.seeot.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired MemberMapper mapper;
	BCryptPasswordEncoder en = new BCryptPasswordEncoder();

	public int login_check( HttpServletRequest request ) {
		MemberDTO dto = mapper.getUser(request.getParameter("id"));
		if(dto != null) {
			if(en.matches(request.getParameter("pw"),dto.getPw()) || dto.getPw().equals(request.getParameter("pw"))) {
				return 0;	
			}
		}
		return 1;
	}
	public void keepLogin(String id, String cookieId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cookieId", cookieId);
		mapper.keepLogin(map);
	}
	public int register(MemberDTO dto) {
		String seq = en.encode(dto.getPw());
		
		dto.setPw( seq );
		
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		
		try {
			return mapper.register( dto );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public MemberDTO getCookieUser(String cookie) {
		return mapper.getCookieUser(cookie);
	}
	public void getUser(Model model,String id) {
		model.addAttribute("info", mapper.getUser(id));
	}
	public void memberlist(Model model) {
		List<MemberDTO> list = mapper.memberlist();
		model.addAttribute("list",list);
	}
	public void delete(String id) {
		mapper.delete(id);
	}
	public int idCheck(String id) throws Exception{
		return mapper.idCheck(id);
	}
	public int modify(HttpServletRequest request,MemberDTO dto) {
		dto.setId(request.getParameter("id"));
		dto.setName(request.getParameter("name"));
		dto.setPhone1(request.getParameter("phone1"));
		dto.setPhone2(request.getParameter("phone2"));
		dto.setPhone3(request.getParameter("phone3"));
		dto.setEmail1(request.getParameter("email1"));
		dto.setEmail2(request.getParameter("email2"));
		dto.setBirth(request.getParameter("birth"));
		
		String seq = en.encode(dto.getPw());
		
		dto.setPw( seq );
		
		try {
			return mapper.modify(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}



















