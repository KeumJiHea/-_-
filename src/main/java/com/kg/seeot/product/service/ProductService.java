package com.kg.seeot.product.service;

import org.springframework.ui.Model;

public interface ProductService {
	public void productAllList(Model model);
	public void list(Model model, int productCategorie);

}
