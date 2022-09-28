package com.kg.seeot.order.service;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;
import com.kg.seeot.product.dto.ProductOrderDTO;
import com.kg.seeot.member.service.MemberService;
import com.kg.seeot.mybatis.order.OrderMapper;
import com.kg.seeot.mybatis.product.ProductMapper;
import com.kg.seeot.order.dto.CancelDTO;
import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired OrderMapper om;
	@Autowired OrderService os;
	@Autowired ProductMapper pm;
	
	@Override
	public void addOrder(OrderDTO dto) {
		om.addOrder(dto);
		pm.orderaddmodify(dto.getOrderStack(), dto.getProductNo(), dto.getProductSize(), dto.getProductColor());
	}
	
	@Override
	public void orderView(HttpSession session,Model model,String memberId) {
		memberId = (String) session.getAttribute("loginUser");
		Map map = (Map) session.getAttribute("orderdata");
		model.addAttribute("order",map);
		ArrayList name = (ArrayList) map.get("glist");
		ArrayList file = (ArrayList) map.get("gfile");
		ArrayList no = (ArrayList) map.get("gno");
		ArrayList stack = (ArrayList) map.get("gstack");
		ArrayList cost = (ArrayList) map.get("gcost");
		ArrayList size = (ArrayList) map.get("gsize");
		ArrayList color = (ArrayList) map.get("gcolor");
		
		model.addAttribute("result",file.size());
	}

	@Override
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
	public void cancel(HttpServletRequest request,String orderNo, String memberId,String reason) {
		HttpSession session = request.getSession();
		memberId = (String)session.getAttribute("loginUser");
		ArrayList<OrderDTO> list = om.getCancelOrder(orderNo);
		String admin = "admin";
		if(memberId.equals(admin)) {
			om.changeStatus_canceled(orderNo);
			om.changehiStatus_canceled(orderNo);
			for(int i=0; i<list.size();i++) {
				int productNo = list.get(i).getProductNo();
				int productSize = list.get(i).getProductSize();
				String productColor = list.get(i).getProductColor(); 
				int orderStack = list.get(i).getOrderStack();
				pm.ordercancelmodify(orderStack, productNo, productSize, productColor);
			}
			
			om.orderdel(orderNo);
		}else {
			System.out.println("orderNo : "+orderNo);
			System.out.println("memberId : "+memberId);
			System.out.println("reason : "+reason);
			Map<String,String> map = new HashMap<String, String>();
			map.put("orderNo", orderNo);
			map.put("memberId", memberId);
			map.put("reason", reason);
			session.setAttribute("cancel", map);
			om.changeStatus_canceling(orderNo);	
			om.changehiStatus_canceling(orderNo);
			om.addcancel_1(memberId, orderNo, reason);
			//om.addcancel_2(orderNo);
			
		}
		
		
	}
	
	
	
	@Override
	public void nonCancel(HttpServletRequest request, String orderNo) {
		HttpSession session = request.getSession();		
			om.changeStatus_noneCancel(orderNo);
			om.changehiStatus_noneCancel(orderNo);	
	}

	@Override
	public ArrayList<OrderDTO> getAllOrders(HttpServletRequest request,Model model,int num) {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		HttpSession session = request.getSession();
		int pageLetter = 20;
		int allCount = om.selectOrderCount();
		
		int repeat = allCount / pageLetter;
		if(allCount%pageLetter !=0) {
			repeat+=1;
		}
		int end = num*pageLetter;
		int start = end+1-pageLetter;
		list =  om.getAllOrders(start,end);
		model.addAttribute("list",list);
		model.addAttribute("repeat",repeat);
		Map map = (Map) session.getAttribute("cancel");
		if(map!=null) {
			String reason = (String) map.get("reason");
			String orderNo = (String) map.get("orderNo");
			String memberId = (String) map.get("memberId");
			model.addAttribute("cancel",map);			
		}
		
		return list;
	}
	

	@Override
	public void getCancel(HttpServletRequest request,Model model,String memberId, String orderNo) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser").equals("admin")) {
			CancelDTO cdto = new CancelDTO();
			cdto = om.getcancel(memberId, orderNo);
			String reason = cdto.getReason();
			memberId = cdto.getMemberId();
			orderNo = cdto.getOrderNo();					
			session.setAttribute("reason", reason);
		}
		
	}

	@Override
	public void getOrder(Model model,String memberId, String orderNo) {
		OrderDTO dto = om.getOrder(orderNo);
		model.addAttribute("dto",dto);
		
	}

	@Override
	public void getOrders(Model model,String memberId) {
		ArrayList<OrderDTO> list = om.getOrders(memberId);
		model.addAttribute("list",list);				
	}
	
	//주문 내역 조회
	@Override
	public void getOrderHistorys(Model model,String memberId) {
		ArrayList<OrderDTO> list = om.getOrderHistorys(memberId);
		model.addAttribute("orderli",list);			
	}

	@Override
	public void doDelevery(String orderNo) {
		om.changeStatus_deliverying(orderNo);
		om.changehiStatus_deliverying(orderNo);
	}
	
	@Override
	public void endDelevery(String orderNo) {
		om.changeStatus_finish(orderNo);
		om.changehiStatus_finish(orderNo);
	}

	@Override
	public ArrayList<OrderDTO> getSearchList(OrderDTO dto,String type,String keyword) {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.selectSearchList(dto,type,keyword);
		
		return list;
	}

	@Override
	public ArrayList<OrderDTO> orderNoSorting_ASC() {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.orderNoSorting_ASC();
		return list;
	}
	@Override
	public ArrayList<OrderDTO> orderNoSorting_DESC() {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.orderNoSorting_DESC();
		
		return list;
	}

	@Override
	public ArrayList<OrderDTO> memberIdSorting_ASC() {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.memberIdSorting_ASC();
		return list;
	}

	@Override
	public ArrayList<OrderDTO> memberIdSorting_DESC() {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.memberIdSorting_DESC();
		return list;
	}

	@Override
	public ArrayList<OrderDTO> orderPriceSorting_ASC() {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.orderPriceSorting_ASC();
		return list;
	}

	@Override
	public ArrayList<OrderDTO> orderPriceSorting_DESC() {
		ArrayList<OrderDTO> list = new ArrayList<OrderDTO>();
		list = om.orderPriceSorting_DESC();
		return list;
	}
	
	
	
	
}
