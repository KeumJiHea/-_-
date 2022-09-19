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

	public void getBoard(int boardNo, Model model) {
		model.addAttribute("dto", mapper.getBoard(boardNo));
		model.addAttribute("fileList", mapper.getBoardFile(boardNo));
	}

	public String boardWrite(MultipartHttpServletRequest mul, HttpServletRequest request) {
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
		result = mapper.boardWrite(dto);
		
		System.out.println("boardNo: " + dto.getBoardNo());
		
		Iterator<String> itr = mul.getFileNames();
		
		while(itr.hasNext()) {
			List<MultipartFile> fileList = mul.getFiles(itr.next());
			if(fileList.size()>0) {
				for(MultipartFile file : fileList) {
					System.out.println("파일아" + file.getOriginalFilename());
					FileDTO fdto = bfs.saveFile(file);
					fdto.setBoardNo(dto.getBoardNo());
					mapper.boardFileWrite(fdto);
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
		dto.setBoardNo(boardNo);
		
		//삭제할 이미지의 저장된 이름 가져오기
		String[] deleteImages = mul.getParameterValues("delete_image");
		//String 배열로 가져오기 때문에 순회하며 이름 뽑아옴
		if(deleteImages != null) {
			for(String image : deleteImages) {
				System.out.println(image);
				bfs.deleteImage(image);
				mapper.deleteImage(image);
			}
		}
		
		Iterator<String> itr = mul.getFileNames();
		
		while(itr.hasNext()) {
			List<MultipartFile> fileList = mul.getFiles(itr.next());
			if(fileList.size()>0) {
				for(MultipartFile file : fileList) {
					System.out.println("추가 파일: " + file.getOriginalFilename());
					FileDTO fdto = bfs.saveFile(file);
					fdto.setBoardNo(dto.getBoardNo());
					mapper.boardFileWrite(fdto);
				}
			}

		}
		
		int result = 0;
		result = mapper.boardModify(dto);
		
		String msg, url;
		if (result == 1) {
			msg = "새글이 추가되었습니다!!";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "문제가 발생했습니다";
			url = request.getContextPath() + "/board/modifyForm?boardNo="+boardNo;
		}
		return bfs.getMessage(msg, url);
	}
	
	public String delete(int boardNo, HttpServletRequest request) {
		List<FileDTO> fileList = mapper.getBoardFile(boardNo);
		int result = mapper.delete(boardNo);
			
		String msg, url;
		if (result == 1) {
			if(fileList != null) {
				for(FileDTO file : fileList) {
					String deleteImage = file.getFileSaveName();
					bfs.deleteImage(deleteImage);
				}
			}
			msg = "성공적으로 삭제 되었습니다!!!";
			url = request.getContextPath() + "/board/boardList";
		} else {
			msg = "삭제 실패!!!";
			url = request.getContextPath() + "/board/getBoard?boardNo=" + boardNo;
		}
		return bfs.getMessage(msg, url);
	}
}
