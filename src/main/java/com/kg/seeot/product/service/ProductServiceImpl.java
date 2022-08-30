package com.kg.seeot.product.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.mybatis.product.ProductMapper;
import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;

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
	
	public void productView(Model model, int productNo) {
		model.addAttribute("pdto", mapper.productView(productNo));
		model.addAttribute("mlist", mapper.productManageView(productNo));
	}
	
	public String productSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		ProductDTO pdto = new ProductDTO();
		ProductManageDTO mdto = new ProductManageDTO();
		
		pdto.setProductNo(Integer.parseInt(mul.getParameter("productNo")));
		pdto.setProductCategorie(Integer.parseInt(mul.getParameter("productCategorie")));
		pdto.setProductName(mul.getParameter("productName"));
		pdto.setProductPrice(Integer.parseInt(mul.getParameter("productPrice")));
		pdto.setProductContent(mul.getParameter("productContent"));
		
		mdto.setProductNo(Integer.parseInt(mul.getParameter("productNo")));
		mdto.setProductSize(Integer.parseInt(mul.getParameter("productSize")));
		mdto.setProductColor(mul.getParameter("productColor"));
		mdto.setProductStack(Integer.parseInt(mul.getParameter("productStack")));
		
		//이미지 처리
		MultipartFile file = mul.getFile("productFile");
		if( file.getSize() != 0 ) { //이미지 있는경우
			pdto.setProductFile(pfs.saveFile(file));
		}else { //이미지가 없는 경우
			pdto.setProductFile("nan");
		}
		
		int presult = 0, mresult = 0;
		String msg, url;
		
		presult = mapper.productSave(pdto);
		mresult = mapper.productManageSave(mdto);
		
		if( presult == 1 && mresult == 1) { //상품 등록 성공시
			msg = "상품이 등록되었습니다.";
			url = request.getContextPath() + "/product/list";
		}else { //상품 등록 실패시
			msg = "상품 등록에 실패하였습니다.";
			url = request.getContextPath() + "/product/productRegister";
		}
		
		return  pfs.getMessage(msg, url); //스크립트 생성
	}
	
	public String productDelete(int productNo, String productFile, HttpServletRequest request) {
		int result = 0;
		String msg, url;
		
		result = mapper.productDelete(productNo);
		
		if( result == 1) {
			pfs.deleteImage(productFile);
			msg = "상품이 삭제되었습니다.";
			url = request.getContextPath() + "/product/list";
		} else {
			msg = "상품 삭제에 실패하였습니다.";
			url = request.getContextPath() + "productView?productNo=" + productNo;
		}
		
		return pfs.getMessage(msg, url);
	}
	
	public void productModify_Form(int productNo, Model model) {
		model.addAttribute("pdto", mapper.productView(productNo));
	}
	
	public String productModify(MultipartHttpServletRequest mul, HttpServletRequest request) {
		ProductDTO dto = new ProductDTO();
		dto.setProductNo(Integer.parseInt(mul.getParameter("productNo")));
		dto.setProductCategorie(Integer.parseInt(mul.getParameter("productCategorie")));
		dto.setProductName(mul.getParameter("productName"));
		dto.setProductPrice(Integer.parseInt(mul.getParameter("productPrice")));
		dto.setProductContent(mul.getParameter("productContent"));
		
		MultipartFile file = mul.getFile("productFile");
		if( file.getSize() != 0) {
			dto.setProductFile(pfs.saveFile(file));
			pfs.deleteImage(mul.getParameter("originProductFile"));
		} else {
			dto.setProductFile(mul.getParameter("originProductFile"));
		}
		
		int result = mapper.productModify( dto );
		String msg, url;
		
		if(result == 1) { //저장 성공
			msg = "성공적으로 상품이 수정되었습니다";
			url = request.getContextPath() + "/product/productView?productNo=" + dto.getProductNo();
		}else { //문제 발생
			msg = "상품 수정에 실패하였습니다...";
			url = request.getContextPath() + "/product/productModify_Form?productNo=" + dto.getProductNo();
		}
		return pfs.getMessage(msg, url);
	}

}
