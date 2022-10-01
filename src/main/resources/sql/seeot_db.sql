--create USER seeot IDENTIFIED by 2022; -- 계정생성 ID / PW
--grant dba to seeot; --권한부여

-- 맴버 테이블
create table seeot_member(
member_id VARCHAR2(20) PRIMARY KEY,
member_pw VARCHAR2(500),
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

-----------------------------------------------------------------------
--멤버 샘플 데이터
insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,
member_addr1,member_addr2,member_addr3,verify)values('admin','seeot_06','관리자','123-4567-8910',
'zpokk@naver.com','2000년1월1일','시','옷','프로젝트',9);

insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,
member_addr1,member_addr2,member_addr3)values('seeotuser','users_06','사용자','010-1111-2222',
'zpokk@naver.com','1999년9월9일','시','옷','프로젝트');

insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,member_addr1,member_addr2,member_addr3)values(
'users','users_06','테스트','010-1234-1111','zpokk@naver.com','2000.01.01','시','옷','프로젝트');

insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,member_addr1,member_addr2,member_addr3)values(
'users2','users_06','테스트','010-1234-1131','zpokk@naver.com','2000.01.01','시','옷','프로젝트');

insert into seeot_member(member_id,member_pw,member_name,member_phone,member_email,member_birth,member_addr1,member_addr2,member_addr3)values(
'users3','users_06','테스트','010-1234-1121','zpokk@naver.com','2000.01.01','시','옷','프로젝트');





-- board_seq 시퀀스 생성
CREATE SEQUENCE BOARD_SEQ
INCREMENT BY 1 
START WITH 1;

-- reply_seq 시퀀스 생성
CREATE SEQUENCE REPLY_SEQ
INCREMENT BY 1 
START WITH 1;

-- 게시판 테이블 생성 PK: board_no, FK: seeot_member의 member_id
CREATE TABLE SEEOT_BOARD(
    "MEMBER_ID" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
   "MEMBER_NAME" VARCHAR2(20 BYTE), 
   "BOARD_NO" NUMBER NOT NULL ENABLE, 
   "BOARD_TITLE" VARCHAR2(50 BYTE), 
   "BOARD_CONTENT" VARCHAR2(300 BYTE), 
   "BOARD_DATE" DATE DEFAULT sysdate, 
   "BOARD_QNATYPE" VARCHAR2(20 BYTE), 
   "BOARD_HIT" NUMBER DEFAULT 0, 
   "REPLY_COUNT" NUMBER DEFAULT 0, 
    CONSTRAINT "SEEOT_BOARD_PK" PRIMARY KEY ("BOARD_NO"),
     CONSTRAINT "SEEOT_BOARD_FK1" FOREIGN KEY ("MEMBER_ID")
        REFERENCES "SEEOT_MEMBER" ("MEMBER_ID") ENABLE
);

-- 게시판 첨부파일 관리 테이블 생성 FK: seeot_board의 board_no(원 게시물 삭제 시 파일도 삭제됨)
CREATE TABLE SEEOT_BOARD_FILE(
    "FILE_ORIGIN_NAME" VARCHAR2(100 BYTE), 
   "FILE_SAVE_NAME" VARCHAR2(100 BYTE), 
   "BOARD_NO" NUMBER NOT NULL ENABLE, 
    CONSTRAINT "FK_SEEOT_BOARD_FILE" FOREIGN KEY ("BOARD_NO")
        REFERENCES "SEEOT_BOARD" ("BOARD_NO") ON DELETE CASCADE ENABLE
);

-- 게시판 댓글 테이블 생성 FK1: seeot_member의 member FK2: seeot_board의 board_no(원 게시물 삭제 시 댓글도 삭제됨)
CREATE TABLE SEEOT_REPLY(
    "MEMBER_ID" VARCHAR2(20 BYTE), 
   "BOARD_NO" NUMBER NOT NULL ENABLE, 
   "REPLY_CONTENT" VARCHAR2(300 BYTE), 
   "MEMBER_NAME" VARCHAR2(20 BYTE), 
   "REPLY_NO" NUMBER, 
   "REPLY_DATE" DATE DEFAULT sysdate, 
    CONSTRAINT "FK_REPLY_MEMBER_ID" FOREIGN KEY ("MEMBER_ID")
        REFERENCES "SEEOT_MEMBER" ("MEMBER_ID") ENABLE, 
    CONSTRAINT "FK_SEEOT_REPLY_BOARD_NO" FOREIGN KEY ("BOARD_NO")
        REFERENCES "SEEOT_BOARD" ("BOARD_NO") ON DELETE CASCADE ENABLE
);

