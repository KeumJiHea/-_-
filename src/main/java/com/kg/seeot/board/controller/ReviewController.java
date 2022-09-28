package com.kg.seeot.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public String reviewList() {
		//System.out.println(productNo);
		return "review/reviewList";
	}
	/**/
	@GetMapping("reviewMore")
	public String reviewMore(Model model,int productNo) {
		System.out.println(productNo);
		rs.reviewMore(model,productNo);
		return "review/reviewMore";
	}
	
	@PostMapping("reviewSave")
	public String reviewSave(MultipartHttpServletRequest mul, int reviewStar
								, int productNo) {
		/**/
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
	
	
	@GetMapping("download")
	public void download(String file, HttpServletResponse response) throws Exception {
		System.out.println("controller file: "+file );
		response.addHeader("Content-disposition", "attachment; fileName="+file);
		//Content-disposition : 다운로드 방식임 	  attachment; fileName=  : 다운로드 받는 파일의 이름 지정함
		File f = new File("c:/spring/image_repo"+"/"+file);
		FileInputStream in = new FileInputStream(f);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
	}
	
	@GetMapping("delete")
	public String delete(int reviewNo,int productNo,int reviewStar) {
		//System.out.println("cotm" +reviewNo);
		//System.out.println("com" +productNo);
		rs.delete(reviewNo,productNo, reviewStar);
		
		return "redirect:../product/productView?productNo="+productNo;
	}
	
	
	@PostMapping("modify")
	public void modify(MultipartHttpServletRequest mul,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("controller");
	
		
		String message = rs.modify(mul, request);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print( message );
		
		
		//System.out.println("con num: "+reviewNo + productNo);
		//rs.modify(reviewNo);
		//return "redirect:../product/productView?productNo="+productNo;
	}
	
	
	
	@GetMapping("modify_form")
	public String modify_form(Model model, int reviewNo) {
		rs.modify_form(reviewNo, model);
		//rs.reviewList(model);
		return "review/modify_form";
	}
	
	
}















