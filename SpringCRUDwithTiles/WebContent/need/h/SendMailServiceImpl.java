package com.avantel.funwork4.service.common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.avantel.funwork4.bo.common.EmployeeWeeklyReportBO;
import com.avantel.funwork4.bo.hr.general.DepartmentBO;
import com.avantel.funwork4.common.utils.ContextUtils;
import com.avantel.funwork4.dao.common.EmployeeWeeklyReportDao;
import com.avantel.funwork4.service.BaseServiceImpl;
import com.avantel.funwork4.vo.MailVO;
import com.avantel.funwork4.vo.common.EmployeeWeeklyReportVO;

@Service("mailService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class SendMailServiceImpl extends BaseServiceImpl implements SendMailService{


	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private CommonUtilService commonUtilService;
	
	@Autowired
	private EmployeeWeeklyReportDao employeeWeeklyReportDao;
	
	@Transactional
	public boolean sendEmployeeWeeklyWorkReport(EmployeeWeeklyReportVO employeeWeeklyReportVO)throws MessagingException,Exception
	{
		boolean status=false;
		try
		{
			MailVO mailVO=new MailVO();
			mailVO.setFrom(employeeWeeklyReportVO.getEwrFromMailId());
			mailVO.setTo(employeeWeeklyReportVO.getEwrToMailId());
			mailVO.setSubject(employeeWeeklyReportVO.getEwrSubject());
			mailVO.setMessageBody(employeeWeeklyReportVO.getEwrBody());
			mailVO.setCc(employeeWeeklyReportVO.getEwrCCMailIds());
			mailVO.setAttachmentStatus(employeeWeeklyReportVO.getAttachmentStatus());
			//send mail with attchments
			sendMail(mailVO);
			
			EmployeeWeeklyReportBO employeeWeeklyReportBO=new EmployeeWeeklyReportBO();
			copy(employeeWeeklyReportVO,employeeWeeklyReportBO);
			
			//employee code,dept from user context
			//int employeeCode=Integer.parseInt(ContextUtils.getUserContext().getUser().getUserId());
			DepartmentBO departmentBO=ContextUtils.getUserContext().getModuleDepartment();
			//employeeWeeklyReportBO.setEwrEmpCode(employeeCode);
			employeeWeeklyReportBO.setEwrDeptId(departmentBO);
			employeeWeeklyReportBO.setEwrDate(new Date());
			employeeWeeklyReportDao.save(employeeWeeklyReportBO);
			status=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
		return status;
	}
	
	//Common Send Mail Method
	public void sendMail(MailVO mailVO)throws MessagingException,Exception
	{
		try
		{
		//creating MIME message
	    MimeMessage message = mailSender.createMimeMessage();  	
	    MimeMessageHelper helper = new MimeMessageHelper(message, true);  	
		//SimpleMailMessage simpleMailMessage=new SimpleMailMessage();
	    helper.setFrom(mailVO.getFrom().trim());
	    helper.setTo(mailVO.getTo().trim());
	    helper.setSubject(mailVO.getSubject());
	    helper.setText(mailVO.getMessageBody());
	    
	    helper.setBcc(mailVO.getFrom().trim());
	    
		//prepare cc
		String cc=mailVO.getCc().trim();
		if(cc!=null && cc!="" && cc.length() > 0)
		{
		String[] ccArr=cc.split(",");
		if(ccArr!=null && ccArr.length > 0)
		{
			helper.setCc(ccArr);
		}
		}
		
		// attach the file  
		if(mailVO.getAttachmentStatus() > 0)
		{
			helper=prepareAttachments(helper);
		}
		
		//sending message  
        mailSender.send(message);
        
		}
		catch(MessagingException me)
		{
			me.printStackTrace();
			throw me;
		}  
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
	}
	public void sendAttendance(MailVO mailVO)throws MessagingException,Exception
	{
		try
		{
		//creating MIME message
	    MimeMessage message = mailSender.createMimeMessage();  	
	    MimeMessageHelper helper = new MimeMessageHelper(message, true);  	
		//SimpleMailMessage simpleMailMessage=new SimpleMailMessage();
	    helper.setFrom(mailVO.getFrom().trim());
	    helper.setTo(mailVO.getTo().trim());
	    helper.setSubject(mailVO.getSubject());
	    helper.setText(mailVO.getMessageBody());
	    
	    helper.setBcc(mailVO.getFrom().trim());
	    message.setText(mailVO.getMessageBody(), "iso-8859-1", "html");
		//prepare cc
		String cc=mailVO.getCc().trim();
		if(cc!=null && cc!="" && cc.length() > 0)
		{
		String[] ccArr=cc.split(",");
		if(ccArr!=null && ccArr.length > 0)
		{
			helper.setCc(ccArr);
		}
		}
		
		// attach the file  
		if(mailVO.getAttachmentStatus() > 0)
		{
			helper=prepareAttachments(helper);
		}
		
		//sending message  
        mailSender.send(message);
        
		}
		catch(MessagingException me)
		{
			me.printStackTrace();
			throw me;
		}  
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
	}
	
	private MimeMessageHelper prepareAttachments(MimeMessageHelper helper)throws Exception
	{
		//UserId From Context
		String UserId=ContextUtils.getUserContext().getUser().getUserId();
	
		String docName="SpecDocuments";
		Date currntDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String docNum="WorkReport-"+sdf.format(currntDate)+"-"+UserId;
		
		String destinationPath = commonUtilService.getAttachmentsFullPath("", docName, docNum);
		String sourcePath = commonUtilService.getAttachmentsFullPath("", docName, "");
		File dest = new File(destinationPath);
		File src = new File(sourcePath);
		try {
			FileSystemResource fileSystemResource = null;
			FileUtils.copyDirectory(src, dest);
			 for (final File fileEntry : dest.listFiles()) {
			        if (fileEntry.isFile()) {
			        	fileSystemResource=new FileSystemResource(fileEntry);
			        	helper.addAttachment(UserId+"_"+fileEntry.getName(), fileSystemResource);
			        }
			    }
			 FileUtils.deleteDirectory(src);
			//src.delete();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return helper;
	}
	
	@Transactional
	public List<EmployeeWeeklyReportVO> getWeeklyReportMails(int ewrEmpCode)
	{
		List<EmployeeWeeklyReportVO> employeeWeeklyReportVOList=new ArrayList<EmployeeWeeklyReportVO>();
		try
		{
			List<EmployeeWeeklyReportBO> employeeWeeklyReportBOList=employeeWeeklyReportDao.getPreviousSentWorkReportList(ewrEmpCode);
			if(employeeWeeklyReportBOList!=null && employeeWeeklyReportBOList.size() > 0)
			{
				for(EmployeeWeeklyReportBO employeeWeeklyReportBO : employeeWeeklyReportBOList)
				{
					if(employeeWeeklyReportBO!=null && employeeWeeklyReportBO.getEwrId() > 0)
					{
						EmployeeWeeklyReportVO employeeWeeklyReportVO=new EmployeeWeeklyReportVO();
						copy(employeeWeeklyReportBO,employeeWeeklyReportVO);
						employeeWeeklyReportVOList.add(employeeWeeklyReportVO);
					}
				}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
		return employeeWeeklyReportVOList;
	}
}
