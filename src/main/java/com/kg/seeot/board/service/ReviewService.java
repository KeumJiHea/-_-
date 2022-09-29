package com.kg.seeot.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.ReviewDTO;

public interface ReviewService {
	public void reviewList(Model model);
	public void reviewMore(Model model, int productNo);
	
	public void addReply(Map<String, String>map, String memberId);

	public  List<ReviewDTO> getRepList(Model model,int productNo , int num);
	public  List<ReviewDTO> getRepList1(int productNo);
	
	 public void fileProcess(MultipartHttpServletRequest mul , int reviewStar
			 				,int productNo);
	
	 public void delete(int reviewNo,int productNo,int reviewStar);
	 public String modify(MultipartHttpServletRequest mul,
				HttpServletRequest request);
	 public void modify_form(int reviewNo,Model model);
	 
	 public ReviewDTO saveFile(MultipartFile file);
	 public String getMessage(String msg, String url);
	 public void productModify(int reviewNo);
	 
	 
	 public void myReview(Model model,String memberId);
}