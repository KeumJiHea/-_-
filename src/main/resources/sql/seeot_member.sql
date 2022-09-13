create table seeot_member(
member_id VARCHAR2(20) PRIMARY KEY,
member_pw VARCHAR2(20),
member_name VARCHAR2(20),
member_phone VARCHAR2(13),
member_email VARCHAR2(40),
member_birth VARCHAR2(20),
member_addr1 VARCHAR2(100),
member_addr2 VARCHAR2(100),
member_addr3 VARCHAR2(100),
login_cookie varchar2(100) default 'nan' not null,
verify number default(0) 
);

insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,
member_addr1,member_addr2,member_addr3,verify)values('admin','seeot_06','관리자','123-4567-8910',
'admin@seeot.com','2000년1월1일','시','옷','프로젝트',9);

insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,
member_addr1,member_addr2,member_addr3)values('seeotuser','users_06','사용자','010-1111-2222',
'users@seeot.com','1999년9월9일','시','옷','프로젝트');