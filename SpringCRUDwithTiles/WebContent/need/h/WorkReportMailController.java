package com.avantel.funwork4.controller.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avantel.funwork4.controller.BaseController;
import com.avantel.funwork4.service.common.CommonUtilService;
import com.avantel.funwork4.service.common.SendMailService;
import com.avantel.funwork4.vo.common.EmployeeWeeklyReportVO;

@Controller
@RequestMapping(value = "/secured/workReportMail")
public class WorkReportMailController extends BaseController
{
	private static Log log = LogFactory.getLog(WorkReportMailController.class);
	
	@Autowired
	private SendMailService mailService;
	
	@Autowired
	private CommonUtilService commonUtilService;
	
	@RequestMapping(value = "/weeklyReport", method = RequestMethod.GET)
	public ModelAndView getWeeklyReport(HttpServletRequest request) 
	{
		String formattedMsg="";
		ModelAndView mav = new ModelAndView("weeklyReportMail");
		EmployeeWeeklyReportVO employeeWeeklyReportVO=new EmployeeWeeklyReportVO();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("dd-MMM-yyyy");
		employeeWeeklyReportVO.setEwrSubject("Weekly Report dt:"+simpleDateFormat.format(new Date()));
		mav.getModel().put("employeeWeeklyReportVO", employeeWeeklyReportVO);
		formattedMsg=commonUtilService.formatLoggerData("EmployeeWeeklyWorkReportMail", "Form Page" , request.getRemoteAddr(),"Add");
		log.info(formattedMsg);
		return mav;
	}
	
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public ModelAndView sendMail(HttpServletRequest request,EmployeeWeeklyReportVO employeeWeeklyReportVO,
			final RedirectAttributes redirectAttributes) 
	{
		ModelAndView mav = new ModelAndView("redirect:/secured/funwork-home");
		String formattedMsg="";
		try
		{
		mailService.sendEmployeeWeeklyWorkReport(employeeWeeklyReportVO);
		formattedMsg=commonUtilService.formatLoggerData("EmployeeWeeklyWorkReportMail", "Send Mail And Save In DB" , request.getRemoteAddr(),"Send Mail");
		log.info(formattedMsg);
		redirectAttributes.addFlashAttribute(FW_SUCCESS,"Mail has been sent successfully");
		}
		catch(Throwable th)
		{
			formattedMsg=commonUtilService.formatLoggerData("EmployeeWeeklyWorkReportMail Error",th.getMessage() , request.getRemoteAddr(),"Send Mail");
			log.error(formattedMsg,th);
			th.printStackTrace();
			redirectAttributes.addFlashAttribute(FW_ERROR,"Error Occured While Sending Mail");
		}
		return mav;
	}
	
	@RequestMapping(value = "/weeklyReportListByEmpCode", method = RequestMethod.GET)
	public @ResponseBody List<EmployeeWeeklyReportVO> getWeeklyReportListByEmpCode(HttpServletRequest request,@RequestParam("empCode") int empCode) {
		String formattedMsg="";
		List<EmployeeWeeklyReportVO> employeeWeeklyReportVOList=null;
		try {
			employeeWeeklyReportVOList=mailService.getWeeklyReportMails(empCode);
			formattedMsg=commonUtilService.formatLoggerData("EmployeeWeeklyWorkReportMail", "Weekly Report List By Emp Code" , request.getRemoteAddr(),"List");
			log.info(formattedMsg);
		} catch (Throwable th) {
			formattedMsg=commonUtilService.formatLoggerData("EmployeeWeeklyWorkReportMail Error",th.getMessage() , request.getRemoteAddr(),"Weekly Report List By Emp Code");
			log.error(formattedMsg,th);
			th.printStackTrace();
		}
		return employeeWeeklyReportVOList;
	}
}
