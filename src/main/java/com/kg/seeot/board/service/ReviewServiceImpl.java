package com.kg.seeot.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.ReviewDTO;
import com.kg.seeot.mybatis.board.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired ReviewMapper mapper;
	
	public void reviewList(Model model) {
		model.addAttribute("reviewList", mapper.reviewList());
	}
	
	public void addReply( Map<String, String>map, String memberId) {
		map.put("memberId", memberId);
		mapper.addReply( map );
	}
	/*
	public String writeSave(MultipartHttpServletRequest mul,
			HttpServletRequest request) {
		ReviewDTO dto = new ReviewDTO();
		dto.setMemberId(mul.getParameter("memberId"));
		dto.setReviewContent(mul.getParameter("reviewContent"));
		dto.setReviewStar(mul.getParameter("reviewStar"));
		//dto.setReviewDate(mul.getParameter("reviewDate"));
		dto.setProductNo(mul.getParameter("productNo");
		
		//dto.setTitle( mul.getParameter("title"));
		//dto.setContent( mul.getParameter("content"));
		//dto.setId( mul.getParameter("id"));
		
		MultipartFile file = mul.getFile("reviewFile");
		if( file.getSize() != 0) {
			dto.setReviewFile( bfs.saveFile(file) );
		}else {
			dto.setReviewFile("nan");
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
*/
}
