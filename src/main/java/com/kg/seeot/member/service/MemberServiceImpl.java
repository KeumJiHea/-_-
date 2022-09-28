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
	public MemberDTO getUser(Model model,String id) {
		MemberDTO info = mapper.getUser(id);
		model.addAttribute("info", info);
		return info;
	}
	public void memberlist(Model model) {
		List<MemberDTO> list = mapper.memberlist();
		model.addAttribute("list",list);
	}
	public void delete(String id) {
		mapper.delete(id);
	}
	public int member_delete(MemberDTO dto) {
		try {
			return mapper.member_delete(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
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
		
		String seq = en.encode(request.getParameter("pw"));
		dto.setPw(seq);
		
		try {
			return mapper.modify(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int edit_addr(HttpServletRequest request,MemberDTO dto) {
		
		dto.setId(request.getParameter("id"));
		dto.setAddr1(request.getParameter("addr1"));
		dto.setAddr2(request.getParameter("addr2"));
		dto.setAddr3(request.getParameter("addr3"));
		
		try {
			return mapper.edit_addr(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	public String id_find(String name, String email) {
		
		String result = "";
		
		try {
			result = mapper.id_find(name,email);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return result;
	}
public String pw_find(String id, String email) {
		
		String result = "";
		
		try {
			result = mapper.pw_find(id,email);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return result;
	}
public int change_pw(HttpServletRequest request,MemberDTO dto) {
	
	dto.setId(request.getParameter("id"));
	String seq = en.encode(request.getParameter("pw"));
	dto.setPw(seq);
	
	try {
		return mapper.change_pw(dto);
	} catch (Exception e) {
		e.printStackTrace();
	}
	return 0;
}
public int kakaoConnectionCheck(Map<String, Object> paramMap){
	
	int check = mapper.idCheck("kakao_"+paramMap.get("id"));
	if( check == 0) {
		MemberDTO dto = new MemberDTO();
		dto.setId("kakao_"+paramMap.get("id"));
		if(paramMap.get("email") != null) {
			dto.setEmail((String)paramMap.get("email"));
		}

		try {
			return mapper.kakaoreg( dto );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	return 0;
  }
}



















