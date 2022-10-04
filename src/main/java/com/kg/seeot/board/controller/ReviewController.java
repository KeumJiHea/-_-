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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.kg.seeot.board.service.ReviewService;
import com.kg.seeot.order.dto.OrderHistoryDTO;
import com.kg.seeot.order.service.OrderServiceImpl;


@Controller
@RequestMapping("review")
public class ReviewController {
@Autowired ReviewService rs;



	@GetMapping("reviewList")
	public String reviewList(Model model, int productNo) {
		
		model.addAttribute("productNo", productNo);
		

		return "review/reviewList.page";
	}
	
	//리뷰 더보기
	@GetMapping("reviewMore")
	public String reviewMore(HttpServletRequest req,Model model,int productNo) {
		
		HttpSession session = req.getSession();
		session.setAttribute("rpn", productNo);
		rs.reviewMore(model,productNo);
		return "review/reviewMore.page";
	}
	
	//리뷰 저장
	@PostMapping("reviewSave")
	public String reviewSave(MultipartHttpServletRequest mul, int reviewStar
								, int productNo) {
		
		rs.fileProcess( mul , reviewStar , productNo );
		
		String id = mul.getParameter("memberId"); 
		
		return "redirect:../member/info?id="+id;
	}
	
	
	
	//이미지 확인용
	@GetMapping("download")
	public void download(String file, HttpServletResponse response) throws Exception {
		
		response.addHeader("Content-disposition", "attachment; fileName="+file);
		
		File f = new File("c:/spring/image_repo"+"/"+file);
		FileInputStream in = new FileInputStream(f);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
	}
	
	//리뷰 삭제
	@GetMapping("delete")
	public String delete(int reviewNo,int productNo,int reviewStar) {
		
		rs.delete(reviewNo,productNo, reviewStar);
		
		return "redirect:../product/productView?productNo="+productNo;
	}
	
	//리뷰 수정
	@PostMapping("modify")
	public void modify(MultipartHttpServletRequest mul,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
	
	
		
		String message = rs.modify(mul, request);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print( message );
		
		
	}
	
	
	//리뷰 수정 페이지
	@GetMapping("modify_form")
	public String modify_form(Model model, int reviewNo) {
		rs.modify_form(reviewNo, model);
	
		return "review/modify_form.page";
	}
	
	//마이페이지 리뷰
	@GetMapping("myReview")
	public String myReview(Model model, String memberId) {
		
		rs.myReview(model, memberId);
		return "review/myReview.page";
	}
	
	
	
	//마이페이지 수정폼
	@GetMapping("my_modifyform")
	public String my_modifyform(Model model, int reviewNo) {
		rs.modify_form(reviewNo, model);
		return "review/my_modifyform.page";
	}
	
	//마이페이지 수정
	@PostMapping("mymodify")
	public void mymodify(MultipartHttpServletRequest mul,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
	
		
		String message = rs.mymodify(mul, request);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print( message );	
		
	}
	//리뷰 상세 저장
	@GetMapping("reviewAdd")
	public String reviewAdd(Model model, int productNo) {
		
		model.addAttribute("productNo", productNo);
		

		return "review/reviewAdd.page";
	}
	//리뷰 저장(상세)
		@PostMapping("reviewAddSave")
		public String reviewAddSave(MultipartHttpServletRequest mul, int reviewStar
									, int productNo) {
			
			rs.fileProcess( mul , reviewStar , productNo );
			
			String id = mul.getParameter("memberId"); 
			
			return "redirect:../product/productView?productNo="+productNo;
		}
	
	//구매자확인 -> 리뷰페이지
	@GetMapping("writeReviewchk")
	public void writeReveiwchk(Model model,HttpServletRequest request,HttpServletResponse response,@RequestParam("productNo") int productNo) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("loginUser");
		
		
		int result = rs.gotoReview(productNo,memberId);
		
		
		if(result == 1) {
			response.setContentType("text/html charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('리뷰 작성페이지로 이동합니다!'); location.href='http://localhost:8085/seeot/review/reviewAdd?productNo="+productNo+"'</script>");
		}else {
			response.setContentType("text/html charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('구매하지 않았습니다! 구매한 뒤 리뷰작성 해주세요!'); location.href='http://localhost:8085/seeot/product/productView?productNo="+productNo+"'</script>");
		}
	}
	
}















