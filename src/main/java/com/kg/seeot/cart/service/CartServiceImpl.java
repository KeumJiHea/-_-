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
	public void addCart(HttpServletRequest request, int productNo,String orderStack,String productSize, String productColor) {
		System.out.println("productNo : "+productNo);
		System.out.println("productStack : "+orderStack);
		System.out.println("productSize : "+productSize);
		System.out.println("productColor : "+productColor);
		
		String[] a = productColor.split(",");
		String[] b = productSize.split(",");
		String[] c = orderStack.split(",");
		
		List<ProductOrderDTO> list = new ArrayList<ProductOrderDTO>();
		for(int i=0; i<a.length ;i++) {
			ProductOrderDTO dto = new ProductOrderDTO();
			dto.setProductNo(productNo);
			dto.setProductName(request.getParameter("productName"));
			dto.setProductFile(request.getParameter("productFile"));
			dto.setProductPrice(Integer.parseInt(request.getParameter("productPrice")));
			dto.setProductColor(a[i]);
			dto.setProductSize(Integer.parseInt(b[i]));
			dto.setProductStack(Integer.parseInt(c[i]));
			
			int result = 0;
			cm.addCart_p(dto.getProductNo());
			cm.addCart_m(productNo,dto.getProductSize(),productColor);
			result = cm.addOrderStack(dto.getProductStack(), productNo);
			if(result==1) {
				System.out.println("카트 데이터 주입성공");
				System.out.println("orderstack : "+orderStack);
			}
			
			}
		
		
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
	
	
}
