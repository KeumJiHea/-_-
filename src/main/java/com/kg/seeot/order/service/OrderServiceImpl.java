package com.kg.seeot.order.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;
import com.kg.seeot.product.dto.ProductOrderDTO;

@Service
public class OrderServiceImpl implements OrderService{
	
	public void productOrder(Model model, HttpServletRequest req, String productColor, String productSize, String productStack) {
		String[] a = productColor.split(",");
		String[] b = productSize.split(",");
		String[] c = productStack.split(",");
		
		List<ProductOrderDTO> list = new ArrayList<ProductOrderDTO>();
		for(int i=0; i<a.length ;i++) {
			ProductOrderDTO dto = new ProductOrderDTO();
			dto.setProductNo(Integer.parseInt(req.getParameter("productNo")));
			dto.setProductName(req.getParameter("productName"));
			dto.setProductFile(req.getParameter("productFile"));
			dto.setProductPrice(Integer.parseInt(req.getParameter("productPrice")));
			dto.setProductColor(a[i]);
			dto.setProductSize(Integer.parseInt(b[i]));
			dto.setProductStack(Integer.parseInt(c[i]));
			list.add(dto);
			}
		
		model.addAttribute("list", list);
	}

}
