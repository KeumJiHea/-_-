package com.kg.seeot.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.ReviewDTO;

public interface ReviewService {
	public void reviewList(Model model);
	//public String writeSave(MultipartHttpServletRequest mul,
	//		HttpServletRequest request);
	public void addReply(Map<String, String>map, String memberId);
	//public void addReview(ReviewDTO dto);
	public  List<ReviewDTO> getRepList(int productNo);
	
	 public void fileProcess(MultipartHttpServletRequest mul , int reviewStar
			 				,int productNo);
	

}
