package com.kg.seeot.board.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.ReviewDTO;
import com.kg.seeot.mybatis.board.ReviewMapper;
import com.kg.seeot.mybatis.order.OrderMapper;
import com.kg.seeot.order.dto.OrderHistoryDTO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewMapper mapper;
	@Autowired OrderMapper om;

	//리뷰 쓰기
	public void reviewList(Model model) {
		model.addAttribute("reviewList", mapper.reviewList());
	}
	//리뷰 더보기
	public void reviewMore(Model model, int productNo) {
		List<ReviewDTO> list = mapper.reviewMore(productNo);
		
		model.addAttribute("productNo", productNo);
		model.addAttribute("reviewMore", list);
	}

	public void addReply(Map<String, String> map, String memberId) {
		map.put("memberId", memberId);
		mapper.addReply(map);
	}
	
	
	public List<ReviewDTO> getRepList(Model model, int productNo , int num){
		
		int pageLetter = 5; 
		int allCount = mapper.getCount(productNo);
		
		int repeat = allCount / pageLetter;
		if( allCount % pageLetter != 0 )
			repeat += 1;
		
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		
		model.addAttribute("repeat", repeat);
		model.addAttribute("page", mapper.reviewPage(productNo, start, end ));
		return mapper.reviewPage(productNo, start, end );
		
		
	}
	
	//관리자용
	public List<ReviewDTO> getRepList1(int productNo){
		return mapper.getRepList( productNo );
	}
	
	//리뷰 저장
	public void fileProcess(MultipartHttpServletRequest mul , int reviewStar 
									, int productNo) {
		
		mapper.productCount(productNo, reviewStar); //별점 카운트
		
		ReviewDTO dto = new ReviewDTO();
		dto.setMemberId(mul.getParameter("memberId"));
		dto.setReviewContent((mul.getParameter("reviewContent")));
		dto.setReviewStar(reviewStar);
		dto.setProductNo(productNo);
		
		Iterator<String> fileNames = mul.getFileNames();
			while(fileNames.hasNext()) {
				MultipartFile file = mul.getFile(fileNames.next());
				
		if( file.getSize() != 0) { 
			SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss-");
			String sysFileName = f.format(new Date());
			
			sysFileName += file.getOriginalFilename();
			
			dto.setReviewFile(sysFileName);
			
			File saveFile = new File("c:/spring/image_repo" +"/"+sysFileName);
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			dto.setReviewFile( "nan");
		}}
		mapper.saveData( dto );
		
	}
	
	//리뷰 삭제
	 public void delete(int reviewNo, int productNo,int reviewStar) {
		
		mapper.productmodify(productNo, reviewStar);
		 mapper.delete(reviewNo);
		
	 }
	
	 //수정 db저장
	 public String modify(MultipartHttpServletRequest mul,
				HttpServletRequest request) {
		
		
		int reviewNo = Integer.parseInt( mul.getParameter("reviewNo"));
		int productNo = Integer.parseInt( mul.getParameter("productNo"));
		int reviewStar = Integer.parseInt(mul.getParameter("reviewStar"));
		
		
		
		productModify(reviewNo);
		
		
		mapper.productCount(productNo, reviewStar);
		 ReviewDTO dto = new ReviewDTO();
		 
		dto.setReviewNo(reviewNo );
		dto.setReviewContent( mul.getParameter("reviewContent") );
		dto.setReviewStar(reviewStar);
		
		
		 MultipartFile file = mul.getFile("reviewFile");
		 
		
		 
		 if( file.getSize() != 0) {
			 ReviewDTO fdto = saveFile(file);
			
			 dto.setReviewFile(fdto.getReviewFile());
			
			}else {
				dto.setReviewFile(
						mul.getParameter("reviewFile") );
			}
		 
		int result = 0;
		result = mapper.modify(dto);
		 
		  String msg,url;
		 
		 if(result == 1) {
			 msg = "수정완료";
			 url=request.getContextPath()+
					 "/product/productView?productNo="+productNo;
		 }else {
				msg = "수정 중 문제 발생!";
				url = request.getContextPath()+
				"/product/productView?productNo="+productNo;
			}
		 
		 return getMessage(msg, url);
		 
	 }
	 
	 //수정 페이지 연결
	 public void modify_form(int reviewNo, Model model) {
		 model.addAttribute("rdto", mapper.contentView(reviewNo));
	 }
	
	//사진 저장
	 public ReviewDTO saveFile(MultipartFile file) {
		 ReviewDTO fdto = new ReviewDTO();
		 
		 SimpleDateFormat simpl = new SimpleDateFormat("yyyyMMddHHmmss-");
			Calendar calendar = Calendar.getInstance();
			
			String reviewFileName = file.getOriginalFilename();
			String reviewFileSave = simpl.format(calendar.getTime()) + reviewFileName;
			File saveFile = new File("c:/spring/image_repo" + "/" + reviewFileSave);
			
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String reviewFile = "nan";
			
			if(file.getSize() != 0) {
				
				fdto.setReviewFile(reviewFileSave);
			 reviewFile = fdto.getReviewFile();
				
			}else {
				fdto.setReviewFile("nan");
				 reviewFile = fdto.getReviewFile();
				
			}
			return fdto;
	 }
	 
	 //저장된 사진 삭제
	 public void deleteFile(String fName) {
		
		 File dFile = new File("c:/spring/image_repo/"+fName);
		 dFile.delete();
		
	 }
	 
	 // 메세지 출력
	 public String getMessage(String msg, String url) {
		 String message = "";
			message += "<script>alert('" + msg + "');";
			message += "location.href='" + url + "';</script>";
			return message;
	 }
	 
	 /*기존에 저장된 db수정*/ 
	 public void productModify(int reviewNo) {
		 
		 ReviewDTO dto = mapper.contentView(reviewNo);
		 	int modifyStar = dto.getReviewStar();
			int modifyProductNo = dto.getProductNo();
			
			mapper.productmodify(modifyProductNo, modifyStar);
			
	 }
	 
	
	 //나의 리뷰 모아보기 페이지
	 public void myReview(Model model,String memberId){
		 model.addAttribute("myReview", mapper.myReview(memberId));
		 
	 }

	 //아이디 불러오기
	 public String member(int reviewNo) {
		 ReviewDTO dto =  mapper.contentView(reviewNo);
		 String memberId = dto.getMemberId();
		 return memberId;
	 }
	 
	 //마이페이지 수정
	 public String mymodify(MultipartHttpServletRequest mul,
				HttpServletRequest request) {
		
		
		String originFile = mul.getParameter("reviewFile");
		int reviewNo = Integer.parseInt( mul.getParameter("reviewNo"));
		int productNo = Integer.parseInt( mul.getParameter("productNo"));
		int reviewStar = Integer.parseInt(mul.getParameter("reviewStar"));
		
		
		productModify(reviewNo);
		
		
		mapper.productCount(productNo, reviewStar);
		 ReviewDTO dto = new ReviewDTO();
		 
		dto.setReviewNo(reviewNo );
		dto.setReviewContent( mul.getParameter("reviewContent") );
		dto.setReviewStar(reviewStar);
		
		
		 MultipartFile file = mul.getFile("reviewFile");
		 
		
		 
		 if( file.getSize() != 0) {
			 ReviewDTO fdto = saveFile(file);
			
			 dto.setReviewFile(fdto.getReviewFile());
				
			}else {
				dto.setReviewFile(
						mul.getParameter("reviewFile") );
			}
		 
		int result = 0;
		result = mapper.modify(dto);
		 
		  String msg,url;
		 String memberId = member(reviewNo);
		 
		 if(result == 1) {
			 msg = "수정완료";
			 url=request.getContextPath()+
					 "/review/myReview?memberId="+memberId;
		 }else {
				msg = "수정 중 문제 발생!";
				url = request.getContextPath()+
				"/review/myReview?memberId="+memberId;
			}
		 
		 return getMessage(msg, url);
		 
	 }
	 
	 //구매자 리뷰
	@Override
	public int gotoReview(int productNo,String memberId) {
		int result = 0;
		ArrayList<OrderHistoryDTO> list = om.getOrderHistory(memberId);
		
		for(OrderHistoryDTO dto : list) {
			if(dto.getHiProductNo()==productNo) {
				result = 1;
			}
		}

	
		return result;
	}

	 
	 
}
