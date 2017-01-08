package com.avantel.funwork4.controller.common;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.avantel.funwork4.bo.common.SystemModule;
import com.avantel.funwork4.bo.common.UserBO;
import com.avantel.funwork4.common.context.UserContext;
import com.avantel.funwork4.controller.BaseController;
import com.avantel.funwork4.service.common.CommonUtilService;
import com.avantel.funwork4.service.common.PasswordService;
import com.avantel.funwork4.vo.common.ChangePasswordVO;


@Controller
@RequestMapping(value = "/secured/password")
public class ChangePasswordController extends BaseController{
	
	
	
	@Autowired
	private PasswordService passwordService;
	
	@Autowired
	private CommonUtilService commonUtilService;
	
	
	@RequestMapping(value = "/newPassword", method = RequestMethod.GET)
	public ModelAndView changingPassword(HttpServletRequest request) {
	
		String tilesStr="";
		//get user id
		UserContext userContextVO = (UserContext)request.getSession().getAttribute("userContextVO");
		SystemModule systemModule=userContextVO.getDefaultSelectedModule();
		int moduleId=systemModule.getId();
		if(moduleId != 17)
		{
			tilesStr="passwordDetails";
		}
		else
		{
			tilesStr="MIS-passwordDetails";
		}
		ModelAndView mav = new ModelAndView(tilesStr);
		//ModelAndView mav = new ModelAndView("passwordDetails");
		ChangePasswordVO passwordVO=new ChangePasswordVO();
		//UserContext userContextVO = (UserContext)request.getSession().getAttribute("userContextVO");
		UserBO userBO=userContextVO.getUser();
		passwordVO.setUserId(userBO.getUserId());
		passwordVO.setUserName(userBO.getUserName());
		passwordVO.setOldPassword(userBO.getUserPassword());
		
		mav.getModel().put("password", passwordVO);
		return mav;
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView savePassword(HttpServletRequest request,ChangePasswordVO passwordVO) {
	
		ModelAndView mav = new ModelAndView("passwordDetails");
		passwordService.updatePassword(passwordVO);
		mav.getModel().put("password", passwordVO);
		addTransactionMsgToModel(mav,"Password Changed Suceessfully");
		return mav;
	}
	
	@RequestMapping(value = "/getEncPwd", method = RequestMethod.GET)
	public @ResponseBody String getMD5EncryptedPassword(HttpServletRequest request,@RequestParam("enteredPwd") String enteredPwd) 
	{
	String encPwd=commonUtilService.Md5PasswordEncoder(enteredPwd);
	return encPwd;
	}
	
	
}