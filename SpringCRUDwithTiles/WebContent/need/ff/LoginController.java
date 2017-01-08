/**
  * @Company : Avantel Ltd
  * @Product : Funwork
  * 
  * @Package com.avantel.funwork4.controller.web
  * @Class   LoginController.java
  * @module  {{Module}}
  *
  * This LoginController.java contains ... {brief description on what the code in this file does}
  *
  * @author Arvi Software
  * @version 1.0
  * @copyright Copyright © 2014 Avantel Ltd.
  * 
  */
package com.avantel.funwork4.controller.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.avantel.funwork4.service.common.CommonUtilService;

@Controller
public class LoginController {
	
	private static Log log = LogFactory.getLog(LoginController.class);
	
	@Autowired
	private CommonUtilService commonUtilService;
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
    public ModelAndView login() {
		if (log.isInfoEnabled()) log.info(" LoginController ::  login :: ");
		return new ModelAndView("login");
        
    }
	
	@RequestMapping(value="/timeout", method = RequestMethod.GET)
    public ModelAndView timeout() {
		if (log.isInfoEnabled()) log.info(" LoginController ::  timeout :: ");
		return new ModelAndView("timeout");
        
    }
	@RequestMapping(value="/accessDenied", method = RequestMethod.GET)
    public ModelAndView acccesDenied(HttpServletRequest request) {
		String formattedMsg="";
		if (log.isInfoEnabled()) log.info(" LoginController ::  accessDenied :: ");
		formattedMsg=commonUtilService.formatLoggerData("Access Denied","Does not have Permissions", request.getRemoteAddr(),"Check Permissions");
		log.info(formattedMsg);
		return new ModelAndView("accessDenied");
        
    }
	
}
