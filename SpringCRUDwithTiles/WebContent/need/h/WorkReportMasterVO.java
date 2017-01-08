package com.avantel.funwork4.vo.common;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.avantel.funwork4.vo.BaseVO;
import com.avantel.funwork4.vo.marketing.workorder.WOMasterVO;


public class WorkReportMasterVO extends BaseVO{

	
	private long workReportId;
	private String approvalRemarks;
	private int approvalStatus;
	private int approvedBy;
	private Date approvedOn;
	private int workReportBranchId;
	private int createdBy;
	private Date createdOn;
	@DateTimeFormat(pattern="dd-MMM-yyyy")
	private Date workReportDate;
	private int workReportDeptId;
	private int modifiedBy;
	private Date modifiedOn;
	private String workReportNumber;
	private String workReportQARemarks;
	private String workReportRemarks;
	private int workReportStatus;
	private WOMasterVO workOrders;
	private List<WorkReportDetailVO> genWorkreportdetail;
	
	private long productId;
	private long woDetailId;
	private String refdocNum;
	private String createdByName;
	private String approvedByName;
	
	private String customerName;
	private String productName;
	private String wrDetailSerialNo;
	private BigDecimal wrDetailQtyOffered;
	
	private Date firApprovedOn;
	private Date clearedOn;
	private int duration;
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public Date getFirApprovedOn() {
		return firApprovedOn;
	}
	public void setFirApprovedOn(Date firApprovedOn) {
		this.firApprovedOn = firApprovedOn;
	}
	public Date getClearedOn() {
		return clearedOn;
	}
	public void setClearedOn(Date clearedOn) {
		this.clearedOn = clearedOn;
	}
	public long getWoDetailId() {
		return woDetailId;
	}
	public void setWoDetailId(long woDetailId) {
		this.woDetailId = woDetailId;
	}
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public long getWorkReportId() {
		return workReportId;
	}
	public void setWorkReportId(long workReportId) {
		this.workReportId = workReportId;
	}
	public String getApprovalRemarks() {
		return approvalRemarks;
	}
	public void setApprovalRemarks(String approvalRemarks) {
		this.approvalRemarks = approvalRemarks;
	}
	public int getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(int approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public int getApprovedBy() {
		return approvedBy;
	}
	public void setApprovedBy(int approvedBy) {
		this.approvedBy = approvedBy;
	}
	public Date getApprovedOn() {
		return approvedOn;
	}
	public void setApprovedOn(Date approvedOn) {
		this.approvedOn = approvedOn;
	}
	public int getWorkReportBranchId() {
		return workReportBranchId;
	}
	public void setWorkReportBranchId(int workReportBranchId) {
		this.workReportBranchId = workReportBranchId;
	}
	public int getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
	public Date getWorkReportDate() {
		return workReportDate;
	}
	public void setWorkReportDate(Date workReportDate) {
		this.workReportDate = workReportDate;
	}
	public int getWorkReportDeptId() {
		return workReportDeptId;
	}
	public void setWorkReportDeptId(int workReportDeptId) {
		this.workReportDeptId = workReportDeptId;
	}
	public int getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public Date getModifiedOn() {
		return modifiedOn;
	}
	public void setModifiedOn(Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
	public String getWorkReportNumber() {
		return workReportNumber;
	}
	public void setWorkReportNumber(String workReportNumber) {
		this.workReportNumber = workReportNumber;
	}
	public String getWorkReportQARemarks() {
		return workReportQARemarks;
	}
	public void setWorkReportQARemarks(String workReportQARemarks) {
		this.workReportQARemarks = workReportQARemarks;
	}
	public String getWorkReportRemarks() {
		return workReportRemarks;
	}
	public void setWorkReportRemarks(String workReportRemarks) {
		this.workReportRemarks = workReportRemarks;
	}
	public int getWorkReportStatus() {
		return workReportStatus;
	}
	public void setWorkReportStatus(int workReportStatus) {
		this.workReportStatus = workReportStatus;
	}
	public WOMasterVO getWorkOrders() {
		return workOrders;
	}
	public void setWorkOrders(WOMasterVO workOrders) {
		this.workOrders = workOrders;
	}
	public List<WorkReportDetailVO> getGenWorkreportdetail() {
		return genWorkreportdetail;
	}
	public void setGenWorkreportdetail(List<WorkReportDetailVO> genWorkreportdetail) {
		this.genWorkreportdetail = genWorkreportdetail;
	}
	public String getRefdocNum() {
		return refdocNum;
	}
	public void setRefdocNum(String refdocNum) {
		this.refdocNum = refdocNum;
	}
	public String getCreatedByName() {
		return createdByName;
	}
	public void setCreatedByName(String createdByName) {
		this.createdByName = createdByName;
	}
	public String getApprovedByName() {
		return approvedByName;
	}
	public void setApprovedByName(String approvedByName) {
		this.approvedByName = approvedByName;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getWrDetailSerialNo() {
		return wrDetailSerialNo;
	}
	public void setWrDetailSerialNo(String wrDetailSerialNo) {
		this.wrDetailSerialNo = wrDetailSerialNo;
	}
	public BigDecimal getWrDetailQtyOffered() {
		return wrDetailQtyOffered;
	}
	public void setWrDetailQtyOffered(BigDecimal wrDetailQtyOffered) {
		this.wrDetailQtyOffered = wrDetailQtyOffered;
	}
	public WorkReportMasterVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WorkReportMasterVO(long workReportId, Date workReportDate,
			String workReportNumber, String refdocNum, String customerName,
			String productName, String wrDetailSerialNo,
			BigDecimal wrDetailQtyOffered) {
		super();
		this.workReportId = workReportId;
		this.workReportDate = workReportDate;
		this.workReportNumber = workReportNumber;
		this.refdocNum = refdocNum;
		this.customerName = customerName;
		this.productName = productName;
		this.wrDetailSerialNo = wrDetailSerialNo;
		this.wrDetailQtyOffered = wrDetailQtyOffered;
	}
	
	public WorkReportMasterVO(long workReportId, Date workReportDate,
			String workReportNumber, String refdocNum, String customerName,
			Date firApprovedOn) {
		super();
		this.workReportId = workReportId;
		this.workReportDate = workReportDate;
		this.workReportNumber = workReportNumber;
		this.refdocNum = refdocNum;
		this.customerName = customerName;
		this.firApprovedOn = firApprovedOn;
		
		
	}
	
	
	

}
