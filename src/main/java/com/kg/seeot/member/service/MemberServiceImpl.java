package com.kg.seeot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kg.seeot.member.dto.MemberDTO;
import com.kg.seeot.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired MemberMapper mapper;
	BCryptPasswordEncoder en = new BCryptPasswordEncoder();

	public int login_check( HttpServletRequest request ) {
		MemberDTO dto = mapper.getUser(request.getParameter("id"));
		if(dto != null) {
			if(en.matches(request.getParameter("pw"),dto.getMember_pw()) || dto.getMember_pw().equals(request.getParameter("pw"))) {
				return 0;	
			}
		}
		return 1;
	}
}
