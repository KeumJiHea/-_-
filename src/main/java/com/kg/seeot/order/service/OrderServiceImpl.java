package com.kg.seeot.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kg.seeot.mybatis.order.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired OrderMapper om;
	
	@Override
	public void addOrder(String memberId) {
		om.addOrder(memberId);
	}
	
}
