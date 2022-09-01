CREATE TABLE product_management
(
    product_no       INT             NULL, 
    product_stack    INT             NULL, 
    product_size     NUMBER          NULL, 
    product_color    VARCHAR2(20)    NULL
);

ALTER TABLE product_management
    ADD CONSTRAINT FK_product_management_product_no_product_product_no FOREIGN KEY (product_no)
        REFERENCES product (product_no) ON DELETE CASCADE;
        
--상품번호, 남은재고수량, 상품사이즈, 상품색
--1
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(10001, 200, 95, 'GRAY');

--2
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(10002, 200, 100, 'GREEN');
	
--3
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(10003, 200, 110, 'WHITE');
	
--4
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(20001, 100, 90, 'IVORY');
	
--5
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(20002, 100, 100, 'NAVY');
	
--6
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(20003, 100, 105, 'BLUE');
	
--7
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(30001, 300, 80, 'BLUE');
	
--8
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(30002, 300, 85, 'BLACK');
	
--9
insert into product_management(
	product_no, product_stack, product_size, product_color)
		VALUES(30003, 300, 75, 'IVORY');