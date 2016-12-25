package com.customer.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.customer.bo.CustomerBO;
import com.customer.dao.CustomerDao;
import com.customer.vo.CustomerVO;

@Service("customerService")
@Transactional(propagation = Propagation.SUPPORTS , readOnly = true)
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerDao customerDao;
	
	@Override
	@Transactional
	public CustomerVO saveOrUpdateCustomer(CustomerVO customerVO) {
		CustomerBO customerBO=null;
		try
		{
			if(customerVO.getCustomerId() > 0)
			{
				customerBO=customerDao.findOne(customerVO.getCustomerId());
			}
			else
			{
				customerBO=new CustomerBO();
			}
		
			BeanUtils.copyProperties(customerVO, customerBO);
			customerBO=customerDao.save(customerBO);
			customerVO.setCustomerId(customerBO.getCustomerId());
			
			return customerVO;
		}
		catch(Exception e)
		{
		return null;
		}
	}
	
	@Override
	@Transactional
	public List<CustomerVO> getCustomerList() {
		List<CustomerVO> customerVOList=new ArrayList<CustomerVO>();
		List<CustomerBO> customerBOList=(List<CustomerBO>) customerDao.findAll();
		CustomerVO customerVO;
		for(CustomerBO customerBO:customerBOList)
		{
			customerVO=new CustomerVO();
			BeanUtils.copyProperties(customerBO,customerVO);
			customerVOList.add(customerVO);
		}
		return customerVOList;
	}

	
	@Override
	public CustomerVO getCustomer(Integer customerId) {
		
		CustomerBO customerBO= customerDao.findOne(customerId);
		CustomerVO customerVO=new CustomerVO();;
		
		BeanUtils.copyProperties(customerBO,customerVO);
			
		return customerVO;
	}

	@Override
	public void deleteCustomer(Integer customerId) {
		
		
		customerDao.delete(customerId);
		
			
	}

}
