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
verify number default(0) 
);

