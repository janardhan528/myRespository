package com.avantel.funwork4.bo.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;

/**
 * The persistent class for the GEN_WRProdSerial database table.
 * 
 */
@Entity
@Table(name = "GEN_WRProdSerial")
public class WorkProdSerialBO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long wrprodSerialId;
	private BigDecimal wrprodCode;
	private long wrprodSerialRCMasterId;
	private long wrprodSerialNo;
	private WorkReportDetailBO wrprodSerialWRDetId;
	private String workReportNumber;

	public WorkProdSerialBO() {
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ProdSerial_Id", unique = true, nullable = false, precision = 10)
	public long getWrprodSerialId() {
		return this.wrprodSerialId;
	}

	public void setWrprodSerialId(long wrprodSerialId) {
		this.wrprodSerialId = wrprodSerialId;
	}

	@Column(name = "ProdCode", precision = 10)
	public BigDecimal getWrprodCode() {
		return this.wrprodCode;
	}

	public void setWrprodCode(BigDecimal wrprodCode) {
		this.wrprodCode = wrprodCode;
	}

	@Column(name = "ProdSerial_RCMasterId", nullable = false, precision = 10)
	public long getWrprodSerialRCMasterId() {
		return this.wrprodSerialRCMasterId;
	}

	public void setWrprodSerialRCMasterId(long wrprodSerialRCMasterId) {
		this.wrprodSerialRCMasterId = wrprodSerialRCMasterId;
	}

	@Column(name = "ProdSerial_SerialNo", nullable = false, precision = 10)
	public long getWrprodSerialNo() {
		return this.wrprodSerialNo;
	}

	public void setWrprodSerialNo(long wrprodSerialNo) {
		this.wrprodSerialNo = wrprodSerialNo;
	}

	@ManyToOne
	@JoinColumn(name = "ProdSerial_WRDetId", nullable = false)
	public WorkReportDetailBO getWrprodSerialWRDetId() {
		return this.wrprodSerialWRDetId;
	}

	public void setWrprodSerialWRDetId(WorkReportDetailBO wrprodSerialWRDetId) {
		this.wrprodSerialWRDetId = wrprodSerialWRDetId;
	}

	@Column(name = "WRNo", length = 100)
	public String getWorkReportNumber() {
		return this.workReportNumber;
	}

	public void setWorkReportNumber(String workReportNumber) {
		this.workReportNumber = workReportNumber;
	}

}