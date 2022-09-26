package com.kg.seeot;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Case;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@GetMapping(value={"getProduct", "/getProduct"})
	@ResponseBody
	public ArrayList<ProductDTO> getProduct() {
		ArrayList<ProductDTO> list = (ArrayList<ProductDTO>)mapper.allList();
		return list;
	}
	
	@GetMapping("search")
	public String search(HttpServletRequest request, Model model){
		String keyword = request.getParameter("keyword");
		model.addAttribute("keyword", keyword);
		return "search.page";
	}
	
	@PostMapping(value = "searchList", produces = "application/json;charset=utf8")
	@ResponseBody
	public List<ProductDTO> prolist(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="keyword", required = false, defaultValue = "") String keyword, 
			@RequestParam(value="chkColor_arr[]", required = false) String[] chkColor_arr, @RequestParam(value="chkPrice_arr[]", required = false) String[] chkPrice_arr) {
//		String orderBy = request.getParameter("orderBy");
//		int num = Integer.parseInt(request.getParameter("num"));
//		int pageViewProduct = Integer.parseInt(request.getParameter("pageViewProduct"));
		return mapper.productNameList(keyword);
	}

}
