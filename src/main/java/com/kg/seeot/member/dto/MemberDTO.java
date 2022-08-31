package com.kg.seeot.member.dto;

public class MemberDTO {
private String id,pw,name,phone,email,birth,addr1,addr2,addr3,loginCookie;
private int verify;
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPw() {
	return pw;
}
public void setPw(String pw) {
	this.pw = pw;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getBirth() {
	return birth;
}
public void setBirth(String birth) {
	this.birth = birth;
}
public String getAddr1() {
	return addr1;
}
public void setAddr1(String addr1) {
	this.addr1 = addr1;
}
public String getAddr2() {
	return addr2;
}
public void setAddr2(String addr2) {
	this.addr2 = addr2;
}
public String getAddr3() {
	return addr3;
}
public void setAddr3(String addr3) {
	this.addr3 = addr3;
}

public String getLoginCookie() {
	return loginCookie;
}
public void setLoginCookie(String loginCookie) {
	this.loginCookie = loginCookie;
}
public int getVerify() {
	return verify;
}
public void setVerify(int verify) {
	this.verify = verify;
}



}
