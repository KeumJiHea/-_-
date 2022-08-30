package com.kg.seeot.product.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ProductService {
	public void allList(Model model);
	public void list(Model model, int productCategorie);
	public void productView(Model model, int productNo);
	public String productSave(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String productDelete(int productNo, String productFile, HttpServletRequest request);
	
	public void productModify_Form(int productNo, Model model);
	public String productModify(MultipartHttpServletRequest mul, HttpServletRequest request);

}
