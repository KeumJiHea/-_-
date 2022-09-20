package com.kg.seeot.product.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;

public interface ProductService {
	public void allList(Model model);
	public void list(Model model, int productCategorie);
	public void productView(Model model, int productNo);
	public String productSave(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String productDelete(int productNo, String productFile, HttpServletRequest request);
	
	public void productModify_Form(int productNo, Model model);
	public String productModify(MultipartHttpServletRequest mul, HttpServletRequest request);
	public void managementView(int productNo, Model model);
	public String managementSave(ProductManageDTO dto, HttpServletRequest request);
	public String managementDelete(int productNo, int productSize, String productColor, HttpServletRequest request);
	public void managementModify_Form(int productNo, int productSize, String productColor, Model model);
	public String managementModify(ProductManageDTO mdto, int moProductStack, String moProductColor, int moProductSize, HttpServletRequest request);
	
	public ProductManageDTO proStackGet(ProductManageDTO mdto);
	
	public int allCount(String orderBy, int productCategorie);
	public List<ProductDTO> prolist(String orderBy, int productCategorie, int num, int pageViewProduct);
	
	
	
	
	public int TestallCount(int productCategorie, String[] chkColor_arr, String[] chkPrice_arr);
	public List<ProductDTO> Testprolist(String orderBy, int productCategorie, int num, int pageViewProduct, String[] chkColor_arr, String[] chkPrice_arr);
	
}
