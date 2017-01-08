	package com.avantel.funwork4.service.hr.employee;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.joda.time.DateTime;
import org.joda.time.Months;
import org.joda.time.Years;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avantel.funwork4.bo.common.BranchMasterBO;
import com.avantel.funwork4.bo.common.SystemModule;
import com.avantel.funwork4.bo.common.UserBO;
import com.avantel.funwork4.bo.common.UserModuleBO;
import com.avantel.funwork4.bo.hr.employee.EmployeeMasterBO;
import com.avantel.funwork4.bo.hr.employee.EmployeePolicyDetailBO;
import com.avantel.funwork4.bo.hr.employee.EmployeePrevExperienceBO;
import com.avantel.funwork4.bo.hr.employee.EmployeeTransactionBO;
import com.avantel.funwork4.bo.hr.general.BankBO;
import com.avantel.funwork4.bo.hr.general.DepartmentBO;
import com.avantel.funwork4.bo.hr.general.DesignationBO;
import com.avantel.funwork4.bo.hr.general.LeaveLedgerBO;
import com.avantel.funwork4.bo.hr.general.OutsourcingAgencyBO;
import com.avantel.funwork4.bo.hr.general.PackageBO;
import com.avantel.funwork4.common.exception.FunworkBusinessException;
import com.avantel.funwork4.common.utils.BranchMasterVO;
import com.avantel.funwork4.common.utils.FunworkProperties;
import com.avantel.funwork4.dao.common.GeneralDao;
import com.avantel.funwork4.dao.common.SystemModuleDao;
import com.avantel.funwork4.dao.common.UserDao;
import com.avantel.funwork4.dao.common.UserModuleDao;
import com.avantel.funwork4.dao.hr.employee.EmployeeDao;
import com.avantel.funwork4.dao.hr.employee.EmployeePolicydetailDao;
import com.avantel.funwork4.dao.hr.employee.EmployeePrevexperienceDao;
import com.avantel.funwork4.dao.hr.employee.EmployeeTransactionDao;
import com.avantel.funwork4.dao.hr.general.BankDao;
import com.avantel.funwork4.dao.hr.general.LeaveLedgerDao;
import com.avantel.funwork4.service.common.CommonUtilService;
import com.avantel.funwork4.vo.common.FileMeta;
import com.avantel.funwork4.vo.common.FinancialYearVO;
import com.avantel.funwork4.vo.common.QueryParamsVO;
import com.avantel.funwork4.vo.hr.employee.EmpTransSummaryVO;
import com.avantel.funwork4.vo.hr.employee.EmployeeLeaveLedgerVO;
import com.avantel.funwork4.vo.hr.employee.EmployeeMasterVO;
import com.avantel.funwork4.vo.hr.employee.EmployeePolicydetailVO;
import com.avantel.funwork4.vo.hr.employee.EmployeePrevexperienceVO;
import com.avantel.funwork4.vo.hr.employee.EmployeeSummaryVO;
import com.avantel.funwork4.vo.hr.employee.EmployeeTransactionVO;
import com.avantel.funwork4.vo.hr.general.BankVO;
import com.avantel.funwork4.vo.hr.general.DepartmentVO;
import com.avantel.funwork4.vo.hr.general.DesignationVO;
import com.avantel.funwork4.vo.hr.general.LeaveLedgerVO;
import com.avantel.funwork4.vo.hr.general.OutsourcingAgencyVO;
import com.avantel.funwork4.vo.hr.general.PackageVO;
import com.avantel.funwork4.vo.hr.report.ManPowerEmpVO;

