package com.kg.seeot.member.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.kg.seeot.member.dto.MemberDTO;

public interface MemberService {
     public int login_check( HttpServletRequest request );
     public void keepLogin(String id, String cookieId);
     public int register(MemberDTO dto);
     public MemberDTO getCookieUser(String cookie);
     public void getUser(Model model,String id);
     public void memberlist(Model model);
     public void delete(String id);
     public int member_delete(MemberDTO dto);
     public int idCheck(String id) throws Exception;
     public int modify(HttpServletRequest request,MemberDTO dto);
     public int edit_addr(HttpServletRequest request,MemberDTO dto);
     public String id_find(String name, String email);
     public String pw_find(String id, String email);
     public int change_pw(HttpServletRequest request,MemberDTO dto);
     public int kakaoConnectionCheck(Map<String, Object> paramMap);
}
