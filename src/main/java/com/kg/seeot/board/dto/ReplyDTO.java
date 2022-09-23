package com.kg.seeot.board.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReplyDTO {
	private String memberId, replyContent, memberName, replyDate;
	private int boardNo, replyNo;
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Timestamp replyDate) {
		SimpleDateFormat s = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		this.replyDate = s.format(replyDate);
	}
}