-----------------------------------------------------------------------
-- 게시판 샘플 데이터
INSERT into seeot_board(member_id, member_name, board_no, board_title, board_content, board_qnatype)
		VALUES('seeotuser', '시옷유저', board_seq.nextval, '테스트 제목', '테스트 컨텐츠', '배송');

INSERT into seeot_board(member_id, member_name, board_no, board_title, board_content, board_qnatype)
		VALUES('admin', '관리자', board_seq.nextval, '테스트 제목2', '테스트 컨텐츠2', '환불');

 INSERT INTO SEEOT_BOARD SELECT MEMBER_ID, MEMBER_NAME, BOARD_SEQ.NEXTVAL, BOARD_TITLE, BOARD_CONTENT, sysdate, BOARD_QNATYPE, BOARD_HIT, reply_count FROM SEEOT_BOARD;
 




-- 상품 테이블
CREATE TABLE product
(
    product_no           INT             NULL, 
    product_name         VARCHAR2(20)    NULL, 
    product_price        INT             NULL, 
    product_file         VARCHAR2(80)    NULL, 
    product_categorie    NUMBER          NULL, 
    product_date         DATE            NULL, 
    review_count        NUMBER          default '0'  NOT NULL, 
    product_rating       FLOAT           default '0'  NOT NULL, 
    product_content      VARCHAR2(300)    NULL, 
    PRIMARY KEY (product_no)
);

-- 상품 재고 테이블
CREATE TABLE product_management
(
    product_no       INT             NULL, 
    product_stack    INT             NULL, 
    product_size     NUMBER          NULL, 
    product_color    VARCHAR2(20)    NULL
);
ALTER TABLE product_management
    ADD CONSTRAINT FK_product_management_no FOREIGN KEY (product_no)
        REFERENCES product (product_no) ON DELETE CASCADE;
        
