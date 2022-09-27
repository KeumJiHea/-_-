package com.kg.seeot.member.dto;

public class MemberDTO {
private String id,pw,name,phone,phone1,phone2,phone3,email,email1,email2,
               birth,addr1,addr2,addr3,loginCookie,code;
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
	if( null != phone ) { // 이미 회원가입된 사람
		return phone;
	} else if( null == phone && ( null == phone1 || null == phone2 || null == phone3 ) ) { // 신규 가입인데, 폰 정보도 입력하지 않은 사람
		return "";
	}
	
	phone = phone1+"-"+phone2+"-"+phone3;
	
	return phone;
}
public String getPhone1() {
	return phone1;
}
public void setPhone1(String phone1) {
	this.phone1 = phone1;
}
public String getPhone2() {
	return phone2;
}
public void setPhone2(String phone2) {
	this.phone2 = phone2;
}
public String getPhone3() {
	return phone3;
}
public void setPhone3(String phone3) {
	this.phone3 = phone3;
}
public String getEmail() {

	if( null != email ) { // 이미 회원가입된 사람
		return email;
	} else if( null == email && ( null == email1 || null == email2 ) ) { // 신규 가입인데, 이메일 정보도 입력하지 않은 사람
		return "";
	}

	email = email1+"@"+email2;
	
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getEmail1() {
	return email1;
}
public void setEmail1(String email1) {
	this.email1 = email1;
}
public String getEmail2() {
	return email2;
}
public void setEmail2(String email2) {
	this.email2 = email2;
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
public String getCode() {
	return code;
}
}
