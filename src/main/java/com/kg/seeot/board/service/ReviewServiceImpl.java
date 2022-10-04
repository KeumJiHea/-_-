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
		System.out.println("list size : "+list.size());
		model.addAttribute("productNo", productNo);
		model.addAttribute("reviewMore", list);
	}

	public void addReply(Map<String, String> map, String memberId) {
		map.put("memberId", memberId);
		mapper.addReply(map);
	}
	
	
	public List<ReviewDTO> getRepList(Model model, int productNo , int num){
		System.out.println("serviceImpl");
		//System.out.println(productNo);
		
		int pageLetter = 5; 
		int allCount = mapper.getCount(productNo);
		
		//System.out.println(allCount);
		
		int repeat = allCount / pageLetter;
		if( allCount % pageLetter != 0 )
			repeat += 1; //네비게이션 수
		
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		/*
		System.out.println(repeat);
		System.out.println(start);
		System.out.println(end);
		*/
		model.addAttribute("repeat", repeat);
		model.addAttribute("page", mapper.reviewPage(productNo, start, end ));
		return mapper.reviewPage(productNo, start, end );
		
		//return mapper.getRepList( productNo );
	}
	
	
	public List<ReviewDTO> getRepList1(int productNo){
		System.out.println("serviceImpl");
		//System.out.println(productNo);
		
		return mapper.getRepList( productNo );
	}
	
	//리뷰 저장
	public void fileProcess(MultipartHttpServletRequest mul , int reviewStar 
									, int productNo) {
		
		mapper.productCount(productNo, reviewStar); //별점 카운트
		
		/*
		System.out.println("reviewcontroller-service");
		System.out.println(mul.getParameter("memberId"));
		System.out.println(mul.getParameter("reviewContent"));
		System.out.println(reviewStar);
		System.out.println(productNo);
		*/
		ReviewDTO dto = new ReviewDTO();
		dto.setMemberId(mul.getParameter("memberId"));
		dto.setReviewContent((mul.getParameter("reviewContent")));
		dto.setReviewStar(reviewStar);
		dto.setProductNo(productNo);
		
		Iterator<String> fileNames = mul.getFileNames();
			while(fileNames.hasNext()) {
				MultipartFile file = mul.getFile(fileNames.next());
				
				//System.out.println(file.getOriginalFilename());
			
		//MultipartFile file = mul.getFile("reviewFile"); //꺼내와야함

		

		
		/**/
		if( file.getSize() != 0) { // file.isEmpty() != true (파일이 존재하면)  !file.isEmpty()
			SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss-");
			String sysFileName = f.format(new Date());
			//System.out.println( sysFileName);
			
			sysFileName += file.getOriginalFilename();
			
			dto.setReviewFile(sysFileName);
			
			//System.out.println(sysFileName); 
			File saveFile = new File("c:/spring/image_repo" +"/"+sysFileName);
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {//파일을 선택하지 않은 경우
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
		
		System.out.println("sevieceimpl modify");
		System.out.println(mul.getParameter("reviewFile") );
		String originFile = mul.getParameter("reviewFile");
		int reviewNo = Integer.parseInt( mul.getParameter("reviewNo"));
		int productNo = Integer.parseInt( mul.getParameter("productNo"));
		int reviewStar = Integer.parseInt(mul.getParameter("reviewStar"));
		
		
		
		
		/*System.out.println("productModify전 reviewNo: "+reviewNo);*/
		productModify(reviewNo);
		
		
		mapper.productCount(productNo, reviewStar);
		 ReviewDTO dto = new ReviewDTO();
		 
		dto.setReviewNo(reviewNo );
		dto.setReviewContent( mul.getParameter("reviewContent") );
		dto.setReviewStar(reviewStar);
		
		
		 MultipartFile file = mul.getFile("reviewFile");
		 
		
		 
		 if( file.getSize() != 0) {
			 ReviewDTO fdto = saveFile(file);
			 System.out.println("서비스 modify if문 fdto파일"+fdto.getReviewFile());
			 dto.setReviewFile(fdto.getReviewFile());
				//saveFile(file);
				//deleteFile(file);
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
				file.transferTo(saveFile);// 해당 위치에 파일 저장
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String reviewFile = "nan";
			
			if(file.getSize() != 0) {
				System.out.println("saveFile if문 reviewFile: "+reviewFileName);
				System.out.println("saveFile if문 reviewFileSave: "+reviewFileSave);
				fdto.setReviewFile(reviewFileSave);
			 reviewFile = fdto.getReviewFile();
				//fdto.setFileSaveName(reviewFileSave);
			}else {
				fdto.setReviewFile("nan");
				 reviewFile = fdto.getReviewFile();
				//fdto.reviewFileSave("NaN");
			}
			return fdto;
	 }
	 
	 //저장된 사진 삭제
	 public void deleteFile(String fName) {
		 System.out.println("delete file: "+fName);
		 File dFile = new File("c:/spring/image_repo/"+fName);
		 dFile.delete();
		 //product 기존 내용 삭제
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
		 System.out.println("product modify");
		 System.out.println(reviewNo);  //여기까지 출력
		 
		
		 System.out.println("dto호출");
		
		 ReviewDTO dto = mapper.contentView(reviewNo);
		 System.out.println("dto불러오기");
		
		 System.out.println(dto.getReviewStar());
		 	
			int modifyStar = dto.getReviewStar();
			int modifyProductNo = dto.getProductNo();
			
			System.out.println("modify Star: "+modifyStar);
			System.out.println("modifyProductNO: "+modifyProductNo);
			
			System.out.println("product 기존 내용 삭제하기");
			mapper.productmodify(modifyProductNo, modifyStar);
			System.out.println("product 수정(삭제) 완료");
	
			
			
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
		
		System.out.println("sevieceimpl modify");
		System.out.println(mul.getParameter("reviewFile") );
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
			 System.out.println("서비스 modify if문 fdto파일"+fdto.getReviewFile());
			 dto.setReviewFile(fdto.getReviewFile());
				//saveFile(file);
				//deleteFile(file);
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
//		for(int i=0; i<list.size();i++) {
//			if(list.get(i).getHiProductNo()==productNo) {
//				result = 1;
//				return result;
//			}
//		}
		System.out.println("리뷰서비스: "+result);
		return result;
	}

	 
	 
}