-----------------------------------------------------------------------
--01 티셔츠
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(10001, 'tshirt01', 7000, 'tshirt01.png', 1, '12/01/21', 'tshirt01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(10002, 'tshirt02', 13000, 'tshirt02.png', 1, '13/08/16', 'tshirt02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(10003, 'tshirt03', 16000, 'tshirt03.png', 1, '14/11/11', 'tshirt03_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(10004, 'tshirt04', 14000, 'tshirt04.png', 1, '15/01/03', 'tshirt04_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(10005, 'tshirt05', 7000, 'tshirt05.png', 1, '15/01/03', 'tshirt05_content.png');

--02 셔츠
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20001, 'shirt01', 8500, 'shirt01.png', 2, '12/01/13', 'shirt01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20002, 'shirt02', 5000, 'shirt02.png', 2, '12/05/26', 'shirt02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20003, 'shirt03', 10000, 'shirt03.png', 2, '13/08/11', 'shirt03_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20004, 'shirt04', 12000, 'shirt04.png', 2, '13/12/12', 'shirt04_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20005, 'shirt05', 7000, 'shirt05.png', 2, '14/01/03', 'shirt05_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20006, 'shirt06', 12000, 'shirt06.png', 2, '14/01/29', 'shirt06_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20007, 'shirt07', 14000, 'shirt07.png', 2, '15/08/27', 'shirt07_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20008, 'shirt08', 11000, 'shirt08.png', 2, '16/04/08', 'shirt08_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20009, 'shirt09', 12000, 'shirt09.png', 2, '17/10/30', 'shirt09_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20010, 'shirt10', 17000, 'shirt10.png', 2, '18/03/07', 'shirt10_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(20011, 'shirt11', 8000, 'shirt11.png', 2, '20/02/05', 'shirt11_content.png');

--03 가디건
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(30001, 'cardigan01', 32000, 'cardigan01.png', 3, '15/02/05', 'cardigan01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(30002, 'cardigan02', 24000, 'cardigan02.png', 3, '18/06/05', 'cardigan02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(30003, 'cardigan03', 56000, 'cardigan03.png', 3, '21/01/03', 'cardigan03_content.png');

--04 자켓
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40001, 'jacket01', 56000, 'jacket01.png', 4, '12/01/19', 'jacket01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40002, 'jacket02', 37000, 'jacket02.png', 4, '14/12/25', 'jacket02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40003, 'jacket03', 62000, 'jacket03.png', 4, '16/04/01', 'jacket03_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40004, 'jacket04', 46000, 'jacket04.png', 4, '16/07/16', 'jacket04_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40005, 'jacket05', 30000, 'jacket05.png', 4, '17/11/27', 'jacket05_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40006, 'jacket06', 27000, 'jacket06.png', 4, '18/02/05', 'jacket06_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40007, 'jacket07', 74000, 'jacket07.png', 4, '18/05/05', 'jacket07_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40008, 'jacket08', 42000, 'jacket08.png', 4, '19/06/07', 'jacket08_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40009, 'jacket09', 78000, 'jacket09.png', 4, '19/12/25', 'jacket09_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40010, 'jacket10', 61000, 'jacket10.png', 4, '20/08/03', 'jacket10_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40011, 'jacket11', 34000, 'jacket11.png', 4, '21/09/13', 'jacket11_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40012, 'jacket12', 24000, 'jacket12.png', 4, '21/10/27', 'jacket12_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40013, 'jacket13', 41000, 'jacket13.png', 4, '22/08/03', 'jacket13_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(40014, 'jacket14', 36000, 'jacket14.png', 4, '22/09/10', 'jacket14_content.png');

--05 코트
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(50001, 'coat01', 120000, 'coat01.png', 5, '20/02/17', 'coat01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(50002, 'coat02', 89000, 'coat02.png', 5, '21/09/20', 'coat02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(50003, 'coat03', 76000, 'coat03.png', 5, '22/04/01', 'coat03_content.png');

--06 하의
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60001, 'pants01', 10000, 'pants01.png', 6, '12/01/01', 'pants01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60002, 'pants02', 7000, 'pants02.png', 6, '12/06/14', 'pants02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60003, 'pants03', 8000, 'pants03.png', 6, '13/04/14', 'pants03_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60004, 'pants04', 10000, 'pants04.png', 6, '13/08/12', 'pants04_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60005, 'pants05', 14000, 'pants05.png', 6, '13/12/17', 'pants05_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60006, 'pants06', 12000, 'pants06.png', 6, '14/06/27', 'pants06_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60007, 'pants07', 10000, 'pants07.png', 6, '14/08/11', 'pants07_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60008, 'pants08', 11000, 'pants08.png', 6, '15/04/01', 'pants08_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60009, 'pants09', 21000, 'pants09.png', 6, '16/12/25', 'pants09_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60010, 'pants10', 8000, 'pants10.png', 6, '17/02/19', 'pants10_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60011, 'pants11', 14000, 'pants11.png', 6, '18/07/11', 'pants11_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60012, 'pants12', 9000, 'pants12.png', 6, '20/07/24', 'pants12_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60013, 'pants13', 16000, 'pants13.png', 6, '22/02/19', 'pants13_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(60014, 'pants14', 24000, 'pants14.png', 6, '22/09/22', 'pants14_content.png');

--07 신발
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70001, 'shoes01', 27000, 'shoes01.png', 7, '12/09/10', 'shoes01_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70002, 'shoes02', 46000, 'shoes02.png', 7, '12/12/29', 'shoes02_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70003, 'shoes03', 52000, 'shoes03.png', 7, '14/04/09', 'shoes03_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70004, 'shoes04', 40000, 'shoes04.png', 7, '15/01/01', 'shoes04_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70005, 'shoes05', 38000, 'shoes05.png', 7, '19/09/11', 'shoes05_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70006, 'shoes06', 38000, 'shoes06.png', 7, '20/05/05', 'shoes06_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70007, 'shoes07', 47000, 'shoes07.png', 7, '21/04/10', 'shoes07_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70008, 'shoes08', 87000, 'shoes08.png', 7, '21/12/01', 'shoes08_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70009, 'shoes09', 24000, 'shoes09.png', 7, '22/01/17', 'shoes09_content.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(70010, 'shoes10', 36000, 'shoes10.png', 7, '22/09/26', 'shoes10_content.png');

 --페이징 데이터
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80001, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80002, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80003, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80004, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80005, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80006, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80007, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80008, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80009, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80010, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80011, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80012, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80013, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80014, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80015, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80016, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80017, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80018, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80019, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80020, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80021, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80022, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80023, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80024, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80025, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80026, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80027, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80028, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80029, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80030, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80031, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80032, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80033, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80034, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80035, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80036, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80037, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80038, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80039, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80040, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80041, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80042, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80043, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80044, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80045, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80046, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80047, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80048, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80049, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80050, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80051, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80052, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80053, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80054, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80055, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80056, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80057, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80058, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80059, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80060, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80061, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80062, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80063, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80064, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80065, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
insert into product(product_no, product_name, product_price, product_file, product_categorie, product_date, product_content) values(80066, 'pagingProduct', 49000, 'pagingimg.png', 8, '01/01/01', 'paging_contentimg.png');
 
 -- 재고: 1티셔츠, 2셔츠, 3가디건, 4자켓, 5코트, 6하의, 7신발
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'RED', 100, 10);
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'BLUE', 105, 25);
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'BLACK', 95, 100);
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'BLACK', 100, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'BLUE', 95, 15);
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'RED', 105, 40);
insert into product_management(product_no, product_color, product_size, product_stack) values(10001, 'BLACK', 105, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(10003, 'BLUE', 105, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(10004, 'YELLOW', 110, 30);
insert into product_management(product_no, product_color, product_size, product_stack) values(10005, 'WHTIE', 100, 50);
insert into product_management(product_no, product_color, product_size, product_stack) values(20002, 'WHITE', 100, 70);
insert into product_management(product_no, product_color, product_size, product_stack) values(20004, 'BLUE', 110, 30);
insert into product_management(product_no, product_color, product_size, product_stack) values(30003, 'GRAY', 110, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(50001, 'BLACK', 115, 10);
insert into product_management(product_no, product_color, product_size, product_stack) values(40001, 'BLACK', 110, 15);
insert into product_management(product_no, product_color, product_size, product_stack) values(40002, 'BLACK', 115, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(40008, 'GRAY', 105, 10);
insert into product_management(product_no, product_color, product_size, product_stack) values(40012, 'BLUE', 100, 30);
insert into product_management(product_no, product_color, product_size, product_stack) values(60001, 'BROWN', 30, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(60002, 'GRAY', 34, 30);
insert into product_management(product_no, product_color, product_size, product_stack) values(60003, 'BROWN', 32, 40);
insert into product_management(product_no, product_color, product_size, product_stack) values(60004, 'WHITE', 30, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(60007, 'BLACK', 36, 40);
insert into product_management(product_no, product_color, product_size, product_stack) values(70001, 'WHITE', 260, 20);
insert into product_management(product_no, product_color, product_size, product_stack) values(70003, 'WHITE', 270, 40);
insert into product_management(product_no, product_color, product_size, product_stack) values(70004, 'WHITE', 265, 30);
insert into product_management(product_no, product_color, product_size, product_stack) values(70005, 'BLACK', 270, 10);
insert into product_management(product_no, product_color, product_size, product_stack) values(70007, 'BLUE', 250, 25);
insert into product_management(product_no, product_color, product_size, product_stack) values(70008, 'BROWN', 265, 15);





--장바구니 테이블
CREATE TABLE cart(
    product_no       INT, 
    cartnum          INT, 
    member_id        VARCHAR2(20), 
    product_name     VARCHAR2(20), 
    product_price    INT, 
    product_file     VARCHAR2(80), 
    order_stack      VARCHAR2(20), 
    product_size     NUMBER, 
    product_color    VARCHAR2(20)    
);
create sequence cartnum_seq;
ALTER TABLE cart
    ADD CONSTRAINT FK_cart_product_product_no FOREIGN KEY (product_no)
        REFERENCES product (product_no) ON DELETE CASCADE; 
ALTER TABLE cart
    ADD CONSTRAINT FK_cart_seeot_member_member_id FOREIGN KEY (member_id)
        REFERENCES seeot_member (member_id) ON DELETE CASCADE; 
        
--상품 주문테이블 
CREATE TABLE goods_order(
    order_no         VARCHAR2(20), 
    order_price      INT, 
    order_addr1      VARCHAR2(100), 
    order_addr2      VARCHAR2(100),
    product_name     VARCHAR2(20), 
    product_no       INT, 
    product_file     VARCHAR2(80), 
    order_date       DATE default sysdate, 
    product_price    INT, 
    order_stack      NUMBER, 
    member_id        VARCHAR2(20),
    product_size     NUMBER, 
    product_color    VARCHAR2(20),
    order_status     INT default 1
);

ALTER TABLE goods_order
    ADD CONSTRAINT FK_order_member_member_id FOREIGN KEY (member_id)
        REFERENCES seeot_member (member_id) ON DELETE CASCADE;
ALTER TABLE goods_order
    ADD CONSTRAINT FK_order_product_product_no FOREIGN KEY (product_no)
        REFERENCES product (product_no) ON DELETE CASCADE;

--주문 내역테이블
CREATE TABLE order_history(    
    himember_id        VARCHAR2(20), 
    hiorder_no         NUMBER, 
    hiproduct_no       INT, 
    hiproduct_name     VARCHAR2(20), 
    hiproduct_size     NUMBER, 
    hiproduct_color    VARCHAR2(20), 
    hiproduct_file     VARCHAR2(80), 
    hiorder_addr1      VARCHAR2(100), 
    hiorder_addr2      VARCHAR2(100), 
    hiorder_price      INT, 
    hiorder_date       DATE default sysdate, 
    hiorder_status     NUMBER, 
    hiproduct_price    INT, 
    hiorder_stack      NUMBER 
);
    
--주문 취소테이블
create table cancel(
    member_id varchar(20),
    order_no varchar(20),
    reason varchar(300)
);
-----------------------------------------------------------------------
--goods_order테이블 샘플데이터
--장바구니테이블 데이터1
insert into cart(product_no,member_id,product_name,product_price,product_file,order_stack,cartnum,product_size,product_color)
            values(10001,'seeotuser','tshirt01',7000,'tshirt01.png',1,cartnum_seq.nextval,105,'BLUE');
--장바구니테이블 데이터2
insert into cart(product_no,member_id,product_name,product_price,product_file,order_stack,cartnum,product_size,product_color)
            values(30003,'seeotuser','cardigan03',56000,'cardigan03.png',1,cartnum_seq.nextval,110,'GRAY');
--장바구니테이블 데이터3
insert into cart(product_no,member_id,product_name,product_price,product_file,order_stack,cartnum,product_size,product_color)
            values(10005,'seeotuser','tshirt05',7000,'tshirt05.png',1,cartnum_seq.nextval,100,'WHTIE');
--장바구니테이블 데이터4
insert into cart(product_no,member_id,product_name,product_price,product_file,order_stack,cartnum,product_size,product_color)
            values(10004,'seeotuser','tshirt04',14000,'tshirt04.png',4,cartnum_seq.nextval,110,'YELLOW');

-- 주문테이블 데이터1
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209291811',100,'시','옷프로젝트','cardigan03',30003,'/seeot/product/download?productFile=cardigan03.png',56000,1,'seeotuser',110,'gray',1);
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209291811',100,'시','옷프로젝트','tshirt04',10004,'/seeot/product/download?productFile=tshirt04.png',56000,4,'seeotuser',110,'YELLOW',1);
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209291811',100,'시','옷프로젝트','tshirt05',10005,'/seeot/product/download?productFile=tshirt05.png',7000,1,'seeotuser',100,'WHTIE',1);
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209291811',100,'시','옷프로젝트','tshirt03',10003,'/seeot/product/download?productFile=tshirt03.png',64000,4,'seeotuser',105,'BLUE',1);
            
--  주문테이블 데이터2           
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209298432',100,'시','옷프로젝트','jacket01',40001,'/seeot/product/download?productFile=jacket01.png',56000,1,'seeotuser',110,'BLACK',1);
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209298432',100,'시','옷프로젝트','jacket02',40002,'/seeot/product/download?productFile=jacket02.png',56000,1,'seeotuser',115,'BLACK',1);

--  주문테이블 데이터3           
insert into goods_order(order_no,order_price,order_addr1,order_addr2,product_name,product_no,product_file,product_price,order_stack,member_id,product_size,product_color,order_status) 
            values('202209291231',100,'시','옷프로젝트','pants01',60001,'/seeot/product/download?productFile=pants01.png',50000,5,'seeotuser',30,'BROWN',1);

-- 주문내역테이블 데이터1            
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209291811',30003,'cardigan03',110,'gray','/seeot/product/download?productFile=cardigan03.png','시','옷프로젝트',sysdate,1,56000,1);
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209291811',10004,'tshirt04',110,'YELLOW','/seeot/product/download?productFile=tshirt04.png','시','옷프로젝트',sysdate,1,56000,4);
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209291811',10005,'tshirt05',100,'WHTIE','/seeot/product/download?productFile=tshirt05.png','시','옷프로젝트',sysdate,1,7000,1);
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209291811',10003,'tshirt03',105,'BLUE','/seeot/product/download?productFile=tshirt03.png','시','옷프로젝트',sysdate,1,64000,4);

-- 주문내역테이블 데이터2            
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209298432',40001,'jacket01',110,'BLACK','/seeot/product/download?productFile=jacket01.png','시','옷프로젝트',sysdate,1,56000,1);            
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209298432',40002,'jacket02',115,'BLACK','/seeot/product/download?productFile=jacket02.png','시','옷프로젝트',sysdate,1,56000,1);    
            
-- 주문내역테이블 데이터3            
insert into order_history(himember_id,hiorder_no,hiproduct_no,hiproduct_name,hiproduct_size,hiproduct_color,hiproduct_file,hiorder_addr1,hiorder_addr2,hiorder_date,hiorder_status,hiproduct_price,hiorder_stack)
            values('seeotuser','202209291231',60001,'pants01',30,'BROWN','/seeot/product/download?productFile=pants01.png','시','옷프로젝트',sysdate,1,50000,5);        





create table seeot_review(
reviewDate date default sysdate,
memberId varchar2(20),
productNo int,
reviewFile varchar(100) default 'nan',
reviewStar number default '5',
reviewContent varchar(300),
reviewNo number,
foreign KEY(memberId)
 references seeot_member (member_id),
 foreign KEY(productNo)
 references product (product_no)
);
create sequence reviewNo start with 1 increment by 1;

-----------------------------------------------------------------------
insert into seeot_review (
reviewDate ,memberId, productNo, reviewFile, reviewStar,reviewContent, reviewNo )
 values(sysdate, 'seeotuser','10002','nan',5,'핏이 너무 이뻐요', REVIEWNO.nextval);
 
 insert into seeot_review (
reviewDate ,memberId, productNo, reviewFile, reviewStar,reviewContent, reviewNo )
 values(sysdate, 'seeotuser','10002','nan',1,'얼룩이 묻어 있어요', REVIEWNO.nextval);
 
 insert into seeot_review (
reviewDate ,memberId, productNo, reviewFile, reviewStar,reviewContent, reviewNo )
 values(sysdate, 'seeotuser','10001','nan', 1,'상품이 마음에 안드네요', REVIEWNO.nextval);
 
 insert into seeot_review (
reviewDate ,memberId, productNo, reviewFile, reviewStar,reviewContent, reviewNo )
 values(sysdate, 'seeotuser','10001','nan',5,'색도 이쁘고 마음에 들어서 좋은거같아여', REVIEWNO.nextval);
 
 insert into seeot_review (
reviewDate ,memberId, productNo, reviewFile, reviewStar,reviewContent, reviewNo )
 values(sysdate, 'seeotuser','10001','nan',5,'아들이 잘 입고 다니네여 아이도 좋아하고 마음에 듭니다', REVIEWNO.nextval);
 
insert into seeot_review (
reviewDate ,memberId, productNo, reviewFile, reviewStar,reviewContent, reviewNo )
values(sysdate, 'seeotuser','10002','nan',3,'핏이 너무 이뻐요 핏이 너무 이뻐요 핏이 너무 이뻐요 핏이 너무 이뻐요 핏이 너무 이뻐요핏이 너무 이뻐요  ', REVIEWNO.nextval);
 
update product set product_rating = 16 ,review_count = 3 where product_no = 10001;
update product set product_rating = 9 ,review_count = 3 where product_no = 10002;

    


 
 commit;