package com.avantel.funwork4.vo.common;

import java.math.BigDecimal;
import java.util.List;

import com.avantel.funwork4.vo.BaseVO;
import com.avantel.funwork4.vo.marketing.product.ProductMasterVO;

public class WorkReportDetailVO extends BaseVO {

	private long wrDetailId;
	private String wrDetailFileName;
	private String wrDetailFIRNo;
	private ProductMasterVO wrDetailProdId;
	private BigDecimal wrDetailQtyAccEar;
	private BigDecimal wrDetailQtyAccNow;
	private BigDecimal wrDetailQtyBalance;
	private BigDecimal wrDetailQtyOffered;
	private BigDecimal wrDetailQtyOrdered;
	private String wrDetailRemarks;
	private String wrDetailSerialNo;
	private WorkReportMasterVO genWorkreportmasters;
	private List<WorkProdSerialVO> wrSerials;
	private String fileName;
	
	private boolean deleteIndicator;
	private String fileURL;
	
	
	
	public boolean isDeleteIndicator() {
		return deleteIndicator;
	}
	public void setDeleteIndicator(boolean deleteIndicator) {
		this.deleteIndicator = deleteIndicator;
	}
	public long getWrDetailId() {
		return wrDetailId;
	}
	public void setWrDetailId(long wrDetailId) {
		this.wrDetailId = wrDetailId;
	}
	public String getWrDetailFileName() {
		return wrDetailFileName;
	}
	public void setWrDetailFileName(String wrDetailFileName) {
		this.wrDetailFileName = wrDetailFileName;
	}
	public String getWrDetailFIRNo() {
		return wrDetailFIRNo;
	}
	public void setWrDetailFIRNo(String wrDetailFIRNo) {
		this.wrDetailFIRNo = wrDetailFIRNo;
	}
	public ProductMasterVO getWrDetailProdId() {
		return wrDetailProdId;
	}
	public void setWrDetailProdId(ProductMasterVO wrDetailProdId) {
		this.wrDetailProdId = wrDetailProdId;
	}
	public BigDecimal getWrDetailQtyAccEar() {
		return wrDetailQtyAccEar;
	}
	public void setWrDetailQtyAccEar(BigDecimal wrDetailQtyAccEar) {
		this.wrDetailQtyAccEar = wrDetailQtyAccEar;
	}
	public BigDecimal getWrDetailQtyAccNow() {
		return wrDetailQtyAccNow;
	}
	public void setWrDetailQtyAccNow(BigDecimal wrDetailQtyAccNow) {
		this.wrDetailQtyAccNow = wrDetailQtyAccNow;
	}
	public BigDecimal getWrDetailQtyBalance() {
		return wrDetailQtyBalance;
	}
	public void setWrDetailQtyBalance(BigDecimal wrDetailQtyBalance) {
		this.wrDetailQtyBalance = wrDetailQtyBalance;
	}
	public BigDecimal getWrDetailQtyOffered() {
		return wrDetailQtyOffered;
	}
	public void setWrDetailQtyOffered(BigDecimal wrDetailQtyOffered) {
		this.wrDetailQtyOffered = wrDetailQtyOffered;
	}
	public BigDecimal getWrDetailQtyOrdered() {
		return wrDetailQtyOrdered;
	}
	public void setWrDetailQtyOrdered(BigDecimal wrDetailQtyOrdered) {
		this.wrDetailQtyOrdered = wrDetailQtyOrdered;
	}
	public String getWrDetailRemarks() {
		return wrDetailRemarks;
	}
	public void setWrDetailRemarks(String wrDetailRemarks) {
		this.wrDetailRemarks = wrDetailRemarks;
	}
	public String getWrDetailSerialNo() {
		return wrDetailSerialNo;
	}
	public void setWrDetailSerialNo(String wrDetailSerialNo) {
		this.wrDetailSerialNo = wrDetailSerialNo;
	}
	public WorkReportMasterVO getGenWorkreportmasters() {
		return genWorkreportmasters;
	}
	public void setGenWorkreportmasters(WorkReportMasterVO genWorkreportmasters) {
		this.genWorkreportmasters = genWorkreportmasters;
	}
	public List<WorkProdSerialVO> getWrSerials() {
		return wrSerials;
	}
	public void setWrSerials(List<WorkProdSerialVO> wrSerials) {
		this.wrSerials = wrSerials;
	}
	public String getFileURL() {
		return fileURL;
	}
	public void setFileURL(String fileURL) {
		this.fileURL = fileURL;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	

}
