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
	
	public void boardModifyForm(String memberId, Model model) {
		model.addAttribute("dto", mapper.boardContentView(memberId));
	}
	
	public String delete(String memberId, String boardFile,
			HttpServletRequest request) {
		String result = mapper.delete( memberId );
		int resultnum=0; 
		if(result.equals("1")) {
			 resultnum = 1;
		}
		String msg, url;
		if(resultnum == 1) {
			bfs.deleteImage( boardFile );
			msg = "성공적으로 삭제 되었습니다!!!";
			url = request.getContextPath()+
					"/board/boardList";
		}else {
			msg="삭제 실패!!!";
			url = request.getContextPath()+
					"/board/boardContentView?memberId="+memberId;
		}
		return bfs.getMessage(msg, url);
	}
	
	
	
	
	
	public String writeSave(MultipartHttpServletRequest mul,HttpServletRequest request) {
		BoardDTO dto = new BoardDTO();
		dto.setMemberId(mul.getParameter("memberId"));
		dto.setBoardTitle( mul.getParameter("boardTitle"));
		dto.setBoardContent( mul.getParameter("boardContent"));
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
