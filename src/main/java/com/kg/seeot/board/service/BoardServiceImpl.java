package com.kg.seeot.board.service;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.BoardDTO;
import com.kg.seeot.board.dto.FileDTO;
import com.kg.seeot.mybatis.board.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper mapper;
	@Autowired
	BoardFileService bfs;

	public void boardList(Model model) {
		model.addAttribute("boardList", mapper.boardList());
	}

	public void boardContentView(int boardNo, Model model) {
		model.addAttribute("dto", mapper.boardContentView(boardNo));
		model.addAttribute("fileList", mapper.boardFileView(boardNo));
	}

	public String delete(String memberId, String boardFile, HttpServletRequest request) {
		String result = mapper.delete(memberId);
		int resultnum = 0;
		if (result.equals("1")) {
			resultnum = 1;
		}
		String msg, url;
		if (resultnum == 1) {
			bfs.deleteImage(boardFile);
			msg = "성공적으로 삭제 되었습니다!!!";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "삭제 실패!!!";
			url = request.getContextPath() + "/board/boardContentView?memberId=" + memberId;
		}
		return bfs.getMessage(msg, url);
	}

	public String writeSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		BoardDTO dto = new BoardDTO();

		if(mul.getParameter("memberId").equals("")) { //비회원 처리
			dto.setMemberId("비회원");
		}else {
			dto.setMemberId(mul.getParameter("memberId"));
		}
		
		dto.setMemberName(mul.getParameter("memberName"));
		dto.setBoardTitle(mul.getParameter("boardTitle"));
		dto.setBoardContent(mul.getParameter("boardContent"));
		dto.setBoardQnAType(mul.getParameter("boardQnAType"));
		dto.setBoardStatus("미처리");
		
		int result = 0;
		result = mapper.writeSave(dto);
		
		System.out.println("boardNo: " + dto.getBoardNo());
		
		Iterator<String> itr = mul.getFileNames();
		
		while(itr.hasNext()) {
			List<MultipartFile> fileList = mul.getFiles(itr.next());
			if(fileList.size()>0) {
				for(MultipartFile file : fileList) {
					System.out.println("파일아" + file.getOriginalFilename());
					FileDTO fdto = bfs.saveFile(file);
					fdto.setBoardNo(dto.getBoardNo());
					mapper.writeFileSave(fdto);
				}
			}

		}
	
		String msg, url;
		if (result == 1) {
			msg = "새글이 추가되었습니다!!";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "문제가 발생했습니다";
			url = request.getContextPath() + "/board/writeForm";
		}
		return bfs.getMessage(msg, url);
	}
	
	public String boardModify(MultipartHttpServletRequest mul, HttpServletRequest request) {
		int boardNo = Integer.parseInt(mul.getParameter("boardNo"));
		System.out.println(boardNo);
		
		BoardDTO dto = new BoardDTO();
		dto.setMemberName(mul.getParameter("memberName"));
		dto.setBoardTitle(mul.getParameter("boardTitle"));
		dto.setBoardContent(mul.getParameter("boardContent"));
		dto.setBoardQnAType(mul.getParameter("boardQnAType"));
		
		System.out.println(mul.getParameter("delete_image"));
		
//		Iterator<String> itr = mul.getFileNames();
//		
//		while(itr.hasNext()) {
//			List<MultipartFile> fileList = mul.getFiles(itr.next());
//			if(fileList.size()>0) {
//				for(MultipartFile file : fileList) {
//					System.out.println("파일아" + file.getOriginalFilename());
//					FileDTO fdto = bfs.saveFile(file);
//					fdto.setBoardNo(dto.getBoardNo());
//					mapper.writeFileSave(fdto);
//				}
//			}
//
//		}
		
		int result = 0;
		//result = mapper.writeSave(dto);
		
		String msg, url;
		if (result == 1) {
			msg = "새글이 추가되었습니다!!";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "문제가 발생했습니다";
			url = request.getContextPath() + "/board/writeForm";
		}
		return bfs.getMessage(msg, url);
	}
}
