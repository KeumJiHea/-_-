CREATE TABLE product
(
    product_no           INT             NULL, 
    product_name         VARCHAR2(20)    NULL, 
    product_price        INT             NULL, 
    product_file         VARCHAR2(80)    NULL, 
    product_categorie    NUMBER          NULL, 
    product_date         DATE            NULL, 
    revicew_count        NUMBER          default '0'  NOT NULL, 
    product_rating       FLOAT           default '0'  NOT NULL, 
    product_content      VARCHAR2(300)    NULL, 
    PRIMARY KEY (product_no)
);

--상품번호, 이름, 상품가격, 상품이미지, 상품설명, 상품카테고리, 상품등록일, 상품리뷰수, 상품별점
--1
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(10001, 'SATUR ', 130000, '20220823_1_10001.jpg', 1, sysdate, 0, 0, '10001번의 상품설명입니다');

--2
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content)  
        VALUES(10002, 'SUARE', 56000, '20220823_1_10002.jpg', 1, sysdate, 0, 0, '10002번의 상품설명입니다');

--3
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(10003, 'BOUTIQUE', 96000, '20220823_1_10003.jpg', 1, sysdate, 0, 0, '10003번의 상품설명입니다');

--4
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(20001, ' INPKOPS', 50000, '20220823_2_20001.jpg', 2, sysdate, 0, 0, '20001번의 상품설명입니다');

--5
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(20002, 'BADBLOOD', 127000, '20220823_2_20002.jpg', 2, sysdate, 0, 0, '20002번의 상품설명입니다');

--6
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(20003, 'MINIDRESS', 159000, '20220823_2_20003.jpg', 2, sysdate, 0, 0, '20003번의 상품설명입니다');

--7
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(30001, 'MMEFMDP112', 82000, '20220823_3_30001.jpg', 3, sysdate, 0, 0, '30001번의 상품설명입니다');

--8
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content)  
        VALUES(30002, 'SEMEWIDEBANDINGPANTS', 27000, '20220823_3_30002.jpg', 3, sysdate, 0, 0, '30002번의 상품설명입니다');

--9
insert into product(
    product_no, product_name, product_price, product_file, product_categorie, 
    product_date, review_count, product_rating, product_content) 
        VALUES(30003, 'HIMALAYAJEANS', 53000, '20220823_3_30003.jpg', 3, sysdate, 0, 0, '30003번의 상품설명입니다');
