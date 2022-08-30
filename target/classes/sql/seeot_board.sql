create table seeot_board(
member_id varchar2(20) primary key,
member_name varchar2(20),
board_no int,
board_title varchar(50),
board_content varchar(300),
board_file varchar(100) default 'nan',
board_date date default sysdate,
board_group int,
board_indent int
);

create sequence board_seq;

ALTER TABLE seeot_board
ADD CONSTRAINT fk_board_member_id foreign KEY(member_id)
references seeot_member (member_id);