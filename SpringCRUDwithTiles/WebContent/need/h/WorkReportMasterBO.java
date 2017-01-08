package com.avantel.funwork4.bo.common;

import java.io.Serializable;

import javax.persistence.*;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.avantel.funwork4.bo.marketing.workorder.WorkOrderMasterBO;
import com.avantel.funwork4.bo.qa.fir.FIRMasterBO;

import java.util.Date;
import java.util.List;


/**
 * The persistent class for the gen_workreportmaster database table.
 * 
 */
@EntityListeners(AuditingEntityListener.class)
@Entity
@Table(name="GEN_WorkReportMaster")
public class WorkReportMasterBO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long workReportId;
	private String approvalRemarks;
	private int approvalStatus;
	private int approvedBy;
	private Date approvedOn;
	private int workReportBranchId;
	@CreatedBy
	private int createdBy;
	@CreatedDate
	private Date createdOn;
	private Date workReportDate;
	private int workReportDeptId;
	@LastModifiedBy
	private int modifiedBy;
	@LastModifiedDate
	private Date modifiedOn;
	private String workReportNumber;
	private String workReportQARemarks;
	private String workReportRemarks;
	private int workReportStatus;
	private WorkOrderMasterBO workOrder;
	private List<WorkReportDetailBO> genWorkreportdetails;
	private List<FIRMasterBO> workReportFirs;

	public WorkReportMasterBO() {
	}


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="WorkReport_Id", unique=true, nullable=false, precision=10)
	public long getWorkReportId() {
		return this.workReportId;
	}

	public void setWorkReportId(long workReportId) {
		this.workReportId = workReportId;
	}


	@Column(name="WorkReport_ApprovalRemarks", length=1000)
	public String getApprovalRemarks() {
		return this.approvalRemarks;
	}

	public void setApprovalRemarks(String approvalRemarks) {
		this.approvalRemarks = approvalRemarks;
	}


	@Column(name="WorkReport_ApprovalStatus", nullable=false)
	public int getApprovalStatus() {
		return this.approvalStatus;
	}

	public void setApprovalStatus(int approvalStatus) {
		this.approvalStatus = approvalStatus;
	}


	@Column(name="WorkReport_ApprovedBy", nullable=false)
	public int getApprovedBy() {
		return this.approvedBy;
	}

	public void setApprovedBy(int approvedBy) {
		this.approvedBy = approvedBy;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="WorkReport_ApprovedOn")
	public Date getApprovedOn() {
		return this.approvedOn;
	}

	public void setApprovedOn(Date approvedOn) {
		this.approvedOn = approvedOn;
	}


	@Column(name="WorkReport_BranchID", nullable=false)
	public int getWorkReportBranchId() {
		return this.workReportBranchId;
	}

	public void setWorkReportBranchId(int workReportBranchId) {
		this.workReportBranchId = workReportBranchId;
	}


	@Column(name="WorkReport_CreatedBy", nullable=false)
	public int getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="WorkReport_CreatedOn")
	public Date getCreatedOn() {
		return this.createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="WorkReport_Date", nullable=false)
	public Date getWorkReportDate() {
		return this.workReportDate;
	}

	public void setWorkReportDate(Date workReportDate) {
		this.workReportDate = workReportDate;
	}


	@Column(name="WorkReport_DeptId", nullable=false)
	public int getWorkReportDeptId() {
		return this.workReportDeptId;
	}

	public void setWorkReportDeptId(int workReportDeptId) {
		this.workReportDeptId = workReportDeptId;
	}


	@Column(name="WorkReport_ModifiedBy", nullable=false)
	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="WorkReport_ModifiedOn")
	public Date getModifiedOn() {
		return this.modifiedOn;
	}

	public void setModifiedOn(Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}


	@Column(name="WorkReport_Number", length=50)
	public String getWorkReportNumber() {
		return this.workReportNumber;
	}

	public void setWorkReportNumber(String workReportNumber) {
		this.workReportNumber = workReportNumber;
	}


	@Column(name="WorkReport_QARemarks", length=1000)
	public String getWorkReportQARemarks() {
		return this.workReportQARemarks;
	}

	public void setWorkReportQARemarks(String workReportQARemarks) {
		this.workReportQARemarks = workReportQARemarks;
	}


	@Column(name="WorkReport_Remarks", length=500)
	public String getWorkReportRemarks() {
		return this.workReportRemarks;
	}

	public void setWorkReportRemarks(String workReportRemarks) {
		this.workReportRemarks = workReportRemarks;
	}


	@Column(name="WorkReport_Status", nullable=false)
	public int getWorkReportStatus() {
		return this.workReportStatus;
	}

	public void setWorkReportStatus(int workReportStatus) {
		this.workReportStatus = workReportStatus;
	}


	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="WorkReport_WoId", nullable=false)
	public WorkOrderMasterBO getWorkOrder() {
		return this.workOrder;
	}

	public void setWorkOrder(WorkOrderMasterBO workOrder) {
		this.workOrder = workOrder;
	}


	//bi-directional many-to-one association to Workreportdetail
	@OneToMany(mappedBy="genWorkreportmaster")
	public List<WorkReportDetailBO> getGenWorkreportdetails() {
		return this.genWorkreportdetails;
	}

	public void setGenWorkreportdetails(List<WorkReportDetailBO> genWorkreportdetails) {
		this.genWorkreportdetails = genWorkreportdetails;
	}

	public WorkReportDetailBO addGenWorkreportdetail(WorkReportDetailBO genWorkreportdetail) {
		getGenWorkreportdetails().add(genWorkreportdetail);
		genWorkreportdetail.setGenWorkreportmaster(this);

		return genWorkreportdetail;
	}

	public WorkReportDetailBO removeGenWorkreportdetail(WorkReportDetailBO genWorkreportdetail) {
		getGenWorkreportdetails().remove(genWorkreportdetail);
		genWorkreportdetail.setGenWorkreportmaster(null);

		return genWorkreportdetail;
	}


	@OneToMany(mappedBy="wrkReport")
	public List<FIRMasterBO> getWorkReportFirs() {
		return workReportFirs;
	}


	public void setWorkReportFirs(List<FIRMasterBO> workReportFirs) {
		this.workReportFirs = workReportFirs;
	}

	
	
}