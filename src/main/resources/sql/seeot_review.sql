create table seeot_review(
review_date date default sysdate,
member_id varchar2(20),
product_no int,
review_file varchar(100) default 'nan',
review_star number default '1',
review_content varchar(300),
primary key(product_no,member_id)
);

ALTER TABLE seeot_review
ADD CONSTRAINT fk_review_member_id foreign KEY(member_id)
 references seeot_member (member_id);
 
ALTER TABLE seeot_review
ADD CONSTRAINT fk_review_product_no foreign KEY(product_no)
 references product (product_no);