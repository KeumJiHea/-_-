package com.kg.seeot.product.service;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.mybatis.cart.CartMapper;
import com.kg.seeot.mybatis.product.ProductMapper;
import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	ProductMapper mapper;
	
	@Autowired
	CartMapper cm;
	
	@Autowired
	ProductFileService pfs;
	
	public void allList(Model model) {
		model.addAttribute("list", mapper.allList() );
	}
	
	public void list(Model model, int productCategorie) {
		model.addAttribute("list", mapper.list(productCategorie));
	}
	
	public void productNameList(Model model, String productName) {
		model.addAttribute("list", mapper.productNameList(productName));
	}
	
	public void productNoList(Model model, int productNo) {
		model.addAttribute("list", mapper.productNoList(productNo));
	}
	
	public void productView(Model model, int productNo) {
		model.addAttribute("pdto", mapper.productView(productNo));
		model.addAttribute("mslist", mapper.managementSize(productNo));
		model.addAttribute("mclist", mapper.managementColor(productNo));
	}
	
	public String productSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		ProductDTO pdto = new ProductDTO();
		ProductManageDTO mdto = new ProductManageDTO();
		
		pdto.setProductNo(Integer.parseInt(mul.getParameter("productNo")));
		pdto.setProductCategorie(Integer.parseInt(mul.getParameter("productCategorie")));
		pdto.setProductName(mul.getParameter("productName"));
		pdto.setProductPrice(Integer.parseInt(mul.getParameter("productPrice")));
		
		mdto.setProductNo(Integer.parseInt(mul.getParameter("productNo")));
		mdto.setProductSize(Integer.parseInt(mul.getParameter("productSize")));
		mdto.setProductColor(mul.getParameter("productColor"));
		mdto.setProductStack(Integer.parseInt(mul.getParameter("productStack")));
		
		//이미지 처리
		MultipartFile file1 = mul.getFile("productFile");
		if( file1.getSize() != 0 ) { //이미지 있는경우
			pdto.setProductFile(pfs.saveFile(file1));
		}else { //이미지가 없는 경우
			pdto.setProductFile("nan");
		}
		
		MultipartFile file2 = mul.getFile("productContent");
		if( file2.getSize() != 0 ) { //이미지 있는경우
			pdto.setProductContent(pfs.saveFile(file2));
		}else { //이미지가 없는 경우
			pdto.setProductContent("nan");
		}
		
		int presult = 0, mresult = 0;
		String msg, url;
		
		presult = mapper.productSave(pdto);
		mresult = mapper.productManageSave(mdto);
		
		if( presult == 1 && mresult == 1) { //상품 등록 성공시
			msg = "상품이 등록되었습니다.";
			url = request.getContextPath() + "/product/productList";
		}else { //상품 등록 실패시
			msg = "상품 등록에 실패하였습니다.";
			url = request.getContextPath() + "/product/productRegister";
		}
		
		return  pfs.getMessage(msg, url); //스크립트 생성
	}
	
	public String productDelete(int productNo, String productFile, String productContent, HttpServletRequest request) {
		int result = 0;
		String msg, url;
		
		result = mapper.productDelete(productNo);
		
		if( result == 1) {
			cm.adminDel(productNo);
			pfs.deleteImage(productFile);
			pfs.deleteImage(productContent);
			msg = "상품이 삭제되었습니다.";
			url = request.getContextPath() + "/product/productList";
		} else {
			msg = "상품 삭제에 실패하였습니다.";
			url = request.getContextPath() + "/product/productList";
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
		
		MultipartFile file1 = mul.getFile("productFile");
		if( file1.getSize() != 0) {
			dto.setProductFile(pfs.saveFile(file1));
			pfs.deleteImage(mul.getParameter("originProductFile"));
		} else {
			dto.setProductFile(mul.getParameter("originProductFile"));
		}
		
		MultipartFile file2 = mul.getFile("productContent");
		if( file2.getSize() != 0) {
			dto.setProductContent(pfs.saveFile(file2));
			pfs.deleteImage(mul.getParameter("originProductContent"));
		} else {
			dto.setProductContent(mul.getParameter("originProductContent"));
		}
		
		int result = mapper.productModify( dto );
		String msg, url;
		
		if(result == 1) { //저장 성공
			msg = "상품 수정에 성공하였습니다.";
			url = request.getContextPath() + "/product/productList";
		}else { //문제 발생
			msg = "상품 수정에 실패하였습니다.";
			url = request.getContextPath() + "/product/productModify_Form?productNo=" + dto.getProductNo();
		}
		return pfs.getMessage(msg, url);
	}
	
	public void managementView(int productNo, Model model) {
		model.addAttribute("list", mapper.productManageView(productNo));
	}
	
	public String managementSave(ProductManageDTO dto, HttpServletRequest request) {
		int result = mapper.productManageSave(dto);
		String msg, url;
		
		if(result == 1) {
			msg = "상품 재고 등록을 하였습니다.";
			url = request.getContextPath() + "/product/managementView?productNo=" + dto.getProductNo();
		} else {
			msg = "상품 재고 등록에 실패하였습니다.";
			url = request.getContextPath() + "/product/managementRegister_form?productNo=" + dto.getProductNo();
		}
		return pfs.getMessage(msg, url);
	}
	
	public String managementDelete(int productNo, int productSize, String productColor, HttpServletRequest request) {
		int result = mapper.managementDelete(productNo, productSize, productColor);
		
		String msg, url;
		if(result == 1) {
			msg = "상품 재고를 삭제하였습니다.";
			url = request.getContextPath() + "/product/managementView?productNo=" + productNo;
		} else {
			msg = "상품 재고 삭제에 실패하였습니다.";
			url = request.getContextPath() + "/product/managementView?productNo=" + productNo;
		}
		return pfs.getMessage(msg, url);
	}
	
	public void managementModify_Form(int productNo, int productSize, String productColor, Model model) {
		System.out.println(productNo);
		System.out.println(productSize);
		System.out.println(productColor);
		model.addAttribute("mdto", mapper.managementModify_Form(productNo, productSize, productColor));
	}
	
	public String managementModify(ProductManageDTO mdto, int moProductStack, String moProductColor, int moProductSize, HttpServletRequest request) {
		int productNo = mdto.getProductNo();
		int productStack = mdto.getProductStack();
		String productColor = mdto.getProductColor();
		int productSize = mdto.getProductSize();
		
		
		int result = mapper.managementModify(productNo, productStack, productColor, productSize, moProductStack, moProductColor, moProductSize);
		String msg, url;
		
		if(result == 1) {
			msg = "상품 재고 수정을 하였습니다.";
			url = request.getContextPath() + "/product/managementView?productNo=" +productNo;
		} else {
			msg = "상품 재고 수정에 실패하였습니다.";
			url = request.getContextPath() + "/product/managementModify_Form?productNo=" + productNo + "&productSize=" + productSize + "&productColor=" + productColor;
		}
		return pfs.getMessage(msg, url);
	}
	
	public ProductManageDTO proStackGet(ProductManageDTO mdto) {
		int productNo = mdto.getProductNo();
		int productSize = mdto.getProductSize();
		String productColor = mdto.getProductColor();
		return mapper.managementModify_Form(productNo, productSize, productColor);
	}
	
	public int allCount(int productCategorie, String[] chkColor_arr, String[] chkPrice_arr) {
		System.out.println("1. all 카테고리 값 : " + productCategorie);
		System.out.println("1. all 컬러 - chkColor_arr : " + chkColor_arr);
		System.out.println("1. all 가격 - chkPrice_arr : " + chkPrice_arr);
		
		return mapper.allCount(productCategorie, chkColor_arr, chkPrice_arr);
	}
	
	public List<ProductDTO> prolist(String orderBy, int productCategorie, int num, int pageViewProduct, String[] chkColor_arr, String[] chkPrice_arr) {
		System.out.println("2. list 카테고리 값 : " + productCategorie);
		System.out.println("2. list 정렬 값 : " + orderBy);
		System.out.println("2. list 페이징 num 값 : " + num);
		System.out.println("2. list 보일 상품의 수 : " + pageViewProduct);
		System.out.println("2. list 컬러 - chkColor_arr : " + chkColor_arr);
		System.out.println("2. list 가격 - chkPrice_arr : " + chkPrice_arr);
		
		
		int end = num * pageViewProduct;
		int start = end + 1 - pageViewProduct;
		System.out.println("start : " +  start);
		System.out.println("end : " + end);
		System.out.println("------------------------------------");
		return mapper.prolist(orderBy, productCategorie, start, end, chkColor_arr, chkPrice_arr);
	}
	
}
