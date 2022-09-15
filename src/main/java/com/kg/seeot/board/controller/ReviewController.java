package com.kg.seeot.board.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.kg.seeot.board.service.ReviewService;

@Controller
@RequestMapping("review")
public class ReviewController {
@Autowired ReviewService rs;

	@GetMapping("reviewList")
	public String test() {
		
		return "review/reviewList";
	}
	/*
	@GetMapping("reviewList")
	public String reviewList(Model model) {
		rs.reviewList(model);
		return "review/reviewList";
	}
	*/
	@PostMapping("reviewSave")
	public String reviewSave(MultipartHttpServletRequest mul, int reviewStar
								, int productNo) {
		System.out.println("reviewcontroller");
		System.out.println("reviewStar: "+ reviewStar);
		System.out.println("productNo: "+ productNo);
		
		rs.fileProcess( mul , reviewStar , productNo );
		
		String id = mul.getParameter("memberId"); 
		return "redirect:../member/info?id="+id;
	}
	
	
	@GetMapping("reviewPrint")
	public String reviewPrint() {
		
		return "review/reviewPrint";
	}
}















