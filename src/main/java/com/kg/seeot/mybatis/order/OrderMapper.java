package com.kg.seeot.mybatis.order;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

public interface OrderMapper {
	public void addOrder(OrderDTO dto);
	public void addOrderHistory(OrderHistoryDTO hdto);
}
