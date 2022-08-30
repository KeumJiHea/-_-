package com.kg.seeot.mybatis.member;

import java.util.Map;

import com.kg.seeot.member.dto.MemberDTO;

public interface MemberMapper {
public MemberDTO getUser( String id );
public void keepLogin(Map<String, Object> map);
public int register( MemberDTO dto );
public int idCheck(String id);
}