@Service("employeeService")
public class EmployeeServiceImpl extends EmployeeServiceImplHelper implements
		EmployeeService {

	@Autowired
	public EmployeeDao employeeDao;

	@Autowired
	public EmployeePolicydetailDao employeePolicyDao;

	@Autowired
	public EmployeePrevexperienceDao employeePrevExpDao;
	@Autowired
	public GeneralDao generalDao;

	@Autowired
	public LeaveLedgerDao leaveLedgerDao;
	
	@Autowired
	public EmployeeTransactionDao empTransactionDao;
	
	@Autowired
	public CommonUtilService commonUtilService;
	
	@Autowired
	public BankDao bankDao;;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private SystemModuleDao systemModuleDao;
	
	@Autowired
	private UserModuleDao userModuleDao;
	
	
	@Transactional
    public List<EmployeeSummaryVO> getEmployeeForEmpEdit() throws FunworkBusinessException {

		try {
            List<EmployeeSummaryVO> employeeList = (List<EmployeeSummaryVO>) employeeDao
                            .getEmployeeList(7);// type!=7
            return employeeList;
            
		} catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
            }
    }
	
	@Transactional
    public List<EmployeeMasterVO> getEmployee() throws FunworkBusinessException {

		try {
            List<EmployeeMasterBO> employeeList = (List<EmployeeMasterBO>) employeeDao
                            .getEmployeeListByType(7);// type!=7
            List<EmployeeMasterVO> empVOList = new ArrayList<EmployeeMasterVO>();
            if(employeeList!=null && employeeList.size() > 0)
            {
            for (EmployeeMasterBO ebo : employeeList) {
                    EmployeeMasterVO evo = new EmployeeMasterVO();
                    copy(ebo, evo);
                    
                    //dept
                    DepartmentBO departmentBO=ebo.getDepartment();
                    if(departmentBO!=null && departmentBO.getDepartmentId() > 0)
                    {
                    DepartmentVO departmentVO = new DepartmentVO();
                    copy(departmentBO, departmentVO);
                    evo.setHrDepartment(departmentVO);
                    }
                    
                    //desg
                    DesignationBO designationBO=ebo.getHrDesignation();
                    if(designationBO!=null && designationBO.getDesignationId() > 0)
                    {
                    DesignationVO designationVO = new DesignationVO();
                    copy(designationBO, designationVO);
                    evo.setDesignation(designationVO);
                    }
                    
                    byte empPhotoBytes[]=ebo.getEmployeePhoto();
                    if(empPhotoBytes!=null && empPhotoBytes.length > 0)
                    {
                    byte[] encoded=Base64.encodeBase64(empPhotoBytes);
        		    String encodedString = new String(encoded);
        		    evo.setEmpPhotoEncodedString(encodedString);
                    }
                    empVOList.add(evo);
            }
            }
            return empVOList;
		} catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
            }
    }
	
	
	@Transactional
    public List<EmpTransSummaryVO> getEmployeeNameforPagePermission() throws FunworkBusinessException {

		try {
			return employeeDao.getEmployeeNameList(7);// type!=7
		} catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
            }
    }
	
	@Transactional
    public List<EmpTransSummaryVO> getEmployeelistForUserCreation() {

		try {
			return employeeDao.getEmployeeListForUserCreation(7);// type!=7
		} catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
            }
    }

	@Transactional
	public List<EmployeeMasterVO> getEmployee(int deptid) throws FunworkBusinessException {

		try {
			;
			List<EmployeeMasterBO> employee = (List<EmployeeMasterBO>) employeeDao.getEmployeeListByDept(deptid);// type=2 Marketing
			List<EmployeeMasterVO> empVO = new ArrayList<EmployeeMasterVO>();
			for (EmployeeMasterBO ebo : employee) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(ebo.getDepartment(), departmentVO);

				DesignationVO designationVO = new DesignationVO();
				copy(ebo.getHrDesignation(), designationVO);

				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);

				empVO.add(evo);
			}
			return empVO;
		} catch (Exception ex) {
			//System.out.println("error: " + ex.getMessage());
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmployeeListForResourceAllocation(
			int deptId) throws FunworkBusinessException {
		try {
			/*List<EmployeeMasterBO> employee = (List<EmployeeMasterBO>) employeeDao
					.fetchEmpListForResourceAllocation(deptId);*/
			List<EmployeeMasterVO> empVO = employeeDao.fetchEmpListForResourceAllocation(deptId);
			/*for (EmployeeMasterBO ebo : employee) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				empVO.add(evo);
			}*/
			return empVO;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional(rollbackFor = Exception.class)
	public boolean saveEmployeeDetails(EmployeeMasterVO employeeMasterVO)
			throws FunworkBusinessException,IOException {
		Integer maxCode = null;
		maxCode = employeeDao.getMaxCode(employeeMasterVO.getEmployeeType());
		try {
			EmployeeMasterBO employeeMasterBO = new EmployeeMasterBO();
			copy(employeeMasterVO, employeeMasterBO);
			String empFullName = employeeMasterVO.getEmployeeName() + " "
					+ employeeMasterVO.getEmployeeLastName();
			
			if (employeeMasterVO.getEmployeeType() == 7) //for OutSopurce Employees 
			{
				//HR_UpdateSalaryforOutSource
				BigDecimal ctcVal=employeeMasterVO.getEmployeeCTCValue();
				if(ctcVal == null)
					ctcVal=BigDecimal.ZERO;
				employeeMasterBO.setEmployeeCTCValue(ctcVal);
				/*BankBO bankBO = new BankBO();
				copy(employeeMasterVO.getHrEmployeeBankId(), bankBO);
				PackageBO packageBO = new PackageBO();
				copy(employeeMasterVO.getHrEmployeePackageId(), packageBO);
				employeeMasterBO.setEmployeeBank(bankBO);
				employeeMasterBO.setEmployeePackage(packageBO);*/
			}
			else
			{
			//bank
			BankVO bankVO=employeeMasterVO.getHrEmployeeBankId();
			if(bankVO!=null && bankVO.getBankId() > 0)
			{
			BankBO bankBO=new BankBO();
			copy(bankVO,bankBO);
			employeeMasterBO.setEmployeeBank(bankBO);
			}
			
			//package details
			PackageVO packageVO=employeeMasterVO.getHrEmployeePackageId();
			if(packageVO!=null && packageVO.getPackageId() > 0)
			{
				PackageBO packageBO=new PackageBO();
				copy(packageVO,packageBO);
				employeeMasterBO.setEmployeePackage(packageBO);
			}
			}
			//branch
			BranchMasterVO branchMasterVO=employeeMasterVO.getHrEmployeeBranchId();
			if(branchMasterVO!=null && branchMasterVO.getBranchMasterId() > 0)
			{
			BranchMasterBO branchMasterBO = new BranchMasterBO();
			copy(branchMasterVO,branchMasterBO);
			employeeMasterBO.setEmployeeBranch(branchMasterBO);
			}

			//group dept
			DepartmentVO departmentVO=employeeMasterVO.getEmployeeDeptGroupId();
			if(departmentVO!=null && departmentVO.getDepartmentId() > 0)
			{
			DepartmentBO departmentGroupBO = new DepartmentBO();
			copy(departmentVO,departmentGroupBO);
			employeeMasterBO.setEmployeeDeptGroupId(departmentGroupBO);
			}

			//hr dept
			DepartmentVO deptDesg=employeeMasterVO.getHrDepartment();
			if(deptDesg!=null && deptDesg.getDepartmentId() > 0)
			{
			DepartmentBO departmentBO = new DepartmentBO();
			copy(deptDesg, departmentBO);
			employeeMasterBO.setDepartment(departmentBO);
			}
			
			//desg
			DesignationVO designationVO=employeeMasterVO.getDesignation();
			if(designationVO!=null && designationVO.getDesignationId() > 0)
			{
			DesignationBO designationBO = new DesignationBO();
			copy(designationVO, designationBO);
			employeeMasterBO.setHrDesignation(designationBO);
			}
			
			//emp consultancy
			OutsourcingAgencyVO outsourcingAgencyVO=employeeMasterVO.getEmployeeConsultancyId();
			if (outsourcingAgencyVO != null && outsourcingAgencyVO.getOutsourcingId() > 0) {
				OutsourcingAgencyBO outSourcingAgencyBO = new OutsourcingAgencyBO();
				copy(outsourcingAgencyVO,outSourcingAgencyBO);
				employeeMasterBO.setEmployeeConsultancyId(outSourcingAgencyBO);
			}
			
			//employeeMasterBO.setCreatedOn(new Date());
			if (employeeMasterVO.getEmployeeType() == 1 || employeeMasterVO.getEmployeeType() == 6) {
				if (maxCode != null) {
					employeeMasterBO.setEmployeeCode(maxCode + 1);
				} else {
					employeeMasterBO.setEmployeeCode(1);
				}
			}
			else if (employeeMasterVO.getEmployeeType() == 2) {
				if (maxCode != null) {
					employeeMasterBO.setEmployeeCode(maxCode + 1);
				} else {
					employeeMasterBO.setEmployeeCode(1000);
				}
			} else if (employeeMasterVO.getEmployeeType() == 3) {
				if (maxCode != null) {
					employeeMasterBO.setEmployeeCode(maxCode + 1);
				} else {
					employeeMasterBO.setEmployeeCode(3000);
				}
			} else if (employeeMasterVO.getEmployeeType() == 4) {
				if (maxCode != null) {
					employeeMasterBO.setEmployeeCode(maxCode + 1);
				} else {
					employeeMasterBO.setEmployeeCode(7000);
				}
			} else if (employeeMasterVO.getEmployeeType() == 5) {
				if (maxCode != null) {
					employeeMasterBO.setEmployeeCode(maxCode + 1);
				} else {
					employeeMasterBO.setEmployeeCode(100000);
				}
			} else {
				if (maxCode != null) {
					employeeMasterBO.setEmployeeCode(maxCode + 1);
				} else {
					employeeMasterBO.setEmployeeCode(6000);
				}
			}
			employeeMasterBO.setEmployeeStatus(1);// status=1:Active

			//employeeMasterBO.setEmployeeCreditELYearly(0);
			//employeeMasterBO.setEmployeeeaveApprovalPermission(true);
			/*if (employeeMasterVO.getEmployeeType() == 1
					|| employeeMasterVO.getEmployeeType() == 6)
				employeeMasterBO.setEmployeeRegularised(1);
			else
				employeeMasterBO.setEmployeeRegularised(0);*/
			employeeMasterBO.setEmployeeFullName(empFullName);

			//photo and signature
			String empPhotoURL=employeeMasterVO.getEmployeePhotoURL();
			if(empPhotoURL!=null && empPhotoURL!="" && empPhotoURL.length() > 0)
			{
				byte[] empPhotoBytes=commonUtilService.getBytesFromFile(empPhotoURL);
				if(empPhotoBytes!=null && empPhotoBytes.length > 0)
					employeeMasterBO.setEmployeePhoto(empPhotoBytes);
			}
			
			String empSignatureURL=employeeMasterVO.getEmployeeSignatureURL();
			if(empSignatureURL!=null && empSignatureURL!="" && empSignatureURL.length() > 0)
			{
				byte[] empSignatureBytes=commonUtilService.getBytesFromFile(empSignatureURL);
				if(empSignatureBytes!=null && empSignatureBytes.length > 0)
					employeeMasterBO.setEmployeeSignature(empSignatureBytes);
			}
			
			employeeMasterBO = employeeDao.save(employeeMasterBO);
			
			//Educational and Professional Attachments
			List<FileMeta> empEducationalDetails=employeeMasterVO.getEmpEducationalMetaData();
			if(empEducationalDetails!=null && empEducationalDetails.size() > 0)
			{
				String folderPath=employeeMasterVO.getEmpDetailsName();
				String docNum=employeeMasterVO.getEmpEducationalName();
				String docName=employeeMasterBO.getEmployeeCode()+"";
				commonUtilService.saveAttachments(folderPath, docName, docNum, empEducationalDetails);
			}
			
			List<FileMeta> empProfessionalDetails=employeeMasterVO.getEmpProfessionalMetaData();
			if(empProfessionalDetails!=null && empProfessionalDetails.size() > 0)
			{
				String folderPath=employeeMasterVO.getEmpDetailsName();
				String docNum=employeeMasterVO.getEmpProfessionalName();
				String docName=employeeMasterBO.getEmployeeCode()+"";
				commonUtilService.saveAttachments(folderPath, docName, docNum, empProfessionalDetails);
			}
			
			//emp policy details
			List<EmployeePolicydetailVO> empPolicyDetails = employeeMasterVO.getHrEmpPolacyDetails();
			List<EmployeePolicyDetailBO> detailBOList = new ArrayList<EmployeePolicyDetailBO>();
			if (empPolicyDetails != null && empPolicyDetails.size() > 0) {
				for (EmployeePolicydetailVO detail : empPolicyDetails) {
					if (!detail.isDeleteIndicator()) {
						EmployeePolicyDetailBO empPolicyDetail = cloneEmployeePolicydetailBO(
								detail, employeeMasterBO);
						detailBOList.add(empPolicyDetail);
					}
				}
				if(detailBOList.size() > 0)
					detailBOList = (List<EmployeePolicyDetailBO>) employeePolicyDao.save(detailBOList);
			}
			
			//emp prev exp
			List<EmployeePrevexperienceVO> empPrevExpDetails = employeeMasterVO.getHrEempPrevExperience();
			List<EmployeePrevExperienceBO> detailsBOlist = new ArrayList<EmployeePrevExperienceBO>();
			if (empPrevExpDetails != null && empPrevExpDetails.size() > 0) {
				for (EmployeePrevexperienceVO details : empPrevExpDetails) {
					if (!details.isDeleteIndicator()) {
						EmployeePrevExperienceBO empPrevExpDetail = cloneEmployeePrevexperienceBO(
								details, employeeMasterBO);
						detailsBOlist.add(empPrevExpDetail);
					}
				}
				if(detailsBOlist.size() > 0)
					detailsBOlist = (List<EmployeePrevExperienceBO>) employeePrevExpDao.save(detailsBOlist);
			}
			copy(employeeMasterBO,employeeMasterVO);
			
			//AddEmployeeCL
			Calendar calDate = Calendar.getInstance(); 
			calDate.setTime(employeeMasterBO.getEmployeeDateofJoining());
			
			int month=calDate.get(Calendar.MONTH);
			int year=calDate.get(Calendar.YEAR);
			
			LeaveLedgerBO leaveLedgerBO=new LeaveLedgerBO();
			leaveLedgerBO.setLeaveLedgerEmpId(employeeMasterBO);
			leaveLedgerBO.setLeaveLedgerYear(year);
			BigDecimal leaveLedgerCL=new BigDecimal(12).subtract(new BigDecimal(month));
			leaveLedgerBO.setLeaveLedgerCL(leaveLedgerCL);
			leaveLedgerBO.setLeaveLedgerEL(BigDecimal.ZERO);
			leaveLedgerDao.save(leaveLedgerBO);
			
			//Add UserBO
			int empType=employeeMasterBO.getEmployeeType();
			if(empType == 1 || empType == 2 || empType == 3 || empType == 4 || empType == 6)
			{
			UserBO userBO=new UserBO();
			userBO.setUserId(employeeMasterBO.getEmployeeCode()+"");
			userBO.setUserName(employeeMasterBO.getEmployeeFullName());
			//getting pwd from property file
			String password = FunworkProperties.getProperty(FunworkProperties.USER_PASSWORD);
			userBO.setUserPassword(password);
			userBO.setUserEmployeeId((int)employeeMasterBO.getEmployeeId());
			DesignationBO designationBO=employeeMasterBO.getHrDesignation();
			if(designationBO!=null && designationBO.getDesignationId() > 0)
			{
				userBO.setUserDesignation(designationBO.getDesignationName());
			}
			userBO.setUserEmail(employeeMasterBO.getEmployeeMailId());
			userBO.setUserRoleId(3);
			userBO=userDao.save(userBO);
			
			//Add UserModule
			DepartmentBO departmentBO=employeeMasterBO.getDepartment();
			if(departmentBO!=null && departmentBO.getDepartmentId() > 0)
			{
				List<SystemModule> systemModuleList=systemModuleDao.getSystemModuleByDept(departmentBO.getDepartmentId(),new PageRequest(0, 1));
				if(systemModuleList!=null && systemModuleList.size() > 0)
				{
				SystemModule systemModule=systemModuleList.get(0);
				UserModuleBO userModuleBO=new UserModuleBO();
				userModuleBO.setUserId((long)userBO.getUserSno());
				userModuleBO.setModuleId(systemModule);
				userModuleBO.setDeafultModuleId(true);
				userModuleDao.save(userModuleBO);
				}
			}
			}
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Transactional
	public EmployeeMasterVO editEmployeeDetails(long employeeId)
			throws FunworkBusinessException {
		EmployeeMasterVO employeerMasterVO = null;
		try
		{
		EmployeeMasterBO employeeMasterBO = employeeDao.findOne(employeeId);
		if(employeeMasterBO!=null && employeeMasterBO.getEmployeeId() > 0)
		{
			employeerMasterVO = cloneEmployeeMasterVO(employeeMasterBO);
		}
		else
		{
			employeerMasterVO=new EmployeeMasterVO();
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
		return employeerMasterVO;
	}

	@Transactional(rollbackFor = Exception.class)
	public boolean UpdateEmployeeDetails(EmployeeMasterVO employeeMasterVO)
			throws FunworkBusinessException,IOException {

		try {
			int deptId=0;
			EmployeeMasterBO employeeMasterBO = employeeDao.findOne(employeeMasterVO.getEmployeeId());
			DepartmentBO deptBO=employeeMasterBO.getDepartment();
			if(deptBO!=null && deptBO.getDepartmentId() > 0)
			{
				deptId=deptBO.getDepartmentId();
			}
			byte[] empPhotoBytesData=employeeMasterBO.getEmployeePhoto();
			byte[] empSignatureBytesData=employeeMasterBO.getEmployeeSignature();
			employeeMasterVO.setEmployeeCode(employeeMasterBO.getEmployeeCode());
			copy(employeeMasterVO, employeeMasterBO);

			String empFullName = employeeMasterVO.getEmployeeName() + " "
					+ employeeMasterVO.getEmployeeLastName();
			if (employeeMasterVO.getEmployeeType() == 7) {
				BigDecimal ctcVal=employeeMasterVO.getEmployeeCTCValue();
				if(ctcVal == null)
					ctcVal=BigDecimal.ZERO;
				employeeMasterBO.setEmployeeCTCValue(ctcVal);
				/*BankBO bankBO = new BankBO();
				copy(employeeMasterVO.getHrEmployeeBankId(), bankBO);
				PackageBO packageBO = new PackageBO();
				copy(employeeMasterVO.getHrEmployeePackageId(), packageBO);
				employeeMasterBO.setEmployeeBank(bankBO);
				employeeMasterBO.setEmployeePackage(packageBO);*/
			}
			else
			{
				//bank
				BankVO bankVO=employeeMasterVO.getHrEmployeeBankId();
				if(bankVO!=null && bankVO.getBankId() > 0)
				{
				BankBO bankBO=new BankBO();
				copy(bankVO,bankBO);
				employeeMasterBO.setEmployeeBank(bankBO);
				}
				
				//package details
				PackageVO packageVO=employeeMasterVO.getHrEmployeePackageId();
				if(packageVO!=null && packageVO.getPackageId() > 0)
				{
					PackageBO packageBO=new PackageBO();
					copy(packageVO,packageBO);
					employeeMasterBO.setEmployeePackage(packageBO);
				}
			}

			//branch
			BranchMasterVO branchMasterVO=employeeMasterVO.getHrEmployeeBranchId();
			if(branchMasterVO!=null && branchMasterVO.getBranchMasterId() > 0)
			{
			BranchMasterBO branchMasterBO = new BranchMasterBO();
			copy(branchMasterVO, branchMasterBO);
			employeeMasterBO.setEmployeeBranch(branchMasterBO);
			}

			//group dept
			DepartmentVO grpDept=employeeMasterVO.getEmployeeDeptGroupId();
			if(grpDept!=null && grpDept.getDepartmentId() > 0)
			{
			DepartmentBO departmentGroupBO = new DepartmentBO();
			copy(grpDept, departmentGroupBO);
			employeeMasterBO.setEmployeeDeptGroupId(departmentGroupBO);
			}

			//hr dept
			DepartmentVO hrDept=employeeMasterVO.getHrDepartment();
			if(hrDept!=null && hrDept.getDepartmentId() > 0)
			{
			DepartmentBO departmentBO = new DepartmentBO();
			copy(hrDept, departmentBO);
			employeeMasterBO.setDepartment(departmentBO);
			
			}
			
			//desg
			DesignationVO designationVO=employeeMasterVO.getDesignation();
			if(designationVO!=null && designationVO.getDesignationId() > 0)
			{
			DesignationBO designationBO = new DesignationBO();
			copy(designationVO, designationBO);
			employeeMasterBO.setHrDesignation(designationBO);
			}
			
			employeeMasterBO.setEmployeeStatus(1);// status=1:Active
			
			//emp consultancy
			OutsourcingAgencyVO outsourcingAgencyVO=employeeMasterVO.getEmployeeConsultancyId();
			if (outsourcingAgencyVO != null && outsourcingAgencyVO.getOutsourcingId() > 0) {
				OutsourcingAgencyBO outSourcingAgencyBO = new OutsourcingAgencyBO();
				copy(outsourcingAgencyVO,outSourcingAgencyBO);
				employeeMasterBO.setEmployeeConsultancyId(outSourcingAgencyBO);
			}
			
			//employeeMasterBO.setEmployeeCreditELYearly(0);
			//employeeMasterBO.setEmployeeeaveApprovalPermission(true);
			/*if (employeeMasterVO.getEmployeeType() == 1
					|| employeeMasterVO.getEmployeeType() == 6)
				employeeMasterBO.setEmployeeRegularised(1);
			else
				employeeMasterBO.setEmployeeRegularised(0);*/
			employeeMasterBO.setEmployeeFullName(empFullName);

			//photo and signature
			String empPhotoURL=employeeMasterVO.getEmployeePhotoURL();
			if(empPhotoURL!=null && empPhotoURL!="" && empPhotoURL.length() > 0)
			{
				byte[] empPhotoBytes=commonUtilService.getBytesFromFile(empPhotoURL);
				if(empPhotoBytes!=null && empPhotoBytes.length > 0)
					employeeMasterBO.setEmployeePhoto(empPhotoBytes);
			}
			else
			{
				employeeMasterBO.setEmployeePhoto(empPhotoBytesData);
			}
			
			String empSignatureURL=employeeMasterVO.getEmployeeSignatureURL();
			if(empSignatureURL!=null && empSignatureURL!="" && empSignatureURL.length() > 0)
			{
				byte[] empSignatureBytes=commonUtilService.getBytesFromFile(empSignatureURL);
				if(empSignatureBytes!=null && empSignatureBytes.length > 0)
					employeeMasterBO.setEmployeeSignature(empSignatureBytes);
			}
			else
			{
				employeeMasterBO.setEmployeeSignature(empSignatureBytesData);
			}
			
			employeeMasterBO = employeeDao.save(employeeMasterBO);
			
			//Educational and Professional Attachments
			List<FileMeta> empEducationalDetails=employeeMasterVO.getEmpEducationalMetaData();
			if(empEducationalDetails!=null && empEducationalDetails.size() > 0)
			{
				String folderPath=employeeMasterVO.getEmpDetailsName();
				String docNum=employeeMasterVO.getEmpEducationalName();
				String docName=employeeMasterBO.getEmployeeCode()+"";
				
				for(FileMeta edFileMeta : empEducationalDetails)
				{
					if(edFileMeta!=null)
					{
					if(edFileMeta.getDeleteType().trim().equalsIgnoreCase("T"))
					{
						if(edFileMeta.getName()!=null && edFileMeta.getName().length() > 0)
						{
							commonUtilService.deleteFileAttachment(docNum, edFileMeta.getName(), folderPath+"/"+docName);
							edFileMeta.setName("");
						}
					}
					}
				}
				
				commonUtilService.saveAttachments(folderPath, docName, docNum, empEducationalDetails);
			}
			
			List<FileMeta> empProfessionalDetails=employeeMasterVO.getEmpProfessionalMetaData();
			if(empProfessionalDetails!=null && empProfessionalDetails.size() > 0)
			{
				String folderPath=employeeMasterVO.getEmpDetailsName();
				String docNum=employeeMasterVO.getEmpProfessionalName();
				String docName=employeeMasterBO.getEmployeeCode()+"";
				
				for(FileMeta profFileMeta : empProfessionalDetails)
				{
					if(profFileMeta!=null)
					{
					if(profFileMeta.getDeleteType().trim().equalsIgnoreCase("T"))
					{
						if(profFileMeta.getName()!=null && profFileMeta.getName().length() > 0)
						{
							commonUtilService.deleteFileAttachment(docNum, profFileMeta.getName(), folderPath+"/"+docName);
							profFileMeta.setName("");
						}
					}
					}
				}
				
				commonUtilService.saveAttachments(folderPath, docName, docNum, empProfessionalDetails);
			}
			
			//policy details
			Map<Long, EmployeePolicyDetailBO> exData = getEmpPolicyDetailMap(employeeMasterBO);
			Map<String, Object> detailsMap = getEmpPolicyDetailMapToSave(
					employeeMasterVO, exData, employeeMasterBO);
			if (detailsMap != null && !detailsMap.isEmpty()) {
				if (detailsMap.get("detail_save") != null) {
					employeePolicyDao.save((List<EmployeePolicyDetailBO>) detailsMap.get("detail_save"));
				}
				if (detailsMap.get("detail_delete") != null) {
					List<Long> delDetailsBOList = (List<Long>) detailsMap.get("detail_delete");
					for (Long detailId : delDetailsBOList)
						employeePolicyDao.delete(detailId);
				}

			}

			//prev exp details
			Map<Long, EmployeePrevExperienceBO> exPrevExpData = getPrevExpDetailMap(employeeMasterBO);
			Map<String, Object> prevExpdetailsMap = getPrevExpDetailMapToSave(
					employeeMasterVO, exPrevExpData, employeeMasterBO);
			if (prevExpdetailsMap != null && !prevExpdetailsMap.isEmpty()) {
				if (detailsMap.get("detail_save") != null) {
					employeePrevExpDao.save((List<EmployeePrevExperienceBO>) prevExpdetailsMap.get("detail_save"));
				}
				if (prevExpdetailsMap.get("detail_delete") != null) {
					List<Long> delDetailsBOList = (List<Long>) prevExpdetailsMap.get("detail_delete");
					for (Long detailId : delDetailsBOList)
						employeePrevExpDao.delete(detailId);
				}

			}
			copy(employeeMasterBO,employeeMasterVO);
			String empUserName=employeeMasterBO.getEmployeeFullName();
			DesignationBO designationBO=employeeMasterBO.getHrDesignation();
			String empDesgName="";
			if(designationBO!=null && designationBO.getDesignationId() > 0)
			{
				empDesgName=designationBO.getDesignationName();
			}
			String empEmailId=employeeMasterBO.getEmployeeMailId();
			
			
			//update userbo for emp full name,desg, and email
			UserBO userBO=userDao.getUserByEmpId((int)employeeMasterBO.getEmployeeId());
			if(userBO!=null && userBO.getUserSno() > 0)
			{
				String userName=userBO.getUserName();
				String desgName=userBO.getUserDesignation();
				String emailId=userBO.getUserEmail();
				int i=0;
				if(!empUserName.equals(userName))
				{
					userName=empUserName;
					++i;
				}
				if(!empDesgName.equals(desgName))
				{
					desgName=empDesgName;
					++i;
				}
				if(!empEmailId.equals(emailId))
				{
					emailId=empEmailId;
					++i;
				}
				if(i > 0)
					userDao.updateUser(userName, desgName, emailId, userBO.getUserSno());
				
				//Modify UserModule
				DepartmentBO departmentBO=employeeMasterBO.getDepartment();
				if(departmentBO!=null && departmentBO.getDepartmentId() > 0)
				{
					if(departmentBO.getDepartmentId()  != deptId)
					{
					userModuleDao.updateSystemModule((long)userBO.getUserSno());
					
					List<SystemModule> systemModuleList=systemModuleDao.getSystemModuleByDept(departmentBO.getDepartmentId(),new PageRequest(0, 1));
					if(systemModuleList!=null && systemModuleList.size() > 0)
					{
					SystemModule systemModule=systemModuleList.get(0);
					UserModuleBO userModuleBO=new UserModuleBO();
					userModuleBO.setUserId((long)userBO.getUserSno());
					userModuleBO.setModuleId(systemModule);
					userModuleBO.setDeafultModuleId(true);
					userModuleDao.save(userModuleBO);
					}
					}
				}
			}
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getOutSourceEmployee()
			throws FunworkBusinessException {
		List<EmployeeMasterVO> empVO = new ArrayList<EmployeeMasterVO>();
		try {
			List<EmployeeMasterBO> employeeList = (List<EmployeeMasterBO>) employeeDao
					.getOutSourceEmployeeListByType(7, 1);// type==7,status==1(Active)
			
			if(employeeList!=null && employeeList.size() > 0)
			{
			for (EmployeeMasterBO ebo : employeeList) {
				if(ebo!=null && ebo.getEmployeeId() > 0)
				{
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);

				//dept
				DepartmentBO departmentBO=ebo.getDepartment();
				if(departmentBO!=null && departmentBO.getDepartmentId() > 0)
				{
				DepartmentVO departmentVO = new DepartmentVO();
				copy(departmentBO, departmentVO);
				evo.setHrDepartment(departmentVO);
				}

				//desg
				DesignationBO designationBO=ebo.getHrDesignation();
				if(designationBO!=null && designationBO.getDesignationId() > 0)
				{
				DesignationVO designationVO = new DesignationVO();
				copy(designationBO, designationVO);
				evo.setDesignation(designationVO);
				}
				
				//outsource agency
				OutsourcingAgencyBO outsourcingAgencyBO=ebo.getEmployeeConsultancyId();
				if(outsourcingAgencyBO!=null && outsourcingAgencyBO.getOutsourcingId() > 0)
				{
				OutsourcingAgencyVO outSrcAgencyVO = new OutsourcingAgencyVO();
				copy(outsourcingAgencyBO, outSrcAgencyVO);
				evo.setEmployeeConsultancyId(outSrcAgencyVO);
				}
				empVO.add(evo);
				}
			}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
		return empVO;
	}

	@Transactional
	public boolean removeOutSrcEmp(EmployeeMasterVO employeeMasterVO)
			throws FunworkBusinessException {
		try {
			employeeDao.removeOurSrcEmp(
					employeeMasterVO.getEmployeeDateofReliving(), 2,
					employeeMasterVO.getEmployeeId());// status=2:Closed
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Transactional
	public boolean updateOutSrcEmp(EmployeeMasterVO employeeMasterVO)
			throws FunworkBusinessException {
		try {
			generalDao.updateOutSorceEmp(employeeMasterVO);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmpListForPermissions(long employeeId)
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employee = employeeDao.fetchEmpListForPermission(employeeId);

			/*List<EmployeeMasterVO> empVO = new ArrayList<EmployeeMasterVO>();
			for (EmployeeMasterBO ebo : employee) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				empVO.add(evo);
			}*/
			return employee;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getLeaveRecommenededEmployeeList(long empId)
			throws FunworkBusinessException {
		try {
			/*List<EmployeeMasterVO> employeeList = new ArrayList<EmployeeMasterVO>();*/

			List<EmployeeMasterVO> empBOList = employeeDao
					.fetchLeaveRecommendedEmployeeList(empId);

			/*for (EmployeeMasterBO ebo : empBOList) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(ebo.getDepartment(), departmentVO);

				DesignationVO designationVO = new DesignationVO();
				copy(ebo.getHrDesignation(), designationVO);

				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);

				employeeList.add(evo);
			}*/
			return empBOList;

		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}
	
	@Transactional
	public List<EmployeeMasterVO> getLeaveRecommenededEmployeeListForUserAdmin()
			throws FunworkBusinessException {
		try {
			/*List<EmployeeMasterVO> employeeList = new ArrayList<EmployeeMasterVO>();*/

			List<EmployeeMasterVO> empBOList = employeeDao
					.fetchLeaveRecommendedEmployeeListForUserAdmin();

			/*for (EmployeeMasterBO ebo : empBOList) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(ebo.getDepartment(), departmentVO);

				DesignationVO designationVO = new DesignationVO();
				copy(ebo.getHrDesignation(), designationVO);

				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);

				employeeList.add(evo);
			}*/
			return empBOList;

		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}
	
	@Transactional
	public List<EmployeeMasterVO> getLeaveApprovalEmployeeList(long empId)
			throws FunworkBusinessException {
		try {
			/*List<EmployeeMasterVO> employeeList = new ArrayList<EmployeeMasterVO>();*/

			List<EmployeeMasterVO> empBOList = employeeDao
					.fetchLeaveApprovalEmployeeList(empId);

			/*for (EmployeeMasterBO ebo : empBOList) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(ebo.getDepartment(), departmentVO);

				DesignationVO designationVO = new DesignationVO();
				copy(ebo.getHrDesignation(), designationVO);

				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);

				employeeList.add(evo);
			}*/
			return empBOList;

		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}
	
	@Transactional
	public List<EmployeeMasterVO> getLeaveApprovalEmployeeListForUserAdmin()
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> empBOList = employeeDao.fetchLeaveApprovalEmployeeListForUserAdmin();
			return empBOList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}
	@Transactional
	public List<EmployeeMasterVO> getODApprovalEmployeeList(long empId)
			 {
		try {
			/*List<EmployeeMasterVO> employeeList = new ArrayList<EmployeeMasterVO>();*/

			List<EmployeeMasterVO> empBOList = employeeDao.fetchODApprovalEmployeeList(empId);
					

			/*for (EmployeeMasterBO ebo : empBOList) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(ebo.getDepartment(), departmentVO);

				DesignationVO designationVO = new DesignationVO();
				copy(ebo.getHrDesignation(), designationVO);

				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);

				employeeList.add(evo);
			}*/
			return empBOList;

		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}
	
	@Transactional
	public List<EmployeeMasterVO> getEmployeeVOListByDeptId(int deptId)
			 {
		try {

			List<EmployeeMasterVO> empBOList = employeeDao.fetchEmpVOListByDeptId(deptId);
					
			
			return empBOList;

		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}

	// get employee dept and branch
	@Transactional
	public List<EmployeeMasterVO> getEmpListByBranchAndDept()
			throws FunworkBusinessException {
		try {
			/*
			 * TODO hard coded values will be replaced by getting the values
			 * from context
			 */
			// branchId=1 (for Madhapur) and deptId=2 (for MKTG)
			int branchId = 1;
			int deptId = 2;

			List<EmployeeMasterVO> employeeVOList = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> employeeBOList = employeeDao.getEmpListByBranchAndDept(deptId, branchId);
			/*if (employeeBOList != null) {
				for (EmployeeMasterBO employeeMasterBO : employeeBOList) {
					EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
					copy(employeeMasterBO, employeeMasterVO);
					employeeVOList.add(employeeMasterVO);
				}
			}*/
			return employeeBOList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Override
	@Transactional
	public List<EmployeeMasterVO> getReguraliseEmployeeList()
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterBO> employeeMasterBOs = employeeDao
					.fetchReguraliseEmployeeList();
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				Calendar cal = Calendar.getInstance();
                cal.setTime(employeeMasterBO.getEmployeeDateofJoining());
                cal.add(Calendar.MONTH, employeeMasterBO.getEmployeeProbationPeriod());

                if(cal.getTime().before(new Date())){
					EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
					copy(employeeMasterBO, employeeMasterVO);
					DesignationVO designationVO = new DesignationVO();
					copy(employeeMasterBO.getHrDesignation(), designationVO);
					DepartmentVO departmentVO = new DepartmentVO();
					copy(employeeMasterBO.getDepartment(), departmentVO);
					employeeMasterVO.setDesignation(designationVO);
					employeeMasterVO.setHrDepartment(departmentVO);
					employeeMasterVOs.add(employeeMasterVO);
                }
			}
			return employeeMasterVOs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	@Transactional
	public boolean reguraliseEmployee(long employeeId)
			throws FunworkBusinessException {
		try {
			EmployeeMasterBO employeeMasterBO = employeeDao.findOne(employeeId);

			employeeDao.reguraliseEmployeeById(employeeId);

			Date Dateofjoining = employeeMasterBO.getEmployeeDateofJoining();
			Calendar cal = Calendar.getInstance();
			cal.setTime(Dateofjoining);
			int year = cal.get(Calendar.YEAR) + 1;
			LeaveLedgerBO leaveLedgerBo = leaveLedgerDao.getLeaveLedgerList(employeeMasterBO.getEmployeeCode(), year);
			if (leaveLedgerBo == null) {

				LeaveLedgerBO leaveLedgerBO = new LeaveLedgerBO();
				leaveLedgerBO.setLeaveLedgerEmpId(employeeMasterBO);
				leaveLedgerBO.setLeaveLedgerYear(year);
				if (employeeMasterBO.getEmployeeProbationPeriod() <= 6) {
					leaveLedgerBO.setLeaveLedgerEL(new BigDecimal(0));
				} else {
					int numOfMnths = 12 - (cal.get(Calendar.MONTH) + 1);
					double earnedLeaves = numOfMnths * 1.25;
					leaveLedgerBO.setLeaveLedgerEL(new BigDecimal(Math.ceil(earnedLeaves)));
				}
				leaveLedgerBO.setCreatedOn(new Date());
				//int casualLeaves = 12 - (cal.get(Calendar.MONTH) + 1);
				leaveLedgerBO.setLeaveLedgerCL(new BigDecimal(0));
				leaveLedgerBO.setCreditDebit(false);
				leaveLedgerBO = leaveLedgerDao.save(leaveLedgerBO);

			}
			if (employeeMasterBO.getEmployeeProbationPeriod() > 6) {
				employeeDao.addELToEmployeeById(employeeId);
			}

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	@Transactional
	public List<EmployeeSummaryVO> getNewLeavesList(int year)
			throws FunworkBusinessException {
		try {
			
			List<EmployeeSummaryVO> empMasterVOs = employeeDao
					.getEmployeeNewLeavesList(year);
			for (EmployeeSummaryVO employeeMasterVO : empMasterVOs) {
				
				Calendar cal = new GregorianCalendar();
				cal.setTime(employeeMasterVO.getEmployeeDateofJoining());
				int joiningYear=cal.get(Calendar.YEAR);
				
				if(joiningYear < year)
				{
					
					if (employeeMasterVO.getEmployeeCreditELYearly() == 1
							&& employeeMasterVO.getEmployeeRegularised() == 1) {
						employeeMasterVO.setEmployeeEL(new BigDecimal(15));
						employeeMasterVO.setEmployeeCL(new BigDecimal(12));
					} else {
						employeeMasterVO.setEmployeeEL(new BigDecimal(0));
						employeeMasterVO.setEmployeeCL(new BigDecimal(12));
					}
					
				}
				
			}return empMasterVOs;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	@Transactional
	public boolean saveNewLeaves(EmployeeLeaveLedgerVO employeeLeaveVO)
			throws FunworkBusinessException {
		try {

			List<LeaveLedgerBO> leaveLedgerBOs = new ArrayList<LeaveLedgerBO>();
			List<LeaveLedgerVO> leaveLedgerVOs = employeeLeaveVO
					.getLeaveLedgerList();
			for (LeaveLedgerVO leaveLedgerVO : leaveLedgerVOs) {
				LeaveLedgerBO leaveLedgerBO = new LeaveLedgerBO();
				copy(leaveLedgerVO, leaveLedgerBO);
				leaveLedgerBO.setCreatedOn(new Date());
				
				EmployeeMasterVO empMasterVO = leaveLedgerVO.getLeaveLedgerEmpId();
				EmployeeMasterBO empMasterBO = new EmployeeMasterBO();
				copy(empMasterVO,empMasterBO);
				leaveLedgerBO.setLeaveLedgerEmpId(empMasterBO);
				
				leaveLedgerBOs.add(leaveLedgerBO);
			}
			leaveLedgerBOs = (List<LeaveLedgerBO>) leaveLedgerDao
					.save(leaveLedgerBOs);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	@Transactional
	public List<EmployeeMasterVO> getAddELAfterReguraliseEmplist()
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterBO> employeeMasterBOs = employeeDao.fetchAddELAfterReguraliseEmpList();
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				Calendar cal = Calendar.getInstance();
                cal.setTime(employeeMasterBO.getEmployeeDateofJoining());
                cal.add(Calendar.YEAR, 1);

                if(cal.getTime().before(new Date())){
					EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
					copy(employeeMasterBO, employeeMasterVO);
					DesignationVO designationVO = new DesignationVO();
					copy(employeeMasterBO.getHrDesignation(), designationVO);
					DepartmentVO departmentVO = new DepartmentVO();
					copy(employeeMasterBO.getDepartment(), departmentVO);
					employeeMasterVO.setDesignation(designationVO);
					employeeMasterVO.setHrDepartment(departmentVO);
					employeeMasterVOs.add(employeeMasterVO);
                }
			}
			return employeeMasterVOs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@Override
	@Transactional
	public boolean addELAfterReguraliseEmployee(long employeeId)
			throws FunworkBusinessException {
		try {
			EmployeeMasterBO employeeMasterBO = employeeDao.findOne(employeeId);

			employeeDao.addELToEmployeeById(employeeId);

			Date Dateofjoining = employeeMasterBO.getEmployeeDateofJoining();
			Calendar cal = Calendar.getInstance();
			cal.setTime(Dateofjoining);
			int year = cal.get(Calendar.YEAR) + 1;
			LeaveLedgerBO leaveLedgerBo = leaveLedgerDao.getLeaveLedgerList(
					employeeMasterBO.getEmployeeCode(), year);
			if (leaveLedgerBo == null) {

				LeaveLedgerBO leaveLedgerBO = new LeaveLedgerBO();
				leaveLedgerBO.setLeaveLedgerEmpId(employeeMasterBO);
				leaveLedgerBO.setLeaveLedgerYear(year);
				if (employeeMasterBO.getEmployeeProbationPeriod() <= 6) {
					leaveLedgerBO.setLeaveLedgerEL(new BigDecimal(0));
				} else {
					int numOfMnths = 12 - (cal.get(Calendar.MONTH) + 1);
					// float els=15/12;
					double earnedLeaves = numOfMnths * 1.25;
					leaveLedgerBO.setLeaveLedgerEL(new BigDecimal(Math
							.ceil(earnedLeaves)));
				}
				leaveLedgerBO.setCreatedOn(new Date());
				int casualLeaves = 12 - (cal.get(Calendar.MONTH) + 1);
				leaveLedgerBO
						.setLeaveLedgerCL(new BigDecimal(casualLeaves * 1));
				leaveLedgerBO = leaveLedgerDao.save(leaveLedgerBO);

			}

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// for Reports
	@Transactional
	public EmployeeMasterVO getApprenticeReport(
			QueryParamsVO queryParamsVO) throws FunworkBusinessException {
		try {
			EmployeeMasterVO employeeMasterVOs=new EmployeeMasterVO();
			List<EmployeeMasterVO> apprenticeList = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> projInternDetails= new ArrayList<EmployeeMasterVO>();
			if (queryParamsVO.getType() == 0) {

				List<EmployeeMasterVO> employeeMasterVOList = employeeDao
						.getApprenticeEmployeeList();

				for (EmployeeMasterVO employeeMasterVO : employeeMasterVOList) {
					//EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
					//copy(employeeMasterBO, employeeMasterVO);

					/*DepartmentVO departmentVO = new DepartmentVO();
					copy(employeeMasterBO.getDepartment(), departmentVO);
					employeeMasterVO.setHrDepartment(departmentVO);*/

					int probPeriod = employeeMasterVO
							.getEmployeeProbationPeriod();

					Calendar cal = Calendar.getInstance();
					cal.setTime(employeeMasterVO.getEmployeeDateofJoining());
					cal.add(Calendar.MONTH, probPeriod);
					cal.add(Calendar.DATE, -1);
					Date completiondate = cal.getTime();

					employeeMasterVO.setCompletionDate(completiondate);
					if(employeeMasterVO.getEmployeeType()==2){
						apprenticeList.add(employeeMasterVO);
					}else{
						projInternDetails.add(employeeMasterVO);
					}
					
				}

			} else {

				Calendar cal1 = Calendar.getInstance();

				Date startDate = cal1.getTime();

				cal1.add(Calendar.DATE, 30);
				Date endDate = cal1.getTime();

				List<EmployeeMasterVO> employeeMasterListVO = employeeDao
						.getApprenticeEmployeeList();

				for (EmployeeMasterVO employeeMasterVO : employeeMasterListVO) {
					/*EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
					copy(employeeMasterBO, employeeMasterVO);

					DepartmentVO departmentVO = new DepartmentVO();
					copy(employeeMasterBO.getDepartment(), departmentVO);
					employeeMasterVO.setHrDepartment(departmentVO);*/

					int probPeriod = employeeMasterVO
							.getEmployeeProbationPeriod();

					Calendar cal = Calendar.getInstance();
					cal.setTime(employeeMasterVO.getEmployeeDateofJoining());
					cal.add(Calendar.MONTH, probPeriod);
					cal.add(Calendar.DATE, -1);
					Date completiondate = cal.getTime();

					employeeMasterVO.setCompletionDate(completiondate);

					if ((completiondate.after(startDate)
							&& completiondate.before(endDate) ) || completiondate.before(startDate) ) {
						
							if(employeeMasterVO.getEmployeeType()==2){
								apprenticeList.add(employeeMasterVO);
							}else{
								projInternDetails.add(employeeMasterVO);
							}
						
					}
				}

			}
			employeeMasterVOs.setApperentiesList(apprenticeList);
			employeeMasterVOs.setProjectInternList(projInternDetails);
			return employeeMasterVOs;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> fetchBirthDayList(QueryParamsVO queryParamsVO)
			throws FunworkBusinessException {
		try {

			List<EmployeeMasterVO> employee = employeeDao
					.fetchBirthDayList(queryParamsVO.getMonth());

			/*List<EmployeeMasterVO> empVO = new ArrayList<EmployeeMasterVO>();
			if(employee !=null && employee.size()>0){
			for (EmployeeMasterBO ebo : employee) {
				if(ebo !=null){
				EmployeeMasterVO evo = new EmployeeMasterVO();
				
				copy(ebo, evo);

				DepartmentVO departmentVO = new DepartmentVO();
				if(ebo.getDepartment() !=null)
				copy(ebo.getDepartment(), departmentVO);

				DesignationVO designationVO = new DesignationVO();
				if(ebo.getHrDesignation() !=null)
				copy(ebo.getHrDesignation(), designationVO);

				BranchMasterVO brnachVo = new BranchMasterVO();
				if(ebo.getEmployeeBranch() !=null)
				copy(ebo.getEmployeeBranch(), brnachVo);
				
				evo.setBranchId(ebo.getEmployeeBranch().getBranchMasterId());
				evo.setBranchMasterName(ebo.getEmployeeBranch().getBranchMasterName());
				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);
				evo.setHrEmployeeBranchId(brnachVo);		
				empVO.add(evo);
				}
			}
			}*/
			return employee;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeSummaryVO> getBloodGroupList()
			throws FunworkBusinessException {
		try {

			List<EmployeeSummaryVO> employee = (List<EmployeeSummaryVO>) employeeDao
					.getEmployeeListForBloodGroup(7);// /
				
			return employee;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmpPersonalDet()
			throws FunworkBusinessException {
		try {

			int status = 1;

			List<EmployeeMasterBO> employeeMasterBOs = employeeDao
					.getEmployeeDetails(status);

			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);

				employeeMasterVOs.add(employeeMasterVO);
			}
			return employeeMasterVOs;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmpWisePfDet()
			throws FunworkBusinessException {
		try {

			List<String> pfNo = employeeDao.getPfNumber();
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			if (pfNo.size() > 0) {
				List<EmployeeMasterBO> employeeMasterBOs = employeeDao
						.getEmployeeWisePf(pfNo);

				if (employeeMasterBOs != null) {
					for (EmployeeMasterBO ebo : employeeMasterBOs) {
						EmployeeMasterVO evo = new EmployeeMasterVO();
						copy(ebo, evo);

						employeeMasterVOs.add(evo);
					}
				}
			}
			return employeeMasterVOs;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getoutSourceEmply()
			throws FunworkBusinessException {
		try {

			List<EmployeeMasterBO> employeeMasterBOs = (List<EmployeeMasterBO>) employeeDao
					.getOutSourceEmployeeListByType(7, 1);// /
															// type==7,status==1(Active)

			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);

				DepartmentVO departmentVO = new DepartmentVO();
				copy(employeeMasterBO.getDepartment(), departmentVO);
				employeeMasterVO.setHrDepartment(departmentVO);

				DesignationVO designationVO = new DesignationVO();
				copy(employeeMasterBO.getHrDesignation(), designationVO);
				employeeMasterVO.setDesignation(designationVO);

				employeeMasterVOs.add(employeeMasterVO);
			}
			return employeeMasterVOs;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getDeptWiseEmpListReport(
			QueryParamsVO queryParamsVO) throws FunworkBusinessException {

		try {

			if (queryParamsVO.getType() == 0) {
				queryParamsVO.setQueryType("B");
			} else if (queryParamsVO.getType() == 1){
				queryParamsVO.setQueryType("BD");
			} else if (queryParamsVO.getType() == 2){
				queryParamsVO.setQueryType("D");
			}
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterBO> employeeMasterBOs = new ArrayList<EmployeeMasterBO>();

			if (queryParamsVO.getQueryType().equals("BD")) {
				employeeMasterVOs = employeeDao.fetchEmpListByDeptIdandBranchId(queryParamsVO.getMasterBranchId(),queryParamsVO.getMasterDeptId());
			} else if (queryParamsVO.getQueryType().equals("B")){
				employeeMasterVOs = employeeDao.fetchEmpListByBranchId(queryParamsVO.getMasterBranchId());
			} else if (queryParamsVO.getQueryType().equals("D")){
				employeeMasterBOs = employeeDao.fetchEmpListByDeptId(queryParamsVO.getMasterDeptId());
			}
			
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);

				DepartmentVO departmentVO = new DepartmentVO();
				copy(employeeMasterBO.getDepartment(), departmentVO);
				employeeMasterVO.setHrDepartment(departmentVO);
				employeeMasterVO.setDeptName(departmentVO.getDepartmentName());

				DesignationVO designationVO = new DesignationVO();
				copy(employeeMasterBO.getHrDesignation(), designationVO);
				employeeMasterVO.setDesignation(designationVO);

				BranchMasterVO branchMasterVO = new BranchMasterVO();
				copy(employeeMasterBO.getEmployeeBranch(), branchMasterVO);
				employeeMasterVO.setHrEmployeeBranchId(branchMasterVO);

				employeeMasterVOs.add(employeeMasterVO);
			}
			return employeeMasterVOs;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getAllEmployeeList()
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterBO> employeeMasterBOs = employeeDao.getAllEmployeeList();
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);
				DesignationVO designationVO = new DesignationVO();
				copy(employeeMasterBO.getHrDesignation(), designationVO);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(employeeMasterBO.getDepartment(), departmentVO);
				employeeMasterVO.setDesignation(designationVO);
				employeeMasterVO.setHrDepartment(departmentVO);
				employeeMasterVOs.add(employeeMasterVO);

			}
			return employeeMasterVOs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmployeeListByDeptId(int deptId)
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterBO> employeeMasterBOs = employeeDao.fetchEmpListByDeptId(deptId);
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);
				DesignationVO designationVO = new DesignationVO();
				copy(employeeMasterBO.getHrDesignation(), designationVO);
				DepartmentVO departmentVO = new DepartmentVO();
				copy(employeeMasterBO.getDepartment(), departmentVO);
				employeeMasterVO.setDesignation(designationVO);
				employeeMasterVO.setHrDepartment(departmentVO);
				employeeMasterVOs.add(employeeMasterVO);

			}
			return employeeMasterVOs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Transactional
	public String getEmployeeName(long empId) {

		return employeeDao.getEmployeeName(empId);

	}
	
	@Transactional
	public List<EmployeeMasterVO> getEmployeeListByDeptandBranchId(int deptId,int branchId){
		try{
			List<EmployeeMasterVO> employeeMasterVOList=new ArrayList<EmployeeMasterVO>();
			
			if(deptId>0){
				if(branchId>0){
					employeeMasterVOList=employeeDao.fetchEmpListForGatePass(branchId, deptId);
				}else{
					employeeMasterVOList=employeeDao.fetchEmpListByDeptIdForGatePass(deptId);
				}
			}
			if(deptId==0){
				if(branchId>0){
					employeeMasterVOList=employeeDao.fetchEmpListByBranchIdForGatepass(branchId);
				}else{
					employeeMasterVOList=employeeDao.fetchEmpListByStatus(1);//status=1
				}
			}
			
			
			return employeeMasterVOList; 
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmployeeListForDropDown()
			throws FunworkBusinessException {
		return employeeDao.fetchEmployeeListForDropDown();
	}
	
	//for employee list in weekly report [GEN_RetrieveEmployees]
	@Transactional
	public List<EmployeeMasterVO> getEmployeesForWeeklyReport(String departments,int branch)
	{
		List<EmployeeMasterVO> employeeMasterVOList=null;
		try
		{
			employeeMasterVOList=employeeDao.getEmpListForWRMail(1);
			if(employeeMasterVOList == null)
				employeeMasterVOList=new ArrayList<EmployeeMasterVO>();
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return employeeMasterVOList;
	}
	
	@Transactional
	public List<EmployeeMasterVO> getEmployeesForIOC(String departments)
	{
		List<EmployeeMasterVO> employeeMasterVOList=null;
		try
		{
			List<Integer> deptIdsList = new ArrayList<Integer>();
			String[] deptId = departments.split("[,]");
			for (int i = 0; i < deptId.length; i++)
				deptIdsList.add(Integer.parseInt(deptId[i]));
			
			employeeMasterVOList=employeeDao.getEmpListForWRMail(1,deptIdsList);
			if(employeeMasterVOList == null)
				employeeMasterVOList=new ArrayList<EmployeeMasterVO>();
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return employeeMasterVOList;
	}

	@Transactional
	public List<EmployeeMasterVO> getEmpListForDocRegister() {
		try {
			List<EmployeeMasterBO> employee = (List<EmployeeMasterBO>) employeeDao.fetchEmployeeListForDocRegister();
					
			List<EmployeeMasterVO> empVO = new ArrayList<EmployeeMasterVO>();
			for (EmployeeMasterBO ebo : employee) {
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				empVO.add(evo);
			}
			return empVO;
		} catch (Exception ex) {
			//System.out.println("error: " + ex.getMessage());
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getLatestIQAAuditeesList() {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			/*int deptId = ContextUtils.getUserContext().getModuleDepartment().getDepartmentId();
			int brId = ContextUtils.getUserContext().getBranch().getBranchMasterId();*/
			List<EmployeeMasterBO> employeeMasterBOs = employeeDao.getLatestIQAAuditeesListByDeptAndBranch();
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);
				employeeMasterVOs.add(employeeMasterVO);

			}
			return employeeMasterVOs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<EmployeeMasterVO> getEmployeelistForDesignVerification() {
		try {
			List<EmployeeMasterVO> employee = employeeDao.getEmployeeListForDesignVerfication(7);// type!=7
			
			return employee;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
	}
	
	
	@Transactional
	public List<EmployeeMasterVO> getProbationaryDetReport(
			QueryParamsVO queryParamsVO) throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			if (queryParamsVO.getType() == 0) {

				List<EmployeeMasterVO> employeeMasterVOList = employeeDao
						.getProbationaryDetEmployeeList();
				if (employeeMasterVOs != null) {
					for (EmployeeMasterVO employeeMasterVo : employeeMasterVOList) {
						//EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
						//if (employeeMasterBO.getDepartment() != null) {
							/*DepartmentVO departmentVO = new DepartmentVO();
							copy(employeeMasterBO.getDepartment(), departmentVO);
							employeeMasterVO.setHrDepartment(departmentVO);*/

							int probPeriod = employeeMasterVo
									.getEmployeeProbationPeriod();

							Calendar cal = Calendar.getInstance();
							cal.setTime(employeeMasterVo
									.getEmployeeDateofJoining());
							cal.add(Calendar.MONTH, probPeriod);
							Date completiondate = cal.getTime();

							employeeMasterVo.setCompletionDate(completiondate);

							employeeMasterVOs.add(employeeMasterVo);
						//}
					}
				}

			} else {

				Calendar cal1 = Calendar.getInstance();

				Date startDate = cal1.getTime();

				cal1.add(Calendar.MONTH, 1);
				Date endDate = cal1.getTime();

				List<EmployeeMasterVO>	employeeMasterVOList = employeeDao
						.getProbationaryDetEmployeeList();
				if (employeeMasterVOs != null) {
					for (EmployeeMasterVO employeeMasterVo : employeeMasterVOList) {
						//EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
						//copy(employeeMasterBO, employeeMasterVO);
						//if (employeeMasterBO.getDepartment() != null) {
							/*DepartmentVO departmentVO = new DepartmentVO();
							copy(employeeMasterBO.getDepartment(), departmentVO);
							employeeMasterVO.setHrDepartment(departmentVO);*/

							int probPeriod = employeeMasterVo
									.getEmployeeProbationPeriod();

							Calendar cal = Calendar.getInstance();
							cal.setTime(employeeMasterVo
									.getEmployeeDateofJoining());
							cal.add(Calendar.MONTH, probPeriod);
							Date completiondate = cal.getTime();

							employeeMasterVo.setCompletionDate(completiondate);

							if (completiondate.before(endDate)) {
								//if (completiondate.compareTo(startDate) == -1 ) {
									employeeMasterVOs.add(employeeMasterVo);
								//}
							}
						//}
					}
				}
			}
			return employeeMasterVOs;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmployeesForAssign() {
		try {
			 List<EmployeeMasterVO> empVO =  employeeDao.getEmployeeListForAssign(7);// type!=7
            return empVO;
    } catch (Exception ex) {
                    //System.out.println("error: " + ex.getMessage());
                    return null;
            }
	}

	@Transactional
	public List<EmployeeMasterVO> getConsolidatedManPower(int type,Date asOndate,int branchId) {
		try {
			List<EmployeeMasterVO> empVO=new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> empListDeptwise=new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> empVOFilterd=new ArrayList<EmployeeMasterVO>();
			if(type==0)
			 empVO =  employeeDao.getConsolidatedManPowerAsOnDate();
			else
				empVO =  employeeDao.getConsolidatedManPowerOnselectedMonth(asOndate);
          
			if(branchId>0)
			{
				
				if(empVO !=null && empVO.size()>0)
				{
				for (EmployeeMasterVO employeeMasterVO : empVO) {
					if(employeeMasterVO.getBranchId()==branchId)
					{
						employeeMasterVO.setTotal(employeeMasterVO.getTraineeFeMale()+employeeMasterVO.getAppFeMale()+employeeMasterVO.getAppMale()+employeeMasterVO.getRegFeMale()+employeeMasterVO.getRegMale()+employeeMasterVO.getTraineeMale());
						empVOFilterd.add(employeeMasterVO);
					}
				}
				}
				
				return empVOFilterd;
			}
			else
			{
				
				if(empVO !=null && empVO.size()>0)
				{
				for (EmployeeMasterVO employeeMasterVO : empVO) {
					List<EmployeeMasterVO> fileterdListTemp=groupByDepartementWise(empListDeptwise, employeeMasterVO.getDeptId());
					if(fileterdListTemp==null)
					{
						
						List<EmployeeMasterVO> fileterdList=groupByDepartementWise(empVO, employeeMasterVO.getDeptId());
					if(fileterdList !=null && fileterdList.size()>0)
					{
						
						 long regMale = 0;
						 long regFeMale = 0;
						 long appMale = 0;
						 long appFeMale = 0;
						 long traineeMale = 0;
						 long traineeFeMale = 0;
						
						for (EmployeeMasterVO employeeMasterVO2 : fileterdList) {
							regMale=regMale+employeeMasterVO2.getRegMale();
							regFeMale=regFeMale+employeeMasterVO2.getRegFeMale();
							appMale=appMale+employeeMasterVO2.getAppMale();
							appFeMale=appFeMale+employeeMasterVO2.getAppFeMale();
							traineeMale=traineeMale+employeeMasterVO2.getTraineeMale();
							traineeFeMale=traineeFeMale+employeeMasterVO2.getTraineeFeMale();
					}
						
						employeeMasterVO.setRegMale(regMale);
						employeeMasterVO.setRegFeMale(regFeMale);
						employeeMasterVO.setAppMale(appMale);
						employeeMasterVO.setAppFeMale(appFeMale);
						employeeMasterVO.setTraineeMale(traineeMale);
						employeeMasterVO.setTraineeFeMale(traineeFeMale);
						employeeMasterVO.setTotal(traineeFeMale+appFeMale+appMale+regFeMale+regMale+traineeMale);
						empListDeptwise.add(employeeMasterVO);
					}
					}
				}
				}
				return empListDeptwise;
			}
			
			
    } catch (Exception ex) {
                   // System.out.println("error: man power report " + ex.getMessage());
                    return null;
            }
	}
	
	
	
	@Transactional
	public List<EmployeeMasterVO> getManPowerDetailsMonthwise(String finYear,int branchId) {
		try {
			List<EmployeeMasterVO> empVO=new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> empListDeptwise=new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> empVOFilterd=new ArrayList<EmployeeMasterVO>();
			QueryParamsVO queryParamsVo = new QueryParamsVO();
			queryParamsVo.setFinacialYear(finYear);
			queryParamsVo = commonUtilService.getDatesByYear(queryParamsVo);
			Date fromDate = queryParamsVo.getDateFromDate();
			Date toDate = queryParamsVo.getDateToDate();
			List<Date> transDates=empTransactionDao.getTransactionDatesBetweenYear(fromDate, toDate);
			
			if(transDates !=null && transDates.size()>0)
			{
				for (Date date : transDates) {
					List<EmployeeMasterVO> empVOTemp=employeeDao.getConsolidatedManPowerOnselectedMonth(date);
				if(empVOTemp !=null && empVOTemp.size()>0)
					empVO.addAll(empVOTemp);
				}
			}
			
			if(branchId>0)
			{
				
				if(empVO !=null && empVO.size()>0)
				{
				for (EmployeeMasterVO employeeMasterVO : empVO) {
					if(employeeMasterVO.getBranchId()==branchId)
					{
						employeeMasterVO.setTotal(employeeMasterVO.getTraineeFeMale()+employeeMasterVO.getAppFeMale()+employeeMasterVO.getAppMale()+employeeMasterVO.getRegFeMale()+employeeMasterVO.getRegMale()+employeeMasterVO.getTraineeMale());
						empVOFilterd.add(employeeMasterVO);
					}
				}
				}
				
				return empVOFilterd;
			}
			
			else
			{
				
				if(empVO !=null && empVO.size()>0)
				{
				for (EmployeeMasterVO employeeMasterVO : empVO) {
					List<EmployeeMasterVO> fileterdListTemp=groupByDepartementandTransDateWise(empListDeptwise, employeeMasterVO.getDeptId(),employeeMasterVO.getEmpTransactionMonthYear());
					if(fileterdListTemp==null)
					{
						
						List<EmployeeMasterVO> fileterdList=groupByDepartementandTransDateWise(empVO, employeeMasterVO.getDeptId(),employeeMasterVO.getEmpTransactionMonthYear());
					if(fileterdList !=null && fileterdList.size()>0)
					{
						
						 long regMale = 0;
						 long regFeMale = 0;
						 long appMale = 0;
						 long appFeMale = 0;
						 long traineeMale = 0;
						 long traineeFeMale = 0;
						
						for (EmployeeMasterVO employeeMasterVO2 : fileterdList) {
							regMale=regMale+employeeMasterVO2.getRegMale();
							regFeMale=regFeMale+employeeMasterVO2.getRegFeMale();
							appMale=appMale+employeeMasterVO2.getAppMale();
							appFeMale=appFeMale+employeeMasterVO2.getAppFeMale();
							traineeMale=traineeMale+employeeMasterVO2.getTraineeMale();
							traineeFeMale=traineeFeMale+employeeMasterVO2.getTraineeFeMale();
					}
						
						employeeMasterVO.setRegMale(regMale);
						employeeMasterVO.setRegFeMale(regFeMale);
						employeeMasterVO.setAppMale(appMale);
						employeeMasterVO.setAppFeMale(appFeMale);
						employeeMasterVO.setTraineeMale(traineeMale);
						employeeMasterVO.setTraineeFeMale(traineeFeMale);
						employeeMasterVO.setTotal(traineeFeMale+appFeMale+appMale+regFeMale+regMale+traineeMale);
						empListDeptwise.add(employeeMasterVO);
					}
					}
				}
				}
				return empListDeptwise;
			}
    } catch (Exception ex) {
                    //System.out.println("error: man power report " + ex.getMessage());
                    return null;
            }
	}
	
	
	public List<EmployeeMasterVO> groupByDepartementWise(
			List<EmployeeMasterVO> emoployeeList, final long deptId) {

		Predicate deptPredicte;

		deptPredicte = new Predicate() {
			public boolean evaluate(Object o) {

				return  ((EmployeeMasterVO) o).getDeptId()==deptId;
				
			}
		};
		Collection deptEmpList = CollectionUtils.select(emoployeeList,
				deptPredicte);
		if (deptEmpList.isEmpty()) {
			return null;
		} else {
			List<EmployeeMasterVO> empList = (List<EmployeeMasterVO>) deptEmpList;
			return empList;
		}

	}
	
	
	public List<EmployeeMasterVO> groupByDepartementandTransDateWise(
			List<EmployeeMasterVO> emoployeeList, final long deptId,final Date tranDate) {

		Predicate deptPredicte;

		deptPredicte = new Predicate() {
			public boolean evaluate(Object o) {

				return  ((EmployeeMasterVO) o).getDeptId()==deptId && ((EmployeeMasterVO) o).getEmpTransactionMonthYear().equals(tranDate);
				
			}
		};
		Collection deptEmpList = CollectionUtils.select(emoployeeList,
				deptPredicte);
		if (deptEmpList.isEmpty()) {
			return null;
		} else {
			List<EmployeeMasterVO> empList = (List<EmployeeMasterVO>) deptEmpList;
			return empList;
		}

	}
	
	
	
	
	@Transactional
	public List<EmployeeMasterVO> getEmployeeCTCReport()
			 {
		try {
			List<EmployeeMasterVO> employeeList = new ArrayList<EmployeeMasterVO>();

			List<EmployeeMasterBO> empBOList = employeeDao.getEmployeeListForCtCReport();
					
if(empBOList !=null && empBOList.size()>0)
{
			for (EmployeeMasterBO ebo : empBOList) {
				if(ebo !=null){
				EmployeeMasterVO evo = new EmployeeMasterVO();
				copy(ebo, evo);
				DepartmentVO departmentVO = new DepartmentVO();
				if(ebo.getDepartment() !=null)
				copy(ebo.getDepartment(), departmentVO);
				
				
				BranchMasterVO brnachMasterVo = new BranchMasterVO();
				if(ebo.getEmployeeBranch() !=null)
				copy(ebo.getEmployeeBranch(), brnachMasterVo);

				DesignationVO designationVO = new DesignationVO();
				if(ebo.getHrDesignation() !=null)
				copy(ebo.getHrDesignation(), designationVO);
				
				PackageVO packageVo=new PackageVO();
				if(ebo.getEmployeePackage() !=null)
					copy(ebo.getEmployeePackage(),packageVo);
					

				evo.setDesignation(designationVO);
				evo.setHrDepartment(departmentVO);
				evo.setHrEmployeePackageId(packageVo);
				evo.setHrEmployeeBranchId(brnachMasterVo);
				employeeList.add(evo);
				}
			}
}
			return employeeList;

		} catch (Exception ex) {
			ex.printStackTrace();
			return null;

		}
	}
	
	@Transactional
	public List<FinancialYearVO>  getMonthYears()
	{
		
		
		List<FinancialYearVO> financialYearVo=new ArrayList<FinancialYearVO>();
		List<Date> listOfTransDays=empTransactionDao.getTransactionDates();
		if(listOfTransDays !=null && listOfTransDays.size()>0)
		{
			for (Date date : listOfTransDays) {
				FinancialYearVO finsYear=new FinancialYearVO();
				SimpleDateFormat dateForamt=new SimpleDateFormat("MMM-yyyy");
				SimpleDateFormat dateForamt2=new SimpleDateFormat("dd-MMM-yyyy");
				SimpleDateFormat dateForamt3=new SimpleDateFormat("yyyy-MM-dd");
				finsYear.setDisplayYear(dateForamt.format(date));
				finsYear.setValueYear(dateForamt2.format(date));
				finsYear.setSortYear(dateForamt3.format(date));
				financialYearVo.add(finsYear);
			}
		}
		return financialYearVo;
		
	}
	
	@Transactional
	public List<FinancialYearVO>  getDistributedMonthYears()
	{
		
		
		List<FinancialYearVO> financialYearVo=new ArrayList<FinancialYearVO>();
		List<Date> listOfTransDays=empTransactionDao.getDistributedTransactionDates();
		if(listOfTransDays !=null && listOfTransDays.size()>0)
		{
			for (Date date : listOfTransDays) {
				FinancialYearVO finsYear=new FinancialYearVO();
				SimpleDateFormat dateForamt=new SimpleDateFormat("MMM-yyyy");
				SimpleDateFormat dateForamt2=new SimpleDateFormat("dd-MMM-yyyy");
				SimpleDateFormat dateForamt3=new SimpleDateFormat("yyyy-MM-dd");
				finsYear.setDisplayYear(dateForamt.format(date));
				finsYear.setValueYear(dateForamt2.format(date));
				finsYear.setSortYear(dateForamt3.format(date));
				financialYearVo.add(finsYear);
			}
		}
		return financialYearVo;
		
	}
	
	
	@Transactional
	public List<BankVO> getBankList( Date monthYear)
	{
		return empTransactionDao.getBankList(monthYear);
	}
	
	@Transactional
	public List<EmployeeMasterVO> getbankStatementReport( Date monthYear,int bankId,int deptId)
	{
		List<EmployeeMasterVO> allEmployeeBankDetailsFilterd=new ArrayList<EmployeeMasterVO>();
		List<EmployeeMasterVO> allEmployeeBankDetails=employeeDao.getBankStatementReport(monthYear,bankId);
		if(deptId==3)
		{
		return allEmployeeBankDetails;
		}
		else
		{
			if(allEmployeeBankDetails !=null && allEmployeeBankDetails.size()>0)
			{
				for (EmployeeMasterVO employeeMasterVO : allEmployeeBankDetails) {
					if(deptId==2)
					{
						if(employeeMasterVO.getDeptId()==7)
						{
							allEmployeeBankDetailsFilterd.add(employeeMasterVO);
						}
					}else if(deptId==1)
					{
						if(employeeMasterVO.getDeptId()!=7)
						{
							allEmployeeBankDetailsFilterd.add(employeeMasterVO);
						}
					}
				}
			}
			
			return allEmployeeBankDetailsFilterd;
		}
	}
	@Transactional
	public EmployeeMasterVO getsalartStatementReport( Date monthYear,int bankId,int deptId)
	{
		try{
		EmployeeMasterVO empMasterVO =new EmployeeMasterVO();
		List<EmployeeMasterVO> allEmployeeBankDetailsFilterd=new ArrayList<EmployeeMasterVO>();
		List<EmployeeMasterVO> allEmployeeBankDetails=employeeDao.getBankStatementReport(monthYear,bankId);
		BigDecimal totamt=new BigDecimal(0);
		if(deptId==3)
		{
			empMasterVO.setEmpListForSalaryStatement(allEmployeeBankDetails);
		return empMasterVO;
		}
		else
		{
			if(allEmployeeBankDetails !=null && allEmployeeBankDetails.size()>0)
			{
				for (EmployeeMasterVO employeeMasterVO : allEmployeeBankDetails) {
					if(deptId==3){
						totamt=totamt.add(employeeMasterVO.getEmpTransactionNetSalary());
					}
					if(deptId==2)
					{
						if(employeeMasterVO.getDeptId()==7)
						{
							totamt=totamt.add(employeeMasterVO.getEmpTransactionNetSalary());
							allEmployeeBankDetailsFilterd.add(employeeMasterVO);
						}
					}else if(deptId==1)
					{
						if(employeeMasterVO.getDeptId()!=7)
						{
							totamt=totamt.add(employeeMasterVO.getEmpTransactionNetSalary());
							allEmployeeBankDetailsFilterd.add(employeeMasterVO);
						}
					}
				}
			}
			if(totamt!=null){
			long totalValue = totamt.longValue();
			String amountinwords=commonUtilService.convertCashToWords(totalValue);
			empMasterVO.setTotNetSalaryInWords(amountinwords);
			}
			empMasterVO.setTotNetSalary(totamt);
			empMasterVO.setEmpListForSalaryStatement(allEmployeeBankDetailsFilterd);
			
			return empMasterVO;
		}
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}
	}
	
	
	@Transactional
	public List<EmployeeMasterVO> getEmployeeHistoryList(int status){
		try{
			List<EmployeeMasterVO> employeeMasterVOList=new ArrayList<EmployeeMasterVO>();
			
					employeeMasterVOList=employeeDao.fetchEmpListByStatus(status);//status=1
			
			
			return employeeMasterVOList; 
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}
	}

	@Override
	public List<EmployeeMasterVO> getHODList() {
		try {
			List<EmployeeMasterVO> employee = employeeDao.getEmpListForIQAMembers();// type!=7
			
			return employee;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
		
	}
	

	@Transactional
	public List<EmployeeTransactionVO> getEmployeePayslipReport(Date monthYear,long empId) {
		try {
			List<EmployeeTransactionVO> employeeTransVoList=new ArrayList<EmployeeTransactionVO>();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
			String strDate = "01-Jan-" +formatter.format(monthYear);
			
			SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
			SimpleDateFormat formatterMonth = new SimpleDateFormat("MMM-yyyy");
			
			Date fDate = formatter1.parse(strDate);
			if(empId==0)
				employeeTransVoList = empTransactionDao
					.getAllEmployeePaySlip(monthYear,fDate,monthYear,Integer.parseInt(formatter.format(monthYear)));
			else
				employeeTransVoList = empTransactionDao
				.getEmployeePaySlip(monthYear,fDate,monthYear,Integer.parseInt(formatter.format(monthYear)),empId);

			
			if (employeeTransVoList != null && employeeTransVoList.size() > 0) {
				for (EmployeeTransactionVO empTransVo : employeeTransVoList) {
					
					empTransVo.setNetsalInWords(commonUtilService.convertCashToWords(empTransVo.getEmpTransactionNetSalary().longValue()));
				empTransVo.setTransMonth(formatterMonth.format(empTransVo.getEmpTransactionMonthYear()));
				}
				
			}
			return employeeTransVoList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeMasterVO> getEmpListForPFForm(){
		try{
			List<EmployeeMasterVO> employeeMasterVOList= employeeDao.fetchEmpListForPFForm();
			return employeeMasterVOList; 
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}
	}

	@Override
	@Transactional
	public List<EmployeeTransactionVO> getEmpDetailsForIncometax(Date monthYear) {
		// TODO Auto-generated method stub  empTransactionDao
		try{
		List<EmployeeTransactionVO> employeeTransactionVO=empTransactionDao.fetchIncometaxDetails(monthYear);;
		/*List<EmployeeTransactionBO> employeeTransactionBO=empTransactionDao.fetchIncometaxDetails(monthYear);*/
		/*if(employeeTransactionBO!=null){
		for (EmployeeTransactionBO empTransactionBO: employeeTransactionBO) {
			EmployeeTransactionVO empTransactionVO=new EmployeeTransactionVO();
			copy(empTransactionBO,empTransactionVO);
			EmployeeMasterVO empMasterVO=new EmployeeMasterVO();
			if(empTransactionBO.getEmpTransactionEmployeeId()!=null){
				copy(empTransactionBO.getEmpTransactionEmployeeId(),empMasterVO);
			}
			DepartmentVO departmentVO=new DepartmentVO();
			if(empTransactionBO.getEmpTransactionDeptId()!=null){
				copy(empTransactionBO.getEmpTransactionDeptId(),departmentVO);
			}
			DesignationVO designationVO=new DesignationVO();
			if(empTransactionBO.getEmpTransactionDesgId()!=null){
				copy(empTransactionBO.getEmpTransactionDesgId(),designationVO);
			}
			empTransactionVO.setEmpTransactionEmployee(empMasterVO);
			empTransactionVO.setEmpTransactionDept(departmentVO);
			empTransactionVO.setEmpTransactionDesg(designationVO);
			employeeTransactionVO.add(empTransactionVO);
		}
		}*/
		
		return employeeTransactionVO;
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}
	}
	

	@Transactional
	public List<EmployeeTransactionVO> getEmployeePaySlipByTransaction(String transactionids) {
		try {
			
			List<Long> transactinIds = new ArrayList<Long>();
			String[] Ids = transactionids.split("[,]");
			for (int i = 0; i < Ids.length; i++)
				transactinIds.add(Long.parseLong(Ids[i]));
			List<EmployeeTransactionVO> employeeTransVoList=empTransactionDao
					.getEmployeePaySlipByTransaction(transactinIds);
			
				
			if (employeeTransVoList != null && employeeTransVoList.size() > 0) {
				for (EmployeeTransactionVO empTransVo : employeeTransVoList) {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
					String strDate = "01-Jan-" +formatter.format(empTransVo.getEmpTransactionMonthYear());
					
					SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
					SimpleDateFormat formatterMonth = new SimpleDateFormat("MMM-yyyy");
					
					Date fDate = formatter1.parse(strDate);
					BigDecimal Clsused=empTransactionDao.getTotalCls(empTransVo.getEmployeeId(), fDate, empTransVo.getEmpTransactionMonthYear());
					BigDecimal Elsused=empTransactionDao.getTotalEls(empTransVo.getEmployeeId(), fDate, empTransVo.getEmpTransactionMonthYear());
					empTransVo.setEmployeeCL(empTransVo.getEmployeeCL().subtract(Clsused));
					empTransVo.setEmployeeEL(empTransVo.getEmployeeEL().subtract(Elsused));
					empTransVo.setNetsalInWords(commonUtilService.convertCashToWords(empTransVo.getEmpTransactionNetSalary().longValue()));
				   empTransVo.setTransMonth(formatterMonth.format(empTransVo.getEmpTransactionMonthYear()));
				}
				
			}
			
			return employeeTransVoList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	@Transactional
	public List<EmployeeTransactionVO>  getMonthandYearsForEmpPaySlip(int reportType,long employeeId)
	{
		try {
		SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
		List<EmployeeTransactionVO> employeeTransVoList=new ArrayList<EmployeeTransactionVO>();
	if(reportType==0)
	{
		
			Date effctedDate=formatter1.parse("01-Apr-2008");
			employeeTransVoList= empTransactionDao.getMonthsYearsForEmpPaySlip(effctedDate, employeeId);
		

	}
	else if(reportType==1)
	{
		Date effctedDate=formatter1.parse("01-Mar-2008");
		Date fromDate=formatter1.parse("01-Apr-2003");
		employeeTransVoList= empTransactionDao.getMonthsYearsbetweenDatesForEmpPaySlip(fromDate,effctedDate, employeeId);
	}
	else
	{
		Date effctedDate=formatter1.parse("01-Mar-2003");
		Date fromDate=formatter1.parse("01-Apr-1999");
		employeeTransVoList= empTransactionDao.getMonthsYearsbetweenDatesForEmpPaySlip(fromDate,effctedDate, employeeId);
	
	}
	Collections.sort(employeeTransVoList, new TransactionOrder());
		return employeeTransVoList;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	@Transactional
	public List<EmployeeMasterVO> getReguraliseEmployeeListForHrReport()
			throws FunworkBusinessException {
		try {
			List<EmployeeMasterVO> employeeMasterVOs = new ArrayList<EmployeeMasterVO>();
			List<EmployeeMasterVO> employeeMasterList = employeeDao.fetchEmpListForHrReport();
			if(employeeMasterList!=null){
				for(EmployeeMasterVO employeeMasterVO:employeeMasterList){
					DateTime  joiningDate=new DateTime(employeeMasterVO.getEmployeeDateofJoining());
					 DateTime  todayDate=new DateTime(new Date());
					 String noOfYearsExp=Years.yearsBetween(joiningDate, todayDate).getYears() + " year(s), "+Months.monthsBetween(joiningDate, todayDate).getMonths() % 12 + "month(s)";
					 employeeMasterVO.setTotExperiance(noOfYearsExp);
				     employeeMasterVOs.add(employeeMasterVO);
				}
			}
			
			/*if(employeeMasterBOs!=null){
			for (EmployeeMasterBO employeeMasterBO : employeeMasterBOs) {
				//if(employeeMasterBO.getHrDesignation().getDesignationLevel()<13){
				EmployeeMasterVO employeeMasterVO = new EmployeeMasterVO();
				copy(employeeMasterBO, employeeMasterVO);
				
				DesignationVO designationVO = new DesignationVO();
				if(employeeMasterBO.getHrDesignation()!=null){
				copy(employeeMasterBO.getHrDesignation(), designationVO);
				}
				
				DepartmentVO departmentVO = new DepartmentVO();
				if(employeeMasterBO.getDepartment()!=null){
				copy(employeeMasterBO.getDepartment(), departmentVO);
				}
				
				BranchMasterVO branchMasterVO=new BranchMasterVO();
				if(employeeMasterBO.getEmployeeBranch()!=null){
					copy(employeeMasterBO.getEmployeeBranch(),branchMasterVO);
				}
				PackageVO packageVO=new PackageVO();
				if(employeeMasterBO.getEmployeePackage()!=null){
					copy(employeeMasterBO.getEmployeePackage(),packageVO);
				}
				employeeMasterVO.setHrEmployeePackageId(packageVO);
				employeeMasterVO.setHrEmployeeBranchId(branchMasterVO);
				employeeMasterVO.setDesignation(designationVO);
				employeeMasterVO.setHrDepartment(departmentVO);
				
				employeeMasterVO.setDeptName(departmentVO.getDepartmentName());
					DateTime  joiningDate=new DateTime(employeeMasterVO.getEmployeeDateofJoining());
					 DateTime  todayDate=new DateTime(new Date());
					 String noOfYearsExp=Years.yearsBetween(joiningDate, todayDate).getYears() + " year(s), "+Months.monthsBetween(joiningDate, todayDate).getMonths() % 12 + "month(s)";
					 employeeMasterVO.setTotExperiance(noOfYearsExp);
				employeeMasterVOs.add(employeeMasterVO);
				//}
				 

			}
			}*/
			return employeeMasterVOs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	@Transactional
	public EmployeeTransactionVO getEmpListForHRESIReport(
			Date selectedDate) {
		// TODO Auto-generated method stub
		EmployeeTransactionVO employeeTransactionVo=new EmployeeTransactionVO();
		List<EmployeeTransactionVO> empTransactionVoListForRD=new ArrayList<EmployeeTransactionVO>();
		List<EmployeeTransactionVO> empTransVoListForOtherMadhapur=new ArrayList<EmployeeTransactionVO>();
		List<EmployeeTransactionVO> empTransVoListForOtherVizag=new ArrayList<EmployeeTransactionVO>();
		List<EmployeeTransactionBO> empTransactionBoList=empTransactionDao.getEmpTransactionListForHRESI(selectedDate);
		BigDecimal wages=new BigDecimal(0);
		for (EmployeeTransactionBO employeeTransactionBO : empTransactionBoList) {
			EmployeeTransactionVO employeeTransactionVO=new EmployeeTransactionVO();
			copy(employeeTransactionBO,employeeTransactionVO);
			
			BigDecimal monthdays=new BigDecimal(employeeTransactionBO.getEmpTransactionMonthDays());
			if(monthdays!=null){
			wages=(employeeTransactionBO.getEmpTransactionGrossSalary().multiply(employeeTransactionBO.getEmpTransactionWageDays())).divide(monthdays,2);
			if(wages!=null){
			employeeTransactionVO.setEmployeeWages(wages);
			}
			}
			//EmployeeMasterVO employeeMasterVO=new EmployeeMasterVO();
			
			/*if(employeeTransactionBO.getEmpTransactionEmployeeId()!=null){
				copy(employeeTransactionBO.getEmpTransactionEmployeeId(),employeeMasterVO);
				BranchMasterVO branchMasterVO=new BranchMasterVO();
				if(employeeTransactionBO.getEmpTransactionEmployeeId().getEmployeeBranch()!=null){
					copy(employeeTransactionBO.getEmpTransactionEmployeeId().getEmployeeBranch(),branchMasterVO);
				}
				employeeMasterVO.setHrEmployeeBranchId(branchMasterVO);
			}*/
			
		/*	DepartmentVO departmentVO=new DepartmentVO();
			if(employeeTransactionBO.getEmpTransactionDeptId()!=null){
				copy(employeeTransactionBO.getEmpTransactionDeptId(),departmentVO);
			}
			employeeTransactionVO.setEmpTransactionEmployee(employeeMasterVO);
			
			employeeTransactionVO.setEmpTransactionDept(departmentVO);*/
			employeeTransactionVO.setEmployeeCode(employeeTransactionBO.getEmpTransactionEmployeeId().getEmployeeCode());
			employeeTransactionVO.setEmployeeName(employeeTransactionBO.getEmpTransactionEmployeeId().getEmployeeFullName());
			
			if(employeeTransactionBO.getEmpTransactionDeptId().getDepartmentId()==7){
				empTransactionVoListForRD.add(employeeTransactionVO);
			}
			else{
				if(employeeTransactionBO.getEmpTransactionEmployeeId().getEmployeeBranch().getBranchMasterId()==1){
				empTransVoListForOtherMadhapur.add(employeeTransactionVO);
				}else{
					empTransVoListForOtherVizag.add(employeeTransactionVO);
				}
			}
		}
		employeeTransactionVo.setEmpTransVoListForOtherMadhapur(empTransVoListForOtherMadhapur);
		employeeTransactionVo.setEmpTransactionVoListForRD(empTransactionVoListForRD);
		employeeTransactionVo.setEmpTransVoListForOtherVizag(empTransVoListForOtherVizag);
		
		return employeeTransactionVo;
	}

	@Override
	@Transactional
	public List<EmployeeMasterVO> fetchDeptWiseEmployeesForHR(int deptID) {
		List<EmployeeMasterVO> trnNeedDeptWiseEmpList = employeeDao.getDeptWiseEmployeesForHR(deptID);
		return trnNeedDeptWiseEmpList;
	}

	@Transactional
	public List<EmployeeMasterVO> fetchDeptWiseEmployeesForAttandanceMail(
			int branchId) {
		try
		{
			List<EmployeeMasterVO> empList=employeeDao.getDeptWiseEmployeesForAttandanceMail(branchId);
			return empList;
		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
	}
	
	//for report
	@Transactional
	public List<ManPowerEmpVO> getManPowerEmpCountForRD()
	{
		try
		{
			List<ManPowerEmpVO> manPowerEmpVOList=employeeDao.getManPowerEmpCountForRD();
		return manPowerEmpVOList;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
	}
	
	@Transactional
	public List<EmployeeMasterVO> getTopRDPersonnel()
	{
		List<EmployeeMasterVO> employeeMasterVOList=new ArrayList<EmployeeMasterVO>();
		try
		{
			List<EmployeeMasterBO> employeeMasterBOList=employeeDao.getTopRDPersonnel(new PageRequest(0,15));
			if(employeeMasterBOList!=null && employeeMasterBOList.size() > 0)
			{
				for(EmployeeMasterBO employeeMasterBO : employeeMasterBOList)
				{
					if(employeeMasterBO!=null && employeeMasterBO.getEmployeeId() > 0)
					{
						EmployeeMasterVO employeeMasterVO=new EmployeeMasterVO();
						copy(employeeMasterBO,employeeMasterVO);
						
						//desg
						DesignationBO designationBO=employeeMasterBO.getHrDesignation();
						if(designationBO!=null && designationBO.getDesignationId() > 0)
						{
						DesignationVO designationVO=new DesignationVO();
						copy(designationBO,designationVO);
						employeeMasterVO.setDesignation(designationVO);
						}
						
						//package
						PackageBO packageBO=employeeMasterBO.getEmployeePackage();
						if(packageBO!=null && packageBO.getPackageId() > 0)
						{
							PackageVO packageVO=new PackageVO();
							copy(packageBO,packageVO);
							employeeMasterVO.setHrEmployeePackageId(packageVO);
							
						}
						
						//total exp
						DateTime  joiningDate=new DateTime(employeeMasterVO.getEmployeeDateofJoining());
						DateTime  todayDate=new DateTime(new Date());
						String noOfYearsExp=Years.yearsBetween(joiningDate, todayDate).getYears() + " year(s), "+Months.monthsBetween(joiningDate, todayDate).getMonths() % 12 + "month(s)";
						employeeMasterVO.setTotExperiance(noOfYearsExp);
						if(employeeMasterVO.getEmployeeCode() != 1)
						{
							employeeMasterVOList.add(employeeMasterVO);	
						}
						else
						{
							employeeMasterVOList.add(0,employeeMasterVO);	
						}
						
					}
				}
			}
			return employeeMasterVOList;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
	}

	@Override
	@Transactional
	public List<EmployeeMasterVO> getEmpListForAttendanceDetails() {
		// TODO Auto-generated method stub
		return employeeDao.fetchEmpListForAttendanceDetails();
	}

	@Transactional
	public EmployeeMasterVO fetchEmployeeDetailsByEmpCode(int empId) {
		EmployeeMasterVO employeeMasterVO = employeeDao.fetchEmployeeDetailsByEmpCode(empId);
		return employeeMasterVO;
	}

	@Transactional
	public List<EmployeeMasterVO> getLeaveRecommendationApprovalList(String permissionType, int empCode) {
		List<EmployeeMasterVO> empList=new ArrayList<EmployeeMasterVO>();
		if(permissionType.equalsIgnoreCase("LR")){
			empList=employeeDao.fetchLeaveRecommendationApprovalList(empCode);
		}
		return empList;
		
	}

	@Transactional
	public List<EmployeeSummaryVO> getEmployeeDropDown() {
		try
		{
			List<EmployeeSummaryVO> employeeList=employeeDao.getEmployeeDropDown(7);
			return employeeList;
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return null;
		}
	}

	@Override
	public List<EmployeeSummaryVO> getEmployeeDropDownByBranch(int branchId) {
		// TODO Auto-generated method stub
		return employeeDao.getEmployeeDropDownByBranch(branchId);
	}
	}

class TransactionOrder implements Comparator<EmployeeTransactionVO> {
	@Override
	public int compare(EmployeeTransactionVO a, EmployeeTransactionVO b) {
		return b.getEmpTransactionId() < a.getEmpTransactionId() ? -1
				: b.getEmpTransactionId()== a
						.getEmpTransactionId() ? 0 : 1;
	}
	
	
	
}