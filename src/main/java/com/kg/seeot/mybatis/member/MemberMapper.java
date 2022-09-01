package com.kg.seeot.mybatis.member;

import java.util.List;
import java.util.Map;

import com.kg.seeot.member.dto.MemberDTO;

public interface MemberMapper {
public MemberDTO getUser( String id );
public void keepLogin(Map<String, Object> map);
public int register( MemberDTO dto );
public int idCheck(String id);
public MemberDTO getCookieUser(String cookie);
public List<MemberDTO> memberlist();
public void delete(String id);
}
