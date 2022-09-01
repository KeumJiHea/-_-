package com.kg.seeot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kg.seeot.member.dto.MemberDTO;

public interface MemberService {
     public int login_check( HttpServletRequest request );
     public void keepLogin(String id, String cookieId);
     public int register(MemberDTO dto);
     public MemberDTO getCookieUser(String cookie);
     public void getUser(Model model,String id);
     public void memberlist(Model model);
     public void delete(String id);
}
