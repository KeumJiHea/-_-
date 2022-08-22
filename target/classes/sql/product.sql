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
    PRIMARY KEY (product_no)
);