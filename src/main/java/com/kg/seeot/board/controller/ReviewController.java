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

	@GetMapping("test")
	public String test() {
		return "review/test";
	}
	
	@GetMapping("reviewList")
	public String reviewList(Model model) {
		rs.reviewList(model);
		return "review/reviewList";
	}
	
	@PostMapping("reviewSave")
	public String reviewSave(MultipartHttpServletRequest mul, int reviewStar) {
		System.out.println("reviewcontroller");
		System.out.println("reviewStar: "+ reviewStar);
		rs.fileProcess( mul );
		//나중에 보드에서 상세페이지로 바꾸기
		return "redirect:board";
	}
	/*
	@PostMapping("reviwSave")
	public void reviwSave(MultipartHttpServletRequest mul,
			HttpServletResponse response,
			HttpServletRequest request) {
String message = rs.writeSave(mul, request);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print( message );
		
	}
	*/
}
