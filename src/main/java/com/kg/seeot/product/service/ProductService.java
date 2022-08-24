package com.kg.seeot.product.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ProductService {
	public void allList(Model model);
	public void list(Model model, int productCategorie);
	
	public String productSave(MultipartHttpServletRequest mul, HttpServletRequest request);

}
