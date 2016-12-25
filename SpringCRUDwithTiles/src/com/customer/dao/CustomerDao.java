package com.customer.dao;

import org.springframework.data.repository.CrudRepository;

import com.customer.bo.CustomerBO;

public interface CustomerDao extends CrudRepository<CustomerBO, Integer> {

}
