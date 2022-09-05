package com.kg.seeot.mybatis.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.board.dto.BoardDTO;

public interface BoardMapper {
public List<BoardDTO> boardList();
public int selectBoardCount();
public BoardDTO boardContentView(String memberId);
public int writeSave( BoardDTO dto );
public String delete( String memberId );

}
