package com.kg.seeot.board.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
