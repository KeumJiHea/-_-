package com.kg.seeot.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ReviewService {
	public void reviewList(Model model);
	//public String writeSave(MultipartHttpServletRequest mul,
	//		HttpServletRequest request);
	public void addReply(Map<String, String>map, String memberId);
	public void addReview(Map<String,Object> map, int reviewStar);
}
