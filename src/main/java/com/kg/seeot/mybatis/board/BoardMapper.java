package com.kg.seeot.mybatis.board;

import java.util.List;
import com.kg.seeot.board.dto.BoardDTO;
import com.kg.seeot.board.dto.FileDTO;

public interface BoardMapper {
	public List<BoardDTO> boardList(); //게시글 리스트
	public BoardDTO getBoard(int boardNo); //게시글 하나 가져오기
	public List<FileDTO> getBoardFile(int boardNo); //게시글에 따른 파일 가져오기
	public int boardWrite(BoardDTO dto); //게시글 저장
	public int boardFileWrite(FileDTO fdto); //게시글에 딸린 파일 저장
	public int boardModify(BoardDTO dto); //게시글 수정
	public int boardFileModify(FileDTO fdto); //게시글에 딸린 파일 수정
	public int delete(int boardNo); //게시글 삭제
	public void deleteImage(String image); //게시글에 딸린 파일 삭제
}
