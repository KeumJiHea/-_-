package com.kg.seeot.member.dto;

public class MemberDTO {
private String member_id,member_pw,member_name,member_phone,member_email,member_birth,
member_addr1,member_addr2,member_addr3,login_cookie;
private int verify;

public String getMember_id() {
	return member_id;
}
public void setMember_id(String member_id) {
	this.member_id = member_id;
}
public String getMember_pw() {
	return member_pw;
}
public void setMember_pw(String member_pw) {
	this.member_pw = member_pw;
}
public String getMember_name() {
	return member_name;
}
public void setMember_name(String member_name) {
	this.member_name = member_name;
}
public String getMember_phone() {
	return member_phone;
}
public void setMember_phone(String member_phone) {
	this.member_phone = member_phone;
}
public String getMember_email() {
	return member_email;
}
public void setMember_email(String member_email) {
	this.member_email = member_email;
}
public String getMember_birth() {
	return member_birth;
}
public void setMember_birth(String member_birth) {
	this.member_birth = member_birth;
}
public String getMember_addr1() {
	return member_addr1;
}
public void setMember_addr1(String member_addr1) {
	this.member_addr1 = member_addr1;
}
public String getMember_addr2() {
	return member_addr2;
}
public void setMember_addr2(String member_addr2) {
	this.member_addr2 = member_addr2;
}
public String getMember_addr3() {
	return member_addr3;
}
public void setMember_addr3(String member_addr3) {
	this.member_addr3 = member_addr3;
}
public String getLogin_cookie() {
	return login_cookie;
}
public void setLogin_cookie(String login_cookie) {
	this.login_cookie = login_cookie;
}
public int getVerify() {
	return verify;
}
public void setVerify(int verify) {
	this.verify = verify;
}

}
