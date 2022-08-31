package com.kg.seeot.member.service;

import javax.servlet.http.HttpServletRequest;

import com.kg.seeot.member.dto.MemberDTO;

public interface MemberService {
     public int login_check( HttpServletRequest request );
     public void keepLogin(String id, String cookieId);
     public int register(MemberDTO dto);
     public MemberDTO getCookieUser(String cookie);
}
