package com.kg.seeot.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.BoardDTO;
import com.kg.seeot.mybatis.board.BoardMapper;



@Service
public class BoardServiceImpl implements BoardService {
	@Autowired BoardMapper mapper;
	@Autowired BoardFileService bfs;
	public void boardList(Model model) {
		model.addAttribute("boardList", mapper.boardList());
	}
	
	public void boardContentView(String memberId, Model model) { 
		model.addAttribute("dto", mapper.boardContentView(memberId));
	}
	
	public String writeSave(MultipartHttpServletRequest mul,HttpServletRequest request) {
		BoardDTO dto = new BoardDTO();
		dto.setBoardTitle( mul.getParameter("title"));
		dto.setBoardContent( mul.getParameter("content"));
		//dto.setBoardNo(mul.getParameter("boardno"));
		
		MultipartFile file = mul.getFile("boardFile");
		if( file.getSize() != 0) {
			dto.setBoardFile(bfs.saveFile(file));
		}else {
			dto.setBoardFile("nan");
		}
		int result = 0;
		result = mapper.writeSave( dto );
		
		String msg, url;
		if( result == 1) {
			msg = "새글이 추가되었습니다!!";
			url = request.getContextPath()
					+"/board/boardAllList";
		}else {
			msg = "문제가 발생했습니다";
			url = request.getContextPath()
					+ "/board/writeForm";
		}
		return bfs.getMessage(msg, url);
	}
}
