package com.kg.seeot.board.dto;

public class BoardDTO {
private String memberId, memberName, boardTitle, boardContent, boardFile,boardDate;
private int boardNo, boardGroup, boardIndent;
//1:1문의 게시판
public String getMemberId() { return memberId; }
public void setMemberId(String memberId) { this.memberId = memberId; }
public String getMember_name() { return memberName; }
public void setMember_name(String member_name) { this.memberName = memberName; }
public String getBoardTitle() { return boardTitle; }
public void setBoardTitle(String boardTitle) { this.boardTitle = boardTitle; }
public String getBoardContent() { return boardContent; }
public void setBoardContent(String boardContent) { this.boardContent = boardContent; }
public String getBoardFile() { return boardFile; }
public void setBoardFile(String boardFile) { this.boardFile = boardFile; }
public String getBoardDate() { return boardDate; }
public void setBoardDate(String boardDate) { this.boardDate = boardDate; }
public int getBoardNo() { return boardNo; }
public void setBoardNo(int boardNo) { this.boardNo = boardNo; }
public int getBoardGroup() { return boardGroup; }
public void setBoardGroup(int boardGroup) { this.boardGroup = boardGroup; }
public int getBoardIndent() { return boardIndent; }
public void setBoardIndent(int boardIndent) { this.boardIndent = boardIndent; }


}
