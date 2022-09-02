package com.kg.seeot;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kg.seeot.mybatis.product.ProductMapper;
import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.service.ProductService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	ProductService ps;
	@Autowired
	ProductMapper mapper;
	
	@RequestMapping(value = {"/", "/home", "/index"}, method = RequestMethod.GET)
	public String home() {
		return "home.page";
	}
	
	@GetMapping(value="getProduct")
	@ResponseBody
	public ArrayList<ProductDTO> getProduct() {
		ArrayList<ProductDTO> list = (ArrayList<ProductDTO>)mapper.allList();
		return list;
	}
	
}
