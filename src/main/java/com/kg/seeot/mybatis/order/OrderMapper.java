package com.kg.seeot.mybatis.order;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

public interface OrderMapper {
	public void addOrder(OrderDTO dto);
	public void addOrderHistory(OrderHistoryDTO hdto);
	public void getOrder(@Param("m") String memberId, @Param("o") String orderNo);
	public void getOrders(String memberId);
	public ArrayList<OrderDTO> getAllOrders();
	
	public void changeStatus_canceling(@Param("o")String orderNo, @Param("m")String memberId);//취소중
	public void changeStatus_canceled(@Param("o")String orderNo, @Param("m")String memberId);//취소됨
	public void changeStatus_deliverying(@Param("o")String orderNo, @Param("m")String memberId);//배송중
	public void changeStatus_finish(@Param("o")String orderNo, @Param("m")String memberId);//배송완
	
	public void changehiStatus_canceling(@Param("o")String orderNo, @Param("m")String memberId);//취소중
	public void changehiStatus_canceled(@Param("o")String orderNo, @Param("m")String memberId);//취소됨
	public void changehiStatus_deliverying(@Param("o")String orderNo, @Param("m")String memberId);//배송중
	public void changehiStatus_finish(@Param("o")String orderNo, @Param("m")String memberId);//배송완
}
