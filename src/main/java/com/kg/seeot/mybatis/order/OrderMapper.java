package com.kg.seeot.mybatis.order;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.order.dto.CancelDTO;
import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

public interface OrderMapper {
	public void addOrder(OrderDTO dto);
	public void addOrderHistory(OrderHistoryDTO hdto);
	public OrderDTO getOrder(String orderNo);
	public ArrayList<OrderDTO> getOrders(String memberId);
	public ArrayList<OrderDTO> getCancelOrder(String orderNo);
	public ArrayList<OrderDTO> getAllOrders();
	
	public void addcancel_1(@Param("m") String memberId,@Param("o") String orderNo, @Param("r") String reason);	
	//public void addcancel_2(String orderNo);	
	public CancelDTO getcancel(@Param("m") String memberId,@Param("o") String orderNo);
	public void orderdel(String orderNo);
	
	
	public void changeStatus_canceling(String orderNo);//취소중
	public void changeStatus_canceled(String orderNo);//취소됨
	public void changeStatus_deliverying(String orderNo);//배송중
	public void changeStatus_finish(String orderNo);//배송완
	
	public void changehiStatus_canceling(String orderNo);//취소중
	public void changehiStatus_canceled(String orderNo);//취소됨
	public void changehiStatus_deliverying(String orderNo);//배송중
	public void changehiStatus_finish(String orderNo);//배송완

	public ArrayList<OrderDTO> selectSearchList(@Param("d")OrderDTO dto,@Param("t")String type,@Param("k")String keyword);
	public ArrayList<OrderDTO> orderNoSorting_ASC();
	public ArrayList<OrderDTO> orderNoSorting_DESC();
	public ArrayList<OrderDTO> memberIdSorting_ASC();
	public ArrayList<OrderDTO> memberIdSorting_DESC();
	public ArrayList<OrderDTO> orderPriceSorting_ASC();
	public ArrayList<OrderDTO> orderPriceSorting_DESC();
}
