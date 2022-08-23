package com.kg.seeot.product.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.mybatis.product.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	ProductMapper mapper;
	
	public void productAllList(Model model) {
		model.addAttribute("productList", mapper.productAllList() );
	}
	
	public void list(Model model, int productCategorie) {
		model.addAttribute("list", mapper.list(productCategorie));
	}

}
