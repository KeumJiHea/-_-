package com.kg.seeot.mybatis.board;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.board.dto.BoardDTO;
import com.kg.seeot.board.dto.FileDTO;
import com.kg.seeot.board.dto.ReplyDTO;

public interface BoardMapper {
	public ArrayList<BoardDTO> boardList(@Param("startPage") int startPage,@Param("endPage") int endPage); //게시글 리스트
	public BoardDTO getBoard(int boardNo); //게시글 하나 가져오기
	public ArrayList<FileDTO> getBoardFile(int boardNo); //게시글에 따른 파일 가져오기
	public int boardWrite(BoardDTO dto); //게시글 저장
	public int boardFileWrite(FileDTO fdto); //게시글에 딸린 파일 저장
	public int boardModify(BoardDTO dto); //게시글 수정
	public int boardFileModify(FileDTO fdto); //게시글에 딸린 파일 수정
	public int delete(int boardNo); //게시글 삭제
	public void deleteImage(String image); //게시글에 딸린 파일 삭제
	public Integer boardCount(); //페이징용 게시글 수 count
	public void addReply(Map<String, String> map); //게시글 댓글 작성
	public ArrayList<ReplyDTO> getReplyList(int boardNo); //게시글 댓글 가져오기
	public int deleteReply(int replyNo); //댓글 삭제
	public int modifyReply(@Param("replyNo") int replyNo, @Param("updateContent") String updateContent); //댓글 수정
}
