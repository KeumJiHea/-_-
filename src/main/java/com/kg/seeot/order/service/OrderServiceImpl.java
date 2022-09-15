package com.kg.seeot.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kg.seeot.mybatis.order.OrderMapper;
import com.kg.seeot.order.dto.OrderDTO;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired OrderMapper om;
	
	@Override
	public void addOrder(OrderDTO dto) {
		om.addOrder(dto);
	}
	
}
