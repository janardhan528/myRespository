<%-- <%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<div class="box">
	<div class="box-header">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="box-title">Permission Slip </h3>

			</div>
		</div>
	</div>

	<div class="box-body">
		<form:form method="POST" action="save.action"
			commandName="permissionSlipVO" id="permissionForm"
			name="permissionForm" data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled" cssClass="form-horizontal">

			<form:hidden path="permissionSlipId" />
			<br/>
			<div class="row">
			<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-4">
					<label for="inputName" class="control-label col-sm-4">Employee:</label>
					
					<form:hidden path="permissionSlipEmpCodes.employeeId" />
					<div class="form-group col-sm-7"><form:input path="permissionSlipEmpCodes.employeeCode" value=""
						cssClass="form-control" placeholder="" data-bv-notempty="true"
						data-bv-notempty-message=""  readonly="true"/>
				</div>
				</div>
				<div class="form-group col-sm-4">
					<label for="inputName" class="control-label col-sm-4"></label>
				
					<form:input path="permissionSlipEmpCodes.employeeFullName"
						cssClass="form-control" placeholder="" data-bv-notempty="true"
						data-bv-notempty-message=""  readonly="true"/>
				
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-9">
					<label for="inputName" class="control-label col-sm-3">Purpose: </label>
					
					<div class="form-group col-sm-9"><form:textarea path="permissionSlipPurpose" value=""
						cssClass="form-control" placeholder="" data-bv-notempty="true"
						data-bv-notempty-message="Enter Purpose" />
				</div>
			</div>
			</div>
			<div class="row">

				<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-4">
					<label for="WorkReportDate " class="control-label col-sm-4">Date:</label>
					
					<div class="form-group col-sm-8"><div class="input-group date" id="datetimepicker1" data-date-format="DD-MMM-YYYY HH:mm">
						<form:input path="permissionSlipFromTime" value=""
							cssClass="form-control" placeholder="DD-MMM-YYYY HH:mm" 
							data-bv-notempty="true"
							data-bv-notempty-message="Select Date"  readonly="true"/>
						<span class="input-group-addon"><span
							class="glyphicon-calendar glyphicon"></span> </span> 
					</div>
					
				</div>
				</div>
				
				 <div class="form-group col-sm-2">
			
				<div class="form-group col-sm-10">	<div class="input-group date" id="datetimepicker2" data-date-format=" HH:mm">
					<form:input path="time" value="" cssClass="form-control"
						 data-bv-notempty="true" placeholder="HH:mm" readonly="true"
						data-bv-notempty-message="" />
						<span class="input-group-addon"><span
							class="glyphicon-calendar glyphicon"></span> </span> 
						</div>
						</div>
				</div> 
				
				<div class="form-group col-sm-3">
					
					<label for="inputName" class="control-label col-sm-8">Approx.Duration: </label>
							
					<spring:message code='mtrl.frn.frnNO-error' var="frn_frnNO" />
					<div class="form-group col-sm-5"><form:input path="approxTime" value="" cssClass="form-control"
						placeholder="" data-bv-notempty="true"
						data-bv-notempty-message="" />
						</div>
				
				
				</div>
				</div>
				
			
			
				<div class="form-group col-sm-3">
				
					<label for="inputName" class="control-label col-sm-5">Time : </label>
					
					<div class="form-group col-sm-4">
					 <fmt:formatDate value="${permissionSlipVO.permissionSlipFromTime}"
											pattern="HH:mm" var="newdatevar1" /> 
											
					<form:input path="time" value="${newdatevar1}" cssClass="form-control"
						placeholder="" data-bv-notempty="true"
						data-bv-notempty-message="" />
				</div>
			</div>
			
			
			
			
			<div class="row">
				<div class="form-group col-sm-2"></div>
				<div class="form-group col-sm-9">
					<label for="docType" class="control-label col-sm-3">Authorised By:</label>
					
					<div class="form-group col-sm-9"><form:select path="permissionSlipReqApprovalFor"
						class="form-control selectized" placeholder="select"
						cssClass="form-control" data-bv-notempty="true"
						data-bv-notempty-message="Select Approved By">


					</form:select>
					<input type="hidden" id="authorisedId"
						value="${permissionSlipVO.permissionSlipReqApprovalFor}" />
				</div>
			</div>
			</div>
			

			<div class="form-group text-center">
				<br /> <br />
				<button type="submit" class="btn btn-primary" value="save">Save</button>
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/permissionSlip/list.action')">Cancel</button>

			</div>
		</form:form>
	</div>
</div>
<spring:message code='FUNWORK.FunworkStaticIP' var="staticSiteURL_mainTemplates"/>

<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticSiteURL_mainTemplates" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>

<script type="text/javascript"
	src="<c:url value='/resources/js/HR/funwork-permissionSlip.js'/>"></script>
<script type="text/javascript" src="http://<c:out value="${staticSiteURL_mainTemplates}" />/resources/funwork-template/datatable/jquery.dataTables.js"></script>

<script>
	var pageContext = '${pageContext.request.contextPath}';

	$(document).ready(
			function() {
				
				
				if($("#permissionSlipId").val()==0){
					var momentTime = new moment(new Date());
					$('#permissionSlipFromTime').val(momentTime.format("DD-MMM-YYYY "));
				}

				COMMON.loadDropDowns(pageContext
						+ "/secured/permissionSlip/getEmployeeList",
						'#permissionSlipReqApprovalFor', 'employeeId',
						'employeeFullName', '#authorisedId');
				//PERMISSION.initializeAndValidateDatepicker();
				PermissionSlip.callBootstrapValidator();
				$('#datetimepicker1').datetimepicker({
					format: 'DD-MMM-YYYY HH:mm',
					pickTime : true,
					dateFormat : 'DD-MMM-YYYY HH:mm'
				});
				
				$('#datetimepicker2').datetimepicker({
					pickTime : false,
					 format: 'HH:mm'
						
				});

			});
</script>
<script>
	var pageContext = '${pageContext.request.contextPath}';
	function getApproval(status) {
		
		var permissionSlipId = $("#permissionSlipId").val();

		
		var approvalURL;
		if (status == 1) {

			approvalURL = pageContext
					+ "/secured/permissionSlip/getApproval?permissionSlipId=" +permissionSlipId;
		} else {
			approvalURL = pageContext + "/secured/permissionSlip/list";
		}
		invokeAction(approvalURL);
	}
</script>
 --%>