<%-- <%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!--content-->
<div class="box-header">
	<h3 class="box-title">Weekly Report</h3>
</div>
<div class="box">
	<div class="box-body">
		<form:form method="POST" action="sendMail.action"
			commandName="employeeWeeklyReportVO" id="weeklyReportMailForm"
			name="weeklyReportMailForm" data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled"
			class="form-horizontal">
			<%
				int employeeId = 0;
					if (session.getAttribute("userContextVO") != null) {
						UserContext userContext = (UserContext) session
								.getAttribute("userContextVO");
						employeeId = userContext.getUser().getUserEmployeeId();
					}
			%>
			<input type="hidden" value="<%=employeeId%>" id="empId" />
			<form:hidden path="attachmentStatus" />
			<form:hidden path="ewrEmpCode" />
			<input type="hidden" id="empFullName" />
			<div class="col-sm-6">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-primary btn-xs"
					onclick="composeClick()">Compose</button>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-primary btn-xs"
					onclick="outboxClick()">Sent</button>
			</div>
			<br />
			<br />
			<div id="composeDiv">
				<div class="row">
					<div class="form-group col-sm-10">
						<label for="from" class="control-label col-sm-2">From:</label>
						<div class="form-group col-sm-8">
							<form:hidden path="ewrFromMailId" />
							<span id="fromAddr"></span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-sm-10">
						<label for="to" class="control-label col-sm-2">To:</label>
						<div class="form-group col-sm-8">
							<div class="input-group">
								<form:input path="ewrToMailId" data-bv-notempty="true"
									readonly="true"
									data-bv-notempty-message="To Mail Address is required" value=""
									cssClass="form-control" />
								<span class="input-group-addon">
									<button type="button" onclick="openMailListForToModal();">
										<span class="glyphicon glyphicon-collapse-up"
											style="font-size: 10px;"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-sm-10">
						<label for="cc" class="control-label col-sm-2">CC:</label>
						<div class="form-group col-sm-8">
							<div class="input-group">
								<form:textarea path="ewrCCMailIds" data-bv-notempty="false"
									data-bv-notempty-message="" readonly="true"
									cssClass="form-control" rows="2" cols="8" />
								<span class="input-group-addon"><button type="button"
										onclick="openMailListForCCModal();">
										<span class="glyphicon glyphicon-collapse-up"
											style="font-size: 10px;"></span>
									</button></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-sm-10">
						<label for="subject" class="control-label col-sm-2">Subject:</label>
						<div class="form-group col-sm-8">
							<form:input path="ewrSubject" data-bv-notempty="true"
								data-bv-notempty-message="Subject is required" value=""
								cssClass="form-control" />
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-sm-10">
						<label for="to" class="control-label col-sm-2">Body:</label>
						<div class="form-group col-sm-8">
							<form:textarea path="ewrBody" data-bv-notempty="true"
								data-bv-notempty-message="Body is required"
								cssClass="form-control" rows="20" cols="80" />
						</div>
					</div>
				</div>
				<br />
				<div class="form-group col-sm-10">
					<div class="col-sm-6">
						<c:set var="mkDocRegSpecsSize" value="0" />
						<table class="display table table-bordered" id="attachmentsGrid">
							<thead>
								<tr>
									<th width="90%">File Name</th>
									<th width="5%">Action</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<input type="hidden" id="mkDocRegSpecsSize"
							value="${mkDocRegSpecsSize}" />
					</div>
				</div>
				<br />
				<div class="form-group text-center">
					<button type="submit" class="btn btn-primary"
						onclick="javascript:return updateAttachmentsStatus('attachmentStatus');">Send</button>
					<!--  disabled="true" -->
					<button type="button" class="btn btn-primary"
						onclick="invokeAction('<%=request.getContextPath()%>/secured/workReportMail/weeklyReport')">Cancel</button>
				</div>
			</div>
			<div id="outboxDiv" style="display: none">
				<div class="box-body table-responsive">
					<table class="table table-striped" id="outboxDt">
						<thead>
							<tr>
								<th style="width: 15%;">Emp Code:</th>
								<th colspan="5"><span id="empCode"></span></th>
							</tr>
							<tr>
								<th style="width: 15%;">Emp Name:</th>
								<th colspan="5"><span id="empName"></span></th>
							</tr>
							<tr>
								<!-- <th style="width: 5%;">S.No.</th> -->
								<th style="width: 15%;">Date</th>
								<th style="width: 10%;">From Mail Id</th>
								<th style="width: 20%;">To Mail Id</th>
								<th style="width: 30%;">CC Mail Ids</th>
								<th style="width: 25%;">Subject</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</form:form>
		<br />
		<div id="composeAttDiv">
			<jsp:include page="../../Marketing/Enquiry/FileAttachments.jsp"></jsp:include>
		</div>
	</div>
