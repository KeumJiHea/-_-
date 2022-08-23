package com.kg.seeot.product.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kg.seeot.product.service.ProductFileService;
import com.kg.seeot.product.service.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired
	ProductService ps;
	
	@GetMapping("productAllList")
	public String productAllList(Model model) {
		ps.productAllList(model);
		return "product/productAllList";
	}
	
	@GetMapping("download")
	public void download(@RequestParam("productFile") String productFile, HttpServletResponse response) throws IOException { //넘어오는 값과 받는 값의 변수가 동일하면 @RequestParam 생략 가능
		response.addHeader("Content-disposition","attachment;fileName="+productFile); //(Content-disposition: 다운로드형식, attachment: 파일명을붙여서; 파일명 )
		File file = new File(ProductFileService.IMAGE_REPO+"/"+productFile);
		FileInputStream in = new FileInputStream(file);
		FileCopyUtils.copy(in, response.getOutputStream()); //(해당 경로로 읽어온 값을 , 사용자에게 전달해줌)
		in.close();
	}
	
	

}
