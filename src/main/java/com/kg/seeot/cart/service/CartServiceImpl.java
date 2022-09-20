package com.kg.seeot.cart.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;
import com.kg.seeot.mybatis.cart.CartMapper;
import com.kg.seeot.product.dto.ProductOrderDTO;

@Service
public class CartServiceImpl implements CartService{
	@Autowired CartMapper cm;

	@Override
	public void addCart(HttpServletRequest request,int productNo,String productSize, String productColor,String productStack) {
		System.out.println("productNo : "+productNo);
		System.out.println("productStack : "+productStack);
		System.out.println("productSize : "+productSize);
		System.out.println("productColor : "+productColor);
		List<ProductOrderDTO> list = productOrder(request, productColor, productSize, productStack);
		for(int i =0; i<list.size();i++) {
			System.out.println("list"+i+" : "+list.get(i).getProductColor());
			System.out.println("list"+i+" : "+list.get(i).getProductSize());
			System.out.println("list"+i+" : "+list.get(i).getProductStack());
			productSize = list.get(i).getProductSize();
			productColor = list.get(i).getProductColor();
			productStack = list.get(i).getProductStack();
			cm.addCart_p(productNo,productSize,productColor,productStack);
			cm.addCart_m(productNo,productSize,productColor);
		}
		System.out.println("카트 데이터 주입성공");
		System.out.println("orderstack : "+productStack);
		
		
	}

	@Override
	public ArrayList<CartDTO> getCart(Model model,String memberId) {
		ArrayList<CartDTO> list = new ArrayList<CartDTO>();		
		list = cm.getCart(memberId);
		model.addAttribute("cart",list);
		
		return list;
	}

	@Override
	public int deleteOneCart(String memberId, int productNo) {
		int result = cm.deleteCartOne(memberId,productNo);
		return result;
	}

	@Override
	public int deleteChkCart(String memberId,int cartNum) {
		int result = cm.deleteChkCart(memberId,cartNum);
		return result;
	}
	
	public List<ProductOrderDTO> productOrder(HttpServletRequest req, String productColor, String productSize, String productStack) {
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
		
		return list;
		
	}

	@Override
	public void alldel(String memberId) {
		cm.alldel(memberId);
		
	}
	
}
