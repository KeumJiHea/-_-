CREATE TABLE cart(
    product_no       INT             NOT NULL, 
    cart_price       INT             NOT NULL, 
    member_id        VARCHAR2(20)    NOT NULL, 
    product_name     VARCHAR2(20)    NOT NULL, 
    product_price    INT             NOT NULL, 
    product_file     VARCHAR2(80)    NOT NULL, 
    order_stack      NUMBER          NOT NULL, 
     PRIMARY KEY (product_no, member_id)
);
ALTER TABLE cart
    ADD CONSTRAINT FK_cart_product_product_no FOREIGN KEY (product_no)
        REFERENCES product (product_no) ON DELETE CASCADE; 
ALTER TABLE cart
    ADD CONSTRAINT FK_cart_seeot_member_member_id FOREIGN KEY (member_id)
        REFERENCES seeot_member (member_id) ON DELETE CASCADE; 