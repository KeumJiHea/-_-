package com.kg.seeot.product.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.product.service.ProductFileService;
import com.kg.seeot.product.service.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired
	ProductService ps;
	
	//상품 전체 리스트 및 카테고리 리스트 출력
	@GetMapping("list")
	public String list(Model model, @RequestParam(value="productCategorie", required = false, defaultValue = "0")  int productCategorie) {
		if(productCategorie == 0) {
			ps.allList(model);
		}else {
			ps.list(model, productCategorie);
		}
		return "product/list";
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

}
