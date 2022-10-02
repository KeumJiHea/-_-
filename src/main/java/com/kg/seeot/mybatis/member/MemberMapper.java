package com.kg.seeot.mybatis.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.kg.seeot.member.dto.MemberDTO;

public interface MemberMapper {
public MemberDTO getUser( String id );
public void keepLogin(Map<String, Object> map);
public int register( MemberDTO dto );
public MemberDTO getCookieUser(String cookie);
public List<MemberDTO> memberlist();
public void delete(String id);
public int member_delete(String id);
public int idCheck(String id);
public int modify(MemberDTO dto);
public int edit_addr(MemberDTO dto);
//아이디 찾기
@Select("select nvl(member_id,0) from seeot_member where member_name=#{name} and member_email=#{email}")
public String id_find(@Param("name") String name,@Param("email")String email);
//비밀번호 찾기,변경
@Select("select nvl(member_pw,0) from seeot_member where member_id=#{id} and member_email=#{email}")
public String pw_find(@Param("id") String id,@Param("email")String email);

public int change_pw(MemberDTO dto);
public int kakaoreg(MemberDTO dto);
}