</div>
<iframe id="viewAttachIframe" src="#" width="100%" height="100%"
	style="display: none;"></iframe>
<div class="modal fade" id="toMailListModal" tabindex="-1" role="dialog"
	aria-labelledby="toMailListModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					id="toMailListModalCloseBtn" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="toMailListModalLabel"></h4>
			</div>
			<div class="modal-body" id="toMailListModal-body">
				<div class="box-body table-responsive">
					<table class="table table-striped" id="toEmailDt">
						<thead>
							<tr>
								<!-- <th style="width: 5%;">S.No.</th> -->
								<th style="width: 10%;">Emp Code</th>
								<th style="width: 40%;">Emp Name</th>
								<th style="width: 40%;">EmailID</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="ccMailListModal" tabindex="-1" role="dialog"
	aria-labelledby="ccMailListModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					id="ccMailListModalCloseBtn" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="ccMailListModalLabel"></h4>
			</div>
			<div class="modal-body" id="ccMailListModal-body">
				<div class="box-body table-responsive">
					<table class="table table-striped" id="ccEmailDt">
						<thead>
							<tr>
								<th style="width: 5%;"><input type="checkbox" id="checkAll"
									onchange="checkAll(this);" /></th>
								<th style="width: 10%;">Emp Code</th>
								<th style="width: 40%;">Emp Name</th>
								<th style="width: 40%;">EmailID</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<br />
				<div class="col-sm-6">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-primary"
						onclick="addCCListFromModal()">Add</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-primary"
						onclick="closeCCListModal()">Cancel</button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<spring:message code='FUNWORK.FunworkStaticIP'
	var="staticURL_mainTemplate" />

<%
	if (session.getAttribute("userContextVO") != null) {
%>
<c:set var="staticURL_mainTemplate"
	value="<%=((UserContext) session.getAttribute(\"userContextVO\"))
						.getStaticURL()%>" />
<%
	}
%>
<link
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/page.css"
	rel="stylesheet" />
<link
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/table.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>

<link
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/treeview/jquery.treeview.css"
	rel="stylesheet" />

