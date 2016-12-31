<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<div class="box-header">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="box-title">Leave Application</h3>

			</div>
		</div>
	</div>
<div class="box">
	<div class="box-body">
		<form:form method="POST" action="leaveAppSave.action"
			commandName="leaveAppVO" id="addleaveForm" name="addleaveForm"
			data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled"
			cssClass="form-horizontal">

			<form:hidden path="leaveAppId" />
			<form:hidden path="leaveAppEmp.hrDepartment.departmentId" />
			<form:hidden path="leaveAppEmp.designation.designationId" />
			<form:hidden path="leaveAppDept.departmentId" />
			<form:hidden path="leaveAppDesg.designationId" />

			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-4">
					<label for="employee" class="control-label col-sm-5">Employee:</label>

					<form:hidden path="leaveAppEmp.employeeId" />
					<form:hidden path="leaveAppEmp.employeeLeaveReccRequired" />
					<form:hidden path="leaveAppEmp.employeeeaveApprovalPermission" />
					<div class="form-group col-sm-6">
						<form:input path="leaveAppEmp.employeeCode" value=""
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" readonly="true"/>
					</div>
				</div>
				<div class="form-group col-sm-4">
					<form:input path="leaveAppEmp.employeeFullName" value=""
						cssClass="form-control" placeholder="" data-bv-notempty="true"
						data-bv-notempty-message="" readonly="true"/>
				</div>

			</div>

			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-2">
					<label for="leaves" class="control-label col-sm-11">Available
						Leaves:</label>
				</div>
				<div class="form-group col-sm-2">
					<label for="cl" class="control-label col-sm-4">CL:</label>
					<div class="form-group col-sm-6">
						<form:input path="" id="cl" value="" cssClass="form-control"
							placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" readonly="true"/>
					</div>
				</div>
				<div class="form-group col-sm-2">
					<label for="el" class="control-label col-sm-3">EL:</label>
					<div class="form-group col-sm-6">
						<form:input path="" id="el" value="" cssClass="form-control"
							placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" readonly="true"/>
					</div>
				</div>
				<div class="form-group col-sm-3">					
					<label for="noofdays" class="control-label col-sm-7">No.of
						Days:</label>
						
					<div class="form-group col-sm-5">
						<form:input path="leaveAppNoofDays" value=""
							onchange="LeaveApplication.getToDate()" cssClass="form-control"
							placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" />
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-4">
					<label for="fromdate" class="control-label col-sm-5">From
						Date:</label>
					<div class="form-group col-sm-7">
						<div class="input-group date" id="datetimepicker1"
							data-date-format="DD-MMM-YYYY">
							<form:input path="leaveAppFromDate" cssClass="form-control" readonly="true"
								placeholder="DD-MMM-YYYY" data-bv-notempty="true"
								data-bv-notempty-message="" />

							<span class="input-group-addon"><span
								class="glyphicon-calendar glyphicon"></span> </span>
						</div>
					</div>
				</div>				
				<div class="form-group col-sm-3">
					<label for="purpose" class="control-label col-sm-6">hrs:</label>
					<div class="form-group col-sm-6">
						<form:select path="leaveAppFromSession"
							onchange="LeaveApplication.getToDate()" value=""
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="">
							<form:option value="9">9</form:option>
							<form:option value="14">14</form:option>
						</form:select>
					</div>
				</div>
				<div class="form-group col-sm-2">
					<label for="purpose" class="control-label col-sm-3">hrs:</label>
					<div class="form-group col-sm-6">
						<form:input path="leaveAppToSession" value="" rows="2" cols="8"
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" readonly="true"/>
					</div>


				</div>


			</div>
			<div class="row">

				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-4">
					<label for="todate" class="control-label col-sm-5">To Date:</label>
					<div class="form-group col-sm-8">
						<div class="input-group date" id="datetimepicker2"
							data-date-format="DD-MMM-YYYY">

							<form:input path="leaveAppToDate" cssClass="form-control"
								placeholder="DD-MMM-YYYY" data-bv-notempty="true"
								data-bv-notempty-message="" readonly="true"/>
							<span class="input-group-addon"><span
								class="glyphicon-calendar glyphicon"></span> </span>
						</div>
					</div>
				</div>
				<div class="form-group col-sm-5">
				<div class="form-group col-sm-1"></div>
					<label for="backonduty" class="control-label col-sm-5">Back
						on Duty:</label>
					<div class="form-group col-sm-5">
						<div class="input-group date" id="datetimepicker3"
							data-date-format="DD-MMM-YYYY">


							<form:input path="leaveAppBackonDuty" cssClass="form-control"
								placeholder="DD-MMM-YYYY" data-bv-notempty="true"
								data-bv-notempty-message="" readonly="true"/>
							<span class="input-group-addon"><span
								class="glyphicon-calendar glyphicon"></span> </span>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-8">
					<label for="purpose" class="control-label col-sm-2">Purpose:</label>
					<div class="form-group col-sm-10">
						<form:textarea path="leaveAppPurpose" value="" rows="2" cols="8"
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-8">
					<label for="addressonleave" class="control-label col-sm-2">Address
						on Leave:</label>
					<div class="form-group col-sm-10">
						<form:textarea path="leaveAppAddress" value="" rows="2" cols="8"
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-8">
					<label for="docType" class="control-label col-sm-2"><spring:message
							code="" />Recommendation By: </label>
					<spring:message code="hr.leave.empty" var="hr_LeaveDesc" />
					<div class="form-group col-sm-10">
						<form:select path="recommendedBy" class="form-control selectized"
							placeholder="select" cssClass="form-control" data-bv-notempty="true"
							data-bv-notempty-message="${hr_LeaveDesc}">
