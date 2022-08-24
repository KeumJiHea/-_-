package com.kg.seeot.product.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.mybatis.product.ProductMapper;
import com.kg.seeot.product.dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	ProductMapper mapper;
	
	@Autowired
	ProductFileService pfs;
	
	public void allList(Model model) {
		model.addAttribute("list", mapper.allList() );
	}
	
	public void list(Model model, int productCategorie) {
		model.addAttribute("list", mapper.list(productCategorie));
	}
	
	public String productSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		ProductDTO dto = new ProductDTO();
		dto.setProductNo(Integer.parseInt(mul.getParameter("productNo")));
		dto.setProductCategorie(Integer.parseInt(mul.getParameter("productCategorie")));
		dto.setProductName(mul.getParameter("productName"));
		dto.setProductSize(Integer.parseInt(mul.getParameter("productSize")));
		dto.setProductColor(mul.getParameter("productColor"));
		dto.setProductPrice(Integer.parseInt(mul.getParameter("productPrice")));
		dto.setProductStack(Integer.parseInt(mul.getParameter("productStack")));
		dto.setProductContent(mul.getParameter("productContent"));
		
		//이미지 처리
		MultipartFile file = mul.getFile("productFile");
		if( file.getSize() != 0 ) { //이미지 있는경우
			dto.setProductFile(pfs.saveFile(file));
		}else { //이미지가 없는 경우
			dto.setProductFile("nan");
		}
		
		int result = 0;
		String msg, url;
		
		result = mapper.productSave(dto);
		if( result == 1 ) { //상품 등록 성공시
			msg = "상품이 등록되었습니다.";
			url = request.getContextPath() + "/product/list";
		}else { //상품 등록 실패시
			msg = "상품 등록에 실패하였습니다.";
			url = request.getContextPath() + "/product/productRegister";
		}
		
		return  pfs.getMessage(msg, url); //스크립트 생성
	}

}
