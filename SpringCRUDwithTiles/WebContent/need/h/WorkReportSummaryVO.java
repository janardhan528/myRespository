package com.avantel.funwork4.vo.common;

import java.math.BigDecimal;
import java.util.Date;

public class WorkReportSummaryVO {
	
	private long wrMastId;
	private String wrNUmber;
	private Date wrDate;
	private long woId;
	private String customer;
	private String woNumber;
	private long productId;
	private String productName;
	private BigDecimal qtyOrdered;
	private String serialNumber;
	private int branchId;
	private String branch;
	
	public WorkReportSummaryVO()
	{
		
	}
	
	public long getWrMastId() {
		return wrMastId;
	}
	public void setWrMastId(long wrMastId) {
		this.wrMastId = wrMastId;
	}
	public String getWrNUmber() {
		return wrNUmber;
	}
	public void setWrNUmber(String wrNUmber) {
		this.wrNUmber = wrNUmber;
	}
	public Date getWrDate() {
		return wrDate;
	}
	public void setWrDate(Date wrDate) {
		this.wrDate = wrDate;
	}
	public long getWoId() {
		return woId;
	}
	public void setWoId(long woId) {
		this.woId = woId;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getWoNumber() {
		return woNumber;
	}
	public void setWoNumber(String woNumber) {
		this.woNumber = woNumber;
	}
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public BigDecimal getOrdered() {
		return qtyOrdered;
	}
	public void setQtyOrdered(BigDecimal qtyOrdered) {
		this.qtyOrdered = qtyOrdered;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	
	

}
