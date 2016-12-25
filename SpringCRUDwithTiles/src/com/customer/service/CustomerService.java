package com.customer.service;

import java.util.List;

import com.customer.vo.CustomerVO;

public interface CustomerService {

	public CustomerVO saveOrUpdateCustomer(CustomerVO customerVO);
	public List<CustomerVO> getCustomerList();
	public CustomerVO getCustomer(Integer customerId);
	public void  deleteCustomer(Integer customerId);
}
