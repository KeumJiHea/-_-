CREATE TABLE order_history(    
    himember_id        VARCHAR2(20)     NOT NULL, 
    hiorder_no         INT              NOT NULL, 
    hiproduct_no       INT              NOT NULL, 
    hiproduct_name     VARCHAR2(20)     NOT NULL, 
    hiproduct_size     NUMBER           NOT NULL, 
    hiproduct_color    VARCHAR2(20)     NOT NULL, 
    hiproduct_file     VARCHAR2(80)     NOT NULL, 
    hiorder_addr1      VARCHAR2(100)    NOT NULL, 
    hiorder_addr2      VARCHAR2(100)    NOT NULL, 
    hiorder_addr3      VARCHAR2(100)    NOT NULL, 
    hiorder_price      INT              NOT NULL, 
    hiorder_date       DATE             NOT NULL, 
    hiorder_status     NUMBER           NOT NULL, 
    hiproduct_price    INT              NOT NULL, 
    hiorder_stack      NUMBER           NOT NULL, 
    PRIMARY KEY (himember_id, hiorder_no, hiproduct_no)
);