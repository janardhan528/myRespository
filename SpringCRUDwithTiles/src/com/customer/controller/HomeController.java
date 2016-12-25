package com.customer.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.customer.service.CustomerService;
import com.customer.vo.CustomerVO;

/**
 * Handles requests for the application home page.
 */
@Controller
/*@RequestMapping("/customer")*/
public class HomeController {
	
	
	
	@Autowired
	private CustomerService customerService;
	
	@RequestMapping("/edit/{CustomerId}")
	public ModelAndView getBook(@PathVariable Integer CustomerId) {

		ModelAndView mav=new ModelAndView("newCustomer");
		
	
		CustomerVO customerVO=customerService.getCustomer(CustomerId);
		
		 mav.getModel().put("customerVOCommond",  customerVO);
		
		return mav;
	}
	
	@RequestMapping(value="/addCustomerPage", method = RequestMethod.GET)
	public ModelAndView getAddCustomerPage(@ModelAttribute("customerVOCommond") CustomerVO customerVOCommond) {
 
		ModelAndView mav=new ModelAndView("newCustomer");
		return mav;
 
	}
	
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	public String saveCustomer(@ModelAttribute("customerVOCommond") CustomerVO customerVOCommond,BindingResult result)
	{
		customerVOCommond=customerService.saveOrUpdateCustomer(customerVOCommond);
		
		return "redirect:listCustomers";
	}
	
	@RequestMapping(value = { "/", "/listCustomers" }, method = RequestMethod.GET)
	public ModelAndView  getCustomerList()
	{
		ModelAndView mav=new ModelAndView("customerDetails");
		List<CustomerVO> customerVOList=customerService.getCustomerList();
		
		
		  mav.getModel().put("customerVOList",  customerVOList);
		  return mav;
	}
	@RequestMapping("/delete/{CustomerId}")
	public ModelAndView deleteBook(@PathVariable Integer CustomerId) {
		
	

		customerService.deleteCustomer(CustomerId);
		
		return new ModelAndView("redirect:/listCustomers");
	}
	
	@RequestMapping(value = { "/customersListJSON" }, method = RequestMethod.GET)
	public @ResponseBody  List<CustomerVO> getListJSON()
	{
	
		List<CustomerVO> customerVOList=customerService.getCustomerList();
	    return customerVOList;
	}
}