<script type="text/javascript" charset="utf-8">
	var pageContext = '${pageContext.request.contextPath}';
	var docName = "SpecDocuments";
	var docNum = "";

	function deleteFile(fileName, delBtn) {
		COMMON.deleteAttachment(pageContext, fileName, docNum, docName, delBtn);
	}
	function viewAttachment(fileName) {
		COMMON.viewAttachment(pageContext, docName, docNum, fileName);
	}
	function uploadFile() {
		COMMON.fileAttachmentUpload(docName, docNum);
	}

	$(document).ready(function() {
		getEmployeeList();
		bindToMailsTable();
		bindCCMailsTable();
		bindOutBoxTable();

		$('#weeklyReportMailForm').bootstrapValidator({
			live : 'enabled',
			excluded : ':disabled',
			message : 'This value is not valid',
			fields : {},
		});
	});

	function getEmployeeList() {
		jBlockUI();
		$
				.ajax({
					url : pageContext
							+ "/secured/employee/getEmployeesForWeeklyReport.action?departments=0",
					type : 'get',
					dataType : 'json',
					contentType : 'application/json',
					mimeType : 'application/json',
					success : function(empData) {
						//console.log("empData",empData);
						var empId = $("#empId").val();
						if (empData != null && empData.length > 0) {

							var dataTbl = $('#toEmailDt').dataTable();
							dataTbl.fnClearTable();
							dataTbl.fnAddData(empData);

							var ccDataTbl = $('#ccEmailDt').dataTable();
							ccDataTbl.fnClearTable();
							ccDataTbl.fnAddData(empData);

							for (var i = 0; i < empData.length; i++) {
								var empMaster = empData[i];
								var empMasterId = empMaster.employeeId;
								var employeeMailId = empMaster.employeeMailId;
								var employeeCode = empMaster.employeeCode;
								var employeeName = empMaster.employeeFullName;
								//empId=501;
								if (empId == empMasterId) {
									$("#ewrFromMailId").val(employeeMailId);
									$("#fromAddr").text(employeeMailId);
									$("#ewrEmpCode").val(employeeCode);
									$("#empFullName").val(employeeName);
									break;
								}
							}
						}
						unBlockUI();
					},
					error : function(data, status, er) {
						console.log("json error: " + data + " status: "
								+ status + " er:" + er);
						unBlockUI();
					}
				});

	}

	function openMailListForToModal() {
		COMMON.ShowModalpopup('#toMailListModal');
	}

	function openMailListForCCModal() {
		$("#ccEmailDt").find('.chidCheckbox').each(function() {
			this.checked = false;
		});
		COMMON.ShowModalpopup('#ccMailListModal');
	}
	function bindToMailsTable() {
		$('#toEmailDt')
				.dataTable(
						{
							"bLengthChange" : true,
							"bInfo" : true,
							"order" : [ [ 1, 'desc' ] ],
							"iDisplayLength" : 5,
							"aoColumns" : [
									{
										"mDataProp" : "employeeId",
										"mRender" : function(employeeCode,
												type, data) {
											if (data.employeeId != 'undefined'
													&& data.employeeCode != 'undefined') {
												var uniqueId = "emp"
														+ data.employeeId;
												return "<input type=\"hidden\" id=\'"+uniqueId+"\' value=\'"+data.employeeMailId+"\'/><a style=\"cursor: pointer;\" onclick=\"getMailAddr(\'"
														+ data.employeeId
														+ "\');\">"
														+ data.employeeCode
														+ "</a>";
											}
										}

									},
									{
										"mDataProp" : "employeeFullName",
										"mRender" : function(employeeFullName,
												type, data) {
											return employeeFullName;
										}

									},
									{
										"mDataProp" : "employeeMailId",
										"mRender" : function(employeeMailId,
												type, data) {
											return employeeMailId;
										}
									} ]
						});
	}
	function bindCCMailsTable() {
		$('#ccEmailDt')
				.dataTable(
						{
							"bLengthChange" : true,
							"bInfo" : true,
							"paging" : false,
							"bFilter" : false,
							"scrollY" : 200,
							"order" : [ [ 1, 'asc' ] ],
							"iDisplayLength" : 5,
							"aoColumns" : [
									{
										"mDataProp" : "checkbox",
										"mRender" : function(employeeId, type,
												data) {
											if (data.employeeId != 'undefined'
													&& data.employeeCode != 'undefined') {
												var uniqueId = "check"
														+ data.employeeId;
												var hiddenId = "hidden"
														+ data.employeeId;
												var mailId = data.employeeMailId;
												return "<input type=\"hidden\" id=\'"+hiddenId+"\' value=\'"+mailId+"\'/><input class=\"chidCheckbox\" type=\"checkbox\" id=\'"+uniqueId+"\' value=\'"+data.employeeId+"\'/>";
											}
										}

									},
									{
										"mDataProp" : "employeeId",
										"mRender" : function(employeeId, type,
												data) {
											if (data.employeeId != 'undefined'
													&& data.employeeCode != 'undefined')
												return data.employeeCode;
										}

									},
									{
										"mDataProp" : "employeeFullName",
										"mRender" : function(employeeFullName,
												type, data) {
											return employeeFullName;
										}

									},
									{
										"mDataProp" : "employeeMailId",
										"mRender" : function(employeeMailId,
												type, data) {
											return employeeMailId;
										}
									} ]
						});
	}
	function getMailAddr(empId) {
		var uniqueId = "#emp" + empId;
		var mailId = $(uniqueId).val();
		$("#ewrToMailId").val(mailId);

		var fromValidation = $('#weeklyReportMailForm').data(
				'bootstrapValidator');
		fromValidation.updateStatus("ewrToMailId", 'NOT_VALIDATED', null)
				.validateField("ewrToMailId");

		$('#toMailListModal').modal('hide');
	}
	function checkAll(selected) {
		if ($(selected).is(':checked')) {
			$("#ccEmailDt").find('.chidCheckbox').each(function() {
				this.checked = true;
			});
		} else {
			$("#ccEmailDt").find('.chidCheckbox').each(function() {
				this.checked = false;
			});
		}
	};
	function closeCCListModal() {
		$('#ccMailListModal').modal('hide');
	}
	function addCCListFromModal() {
		//$("#ccEmailDt_filter").find("input[type=search]").val("");
		//$("#ccEmailDt_filter").trigger("change");
		var mailIdsStr = "";
		$("#ccEmailDt").find(".chidCheckbox").each(function(i, obj) {
			if ($(this).is(':checked')) {
				var empId = $(this).val();
				var hiddenId = "#hidden" + empId;
				var mailId = $(hiddenId).val();
				mailIdsStr += "," + mailId;
			}
		});
		mailIdsStr = mailIdsStr.substring(1, mailIdsStr.length);
		$("#ewrCCMailIds").val(mailIdsStr);
		closeCCListModal();
	}
	function updateAttachmentsStatus(attachmentStatus) {
		COMMON.checkAttachments(attachmentStatus);
		return true;
	}
	function composeClick() {
		$("#outboxDiv").hide();
		$("#composeDiv").show();
		$("#composeAttDiv").show();
	}
	function outboxClick() {
		jBlockUI();
		$
				.ajax({
					url : pageContext
							+ "/secured/workReportMail/weeklyReportListByEmpCode.action?empCode="
							+ $("#ewrEmpCode").val(),
					type : 'get',
					dataType : 'json',
					contentType : 'application/json',
					mimeType : 'application/json',
					success : function(mailsData) {

						if (mailsData != null && mailsData.length > 0) {
							var dataTbl = $('#outboxDt').dataTable();
							dataTbl.fnClearTable();
							dataTbl.fnAddData(mailsData);
						}
						var employeeName = $("#empFullName").val();
						var empCode = $("#ewrEmpCode").val();

						$("#empCode").text(empCode);
						$("#empName").text(employeeName);

						$("#composeDiv").hide();
						$("#composeAttDiv").hide();
						$("#outboxDiv").show();
						unBlockUI();
					},
					error : function(data, status, er) {
						console.log("json error: " + data + " status: "
								+ status + " er:" + er);
						unBlockUI();
					}

				});
	}
	function bindOutBoxTable() {
		$('#outboxDt')
				.dataTable(
						{
							"bLengthChange" : true,
							"bInfo" : true,
							"order" : [ [ 1, 'desc' ] ],
							"iDisplayLength" : 10,
							"aoColumns" : [
									{
										"mDataProp" : "ewrDate",
										"mRender" : function(ewrDate, type,
												data) {
											var enQDateVal = '<span style="display:none;">'
													+ convertJSONDatetoFormatNew(data.ewrDate)
													+ '</span>'
													+ convertJSONDatetoFormat(data.ewrDate);
											return enQDateVal;
										}

									},
									{
										"mDataProp" : "ewrFromMailId",
										"mRender" : function(ewrFromMailId,
												type, data) {
											return ewrFromMailId;
										}
									},
									{
										"mDataProp" : "ewrToMailId",
										"mRender" : function(ewrToMailId, type,
												data) {
											return ewrToMailId;
										}

									},
									{
										"mDataProp" : "ewrCCMailIds",
										"mRender" : function(ewrCCMailIds,
												type, data) {
											return ewrCCMailIds;
										}

									},
									{
										"mDataProp" : "ewrSubject",
										"mRender" : function(ewrSubject, type,
												data) {
											return ewrSubject;
										}

									} ]
						});
	}
</script> --%>