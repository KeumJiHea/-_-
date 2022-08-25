create table seeot_reply(
member_id varchar2(20),
reply_group number(10),
reply_title varchar2(300),
reply_content varchar2(300)
);

ALTER TABLE seeot_reply
ADD CONSTRAINT fk_reply_member_id foreign KEY(member_id)
references seeot_member (member_id);