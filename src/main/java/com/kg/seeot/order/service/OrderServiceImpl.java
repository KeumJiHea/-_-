package com.kg.seeot.order.service;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;
import com.kg.seeot.product.dto.ProductOrderDTO;
import com.kg.seeot.member.service.MemberService;
import com.kg.seeot.mybatis.order.OrderMapper;
import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired OrderMapper om;
	
	@Override
	public void addOrder(OrderDTO dto) {
		om.addOrder(dto);
	}
		
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
			dto.setProductSize(b[i]);
			dto.setProductStack(c[i]);
			list.add(dto);
			}
		
		model.addAttribute("list", list);
	}

	@Override
	public void addHiOrder(OrderHistoryDTO hdto) {
		om.addOrderHistory(hdto);		
	}

	@Override
	public void cancle(HttpServletRequest request,String orderNo, String memberId) {
		HttpSession session = request.getSession();
		memberId = (String)session.getAttribute("loginUser");
		System.out.println("orderNo : "+orderNo);
		System.out.println("memberId : "+memberId);
	}
	
	
}
