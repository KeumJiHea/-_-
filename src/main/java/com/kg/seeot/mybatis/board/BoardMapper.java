package com.kg.seeot.mybatis.board;

import java.util.List;
import com.kg.seeot.board.dto.BoardDTO;
import com.kg.seeot.board.dto.FileDTO;

public interface BoardMapper {
	public List<BoardDTO> boardList();
	public int selectBoardCount();
	public BoardDTO boardContentView(int boardNo);
	public List<FileDTO> boardFileView(int boardNo);
	public int writeSave(BoardDTO dto);
	public int writeFileSave(FileDTO fdto);
	public String delete(String memberId);
}
