package com.kg.seeot.member.dto;

public class MemberDTO {
private String id,pw,name,phone,phone1,phone2,phone3,email,email1,email2,
               birth,addr1,addr2,addr3,loginCookie;
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
	phone = null == phone ? "" : phone;
	
	if ( 0 < phone.length() ) {
		return phone;
	}
	
	if( 0 < phone2.length() && 0 < phone3.length() ) {
		phone = phone1+"-"+phone2+"-"+phone3;
	}
	
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
	email = null == email ? "" : email;
	
	if( 0 < email1.length() && 0 < email2.length() ) {
		email = email1+"@"+email2;
	}
	
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
}
