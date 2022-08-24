CREATE TABLE product(
    product_no           INT             NOT NULL, 
    product_name         VARCHAR2(20)    NOT NULL, 
    product_stack        INT             NOT NULL, 
    product_price        INT             NOT NULL, 
    product_file         VARCHAR2(80)    NOT NULL, 
    product_categorie    NUMBER          NOT NULL, 
    product_date         DATE            NOT NULL, 
    review_count         NUMBER          default '0'  NOT NULL, 
    product_rating       FLOAT           default '0'  NOT NULL, 
    product_size         NUMBER          NOT NULL, 
    product_color        VARCHAR2(20)    NOT NULL,
    product_content		 VARCHAR2(300)	 NOT NULL,
    PRIMARY KEY (product_no)
);

--상품번호, 이름, 재고수량, 상품가격, 상품이미지, 상품카테고리, 상품등록일, 리뷰수, 상품별점, 상품사이즈, 상품색, 상품 설명
--1
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(10001, 'SATUR ', 200, 130000, '20220823_1_10001.jpg', 1, sysdate, 0, 0, 105, 'GRAY', '상품 설명 추가');

--2
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(10002, 'SUARE', 200, 56000, '20220823_1_10002.jpg', 1, sysdate, 0, 0, 95, 'GREEN', '상품 설명 추가');

--3
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(10003, 'BOUTIQUE', 200, 96000, '20220823_1_10003.jpg', 1, sysdate, 0, 0, 110, 'WHITE', '상품 설명 추가');

--4
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(20001, ' INPKOPS', 100, 50000, '20220823_2_20001.jpg', 2, sysdate, 0, 0, 90, 'IVORY', '상품 설명 추가');

--5
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(20002, 'BADBLOOD', 100, 127000, '20220823_2_20002.jpg', 2, sysdate, 0, 0, 100, 'NAVY', '상품 설명 추가');

--6
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(20003, 'MINIDRESS', 100, 159000, '20220823_2_20003.jpg', 2, sysdate, 0, 0, 105, 'BLUE', '상품 설명 추가');

--7
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(30001, 'MMEFMDP112', 300, 82000, '20220823_3_30001.jpg', 3, sysdate, 0, 0, 85, 'BLUE', '상품 설명 추가');

--8
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(30002, 'SEMEWIDEBANDINGPANTS', 300, 27000, '20220823_3_30002.jpg', 3, sysdate, 0, 0, 80, 'BLACK', '상품 설명 추가');

--9
insert into product(
    product_no, product_name, product_stack, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_size, product_color, product_content) 
        VALUES(30003, 'HIMALAYAJEANS', 300, 53000, '20220823_3_30003.jpg', 3, sysdate, 0, 0, 75, 'IVORY', '상품 설명 추가');
