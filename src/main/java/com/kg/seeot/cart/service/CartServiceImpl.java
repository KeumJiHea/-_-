package com.kg.seeot.cart.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;
import com.kg.seeot.mybatis.cart.CartMapper;
import com.kg.seeot.mybatis.product.ProductMapper;
import com.kg.seeot.product.dto.ProductManageDTO;
import com.kg.seeot.product.dto.ProductOrderDTO;

@Service
public class CartServiceImpl implements CartService{
	@Autowired CartMapper cm;
	@Autowired ProductMapper pm;

	@Override
	public int addCart(HttpServletRequest request,int productNo,String productSize, String productColor,String productStack) {
		ArrayList<CartDTO> clist = null;
		List<ProductOrderDTO> list = productOrder(request, productColor, productSize, productStack);
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("loginUser");
		
		int result = 0;
		String[] a = productColor.split(",");
		String[] b = productSize.split(",");
		for(int i =0; i<list.size();i++) {
			productSize = list.get(i).getProductSize();
			productColor = list.get(i).getProductColor();
			productStack = list.get(i).getProductStack();
			clist = cm.getSameCart(memberId,productNo,productSize,productColor);
			if(clist.size() == 1) {
				result++;
				
			}else if(clist.size() == 0) {
				result += 1000;
				cm.addCart_p(memberId,productNo,productSize,productColor,productStack);
				cm.addCart_m(productNo,productSize,productColor);
			}
			 
		}
		return result;		
	}


	@Override
    public ArrayList<CartDTO> getCart(Model model,String memberId) {
        ArrayList<CartDTO> list = new ArrayList<CartDTO>();        
        list = cm.getCart(memberId);
        model.addAttribute("cart",list);
        ArrayList<ProductManageDTO> plist = new ArrayList<ProductManageDTO>();
        for(int i=0;i<list.size();i++) {
            int productNo = list.get(i).getProductNo();
            int productSize = list.get(i).getProductSize();
            String productColor = list.get(i).getProductColor();
            plist.add(i,pm.managementModify_Form(productNo, productSize, productColor));
        }
        model.addAttribute("plist",plist);
                
        return list;
    }

	@Override
    public int deleteOneCart(String memberId, int cartnum) {
        int result = cm.deleteCartOne(memberId,cartnum);
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