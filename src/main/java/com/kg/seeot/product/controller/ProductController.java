package com.kg.seeot.product.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tiles.request.Request;
import org.apache.velocity.runtime.directive.Parse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.service.ReviewService;
import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;
import com.kg.seeot.product.service.ProductFileService;
import com.kg.seeot.product.service.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired
	ProductService ps;
	
	//상품 전체 리스트 및 카테고리 리스트 출력
	@GetMapping("list")
	public String list() {
		return "product/list";
	}
	
	//해당 카테고리 전체 상품 수
	@PostMapping(value = "allCount", produces = "application/json;charset=utf8")
	@ResponseBody
	public int allCount(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="productCategorie", required = false, defaultValue = "0") int productCategorie, 
				@RequestParam(value="chkColor_arr[]", required = false) String[] chkColor_arr, @RequestParam(value="chkPrice_arr[]", required = false) String[] chkPrice_arr) {
		
		return ps.allCount(productCategorie, chkColor_arr, chkPrice_arr);
	}
	
	//list 페이지에 보여질 상품
	@PostMapping(value = "prolist", produces = "application/json;charset=utf8")
	@ResponseBody
	public List<ProductDTO> prolist(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="productCategorie", required = false, defaultValue = "0") int productCategorie, 
			@RequestParam(value="chkColor_arr[]", required = false) String[] chkColor_arr, @RequestParam(value="chkPrice_arr[]", required = false) String[] chkPrice_arr) {
		String orderBy = request.getParameter("orderBy");
		int num = Integer.parseInt(request.getParameter("num"));
		int pageViewProduct = Integer.parseInt(request.getParameter("pageViewProduct"));
		return ps.prolist(orderBy, productCategorie, num, pageViewProduct, chkColor_arr, chkPrice_arr);
	}
	
	//상품 이미지 로드
	@GetMapping("download")
	public void download(@RequestParam("productFile") String productFile, HttpServletResponse response) throws IOException { //넘어오는 값과 받는 값의 변수가 동일하면 @RequestParam 생략 가능
		response.addHeader("Content-disposition","attachment;fileName="+productFile); //(Content-disposition: 다운로드형식, attachment: 파일명을붙여서; 파일명 )
		File file = new File(ProductFileService.IMAGE_REPO+"/"+productFile);
		FileInputStream in = new FileInputStream(file);
		FileCopyUtils.copy(in, response.getOutputStream()); //(해당 경로로 읽어온 값을 , 사용자에게 전달해줌)
		in.close();
	}
	
	//상품 상세 정보
	@GetMapping("productView")
	public String productView(Model model, int productNo) {
		ps.productView(model, productNo);
		return "product/productView";
	}
	
	//상품 등록 페이지 연결
	@GetMapping("productRegister")
	public String productRegister() {
		return "product/productRegister";
	}
	
	//상품 등록
	@PostMapping("productSave")
	public void productSave(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request) throws Exception {
		String message = ps.productSave(mul, request);
		
		response.setContentType("text/html; charser=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	//상품 삭제
	@GetMapping("productDelete")
	public void productDelete(int productNo, String productFile, HttpServletResponse response ,HttpServletRequest request) throws Exception {
		String message = ps.productDelete(productNo, productFile, request);
		
		response.setContentType("text/html; charser=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	//상품 수정 페이지 연결
	@GetMapping("productModify_Form")
	public String productModify_Form(int productNo, Model model) {
		ps.productModify_Form(productNo, model);
		return "product/productModify_Form";
	}
	
	//상품 수정
	@PostMapping("productModify")
	public void productModify(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String message = ps.productModify(mul, request);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	//상품 재고 현황
	@GetMapping("managementView")
	public String managementView(int productNo, Model model) {
		ps.managementView(productNo, model);
		return "product/managementView";
	}
	
	//상품 재고 등록 페이지 연결
	@GetMapping("managementRegister_Form")
	public String managementRegister_Form() {
		return "product/managementRegister_Form";
	}
	
	//상품 재고 신규 등록
	@PostMapping("managementSave")
	public void managementSave(ProductManageDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String message = ps.managementSave(dto, request);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	//상품 재고 삭제
	@GetMapping("managementDelete")
	public void managementDelete( @RequestParam(value="productNo") int productNo, @RequestParam(value="productSize") int productSize, @RequestParam(value="productColor") String productColor, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		String message = ps.managementDelete(productNo, productSize, productColor, request);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	//상품 재고 수정 페이지 연결
	@GetMapping("managementModify_Form")
	public String managementModify_Form(@RequestParam(value="productNo") int productNo, @RequestParam(value="productSize") int productSize, @RequestParam(value="productColor") String productColor, Model model) {
		ps.managementModify_Form(productNo, productSize, productColor, model);
		return "product/managementModify_Form";
	}
	
	//상품 재고 수정
	@PostMapping("managementModify")
	public void managementModify(ProductManageDTO mdto, int moProductStack, String moProductColor, int moProductSize, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String message = ps.managementModify(mdto, moProductStack, moProductColor, moProductSize, request);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	//상품 상세페이지 남은 재고 가져오기
	@GetMapping(value = "proStackGet", produces = "application/json;charset=utf8")
	@ResponseBody
	public ProductManageDTO proStackGet(ProductManageDTO mdto) {
		return ps.proStackGet(mdto);
	}
	
	//상품 전체 리스트 및 카테고리 리스트 출력
	@GetMapping("productList")
	public String productList(Model model) {
		ps.allList(model);
		return "admin/productList";
	}
	
	@PostMapping("searchProduct")
	public String searchProduct(Model model, @RequestParam(value="search") String search, @RequestParam(value="val") String val) {
		System.out.println(search);
		switch(search) {
		case "productNo":
			int productNo = Integer.parseInt(val);
			ps.productNoList(model, productNo);
			break;
		case "productName":
			String productName = val;
			ps.productNameList(model, productName);
			break;
		case "productCategorie":
			int productCategorie = Integer.parseInt(val);
			ps.list(model, productCategorie);
			break;
		}
		return "admin/productList";
	}
	
}
