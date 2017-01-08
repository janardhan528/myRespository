package com.avantel.funwork4.service.common;

import java.util.List;

import javax.mail.MessagingException;

import com.avantel.funwork4.vo.MailVO;
import com.avantel.funwork4.vo.common.EmployeeWeeklyReportVO;

public interface SendMailService {

	public boolean sendEmployeeWeeklyWorkReport(EmployeeWeeklyReportVO employeeWeeklyReportVO)throws MessagingException,Exception;
	public void sendMail(MailVO mailVO)throws MessagingException,Exception;
	public List<EmployeeWeeklyReportVO> getWeeklyReportMails(int ewrEmpCode);
	public void sendAttendance(MailVO mailVO)throws MessagingException,Exception;
}
