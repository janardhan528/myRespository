package com.avantel.funwork4.bo.common;

import java.io.Serializable;

import javax.persistence.*;

import com.avantel.funwork4.bo.marketing.product.ProductMasterBO;

import java.math.BigDecimal;
import java.util.List;

/**
 * The persistent class for the gen_workreportdetail database table.
 * 
 */
@Entity
@Table(name = "GEN_WorkReportDetail")
public class WorkReportDetailBO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long wrDetailId;
	private String wrDetailFileName;
	private String wrDetailFIRNo;
	private ProductMasterBO wrDetailProd;
	private BigDecimal wrDetailQtyAccEar;
	private BigDecimal wrDetailQtyAccNow;
	private BigDecimal wrDetailQtyBalance;
	private BigDecimal wrDetailQtyOffered;
	private BigDecimal wrDetailQtyOrdered;
	private String wrDetailRemarks;
	private String wrDetailSerialNo;
	private WorkReportMasterBO genWorkreportmaster;
	
	private List<WorkProdSerialBO> wrSerialNumbers;
	public WorkReportDetailBO() {
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "WRDet_Id", unique = true, nullable = false, precision = 10)
	public long getWrDetailId() {
		return this.wrDetailId;
	}

	public void setWrDetailId(long wrDetailId) {
		this.wrDetailId = wrDetailId;
	}

	@Column(name = "WRDet_FileName", length = 255)
	public String getWrDetailFileName() {
		return this.wrDetailFileName;
	}

	public void setWrDetailFileName(String wrDetailFileName) {
		this.wrDetailFileName = wrDetailFileName;
	}

	@Column(name = "WRDet_FIRNo", length = 20)
	public String getWrDetailFIRNo() {
		return this.wrDetailFIRNo;
	}

	public void setWrDetailFIRNo(String wrDetailFIRNo) {
		this.wrDetailFIRNo = wrDetailFIRNo;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "WRDet_ProdId", nullable = false)
	public ProductMasterBO getWrDetailProd() {
		return this.wrDetailProd;
	}

	public void setWrDetailProd(ProductMasterBO wrDetailProd) {
		this.wrDetailProd = wrDetailProd;
	}

	@Column(name = "WRDet_QtyAccEar", nullable = false, precision = 10, scale = 3)
	public BigDecimal getWrDetailQtyAccEar() {
		return this.wrDetailQtyAccEar;
	}

	public void setWrDetailQtyAccEar(BigDecimal wrDetailQtyAccEar) {
		this.wrDetailQtyAccEar = wrDetailQtyAccEar;
	}

	@Column(name = "WRDet_QtyAccNow", nullable = false, precision = 10, scale = 3)
	public BigDecimal getWrDetailQtyAccNow() {
		return this.wrDetailQtyAccNow;
	}

	public void setWrDetailQtyAccNow(BigDecimal wrDetailQtyAccNow) {
		this.wrDetailQtyAccNow = wrDetailQtyAccNow;
	}

	@Column(name = "WRDet_QtyBalance", nullable = false, precision = 10, scale = 3)
	public BigDecimal getWrDetailQtyBalance() {
		return this.wrDetailQtyBalance;
	}

	public void setWrDetailQtyBalance(BigDecimal wrDetailQtyBalance) {
		this.wrDetailQtyBalance = wrDetailQtyBalance;
	}

	@Column(name = "WRDet_QtyOffered", nullable = false, precision = 10, scale = 3)
	public BigDecimal getWrDetailQtyOffered() {
		return this.wrDetailQtyOffered;
	}

	public void setWrDetailQtyOffered(BigDecimal wrDetailQtyOffered) {
		this.wrDetailQtyOffered = wrDetailQtyOffered;
	}

	@Column(name = "WRDet_QtyOrdered", nullable = false, precision = 10, scale = 3)
	public BigDecimal getWrDetailQtyOrdered() {
		return this.wrDetailQtyOrdered;
	}

	public void setWrDetailQtyOrdered(BigDecimal wrDetailQtyOrdered) {
		this.wrDetailQtyOrdered = wrDetailQtyOrdered;
	}

	@Column(name = "WRDet_Remarks", length = 255)
	public String getWrDetailRemarks() {
		return this.wrDetailRemarks;
	}

	public void setWrDetailRemarks(String wrDetailRemarks) {
		this.wrDetailRemarks = wrDetailRemarks;
	}

	@Column(name = "WRDet_SerialNo", length = 500)
	public String getWrDetailSerialNo() {
		return this.wrDetailSerialNo;
	}

	public void setWrDetailSerialNo(String wrDetailSerialNo) {
		this.wrDetailSerialNo = wrDetailSerialNo;
	}

	// bi-directional many-to-one association to Workreportmaster
	@ManyToOne
	@JoinColumn(name = "WRDet_MasterId", nullable = false)
	public WorkReportMasterBO getGenWorkreportmaster() {
		return this.genWorkreportmaster;
	}

	public void setGenWorkreportmaster(WorkReportMasterBO genWorkreportmaster) {
		this.genWorkreportmaster = genWorkreportmaster;
	}

	@OneToMany(mappedBy="wrprodSerialWRDetId")
	public List<WorkProdSerialBO> getWrSerialNumbers() {
		return wrSerialNumbers;
	}

	public void setWrSerialNumbers(List<WorkProdSerialBO> wrSerialNumbers) {
		this.wrSerialNumbers = wrSerialNumbers;
	}

	
}