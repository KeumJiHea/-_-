CREATE TABLE goods_order(
    order_no         INT              NOT NULL, 
    order_price      INT              NOT NULL, 
    order_addr1      VARCHAR2(100)    NOT NULL, 
    order_addr2      VARCHAR2(100)    NOT NULL, 
    order_addr3      VARCHAR2(100)    NOT NULL, 
    product_name     VARCHAR2(20)     NOT NULL, 
    product_no       INT              NOT NULL, 
    product_file     VARCHAR2(80)     NOT NULL, 
    order_date       DATE             NOT NULL, 
    product_price    INT              NOT NULL, 
    order_stack      NUMBER           NOT NULL, 
    member_id        VARCHAR2(20)     NOT NULL, 
    PRIMARY KEY (order_no, product_no, member_id)
);
CREATE SEQUENCE order_SEQ
START WITH 100001
INCREMENT BY 1;

ALTER TABLE goods_order
    ADD CONSTRAINT FK_order_member_member_id FOREIGN KEY (member_id)
        REFERENCES seeot_member (member_id) ON DELETE CASCADE;
ALTER TABLE goods_order
    ADD CONSTRAINT FK_order_product_product_no FOREIGN KEY (product_no)
        REFERENCES product (product_no) ON DELETE CASCADE; 