<

					</form:select>
					</div>
					<input type="hidden" id="recommendedId"
						value="${leaveAppVO.recommendedBy}" />
				</div>
			</div>

			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-8">
					<label for="docType" class="control-label col-sm-2"><spring:message
							code="" />Approval By: </label>
					<spring:message code="hr.leave.empty" var="hr_LeaveDesc" />
					<div class="form-group col-sm-10">
						<form:select path="approvedBy" class="form-control selectized"
							placeholder="select" cssClass="form-control"
							data-bv-notempty="true" data-bv-notempty-message="${hr_LeaveDesc}">


						</form:select>
					</div>
					<input type="hidden" id="approvalId" value="${leaveAppVO.approvedBy}" />
				</div>
			</div>

			<div class="form-group text-center">
				<br /> <br />
				<button type="submit" class="btn btn-primary" value="update">Add</button>
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/leaveapp/leaveAppList.action')">Cancel</button>

			</div>
		</form:form>


	</div>
</div>
<spring:message code='FUNWORK.FunworkStaticIP' var="staticURL_mainTemplate"/>

<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticURL_mainTemplate" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>

<script type="text/javascript"
	src="<c:url value='/resources/js/HR/funwork-leaveapplication.js'/>"></script>
<script type="text/javascript" src="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>
<script>
	var pageContext = '${pageContext.request.contextPath}';

	$(document)
			.ready(
					function() {
						LeaveApplication.getLastPaySlipDate();
						/* $('#recommendedBy').selectize();
						$('#approvedBy').selectize(); */
						LeaveApplication.initializeAndValidateDatepicker();
						LeaveApplication.callBootstrapValidator();
						LeaveApplication.getEls(pageContext);
						LeaveApplication.getCls(pageContext);

						if ($('#leaveAppId').val() == 0) {
							LeaveApplication.getToDate();
						}

						if ($('#leaveAppEmp\\.employeeLeaveReccRequired').val() == "true") {
							$('#recommendedBy').attr('data-bv-notempty','true');
							COMMON
									.loadDropDowns(
											pageContext+ "/secured/leaveapp/getRecommendedEmployeeList",'#recommendedBy', 'employeeId',
											'employeeFullName', '#recommendedId');
						} else {
							$('#recommendedBy').attr('data-bv-notempty','false');
							// disable control
							$('#recommendedBy').prop('disabled', true);
							//$('.dropdown-toggle').prop('disabled', true);
						}

						/* if ($('#leaveAppEmp\\.employeeeaveApprovalPermission')
								.val() == "true") { */

							COMMON.loadDropDowns(pageContext+ "/secured/leaveapp/getApprovalEmployeeList",'#approvedBy', 'employeeId',
											'employeeFullName', '#approvalId');
						//}

						$('#leaveAppFromSession').selectize();

					});
</script>
<script>
	var pageContext = '${pageContext.request.contextPath}';
	function getApproval(status) {
		var recommendedBy = 1;
		var leaveappId = $("#leaveAppId").val();

		if ($("#leaveAppEmp\\.employeeLeaveReccRequired").val() =='false') {
			recommendedBy = 0;
		}
		var approvalURL;
		if (status == 1) {

			approvalURL = pageContext
					+ "/secured/leaveapp/getApproval?leaveappId=" + leaveappId
					+ "&recommendedBy=" + recommendedBy;
		} else {
			approvalURL = pageContext + "/secured/leaveapp/leaveAppList";
		}
		invokeAction(approvalURL);
	}
</script>
 --%>