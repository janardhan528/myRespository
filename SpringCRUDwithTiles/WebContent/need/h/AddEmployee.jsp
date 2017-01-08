<%-- <%@page import="com.avantel.funwork4.vo.hr.employee.EmployeeMasterVO"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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


<link rel="stylesheet"
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/blueimp/x/css/blueimp-gallery.min.css">
<link rel="stylesheet"
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/blueimp/9.5.4/css/jquery.fileupload.css">
<link rel="stylesheet"
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/blueimp/9.5.4/css/jquery.fileupload-ui.css">
<!-- CSS adjustments for browsers with JavaScript disabled -->
<noscript>
	<link rel="stylesheet"
		href="http://<c:out value="${staticURL_mainTemplate}" />/resources/blueimp/9.5.4/css/jquery.fileupload-noscript.css">
</noscript>
<noscript>
	<link rel="stylesheet"
		href="http://<c:out value="${staticURL_mainTemplate}" />/resources/blueimp/9.5.4/css/jquery.fileupload-ui-noscript.css">
</noscript>
<div class="box-header">
	<div class="row">
		<div class="col-sm-6">
			<h3 class="box-title">Add Employee</h3>
		</div>

	</div>
</div>
<div class="box">

	<div class="box-body">
		<form:form method="POST" action="save.action" id="addEmployeeForm"
			commandName="employeeMaster" name="addEmployeeForm"
			data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled"
			class="form-horizontal">

			<form:hidden path="employeeId" />
			<form:hidden path="employeeCode" />
			<form:hidden path="employeePhotoURL" />
			<form:hidden path="employeeSignatureURL" />
			<form:hidden path="employeePFAccountNo" />
			<form:hidden path="employeeCreditELYearly" />

			<form:hidden path="hrEmployeePackageId.packageGross" />
			<form:hidden path="employeeApprenticeRegNo" />
			<form:hidden path="employeeConsultancyId.outsourcingId" />
			<form:hidden path="employeeCTCValue" />
			<form:hidden path="employeeDateofReliving" />
			<form:hidden path="employeeDORRemarks" />
			<form:hidden path="employeePermissionSlipApproval" />
			<form:hidden path="employeePFSSNo" />
			<form:hidden path="employeePrevEmpId" />
			<form:hidden path="employeeRegularised" />
			<form:hidden path="employeeStatus" />
			<form:hidden path="employeeWeeklyReportReq" />

			<spring:message code="empDetailsName" var="empDetsName" />
			<form:hidden path="empDetailsName" value="${empDetsName}" />

			<spring:message code="empEducationalName" var="empEdName" />
			<form:hidden path="empEducationalName" value="${empEdName}" />

			<spring:message code="empProfessionalName" var="empProfName" />
			<form:hidden path="empProfessionalName" value="${empProfName}" />

			<div class="row">
				<div class="form-group col-sm-6">
					<label for="qtnDate" class="control-label col-sm-4">Employee
						Type:</label>
					<form:hidden path="employeeType" />
					<spring:message code='mktg.coMast.clsStatus-enter' var="clsStatus" />
					<div class="col-sm-8">
						<form:select path="empType" class="form-control selectized"
							placeholder="Select Employee Type" data-bv-notempty="true"
							data-bv-notempty-message="Select Employee Type">
							<form:option value="0">Select Employee Type</form:option>
							<form:option value="1">Regular</form:option>
							<form:option value="2">Apprentice</form:option>
							<form:option value="3">Trainee</form:option>
							<form:option value="4">Consultant</form:option>
							<form:option value="5">Executive Directors</form:option>
							<form:option value="6">Non-Executive Directors</form:option>
						</form:select>
					</div>
				</div>
			</div>
			<br />
			<div class="tabbable">
				<!-- Only required for left/right tabs -->
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab1" data-toggle="tab">Personal
							Information</a></li>
					<li><a href="#tab2" data-toggle="tab">Address</a></li>
					<li><a href="#tab3" data-toggle="tab">Experience Details</a></li>
					<li><a href="#tab4" data-toggle="tab">Policy Details </a></li>

				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
						<br />
						<div class="row">
							<div class="col-sm-6">

								<div class="row" id="empcode" style="display: none;">
									<div class="form-group">
										<label for="employeeCode" class="control-label col-sm-4">
											Employee Code:</label>

										<div class="col-sm-6">
											<form:label path="employeeCode" class="control-label">${employeeMaster.employeeCode}</form:label>

										</div>
									</div>
								</div>


								<div class="row">
									<div class="form-group">
										<label for="fn" class="control-label col-sm-4">First
											Name:</label>
										<div class="col-sm-6">
											<form:input path="employeeName" data-bv-notempty="true"
												placeholder="First Name" cssClass="form-control"
												data-bv-notempty-message="First Name is required" />
										</div>
									</div>

								</div>

								<div class="row">
									<div class="form-group">
										<label for="ln" class="control-label col-sm-4">Last
											Name:</label>
										<div class="col-sm-6">
											<form:input path="employeeLastName" cssClass="form-control"
												placeholder="Last Name"
												data-bv-notempty-message="Last Name is required"
												data-bv-notempty="false" />
										</div>
									</div>
								</div>

								<div class="row">
									<div class="form-group">
										<label for="nn" class="control-label col-sm-4">Nick
											Name:</label>
										<div class="col-sm-6">
											<form:input path="employeeEmpNickName"
												cssClass="form-control" placeholder="Nick Name"
												data-bv-notempty-message="Nick Name is required"
												data-bv-notempty="false" />
										</div>
									</div>
								</div>

								<div class="row">
									<div class="form-group">
										<label for="fatherName" class="control-label col-sm-4">Father
											Name:</label>
										<div class="col-sm-6">
											<form:input path="employeeFatherName" cssClass="form-control"
												data-bv-notempty="true" placeholder="Father Name"
												data-bv-notempty-message="Father Name is required" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label for="qual" class="control-label col-sm-4">Qualification:</label>
										<div class="col-sm-6">
											<form:input path="employeeQualification"
												cssClass="form-control" data-bv-notempty="true"
												placeholder="Qualification"
												data-bv-notempty-message="Qualification is required" />
										</div>
									</div>
								</div>

								<div class="row">

									<div class="form-group">
										<label for="dob" class="control-label col-sm-4">Date
											of Birth:</label>
										<div class="col-sm-6">
											<div class="input-group date" id="datetimepicker1"
												data-date-format="DD-MMM-YYYY">
												<form:input path="employeeDateofBirth" value=""
													cssClass="form-control" placeholder="DD-MMM-YYYY"
													data-bv-notempty="true" readonly="true"
													data-bv-notempty-message="Date Of Birth is required" />
												<span class="input-group-addon"><span
													class="glyphicon-calendar glyphicon"></span> </span>
											</div>
										</div>
									</div>

								</div>

								<div class="row">
									<div class="form-group">
										<label for="odob" class="control-label col-sm-4">Original
											DOB:</label>
										<div class="col-sm-6">
											<div class="input-group date" id="datetimepicker2"
												data-date-format="DD-MMM-YYYY">
												<form:input path="employeeOriginalDOB" value=""
													cssClass="form-control" placeholder="DD-MMM-YYYY"
													data-bv-notempty="true" readonly="true"
													data-bv-notempty-message="Original DOB is required" />
												<span class="input-group-addon"><span
													class="glyphicon-calendar glyphicon"></span> </span>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label for="doj" class="control-label col-sm-4">Date
											of joining:</label>
										<div class="col-sm-6">
											<div class="input-group date" id="datetimepicker3"
												data-date-format="DD-MMM-YYYY">
												<form:input path="employeeDateofJoining" value=""
													cssClass="form-control" placeholder="DD-MMM-YYYY"
													data-bv-notempty="true" readonly="true"
													data-bv-notempty-message="Date Of Joining is required" />
												<span class="input-group-addon"><span
													class="glyphicon-calendar glyphicon"></span> </span>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label for="pp" class="control-label col-sm-4">Probationary
											Period:</label>
										<div class="col-sm-4">
											<form:input path="employeeProbationPeriod"
												placeholder="Probationary period"
												cssClass="form-control numericOnly" data-bv-notempty="true"
												data-bv-notempty-message="Probationary Period is required" />
										</div>
										<div class="col-sm-2">
											<label class="control-label">Months</label>
										</div>
									</div>
								</div>

							</div>
							<div class="col-sm-6">
								<div class="row">
									<div class="form-group">
										<div class="col-md-4"></div>
										<div class="col-md-3">
											<a href="#" class="thumbnail"> <%
 	String encodedString = null;
 		long empId = 0;
 		//EmployeeMasterVO employeeMasterVO = (EmployeeMasterVO) request
 				.getAttribute("employeeMaster");
 		if (employeeMasterVO != null
 				&& employeeMasterVO.getEmployeeId() > 0) {
 			empId = employeeMasterVO.getEmployeeId();
 			byte[] employeeImage = employeeMasterVO.getEmployeePhoto();
 			if (employeeImage == null)
 				employeeImage = new byte[1];
 			byte[] encoded = Base64.encodeBase64(employeeImage);
 			encodedString = new String(encoded);
 		}
 		if (empId > 0) {
 %> <img src="data:image/jpeg;base64,<%=encodedString%>" alt="No Image"
												style="width: 131px; height: 114px;" id="originalPic" /> <%
 	} else {
 %> <img src="<%=request.getContextPath()%>/resources/img/noImage.gif"
												style="width: 131px; height: 114px;" alt="No Image"
												id="empPic" /> <%
 	}
 %>

											</a> <br />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label for="empPhoto" class="control-label col-sm-4">Employee
											Photo:</label>
										<div class="col-sm-6">
											<button type="button" onclick="openPhotoUploadModal();">
												<span class="glyphicon glyphicon-collapse-up"
													style="font-size: 14px;"></span>
											</button>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<div class="col-md-4"></div>
										<div class="col-md-7">
											<a href="#" class="thumbnail"> <%
 	String encodedSignatureString = null;
 		if (employeeMasterVO != null
 				&& employeeMasterVO.getEmployeeId() > 0) {
 			byte[] employeeSignature = employeeMasterVO
 					.getEmployeeSignature();
 			if (employeeSignature == null)
 				employeeSignature = new byte[1];
 			byte[] encodedSignature = Base64
 					.encodeBase64(employeeSignature);
 			encodedSignatureString = new String(encodedSignature);
 		}
 		if (empId > 0) {
 %> <img src="data:image/jpeg;base64,<%=encodedSignatureString%>"
												style="width: 300px; height: 40px;" alt="No Signature"
												id="originalSignature" /> <%
 	} else {
 %> <img
												src="<%=request.getContextPath()%>/resources/img/no_signature_avail.JPG"
												style="width: 300px; height: 40px;" alt="No Image"
												id="signaturePic" /> <%
 	}
 %>
											</a> <br />
										</div>
									</div>
								</div>
								<div class="row">

									<div class="form-group">
										<label for="signature" class="control-label col-sm-4">Signature:</label>
										<div class="col-sm-6">
											<button type="button" onclick="openSignatureUploadModal();">
												<span class="glyphicon glyphicon-collapse-up"
													style="font-size: 14px;"></span>
											</button>
										</div>
									</div>
								</div>
								<br />
							</div>
							<div>

								<br />
								<div class="row">
									<div class="form-group col-sm-6">
										<label for="gen" class="control-label col-sm-4">Gender:</label>
										<spring:message code='mktg.coMast.clsStatus-enter'
											var="clsStatus" />
										<div class="col-sm-8">
											<form:select path="employeeGender"
												class="form-control selectized" placeholder="Select Gender"
												data-bv-notempty-message="Gender is required"
												data-bv-notempty="true">
												<form:option value="select">Select Gender</form:option>
												<form:option value="Male">Male</form:option>
												<form:option value="Female">Female</form:option>

											</form:select>
										</div>
									</div>
									<div class="form-group col-sm-6">
										<label for="ms" class="control-label col-sm-4">Marital
											Status:</label>
										<spring:message code='mktg.coMast.clsStatus-enter'
											var="clsStatus" />
										<div class="col-sm-8">
											<form:select path="employeeMaritalStatus"
												class="form-control selectized"
												placeholder="Select Maritual Status"
												data-bv-notempty-message="Marital Status is required"
												data-bv-notempty="true">
												<form:option value="select">Select Maritual Status</form:option>
												<form:option value="Married">Married</form:option>
												<form:option value="Unmarried">Unmarried</form:option>
												<form:option value="Divorce">Divorce</form:option>
											</form:select>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-sm-6" id="spouseDiv"
										style="display: none;">
										<label for="spouse" class="control-label col-sm-4">Spouse
											Name:</label>
										<div class="col-sm-8">
											<form:input path="empMastSpouseName" cssClass="form-control"
												data-bv-notempty="false"
												data-bv-notempty-message="Spouse Name is required"
												placeholder="Spouse Name" />
										</div>
									</div>
									<div class="form-group col-sm-6" id="marDate"
										style="display: none;">
										<label for="md" class="control-label col-sm-4">Marriage
											Date:</label>
										<div class="col-sm-8">
											<div class="input-group date" id="datetimepicker4"
												data-date-format="DD-MMM-YYYY">
												<form:input path="employeeMarriageDate" value=""
													cssClass="form-control" placeholder="DD-MMM-YYYY"
													data-bv-notempty="false" readonly="true"
													data-bv-notempty-message="Marriage Date is required" />
												<span class="input-group-addon"><span
													class="glyphicon-calendar glyphicon"></span> </span>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-sm-6">
										<label for="branch" class="control-label col-sm-4">Branch</label>
										<spring:message code="mtrl.gatepass.gpdept-error"
											var="gp_gpdept" />

										<div class="col-sm-8">
											<form:select path="hrEmployeeBranchId.branchMasterId"
												class="form-control selectized" placeholder="Select Branch"
												data-bv-notempty="true"
												data-bv-notempty-message="Branch is required">
											</form:select>
											<input type="hidden" id="branchId"
												value="${employeeMaster.hrEmployeeBranchId.branchMasterId}" />
										</div>
									</div>
									<div class="form-group col-sm-6" id="pfNomineeDiv"
										style="display: none;">
										<label for="spouse" class="control-label col-sm-4">PF
											Nominee</label>
										<div class="col-sm-1">
											<form:checkbox path="empMastSpousePFNominee"
												data-bv-notempty-message="PF Nominee is required" />
										</div>

									</div>


								</div>
								<div class="row">
									<div class="form-group col-sm-6">
										<label for="dep" class="control-label col-sm-4">Department:</label>
										<spring:message code="mtrl.gatepass.gpdept-error"
											var="gp_gpdept" />
										<div class="col-sm-8">
											<form:select path="hrDepartment.departmentId"
												onchange="getGroup()" class="form-control selectized"
												placeholder="Select Department" data-bv-notempty="true"
												data-bv-notempty-message="Department is required">
											</form:select>
											<input type="hidden" id="deptId"
												value="${employeeMaster.hrDepartment.departmentId}" />
										</div>
									</div>
									<div class="form-group col-sm-6">
										<label for="email" class="control-label col-sm-4">Email
											Id:</label>
										<div class="col-sm-8">
											<form:input path="employeeMailId" cssClass="form-control"
												data-bv-notempty="false"
												data-bv-notempty-message="Email Id is required"
												data-bv-emailaddress="true"
												data-bv-emailaddress-message="The value is not a valid email address"
												placeholder="Email Id" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-sm-6">
										<label for="grp" class="control-label col-sm-4">Group:</label>
										<spring:message code="mtrl.gatepass.gpdept-error"
											var="gp_gpdept" />
										<div class="col-sm-8">
											<form:select path="employeeDeptGroupId.departmentId"
												class="form-control selectized" placeholder="Select Group"
												data-bv-notempty="false" data-bv-notempty-message="">

											</form:select>
											<input type="hidden" id="groupId"
												value="${employeeMaster.employeeDeptGroupId.departmentId}" />
										</div>
									</div>
									<div class="form-group col-sm-6">
										<label for="bn" class="control-label col-sm-4">Bank
											Name:</label>
										<spring:message code="mtrl.gatepass.gpdept-error"
											var="gp_gpdept" />
										<div class="col-sm-8">
											<form:select path="hrEmployeeBankId.bankId"
												class="form-control selectized"
												placeholder="Select Bank Name" data-bv-notempty="true"
												data-bv-notempty-message="Bank Name is required">

											</form:select>
											<input type="hidden" id="bankId"
												value="${employeeMaster.hrEmployeeBankId.bankId}" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-sm-6">
										<label for="desg" class="control-label col-sm-4">Designation:</label>
										<form:hidden path="designation.designationName" />
										<spring:message code="mtrl.gatepass.gpdept-error"
											var="gp_gpdept" />
										<div class="col-sm-8">
											<form:select path="designation.designationId"
												class="form-control selectized"
												placeholder="Select Designation" data-bv-notempty="true"
												data-bv-notempty-message="Designation is required">

											</form:select>
											<input type="hidden" id="designationId"
												value="${employeeMaster.designation.designationId}" />
										</div>
									</div>
									<div class="form-group col-sm-6">
										<label for="ban" class="control-label col-sm-4">Bank
											A/C No:</label>
										<div class="col-sm-8">
											<form:input path="employeeBankACNo"
												cssClass="form-control numericOnly" data-bv-notempty="true"
												data-bv-notempty-message="Bank A/C No is required"
												placeholder="Bank A/C No" />
										</div>
									</div>
								</div>
								<div class="row">

									<div class="form-group col-sm-6">
										<label for="marketingremark" class="control-label col-sm-4">Salary
											PM (Rs):</label>
										<div class="col-sm-8">
											<div class="input-group">
												<form:input path="" id="grossSalary" cssClass="form-control"
													readonly="true" placeholder="Select Salary PM"
													data-bv-notempty-message="Project name is required" />
												<form:hidden path="hrEmployeePackageId.packageId"
													cssClass="form-control"
													data-bv-notempty-message="Project name is required" />


												<span class="input-group-addon"><button type="button"
														onclick="getSalaryDetails();" id="qtnButId">
														<span class="glyphicon glyphicon-collapse-up"
															style="font-size: 14px;"></span>
													</button></span>
											</div>
										</div>
									</div>
									<div class="form-group col-sm-6">
										<label for="rt" class="control-label col-sm-4">Reporting
											To:</label>
										<spring:message code="mtrl.gatepass.gpdept-error"
											var="gp_gpdept" />
										<div class="col-sm-8">
											<form:select path="employeeReportingTo"
												class="form-control selectized"
												placeholder="Select Reporting To" data-bv-notempty="false"
												data-bv-notempty-message="">

											</form:select>
											<input type="hidden" id="reportId"
												value="${employeeMaster.employeeReportingTo}" />
										</div>
									</div>
								</div>
								<div class="row">

									<div class="form-group col-sm-6">
										<label for="bloodGrp" class="control-label col-sm-4">Blood
											Group:</label>
										<spring:message code='mktg.coMast.clsStatus-enter'
											var="clsStatus" />
										<div class="col-sm-8">
											<form:select path="employeeBloodGroup"
												class="form-control selectized"
												placeholder="Select Blood Group"
												data-bv-notempty-message="Blood Group is required"
												data-bv-notempty="true">
												<form:option value="0">Select Blood Group</form:option>
												<form:option value="1">A +</form:option>
												<form:option value="2">A -</form:option>
												<form:option value="3">B +</form:option>
												<form:option value="4">B -</form:option>
												<form:option value="5">AB +</form:option>
												<form:option value="6">AB -</form:option>
												<form:option value="7">O +</form:option>
												<form:option value="8">O -</form:option>
											</form:select>
										</div>
									</div>
									<div class="form-group col-sm-6">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-1">

											<form:checkbox path="employeeLeaveReccRequired" value="0"
												data-bv-notempty-message="Project name is required" />
										</div>
										<div class="form-group col-sm-8">
											<label for="marketingremark" class="control-label">
												Leave Recomm.Required</label>
										</div>

									</div>

								</div>
								<div class="row">

									<div class="form-group col-sm-6">
										<label for="esi" class="control-label col-sm-4">ESI
											Number:</label>
										<div class="col-sm-8">
											<form:input path="employeeESINumber" cssClass="form-control"
												data-bv-notempty="true"
												data-bv-notempty-message="ESI Number is required"
												placeholder="ESI Number" />
										</div>
									</div>
									<div class="form-group col-sm-6">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-1">

											<form:checkbox path="employeeLeaveReccPermission" value="0"
												data-bv-notempty-message="Project name is required" />
										</div>
										<div class="col-sm-8">
											<label for="marketingremark" class="control-label">Leave
												Recomm.Permission</label>
										</div>
									</div>

								</div>
								<div class="row">

									<div class="form-group col-sm-6">
										<label for="marketingremark" class="control-label col-sm-4">PAN
											Number:</label>
										<div class="col-sm-8">
											<form:input path="employeePAN" cssClass="form-control"
												data-bv-notempty="true"
												data-bv-notempty-message="PAN Number is required"
												placeholder="PAN Number" />
										</div>
									</div>
									<div class="form-group col-sm-6">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-1">
											<form:checkbox path="employeeeaveApprovalPermission"
												value="0"
												data-bv-notempty-message="Project name is required" />
										</div>
										<div class="col-sm-8">
											<label for="marketingremark" class="control-label">Leave
												Approval Permission</label>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="form-group col-sm-6">
										<label for="marketingremark" class="control-label col-sm-4">Aadhar
											Number:</label>
										<div class="col-sm-8">
											<form:input path="empMastAdharNumber" cssClass="form-control"
												data-bv-notempty="true"
												data-bv-notempty-message="Aadhar Number is required"
												placeholder="Aadhar Number" />
										</div>
									</div>

									<div class="form-group col-sm-6">
										<div class="col-sm-3">
										</div>
										<div class="col-sm-1">
											<form:checkbox path="employeeODApprovalPermission" value="0"
												data-bv-notempty-message="Project name is required" />
										</div>
										<div class="col-sm-8">
											<label for="marketingremark" class="control-label">OD
												Approval Permission</label>
										</div>

									</div>

								</div>
								<div class="row">
									<div class="form-group col-sm-6">
										<label for="marketingremark" class="control-label col-sm-4">Remarks:</label>
										<div class="col-sm-8">
											<form:textarea path="empMastRemarks" cssClass="form-control"
												data-bv-notempty="true"
												data-bv-notempty-message="Remarks is required"
												placeholder="Remarks" />
										</div>
									</div>

									<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Employee
									Weekly Work Report:</label>
									<div class="col-sm-8">
								<form:checkbox path="employeeWeeklyReportReq"
									cssClass="form-control" value="0"
									data-bv-notempty-message="Project name is required" />
									</div>
							</div>

								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane" id="tab2">
						<br />
						<div class="row">
							<div class="form-group col-sm-6">
								<div class="col-sm-1">
									<form:checkbox path="" id="sameAddress" onclick="sameAddr()"
										value="0" data-bv-notempty-message="Project name is required" />
								</div>
								<div class="col-sm-1">
								</div>
								<div class="col-sm-10">
									<label for="prepermAddr" class="control-label">Permanent
										Address same as Present Address</label>
								</div>
							</div>

						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Present
									Address:</label>
								<div class="col-sm-8">
									<form:input path="employeePresentAddress1"
										placeholder="Present Address1" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Present Address1" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Permanent
									Address:</label>
								<div class="col-sm-8">
									<form:input path="employeePermanentAddress1"
										placeholder="Permanent Address1" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Permanent Address1" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4"></label>
								<div class="col-sm-8">
									<form:input path="employeePresentAddress2"
										placeholder="Present Address2" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Present Address2" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4"></label>
								<div class="col-sm-8">
									<form:input path="employeePermanentAddress2"
										placeholder="Permanent Address2" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Permanent Address2" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4"></label>
								<div class="col-sm-8">
									<form:input path="employeePresentAddress3"
										placeholder="Present Address3" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Present Address3" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4"></label>
								<div class="col-sm-8">
									<form:input path="employeePermanentAddress3"
										placeholder="Permanent Address3" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Permanent Address3" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">City:</label>
								<div class="col-sm-8">
									<form:input path="employeePresentCity" cssClass="form-control"
										data-bv-notempty="true" data-bv-notempty-message="Enter City"
										placeholder="Present City" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">City:</label>
								<div class="col-sm-8">
									<form:input path="employeePermanentCity"
										cssClass="form-control" data-bv-notempty="true"
										data-bv-notempty-message="Enter Permanent address City"
										placeholder="Permanent City" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">State:</label>
								<div class="col-sm-8">
									<form:input path="employeePresentState" cssClass="form-control"
										data-bv-notempty="true" data-bv-notempty-message="Enter State"
										placeholder="Present State" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">State:</label>
								<div class="col-sm-8">
									<form:input path="employeePermanentState"
										cssClass="form-control"
										data-bv-notempty-message="Project code is required"
										placeholder="Permanent State" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Pin
									Code:</label>
								<div class="col-sm-8">
									<form:input path="employeePresentPincode"
										cssClass="form-control" placeholder="Present Pin Code"
										data-bv-notempty-message="Project code is required" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Pin
									Code:</label>
								<div class="col-sm-8">
									<form:input path="employeePermanentPincode"
										cssClass="form-control" placeholder="Permanent Pin Code"
										data-bv-notempty-message="Project code is required" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Telephone
									Number:</label>
								<div class="col-sm-8">
									<form:input path="employeePresentPhoneNo"
										cssClass="form-control" placeholder="Present Telephone Number"
										data-bv-notempty-message="Project code is required" />
								</div>
							</div>
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Telephone
									Number:</label>
								<div class="col-sm-8">
									<form:input path="employeePermanentPhoneNo"
										cssClass="form-control"
										placeholder="Permanent Telephone Number"
										data-bv-notempty-message="Project code is required" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-sm-6">
								<label for="marketingremark" class="control-label col-sm-4">Mobile
									Number:</label>
								<div class="col-sm-8">
									<form:input path="employeeMobileNo" cssClass="form-control"
										data-bv-notempty-message="Project code is required"
										placeholder="Mobile Number" />
								</div>
							</div>

						</div>
					</div>



					<div class="tab-pane" id="tab3">
						<br />
						<button type="button" class="btn btn-primary btn-xs"
							data-toggle="tooltip" data-original-title="Add Experience"
							data-placement="right" onclick="openAddDocumentRegisterModal();">
							&nbsp;<i class="fa  fa-plus"></i>&nbsp;
						</button>
						<br />
						<div>
							<div class="box-body table-responsive">
								<table class="table table-striped" id="EmpPreExpGrid">
									<thead>
										<tr>

											<!-- <th>SNo.</th> -->
											<th>Comapny Name</th>
											<th>Designation</th>
											<th>No of Yrs</th>
											<th>Salary</th>
											<th>Remarks</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="hrEempPrevExperience"
											value="${employeeMaster.hrEempPrevExperience}" />
										<c:set var="hrEmpdetailsSize" value="0" />
										<c:if test="${!empty hrEempPrevExperience}">

											<c:forEach items="${hrEempPrevExperience}" var="detail"
												varStatus="loopCounter">
												<c:set var="hrEmpdetailsSize"
													value="${hrEmpdetailsSize + 1}" />
												<tr id="prevExpGridRow${loopCounter.count}"
													detailid="${loopCounter.index}">
													<td><form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].deleteIndicator"
															id="hrEempPrevExperience${loopCounter.index}.deleteIndicator"
															value="false" /> <form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].prevExpId"
															id="hrEempPrevExperience${loopCounter.index}.prevExpId" />


														<form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].prevExpCompany"
															id="hrEempPrevExperience${loopCounter.index}.prevExpCompany"
															fwformfield="prevExpCompany" /> <span
														id="hrEempPrevExperience${loopCounter.index}.prevExpCompany.txt">${detail.prevExpCompany}</span>
													</td>
													<td><form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].prevExpDesignation"
															id="hrEempPrevExperience${loopCounter.index}.prevExpDesignation"
															fwformfield="prevExpDesignation" /> <span
														id="hrEempPrevExperience${loopCounter.index}.prevExpDesignation.txt">${detail.prevExpDesignation}</span>
													</td>

													<td><form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].prevExpExperienceInYears"
															id="hrEempPrevExperience${loopCounter.index}.prevExpExperienceInYears"
															fwformfield="prevExpExperienceInYears" /> <span
														id="hrEempPrevExperience${loopCounter.index}.prevExpExperienceInYears.txt">${detail.prevExpExperienceInYears}</span>
													</td>
													<td><form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].prevExpMonthlySalary"
															id="hrEempPrevExperience${loopCounter.index}.prevExpMonthlySalary"
															fwformfield="prevExpMonthlySalary" /> <span
														id="hrEempPrevExperience${loopCounter.index}.prevExpMonthlySalary.txt">${detail.prevExpMonthlySalary}</span>
													</td>
													<td><form:hidden
															path="hrEempPrevExperience[${loopCounter.index}].prevExpRemarks"
															id="hrEempPrevExperience${loopCounter.index}.prevExpRemarks"
															fwformfield="prevExpRemarks" /> <span
														id="hrEempPrevExperience${loopCounter.index}.prevExpRemarks.txt">${detail.prevExpRemarks}</span>
													</td>




													<td class="center">
														<button type="button" class="btn btn-default btn-xs"
															onclick="openEditPrevExpModal(this);">
															<span class="glyphicon glyphicon-edit"></span>
														</button>&nbsp;
														<button type="button" class="btn btn-default btn-xs"
															onclick="COMMON.commondeleteRow(this,'hrEempPrevExperience${loopCounter.index}\\.deleteIndicator');">
															<span class="glyphicon glyphicon-trash"></span>
														</button>
													</td>
												</tr>
											</c:forEach>

										</c:if>

									</tbody>
								</table>
								<input type="hidden" id="hrEmpdetailsSize"
									value="${hrEmpdetailsSize}" />
								<!-- <input type="hidden" id="hrEmpdetailsSize" value="0" />  -->
							</div>
						</div>

					</div>
					<div class="tab-pane" id="tab4">
						<br />
						<button type="button" class="btn btn-primary btn-xs"
							data-toggle="tooltip" data-original-title="Add Policy"
							data-placement="right" onclick="openAddPolicyModal();">
							&nbsp;<i class="fa  fa-plus"></i>&nbsp;
						</button>

						<br /> <br />
						<div>
							<div class="box-body table-responsive">
								<table class="table table-striped" id="EmpPolicyGrid">
									<thead>
										<tr>
											<!-- <th>SNo.</th> -->
											<th style="width: 10%;">Policy Id</th>
											<th style="width: 20%;">Name</th>
											<th style="width: 20%;">Relationship</th>
											<th style="width: 10%;">DOB</th>
											<th style="width: 5%;">Age</th>
											<th style="width: 5%;">Action</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="hrEmpPolacyDetails"
											value="${employeeMaster.hrEmpPolacyDetails}" />
										<c:set var="hrEmpPolicySize" value="0" />
										<c:if test="${!empty hrEmpPolacyDetails}">

											<c:forEach items="${hrEmpPolacyDetails}" var="detail"
												varStatus="loopCounter">
												<c:set var="hrEmpPolicySize" value="${hrEmpPolicySize + 1}" />
												<tr id="policysGridRow${loopCounter.count}"
													policydetailid="${loopCounter.index}">
													<td><form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].deleteIndicator"
															id="hrEmpPolacyDetails${loopCounter.index}.deleteIndicator"
															value="false" /> <form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].policyDetailId"
															id="hrEmpPolacyDetails${loopCounter.index}.policyDetailId" />


														<form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].policyDetailsPolicyId"
															id="hrEmpPolacyDetails${loopCounter.index}.policyDetailsPolicyId"
															fwformfield="policyDetailId" /> <span
														id="hrEmpPolacyDetails${loopCounter.index}.policyDetailsPolicyId.txt">${detail.policyDetailsPolicyId}</span>
													</td>
													<td><form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].policyDetailName"
															id="hrEmpPolacyDetails${loopCounter.index}.policyDetailName"
															fwformfield="policyDetailName" /> <span
														id="hrEmpPolacyDetails${loopCounter.index}.policyDetailName.txt">${detail.policyDetailName}</span>
													</td>

													<td><form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].policyDetailsRelationShip"
															id="hrEmpPolacyDetails${loopCounter.index}.policyDetailsRelationShip"
															fwformfield="policyDetailsRelationShip" /> <span
														id="hrEmpPolacyDetails${loopCounter.index}.policyDetailsRelationShip.txt">${detail.policyDetailsRelationShip}</span>
													</td>
													<td><fmt:formatDate value="${detail.policyDetailDOB}"
															pattern="dd-MMM-yyyy" var="newdatevar" /> <form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].policyDetailDOB"
															id="hrEmpPolacyDetails${loopCounter.index}.policyDetailDOB"
															fwformfield="policyDetailDOB" /> <span
														id="hrEmpPolacyDetails${loopCounter.index}.policyDetailDOB.txt">${newdatevar}</span>
													</td>
													<td><form:hidden
															path="hrEmpPolacyDetails[${loopCounter.index}].policyDetailAge"
															id="hrEmpPolacyDetails${loopCounter.index}.policyDetailAge"
															fwformfield="policyDetailAge" /> <span
														id="hrEmpPolacyDetails${loopCounter.index}.policyDetailAge.txt">${detail.policyDetailAge}</span>
													</td>


													<td class="center">
														<button type="button" class="btn btn-default btn-xs"
															onclick="openEditPolicyModal(this);">
															<span class="glyphicon glyphicon-edit"></span>
														</button>&nbsp;
														<button type="button" class="btn btn-default btn-xs"
															onclick="COMMON.commondeleteRow(this,'hrEmpPolacyDetails${loopCounter.index}\\.deleteIndicator');">
															<span class="glyphicon glyphicon-trash"></span>
														</button>
													</td>
												</tr>
											</c:forEach>

										</c:if>
									</tbody>
								</table>

								<input type="hidden" id="hrEmpPolicySize"
									value="${hrEmpPolicySize}" />
								<!-- <input type="hidden" id="hrEmpPolicySize" value="0" /> -->
							</div>
						</div>


					</div>

				</div>


			</div>
			<hr>
			<div class="row">
				<div class="col-sm-6">
					<div class="box box-success">
						<h4>Educational Attachments</h4>
						Click to Add Educational Attachments&nbsp;
						<button type="button" onclick="openEducatAttachModal();">
							<span class="glyphicon glyphicon-open" style="font-size: 14px;"></span>
						</button>
						<br /> <br />
						<c:set var="educatFilesSize" value="0" />
						<table class="display table table-bordered"
							id="educatAttachmentsGrid">
							<thead>
								<tr>
									<th width="90%">File Name</th>
									<th width="5%">Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${educatFilesList}" var="edAttachment"
									varStatus="loopCounter">
									<c:set var="educatFilesSize" value="${educatFilesSize + 1}" />
									<tr detailid="${loopCounter.index}">
										<td><input type="hidden"
											id="empEducationalMetaData${loopCounter.index}.deleteType"
											name="empEducationalMetaData[${loopCounter.index}].deleteType"
											value="F" fwformfield="deleteType" /> <input type="hidden"
											id="empEducationalMetaData${loopCounter.index}.name"
											name="empEducationalMetaData[${loopCounter.index}].name"
											value="${edAttachment}" /> <a style="cursor: pointer;"
											onclick="viewEdAttachmentInEdit('${edAttachment}');">${edAttachment}</a>
										</td>
										<td class="center">
											<button type="button" class="btn btn-default btn-xs"
												onclick="deleteEdFileInEdit('${edAttachment}',this);">
												<span class="glyphicon glyphicon-trash"></span>
											</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<input type="hidden" id="educatFilesSize"
							value="${educatFilesSize}" />
					</div>
				</div>
				<div class="col-sm-6">
					<div class="box box-warning">
						<h4>Professional Attachments</h4>
						Click to Add Professional Attachments&nbsp;
						<button type="button" onclick="openProfAttachModal();">
							<span class="glyphicon glyphicon-open" style="font-size: 14px;"></span>
						</button>
						<br /> <br />
						<c:set var="profFilesSize" value="0" />
						<table class="display table table-bordered"
							id="profAttachmentsGrid">
							<thead>
								<tr>
									<th width="90%">File Name</th>
									<th width="5%">Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${profFilesList}" var="profAttachment"
									varStatus="loopCounter">
									<c:set var="profFilesSize" value="${profFilesSize + 1}" />
									<tr detailid="${loopCounter.index}">
										<td><input type="hidden"
											id="empProfessionalMetaData${loopCounter.index}.deleteType"
											name="empProfessionalMetaData[${loopCounter.index}].deleteType"
											value="F" fwformfield="deleteType" /> <input type="hidden"
											id="empProfessionalMetaData${loopCounter.index}.name"
											name="empProfessionalMetaData[${loopCounter.index}].name"
											value="${profAttachment}" /> <a style="cursor: pointer;"
											onclick="viewProfAttachmentInEdit('${profAttachment}');">${profAttachment}</a>
										</td>
										<td class="center">
											<button type="button" class="btn btn-default btn-xs"
												onclick="deleteProfFileInEdit('${profAttachment}',this);">
												<span class="glyphicon glyphicon-trash"></span>
											</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<input type="hidden" id="profFilesSize" value="${profFilesSize}" />
					</div>
				</div>
			</div>

			<div class="form-group text-center">
				<br /> <br />
				<button type="submit" value="save" class="btn btn-primary">Save</button>
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/employee/list.action')">Cancel</button>

			</div>

			<div class="modal fade" id="packageListModal" tabindex="-1"
				role="dialog" aria-labelledby="qtnListModalLabel" aria-hidden="true"
				style="display: none">
				<div class="modal-dialog modal-md">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								id="qtnListModalCloseBtn" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="qtnListModalLabel"></h4>
						</div>
						<div class="box-body">
							<div class="box-body table-responsive">
								<table class="table table-striped" id="salDetsGrid">
									<thead>
										<tr>
											<!-- <th>S.No.</th> -->
											<th style="display: none;">ctc</th>
											<th>Gross Salary</th>
											<th>Basic</th>
											<th>DA</th>
											<th>HRA</th>
											<th>CA</th>
											<th>Other Allowance</th>
											<th>Employer PF</th>
											<th>Employer ESI</th>
											<th>CTC Value</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</form:form>
		<div class="modal fade bs-example-modal-md" id="employeeModel"
			tabindex="0" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							id="documentchildClose" aria-hidden="true">&times;</button>
						<h4 class="modal-title text-center">Add Details</h4>
					</div>

					<div class="modal-body">
						<form:form method="POST" commandName="expDetail"
							id="addExpDetailForm" name="addExpDetailForm"
							data-bv-message="This value is not valid"
							data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
							data-bv-submitbuttons='button[type="submit"]'
							data-bv-live="enabled" class="form-horizontal">

							<div class="form-group">
								<label for="inputName" class="control-label col-sm-4">Company
									Name:</label>
								<div class="col-sm-8">
									<form:input path="prevExpCompany" value=""
										cssClass="form-control" placeholder="Company Name"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Company Name" />
								</div>
							</div>
							<div class="form-group">
								<label for="marketingremark" class="control-label col-sm-4">Designation:</label>
								<div class="col-sm-8">
									<form:input path="prevExpDesignation" value=""
										placeholder="Designation" cssClass="form-control"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Designation" />
								</div>
							</div>



							<div class="form-group">
								<label for="years" class="control-label col-sm-4">No. Of
									Years:</label>
								<div class="col-sm-8">
									<form:input path="prevExpExperienceInYears" value=""
										cssClass="form-control numericOnly" placeholder="No.Of Years"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter No Of Years" />
								</div>
							</div>
							<div class="form-group">
								<label for="salary" class="control-label col-sm-4">Salary(Rs):</label>
								<div class="col-sm-8">
									<form:input path="prevExpMonthlySalary" value=""
										cssClass="form-control numericOnly" placeholder="Salary"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Salary" />
								</div>
							</div>





							<div class="form-group">
								<label for="marketingremark" class="control-label col-sm-4">Remarks:</label>
								<div class="col-sm-8">
									<form:textarea path="prevExpRemarks" value=""
										cssClass="form-control" rows="2" cols="8"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Remarks" />
								</div>
							</div>


							<div class="form-group text-center">
								<button type="submit" class="btn btn-primary">Add</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade bs-example-modal-md" id="policyModel"
			tabindex="0" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							id="documentchildClose" aria-hidden="true">&times;</button>
						<h4 class="modal-title text-center">Add Details</h4>
					</div>

					<div class="modal-body">
						<form:form method="POST" commandName="policyDetail"
							id="addPolicyDetailForm" name="addPolicyDetailForm"
							data-bv-message="This value is not valid"
							data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
							data-bv-submitbuttons='button[type="submit"]'
							data-bv-live="enabled" class="form-horizontal">

							<div class="form-group">
								<label for="marketingremark" class="control-label col-sm-4">Self:</label>
								<div class="col-sm-1">
									<form:checkbox path="" id="self" value="1"
										data-bv-notempty-message="Project name is required" />
								</div>
							</div>



							<div class="form-group">
								<label for="inputName" class="control-label col-sm-4">Policy
									Id:</label>
								<div class="col-sm-8">
									<form:input path="policyDetailsPolicyId" value=""
										cssClass="form-control numericOnly" placeholder="Policy Id"
										data-bv-notempty="false"
										data-bv-notempty-message="FileName could no be empty" />
								</div>
							</div>
							<div class="form-group">
								<label for="marketingremark" class="control-label col-sm-4">Name:</label>
								<div class="col-sm-8">
									<form:input path="policyDetailName" value="" placeholder="Name"
										cssClass="form-control" data-bv-notempty="true"
										data-bv-notempty-message="Enter Name" />
								</div>
							</div>




							<div class="form-group">
								<label for="inputName" class="control-label col-sm-4">Relationship:</label>
								<div class="col-sm-8">
									<form:input path="policyDetailsRelationShip" value=""
										cssClass="form-control" placeholder="Relationship"
										data-bv-notempty="true"
										data-bv-notempty-message="Enter Relationship" />
								</div>
							</div>
							<div class="form-group">
								<label for="refDate" class="control-label col-sm-4">DOB:</label>
								<div class="col-sm-8">
									<div class="input-group date" id="datetimepicker5"
										data-date-format="DD-MMM-YYYY">
										<form:input path="policyDetailDOB" value=""
											cssClass="form-control" placeholder="DD-MMM-YYYY"
											data-bv-notempty="true" readonly="true"
											data-bv-notempty-message="Enter DOB" />
										<span class="input-group-addon"><span
											class="glyphicon-calendar glyphicon"></span> </span>
									</div>
								</div>
							</div>




							<div class="form-group">
								<label for="inputName" class="control-label col-sm-4">Age:</label>
								<div class="col-sm-8">
									<form:input path="policyDetailAge" value=""
										cssClass="form-control" placeholder="Age"
										data-bv-notempty="true" data-bv-notempty-message="Enter Age" />
								</div>
							</div>


							<div class="form-group text-center">
								<button type="submit" class="btn btn-primary">Add</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<table style="display: none;">
	<tr detailid="0" id="addPreExpTemplate" class="odd">

		<td><input type="hidden" value="false"
			name="hrEempPrevExperience[-id-].deleteIndicator"
			id="hrEempPrevExperience-id-.deleteIndicator" value="false" /> <input
			type="hidden" value="" name="hrEempPrevExperience[-id-].prevExpId"
			id="hrEempPrevExperience-id-.prevExpId" fwformfield="prevExpId" /> <!-- <span
			id="hrEempPrevExperience-id-.prevExpId.txt"></span></td>
			<td> --> <input type="hidden" value=""
			name="hrEempPrevExperience[-id-].prevExpCompany"
			id="hrEempPrevExperience-id-.prevExpCompany"
			fwformfield="prevExpCompany" /> <span
			id="hrEempPrevExperience-id-.prevExpCompany.txt"></span></td>
		<td><input type="hidden" value=""
			name="hrEempPrevExperience[-id-].prevExpDesignation"
			id="hrEempPrevExperience-id-.prevExpDesignation"
			fwformfield="prevExpDesignation" /> <span
			id="hrEempPrevExperience-id-.prevExpDesignation.txt"></span></td>
		<td><input type="hidden" value=""
			name="hrEempPrevExperience[-id-].prevExpExperienceInYears"
			id="hrEempPrevExperience-id-.prevExpExperienceInYears"
			fwformfield="prevExpExperienceInYears" /> <span
			id="hrEempPrevExperience-id-.prevExpExperienceInYears.txt"></span></td>
		<td><input type="hidden" value=""
			name="hrEempPrevExperience[-id-].prevExpMonthlySalary"
			id="hrEempPrevExperience-id-.prevExpMonthlySalary"
			fwformfield="prevExpMonthlySalary" /> <span
			id="hrEempPrevExperience-id-.prevExpMonthlySalary.txt"></span></td>
		<td><input type="hidden" value=""
			name="hrEempPrevExperience[-id-].prevExpRemarks"
			id="hrEempPrevExperience-id-.prevExpRemarks"
			fwformfield="prevExpRemarks" /> <span
			id="hrEempPrevExperience-id-.prevExpRemarks.txt"></span></td>


		<td class="center">
			<button type="button" class="btn btn-default btn-xs"
				onclick="openEditPrevExpModal(this);">
				<span class="glyphicon glyphicon-edit"></span>
			</button>&nbsp;
			<button type="button" class="btn btn-default btn-xs"
				onclick="COMMON.commondeleteRow(this,'hrEempPrevExperience-id-\\.deleteIndicator');">
				<span class="glyphicon glyphicon-trash"></span>
			</button>
		</td>


	</tr>
</table>
<input type="hidden" id="currentrow" />

<table style="display: none;">
	<tr policydetailid="0" id="addPolicyTemplate" class="odd">

		<td><input type="hidden" value="false"
			name="hrEmpPolacyDetails[-id-].deleteIndicator"
			id="hrEmpPolacyDetails-id-.deleteIndicator" value="false" /> <input
			type="hidden" value="" name="hrEmpPolacyDetails[-id-].policyDetailId"
			id="hrEmpPolacyDetails-id-.policyDetailId"
			fwformfield="policyDetailId" /> <input type="hidden" value=""
			name="hrEmpPolacyDetails[-id-].policyDetailsPolicyId"
			id="hrEmpPolacyDetails-id-.policyDetailsPolicyId"
			fwformfield="policyDetailsPolicyId" /> <span
			id="hrEmpPolacyDetails-id-.policyDetailsPolicyId.txt"></span></td>


		<td><input type="hidden" value=""
			name="hrEmpPolacyDetails[-id-].policyDetailName"
			id="hrEmpPolacyDetails-id-.policyDetailName"
			fwformfield="policyDetailName" /> <span
			id="hrEmpPolacyDetails-id-.policyDetailName.txt"></span></td>

		<td><input type="hidden" value=""
			name="hrEmpPolacyDetails[-id-].policyDetailsRelationShip"
			id="hrEmpPolacyDetails-id-.policyDetailsRelationShip"
			fwformfield="policyDetailsRelationShip" /> <span
			id="hrEmpPolacyDetails-id-.policyDetailsRelationShip.txt"></span></td>
		<td><input type="hidden" value=""
			name="hrEmpPolacyDetails[-id-].policyDetailDOB"
			id="hrEmpPolacyDetails-id-.policyDetailDOB"
			fwformfield="policyDetailDOB" /> <span
			id="hrEmpPolacyDetails-id-.policyDetailDOB.txt"></span></td>
		<td><input type="hidden" value=""
			name="hrEmpPolacyDetails[-id-].policyDetailAge"
			id="hrEmpPolacyDetails-id-.policyDetailAge"
			fwformfield="policyDetailAge" /> <span
			id="hrEmpPolacyDetails-id-.policyDetailAge.txt"></span></td>



		<td class="center">
			<button type="button" class="btn btn-default btn-xs"
				onclick="openEditPolicyModal(this);">
				<span class="glyphicon glyphicon-edit"></span>
			</button>&nbsp;
			<button type="button" class="btn btn-default btn-xs"
				onclick="COMMON.commondeleteRow(this,'hrEmpPolacyDetails-id-\\.deleteIndicator');">
				<span class="glyphicon glyphicon-trash"></span>
			</button>
		</td>


	</tr>
</table>
<input type="hidden" id="currentrowpolicy" />

<div class="modal fade" id="photoModal" tabindex="-1" role="dialog"
	aria-labelledby="photoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					id="photoModalCloseBtn" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="photoModalLabel"></h4>
			</div>
			<div class="modal-body" id="photoModal-body" align="center">
				<label class="control-label">Select Photo</label>

				<div id="imageuploadProgress"></div>
				<div id="imageUploadFormHolder">
					<form action="#" id="productSpecUploadForm" method="POST"
						enctype="multipart/form-data">
						<input type="hidden" name="productSpecUploadFormProductid"
							id="productSpecUploadFormProductid" value="" />
						<spring:message code="empPhotoDocName" var="empName" />
						<input type="hidden" name="docName" value="${empName}" /> <input
							type="file" id="productFile" name="productFile" value="" /> <input
							type="button" class="btn btn-primary"
							onclick="ajaxPhotoUpload();" value="Upload" />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="signatureModal" tabindex="-1" role="dialog"
	aria-labelledby="signatureModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					id="signatureModalCloseBtn" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="signatureModalLabel"></h4>
			</div>
			<div class="modal-body" id="signatureModal-body" align="center">
				<label class="control-label">Select Signature</label>

				<div id="signatureUploadProgress"></div>
				<div id="signatureUploadFormHolder">
					<form action="#" id="signatureUploadForm" method="POST"
						enctype="multipart/form-data">
						<input type="hidden" name="signatureUploadFormId"
							id="signatureUploadFormId" value="" />
						<spring:message code="empSignatureDocName" var="empSignatureName" />
						<input type="hidden" name="signatureDocName"
							value="${empSignatureName}" /> <input type="file"
							id="signatureFile" name="signatureFile" value="" /> <input
							type="button" class="btn btn-primary"
							onclick="ajaxSignatureUpload();" value="Upload" />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="educatModal" tabindex="-1" role="dialog"
	aria-labelledby="educatModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					id="educatModalCloseBtn" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="educatModalLabel">Select File to
					upload Educational Details</h4>
			</div>
			<div class="modal-body" id="educatModal-body" align="center">
				<div style="padding: 20px; margin-top: 10px;" class="bg-info">
					<form id="educatFileAttachments"
						action="<%=request.getContextPath()%>/secured/file/upload"
						method="POST" enctype="multipart/form-data">
						<div class="row fileupload-buttonbar">
							<div class="col-lg-6 text-right">
								<span class="btn btn-success btn-xs fileinput-button"> <i
									class="glyphicon glyphicon-plus"></i> <span>Add files...</span>
									<input id="educatAttachedFiles" type="file" name="files[]"
									multiple>
								</span> <span class="fileupload-process"></span>
								<spring:message code="FUNWORK.Attachments_SIZE"
									var="fileSizeLimit" />
								<div class="bg-info">
									Max. file upload size
									<c:out value="${fileSizeLimit}" />
									MB
								</div>
							</div>
							<div class="col-lg-4 fileupload-progress fade">
								<!-- The global progress bar -->
								<div class="progress progress-striped active" role="progressbar"
									aria-valuemin="0" aria-valuemax="100">
									<div class="progress-bar progress-bar-success"
										style="width: 0%;"></div>
								</div>
								<!-- The extended global progress state -->
								<div class="progress-extended">&nbsp;</div>
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="profModal" tabindex="-1" role="dialog"
	aria-labelledby="profModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					id="profModalCloseBtn" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="profModalLabel">Select File to
					upload Professional Details</h4>
			</div>
			<div class="modal-body" id="profModal-body" align="center">
				<div style="padding: 20px; margin-top: 10px;" class="bg-info">
					<form id="profFileAttachments"
						action="<%=request.getContextPath()%>/secured/file/upload"
						method="POST" enctype="multipart/form-data">
						<div class="row fileupload-buttonbar">
							<div class="col-lg-6 text-right">
								<span class="btn btn-success btn-xs fileinput-button"> <i
									class="glyphicon glyphicon-plus"></i> <span>Add files...</span>
									<input id="profAttachedFiles" type="file" name="files[]"
									multiple>
								</span> <span class="fileupload-process"></span>
								<spring:message code="FUNWORK.Attachments_SIZE"
									var="fileSizeLimit" />
								<div class="bg-info">
									Max. file upload size
									<c:out value="${fileSizeLimit}" />
									MB
								</div>
							</div>
							<div class="col-lg-4 fileupload-progress fade">
								<!-- The global progress bar -->
								<div class="progress progress-striped active" role="progressbar"
									aria-valuemin="0" aria-valuemax="100">
									<div class="progress-bar progress-bar-success"
										style="width: 0%;"></div>
								</div>
								<!-- The extended global progress state -->
								<div class="progress-extended">&nbsp;</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<iframe id="viewAttachIframe" src="#" width="100%" height="100%"
	class="multi-download-frame" style="display: none;"></iframe>

<script type="text/javascript"
	src="<c:url value='/resources/js/HR/funwork-employee.js'/>"></script>
<script type="text/javascript" charset="utf-8">
	var pageContext = '${pageContext.request.contextPath}';

	var empDetsName = $("#empDetailsName").val();
	var empEdName = $("#empEducationalName").val();
	var empProfName = $("#empProfessionalName").val();
	var docNum = "";

	function viewEdAttachment(fileName) {
		var docName = empDetsName + "/" + empEdName;
		COMMON.viewAttachment(pageContext, docName, docNum, fileName);
	}

	function viewProfAttachment(fileName) {
		var docName = empDetsName + "/" + empProfName;
		COMMON.viewAttachment(pageContext, docName, docNum, fileName);
	}

	function viewEdAttachmentInEdit(fileName) {
		var empCode = $("#employeeCode").val();
		var docName = empDetsName + "/" + empCode;
		COMMON.viewAttachment(pageContext, docName, empEdName, fileName);
	}

	function viewProfAttachmentInEdit(fileName) {
		var empCode = $("#employeeCode").val();
		var docName = empDetsName + "/" + empCode;
		COMMON.viewAttachment(pageContext, docName, empProfName, fileName);
	}

	function deleteEdFile(fileName, delBtn) {
		var docName = empDetsName + "/" + empEdName;
		COMMON.deleteAttachment(pageContext, fileName, docNum, docName, delBtn);
	}

	function chnangeDeleteType(delBtn)//T=True and F=False
	{
		var tr = $(delBtn).closest('tr');
		$(tr).children().each(function() {
			$(this).children().each(function() {
				if (this.nodeName == 'INPUT') {
					var nodeId = $(this).attr("fwformfield");
					console.log("nodeId", nodeId);
					if (nodeId == "deleteType") {
						$(this).val("T");
					}
				}
			});
		});

		tr.css("display", "none");
	}

	function deleteProfFile(fileName, delBtn) {
		var docName = empDetsName + "/" + empProfName;
		COMMON.deleteAttachment(pageContext, fileName, docNum, docName, delBtn);
	}

	function deleteEdFileInEdit(fileName, delBtn) {
		chnangeDeleteType(delBtn);

		//var empCode=$("#employeeCode").val();
		//var docName=empDetsName+"/"+empCode;
		//COMMON.deleteAttachment(pageContext, fileName, empEdName, docName, delBtn);
	}

	function deleteProfFileInEdit(fileName, delBtn) {
		chnangeDeleteType(delBtn);

		//var empCode=$("#employeeCode").val();
		//var docName=empDetsName+"/"+empCode;
		//COMMON.deleteAttachment(pageContext, fileName, empProfName, docName, delBtn);
	}

	$(document)
			.ready(
					function() {

						$("#educatAttachedFiles").change(
								function() {
									var educationalPath = empDetsName + "/"
											+ empEdName;
									educatFileAttachmentUpload(educationalPath,
											"");
								});

						$("#profAttachedFiles").change(
								function() {
									var professionalPath = empDetsName + "/"
											+ empProfName;
									profFileAttachmentUpload(professionalPath,
											"");
								});

						/* $('#educatAttachmentsGrid').dataTable({
							"bLengthChange" : true,
							"bInfo" : true,
							"paging": false,
							 bFilter: false,
							 "scrollY":100,
							 scrollCollapse: true,
						});
						
						$('#profAttachmentsGrid').dataTable({
							"bLengthChange" : true,
							"bInfo" : true,
							"paging": false,
							 bFilter: false,
							 scrollCollapse: true,
						}); */

						$('[data-toggle="tooltip"]').tooltip();
						var employeeId = $("#employeeId").val();
						var selectize = $("#empType").selectize()[0].selectize;
						var empMSselectize = $("#employeeMaritalStatus")
								.selectize()[0].selectize;

						if (employeeId == undefined || employeeId == ""
								|| employeeId == 0) {
							$("#employeeType").val(1);
							selectize.addItem(1);

							$("#employeeMailId").val("funwork@avantel.in");

							empMSselectize.clear();
						} else if (employeeId > 0) {
							selectize.disable();

							//package
							var gross = $("#hrEmployeePackageId\\.packageGross")
									.val();
							if (gross == null || gross == undefined)
								gross = 0;
							$("#grossSalary").val(gross);
						}

						bindPackageDetsTable();

						EMPLOYEE.callBootstrapValidator();
						EMPLOYEE.expDetailBootstrapValidator();
						EMPLOYEE.policyDetailBootstrapValidator();

						//$("#empType").selectize();
						EMPLOYEE.initializeAndValidateDatepickers();
						COMMON.loadDropDowns(pageContext
								+ "/secured/branch/getbranchjson",
								'#hrEmployeeBranchId\\.branchMasterId',
								'branchMasterId', 'branchMasterName',
								'#branchId');

						COMMON.loadDropDowns(pageContext
								+ "/secured/department/list/jsondropdown",
								'#hrDepartment\\.departmentId', 'departmentId',
								'departmentName', '#deptId');

						COMMON.loadDropDowns(pageContext
								+ "/secured/bank/jsondropdown",
								'#hrEmployeeBankId\\.bankId', 'bankId',
								'bankName', '#bankId');

						COMMON.loadDropDowns(pageContext
								+ "/secured/desgination/jsondropdown",
								'#designation\\.designationId',
								'designationId', 'designationName',
								'#designationId');

						COMMON.loadDropDowns(pageContext
								+ "/secured/iqamembers/empListJson",
								'#employeeReportingTo', 'employeeId',
								'employeeFullName', '#reportId');

						$("#employeeLeaveReccRequired[type='checkbox']").attr(
								'checked', 'checked');
						$('#employeeBloodGroup').selectize();
						$('#employeeGender').selectize();
						$('#employeeMaritalStatus').selectize();
						if ($('#employeeId').val() > 0) {
							$('#empcode').show();
						}

						var employeeId = $('#employeeId').val();
						if (employeeId > 0)
							showOrHideMarriageDate();

						$("#employeeMaritalStatus").change(function() {
							showOrHideMarriageDate();
						});

						$('#self')
								.change(
										function() {
											if ($('#self').is(':checked')) {
												var empName = "";
												var dob = $(
														'#employeeDateofBirth')
														.val();
												var empLastName = $(
														"#employeeLastName")
														.val();
												var empFirstName = $(
														"#employeeName").val();
												if (empFirstName.length > 0
														&& empLastName.length > 0)
													empName = empFirstName
															+ " " + empLastName;
												if (dob == "") {
													$('#self').attr('checked',
															false);
													bootbox
															.alert(
																	"Please Enter Date Of Birth",
																	function() {
																	});
													return;
												} else {
													$("#policyDetailName").val(
															empName);
													$('#policyDetailDOB').val(
															dob);
													$(
															"#policyDetailsRelationShip")
															.val("Self");
													$("#policyDetailAge")
															.val(0);

													var fromValidation = $(
															'#addPolicyDetailForm')
															.data(
																	'bootstrapValidator');
													fromValidation
															.updateStatus(
																	"policyDetailName",
																	'NOT_VALIDATED',
																	null)
															.validateField(
																	"policyDetailName");
													fromValidation
															.updateStatus(
																	"policyDetailDOB",
																	'NOT_VALIDATED',
																	null)
															.validateField(
																	"policyDetailDOB");
													fromValidation
															.updateStatus(
																	"policyDetailsRelationShip",
																	'NOT_VALIDATED',
																	null)
															.validateField(
																	"policyDetailsRelationShip");
													fromValidation
															.updateStatus(
																	"policyDetailAge",
																	'NOT_VALIDATED',
																	null)
															.validateField(
																	"policyDetailAge");
												}
											} else {
												$("#policyDetailName").val("");
												$('#policyDetailDOB').val("");
												$("#policyDetailsRelationShip")
														.val("");
											}

										});

						$("#empType")
								.change(
										function() {
											var empType = $("#empType").val();
											var employeeType = $(
													"#employeeType").val();
											//console.log("empType",empType);
											//console.log("employeeType",employeeType);

											var empPolicyTabLen = $("#EmpPolicyGrid >tbody >tr").length;
											if (empPolicyTabLen > 0) {
												bootbox
														.confirm(
																"Existing Policy Details Will be Cleared",
																function(result) {
																	if (result) {
																		$(
																				"#employeeType")
																				.val(
																						empType);
																		$(
																				"#EmpPolicyGrid >tbody")
																				.html(
																						"");
																		bootbox
																				.hideAll();
																	} else {
																		selectize
																				.addItem(employeeType);
																		bootbox
																				.hideAll();
																	}
																});
											} else {
												$("#employeeType").val(empType);
											}

										});

						$("#designation\\.designationId")
								.change(
										function() {
											var selDesgName = COMMON
													.getSelectizedText("#designation\\.designationId");
											$("#designation\\.designationName")
													.val(selDesgName);
										});

					});

	function educatFileAttachmentUpload(docName, docNum) {

		if ($("#educatAttachedFiles").val() == "") {
			bootbox.alert("Please Select file to Upload", function(result) {
				return;
			});
			return;
		}
		var file_size = $('#educatAttachedFiles')[0].files[0].size;
		var fileLimitSize = $("#fileLimitSize").val();
		var fileLimitSizeVal = COMMON.mbToBytes(fileLimitSize);
		if (file_size > fileLimitSizeVal) {
			bootbox.alert("File size should be less than or equal to "
					+ fileLimitSize + "MB", function(result) {
				return;
			});
			return;
		}
		jBlockUI();
		$
				.ajax({
					type : "POST",
					url : $("#educatFileAttachments").attr('action')
							+ "?docName=" + docName + "&docNum=" + docNum,
					data : new FormData($("#educatFileAttachments").get(0)),
					dataType : "json",
					contentType : false,
					processData : false,
					success : function(jsonObj) {
						console.log("jsonObj jsonObj jsonObj", jsonObj);
						if (!jQuery.isEmptyObject(jsonObj)) {
							var filesLength = jsonObj.files.length;
							var tableLen = getfloatVal($("#educatFilesSize")
									.val());
							if (filesLength > 0) {
								var td = "";
								td += "<tr><td><a style=\"cursor: pointer;\" onclick=\"viewEdAttachment('"
										+ jsonObj.files[0].name
										+ "');\">"
										+ jsonObj.files[0].name
										+ "</a>"
										+ "<input type='hidden' id='empEducationalMetaData"+tableLen+".deleteType' name='empEducationalMetaData["+tableLen+"].deleteType' value=\"F\" fwformfield=\"deleteType\"/> "
										+ "<input type='hidden' id='empEducationalMetaData"+tableLen+".name' name='empEducationalMetaData["+tableLen+"].name' value='"+jsonObj.files[0].name+"' /> "
										+ "<input type='hidden' id='empEducationalMetaData"+tableLen+".url' name='empEducationalMetaData["+tableLen+"].url' value='"+jsonObj.files[0].url+"' /> </td>";
								td += "<td><button type=\"button\" class=\"btn btn-default btn-xs\""
										+ " onclick=\"deleteEdFile(\'"
										+ jsonObj.files[0].name
										+ "\',this);\">"
										+ "<span class=\"glyphicon glyphicon-trash\"></span></button></td></tr>";
								$("#educatAttachmentsGrid >tbody").append(td);
							}
							$("#educatFilesSize").val(tableLen + 1);
							$("#educatAttachedFiles").val("");
						} else {
							$(
									"<p class='alert alert-danger'>Error Occurred. Please try again.</p>")
									.appendTo($("#educatFileAttachments"));
						}
						unBlockUI();
						bootbox.alert("Attachment Uploaded successfully",
								function(result) {
									return;
								});
					},
					error : function(jqXHR, textStatus, errorThrown) {
						$(
								"<p class='alert alert-danger'>" + errorThrown
										+ ". Please try again.</p>").appendTo(
								$("#educatFileAttachments"));
						unBlockUI();
					}
				});
	};

	function profFileAttachmentUpload(docName, docNum) {

		if ($("#profAttachedFiles").val() == "") {
			bootbox.alert("Please Select file to Upload", function(result) {
				return;
			});
			return;
		}
		var file_size = $('#profAttachedFiles')[0].files[0].size;
		var fileLimitSize = $("#fileLimitSize").val();
		var fileLimitSizeVal = COMMON.mbToBytes(fileLimitSize);

		if (file_size > fileLimitSizeVal) {
			bootbox.alert("File size should be less than or equal to "
					+ fileLimitSize + "MB", function(result) {
				return;
			});
			return;
		}
		jBlockUI();
		$
				.ajax({
					type : "POST",
					url : $("#profFileAttachments").attr('action')
							+ "?docName=" + docName + "&docNum=" + docNum,
					data : new FormData($("#profFileAttachments").get(0)),
					dataType : "json",
					contentType : false,
					processData : false,
					success : function(jsonObj) {
						console.log("jsonObj jsonObj jsonObj", jsonObj);
						if (!jQuery.isEmptyObject(jsonObj)) {
							var filesLength = jsonObj.files.length;
							var tableLen = getfloatVal($("#profFilesSize")
									.val());
							if (filesLength > 0) {
								var td = "";
								td += "<tr><td><a style=\"cursor: pointer;\" onclick=\"viewProfAttachment('"
										+ jsonObj.files[0].name
										+ "');\">"
										+ jsonObj.files[0].name
										+ "</a>"
										+ "<input type='hidden' id='empProfessionalMetaData"+tableLen+".deleteType' name='empProfessionalMetaData["+tableLen+"].deleteType' value=\"F\" fwformfield=\"deleteType\"/> "
										+ "<input type='hidden' id='empProfessionalMetaData"+tableLen+".name' name='empProfessionalMetaData["+tableLen+"].name' value='"+jsonObj.files[0].name+"' /> "
										+ "<input type='hidden' id='empProfessionalMetaData"+tableLen+".url' name='empProfessionalMetaData["+tableLen+"].url' value='"+jsonObj.files[0].url+"' /> </td>";
								td += "<td><button type=\"button\" class=\"btn btn-default btn-xs\""
										+ " onclick=\"deleteProfFile(\'"
										+ jsonObj.files[0].name
										+ "\',this);\">"
										+ "<span class=\"glyphicon glyphicon-trash\"></span></button></td></tr>";
								$("#profAttachmentsGrid >tbody").append(td);
							}
							$("#profFilesSize").val(tableLen + 1);
							$("#profAttachedFiles").val("");
						} else {
							$(
									"<p class='alert alert-danger'>Error Occurred. Please try again.</p>")
									.appendTo($("#profFileAttachments"));
						}
						unBlockUI();
						bootbox.alert("Attachment Uploaded successfully",
								function(result) {
									return;
								});
					},
					error : function(jqXHR, textStatus, errorThrown) {
						$(
								"<p class='alert alert-danger'>" + errorThrown
										+ ". Please try again.</p>").appendTo(
								$("#profFileAttachments"));
						unBlockUI();
					}
				});
	};

	function ajaxPhotoUpload() {

		var fileVal = $("#productFile").val();
		if (fileVal != "") {
			var ext = fileVal.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
				bootbox
						.alert(
								"Only '.gif','.png','.jpg','.jpeg' formats are allowed",
								function(result) {
									return;
								});
			} else {
				var progressBarData = "<div class=\"progress\">"
						+ "<div class=\"progress-bar progress-bar-striped active\" role=\"progressbar\" "
						+ "aria-valuenow=\"100\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 100%\">"
						+ "<span class=\"sr-only\">100% Complete</span></div></div>";
				$("#imageuploadProgress").html(progressBarData);

				$
						.ajax({
							type : "POST",
							url : pageContext + '/secured/employeeImageUpload',
							data : new FormData($("#productSpecUploadForm")
									.get(0)),
							dataType : "json",
							contentType : false,
							processData : false,
							success : function(jsonObj) {
								if (!jQuery.isEmptyObject(jsonObj)) {
									console.log("resposne json", jsonObj);
									var filesLength = jsonObj.files.length;
									//console.log("files length",jsonObj.files.length+"name$$"+jsonObj.files[0].name);
									if (filesLength > 0) {
										//var specName=jsonObj.files[0].name;
										//specName=specName.substring(15,specName.length);
										var photoURL = jsonObj.files[0].url;
										var photoBytesDataStr = jsonObj.files[0].encodedString;
										$("#employeePhotoURL").val(photoURL);
										var empMasterId = $("#employeeId")
												.val();
										if (empMasterId > 0) {
											$("#originalPic")
													.attr(
															"src",
															"data:image/jpeg;base64,"
																	+ photoBytesDataStr);
										} else {
											$("#empPic")
													.attr(
															"src",
															"data:image/jpeg;base64,"
																	+ photoBytesDataStr);
										}
									}
									//$("#productSpecUploadFormHolder").show();
								} else {
									console.log("empty object");
								}
								$("#imageuploadProgress").html("");
								$('#photoModal').modal('hide');
								bootbox.alert("Photo Uploaded Successfully",
										function(result) {
											return;
										});
								//alert("Spec saved successfully");
							},
							error : function(jqXHR, textStatus, errorThrown) {
								$("#imageuploadProgress").html("");
								//$("#productSpecUploadFormHolder").show();
								$(
										"<p class='alert alert-danger'>"
												+ errorThrown
												+ ". Please try again.</p>")
										.appendTo($("#productSpecUploadForm"));
							}
						});
			}
		} else {
			bootbox.alert("Please Select Image to Upload", function(result) {
				return;
			});
		}
	};

	function ajaxSignatureUpload() {

		var fileVal = $("#signatureFile").val();
		if (fileVal != "") {
			var ext = fileVal.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
				bootbox
						.alert(
								"Only '.gif','.png','.jpg','.jpeg' formats are allowed",
								function(result) {
									return;
								});
			} else {
				var progressBarData = "<div class=\"progress\">"
						+ "<div class=\"progress-bar progress-bar-striped active\" role=\"progressbar\" "
						+ "aria-valuenow=\"100\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 100%\">"
						+ "<span class=\"sr-only\">100% Complete</span></div></div>";
				$("#signatureUploadProgress").html(progressBarData);

				$
						.ajax({
							type : "POST",
							url : pageContext
									+ '/secured/employeeSignatureUpload',
							data : new FormData($("#signatureUploadForm")
									.get(0)),
							dataType : "json",
							contentType : false,
							processData : false,
							success : function(jsonObj) {
								if (!jQuery.isEmptyObject(jsonObj)) {
									console.log("resposne json", jsonObj);
									var filesLength = jsonObj.files.length;
									//console.log("files length",jsonObj.files.length+"name$$"+jsonObj.files[0].name);
									if (filesLength > 0) {
										//var specName=jsonObj.files[0].name;
										//specName=specName.substring(15,specName.length);
										var signatureURL = jsonObj.files[0].url;
										var signatureBytesDataStr = jsonObj.files[0].encodedString;
										$("#employeeSignatureURL").val(
												signatureURL);

										var empMastId = $("#employeeId").val();
										if (empMastId > 0) {
											$("#originalSignature")
													.attr(
															"src",
															"data:image/jpeg;base64,"
																	+ signatureBytesDataStr);
										} else {
											$("#signaturePic")
													.attr(
															"src",
															"data:image/jpeg;base64,"
																	+ signatureBytesDataStr);
										}

									}
									//$("#productSpecUploadFormHolder").show();
								} else {
									console.log("empty object");
								}
								$("#signatureUploadProgress").html("");
								$('#signatureModal').modal('hide');
								bootbox.alert(
										"Signature Uploaded Successfully",
										function(result) {
											return;
										});
								//alert("Spec saved successfully");
							},
							error : function(jqXHR, textStatus, errorThrown) {
								$("#imageuploadProgress").html("");
								//$("#productSpecUploadFormHolder").show();
								$(
										"<p class='alert alert-danger'>"
												+ errorThrown
												+ ". Please try again.</p>")
										.appendTo($("#productSpecUploadForm"));
							}
						});
			}
		} else {
			bootbox.alert("Please Select Image to Upload", function(result) {
				return;
			});
		}
	};

	function showOrHideMarriageDate() {
		var employeeMaritalStatus = $("#employeeMaritalStatus").val();
		if (employeeMaritalStatus == "Married") {
			$("#marDate").show();
			$("#pfNomineeDiv").show();
			$("#spouseDiv").show();
		} else {
			$("#marDate").hide();
			$("#pfNomineeDiv").hide();
			$("#spouseDiv").hide();
		}
	}

	function openPackageListModal() {

		$('#packageListModal').modal({
			backdrop : 'static',
			keyboard : false,
			show : true
		});

	}
</script>
<script type="text/javascript">
	function getSalary(grossSalary, packageId) {

		$('#grossSalary').val(grossSalary);
		$('#hrEmployeePackageId\\.packageId').val(packageId);
		$('#packageListModal').modal('hide');

	}

	this.getSalaryDetails = function() {

		jBlockUI();
		$.ajax({
			url : pageContext + "/secured/package/getHRPackageList.action",
			type : "GET",
			dataType : "json",
			contentType : 'application/json',
			mimeType : 'application/json',
			success : function(salData) {
				//console.log("salData",salData);
				var salDataLen = salData.length;
				if (salDataLen > 0) {
					var dataTbl = $('#salDetsGrid').dataTable();
					dataTbl.fnClearTable();
					dataTbl.fnAddData(salData);

					openPackageListModal();
				}
				unBlockUI();
			},
			error : function(data, status, er) {
				console.log("error: ", data, " status: ", status, " er:", er);
				unBlockUI();
			}
		});

		/* $.getJSON(
						pageContext
								+ "/secured/salPackage/getPackageList.action",
						{},
						function(salPackageList) {
							
							var row = "";
							$("#searchEnquiryGrid >tbody").html("");
							for (var i = 0; i < salPackageList.length; i++) {
								
								
								var GrossSalary = salPackageList[i].packageBasic
										+ salPackageList[i].packageDA
										+ salPackageList[i].packageHRA
										+ salPackageList[i].packageCA
										+ salPackageList[i].packageOtherAllowance;

								row += "<tr>";
								row += "<td>" + i + 1 + "</td>";
								row += "<td><a href=\"javascript:void(0);\" onclick=\"getServiceEnquiry('"+ GrossSalary+ "','"+salPackageList[i].packageId+"');\">"
										+ GrossSalary
										+ "</a></td>";
								row += "<td>" + salPackageList[i].packageBasic
										+ "</td>";
								row += "<td>" + salPackageList[i].packageDA
										+ "</td>";
								row += "<td>" + salPackageList[i].packageHRA
										+ "</td>";
								row += "<td>" + salPackageList[i].packageCA
										+ "</td>";
								row += "<td>"
										+ salPackageList[i].packageOtherAllowance
										+ "</td>";
								row += "<td>"
										+ salPackageList[i].packageEmployerPF
										
										
								  row += "<td>"+salPackageList[i].packageEmployerESI +"</td>";  
								row += "</tr>";
								
								
							}
							$("#searchEnquiryGrid >tbody").html(row);

							openPackageListModal();
						}); */
	};
</script>
<script type="text/javascript">
	function openAddDocumentRegisterModal() {

		$("#employeeModel").find("input[type=text], textarea").val("");
		$('#addExpDetailForm').bootstrapValidator('resetForm', true);
		$("#currentrow").val("");
		$("#employeeModel").modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});

	};

	addDocumentToList = function() {
		var rowsCount = parseInt($("#hrEmpdetailsSize").val());
		var rowsCount = COMMON.addUpdateRowUtil(rowsCount, "currentrow",
				"prevExpGridRow", "addPreExpTemplate", "EmpPreExpGrid");
		$("#hrEmpdetailsSize").val(rowsCount);
		$(".dataTables_empty").hide();
		$("#producteditingrow").val("");
		var currentRowVal = $("#currentrow").val();

		$('#employeeModel').modal('hide');
	};

	this.openEditPrevExpModal = function(editBtn) {
		$('#addExpDetailForm').bootstrapValidator('resetForm', true);
		var tr = $(editBtn).closest('tr');
		var row = $(tr).attr("detailid");

		$("#currentrow").val(row);

		$("#producteditingrow").val(row);

		COMMON.editRowUtil(tr);

		$('#employeeModel').modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});

	};
</script>
<script type="text/javascript">
	function openAddPolicyModal() {

		var empType = $("#empType").val();
		if (empType != 1 && empType != 5) {
			bootbox.alert("Medical Policy Not Applicable", function() {
			});
			return;
		} else {
			$('#addPolicyDetailForm').bootstrapValidator('resetForm', true);
			$("#policyModel").find("input[type=text], textarea").val("");
			$("#currentrowpolicy").val("");
			$("#policyModel").modal({
				"backdrop" : "static",
				"keyboard" : false,
				"show" : true
			});
		}

	};

	addPolicyToList = function() {
		var rowsCount = parseInt($("#hrEmpPolicySize").val());

		var rowsCount = COMMON.addUpdateRowUtil(rowsCount, "currentrowpolicy",
				"policysGridRow", "addPolicyTemplate", "EmpPolicyGrid");

		$("#hrEmpPolicySize").val(rowsCount);
		$(".dataTables_empty").hide();
		$("#producteditingrow").val("");
		var currentRowVal = $("#currentrowpolicy").val();

		$('#policyModel').modal('hide');
	};

	this.openEditPolicyModal = function(editBtn) {
		$('#addPolicyDetailForm').bootstrapValidator('resetForm', true);
		var tr = $(editBtn).closest('tr');
		var row = $(tr).attr("detailid");

		$("#currentrowpolicy").val(row);

		$("#producteditingrow").val(row);

		COMMON.editRowUtil(tr);

		$('#policyModel').modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});

	};
	function sameAddr() {

		var permAddr1 = $('#employeePermanentAddress1').val();
		var permAddr2 = $('#employeePermanentAddress2').val();
		var permAddr3 = $('#employeePermanentAddress3').val();
		var permCity = $('#employeePermanentCity').val();
		var permState = $('#employeePermanentState').val();
		var permPinCode = $('#employeePermanentPincode').val();
		var permPhoneNo = $('#employeePermanentPhoneNo').val();

		if ($('#sameAddress').prop('checked') == true) {
			if (permAddr1 != "" || permAddr2 != "" || permAddr3 != ""
					|| permCity != "" || permState != "" || permPinCode != ""
					|| permPhoneNo != "") {
				bootbox
						.confirm(
								"Parmanent Address already Exist: Do you want to Replace?",
								function(result) {
									if (result) {
										$('#employeePermanentAddress1').val(
												$('#employeePresentAddress1')
														.val());
										$('#employeePermanentAddress2').val(
												$('#employeePresentAddress2')
														.val());
										$('#employeePermanentAddress3').val(
												$('#employeePresentAddress3')
														.val());
										$('#employeePermanentCity')
												.val(
														$(
																'#employeePresentCity')
																.val());
										$('#employeePermanentState').val(
												$('#employeePresentState')
														.val());
										$('#employeePermanentPincode').val(
												$('#employeePresentPincode')
														.val());
										$('#employeePermanentPhoneNo').val(
												$('#employeePresentPhoneNo')
														.val());

										var fromValidation = $(
												'#addEmployeeForm').data(
												'bootstrapValidator');
										fromValidation
												.updateStatus(
														"employeePermanentAddress1",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentAddress1");
										fromValidation
												.updateStatus(
														"employeePermanentAddress2",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentAddress2");
										fromValidation
												.updateStatus(
														"employeePermanentAddress3",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentAddress3");
										fromValidation
												.updateStatus(
														"employeePermanentCity",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentCity");
										fromValidation
												.updateStatus(
														"employeePermanentState",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentState");
										fromValidation
												.updateStatus(
														"employeePermanentPincode",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentPincode");
										fromValidation
												.updateStatus(
														"employeePermanentPhoneNo",
														'NOT_VALIDATED', null)
												.validateField(
														"employeePermanentPhoneNo");
										bootbox.hideAll();
									} else {
										bootbox.hideAll();
									}
								});
			} else {
				$('#employeePermanentAddress1').val(
						$('#employeePresentAddress1').val());
				$('#employeePermanentAddress2').val(
						$('#employeePresentAddress2').val());
				$('#employeePermanentAddress3').val(
						$('#employeePresentAddress3').val());
				$('#employeePermanentCity')
						.val($('#employeePresentCity').val());
				$('#employeePermanentState').val(
						$('#employeePresentState').val());
				$('#employeePermanentPincode').val(
						$('#employeePresentPincode').val());
				$('#employeePermanentPhoneNo').val(
						$('#employeePresentPhoneNo').val());

				var fromValidation = $('#addEmployeeForm').data(
						'bootstrapValidator');
				fromValidation.updateStatus("employeePermanentAddress1",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentAddress1");
				fromValidation.updateStatus("employeePermanentAddress2",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentAddress2");
				fromValidation.updateStatus("employeePermanentAddress3",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentAddress3");
				fromValidation.updateStatus("employeePermanentCity",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentCity");
				fromValidation.updateStatus("employeePermanentState",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentState");
				fromValidation.updateStatus("employeePermanentPincode",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentPincode");
				fromValidation.updateStatus("employeePermanentPhoneNo",
						'NOT_VALIDATED', null).validateField(
						"employeePermanentPhoneNo");
			}

		} else if ($('#sameAddress').prop('checked') == false) {
			$('#employeePermanentAddress1').val("");
			$('#employeePermanentAddress2').val("");
			$('#employeePermanentAddress3').val("");
			$('#employeePermanentCity').val("");
			$('#employeePermanentState').val("");
			$('#employeePermanentPincode').val("");
			$('#employeePermanentPhoneNo').val("");
		}

	};

	function getGroup() {

		var departmentParentId = $('#hrDepartment\\.departmentId').val();
		var row = "";
		var pageContext = '${pageContext.request.contextPath}';
		$
				.getJSON(
						pageContext
								+ "/secured/department/getDeptGroupListByDept?departmentParentId="
								+ departmentParentId, function(data) {
							var selectize = $(
									'#employeeDeptGroupId\\.departmentId')
									.selectize({
										plugins : [ 'remove_button' ],
										delimiter : ',',
										create : false
									})[0].selectize;

							selectize.addOption({
								value : "",
								text : "select Group Name"
							});
							var details = data;
							selectize.clearOptions();
							for (var i = 0; i < details.length; i++) {

								selectize.addOption({
									value : details[i].departmentId,
									text : details[i].departmentName
								});

							}
							selectize.addItem($('#groupId').val());

						});

	}

	function bindPackageDetsTable() {
		$('#salDetsGrid')
				.dataTable(
						{
							"bLengthChange" : true,
							"bInfo" : true,
							"order" : [ [ 1, 'desc' ] ],
							"iDisplayLength" : 5,
							"aoColumns" : [
									{
										"mDataProp" : "ctc",
										"mRender" : function(ctc, type, data) {
											return "<span style=\"display:none;\">"
													+ ctc + "</span>";
										},
										"visible" : false

									},
									{
										"mDataProp" : "packageGross",
										"mRender" : function(packageGross,
												type, data) {
											if (data.packageId != 'undefined'
													&& data.packageGross != 'undefined')
												return "<a style=\"cursor:pointer\" onclick=\"getSalary(\'"
														+ data.packageGross
														+ "\',\'"
														+ data.packageId
														+ "\');\">"
														+ data.packageGross
														+ "</a>";
										}

									},
									{
										"mDataProp" : "packageBasic",
										"mRender" : function(packageBasic,
												type, data) {
											return packageBasic;
										}

									},
									{
										"mDataProp" : "packageDA",
										"mRender" : function(packageDA, type,
												data) {
											return packageDA;
										}
									},
									{
										"mDataProp" : "packageHRA",
										"mRender" : function(packageHRA, type,
												data) {
											return packageHRA;
										}

									},
									{
										"mDataProp" : "packageCA",
										"mRender" : function(packageCA, type,
												data) {
											return packageCA;
										}

									},
									{
										"mDataProp" : "packageOtherAllowance",
										"mRender" : function(
												packageOtherAllowance, type,
												data) {
											return packageOtherAllowance;
										}

									},
									{
										"mDataProp" : "packageEmployerPFValue",
										"mRender" : function(
												packageEmployerPFValue, type,
												data) {
											return packageEmployerPFValue;
										}

									},
									{
										"mDataProp" : "packageEmployerESIValue",
										"mRender" : function(
												packageEmployerESIValue, type,
												data) {
											return packageEmployerESIValue;
										}

									}, {
										"mDataProp" : "ctc",
										"mRender" : function(ctc, type, data) {
											//var ctc=data.packageBasic+data.packageHRA+data.packageCA+data.packageDA+data.packageOtherAllowance+data.packageMedicalAllowance+data.packageEmployerPFValue+data.packageEmployerESIValue;	
											return ctc;
										}

									}

							]
						});
	}

	function getSuccessMsg() {
		var targetURL = pageContext + "/secured/employee/list";
		invokeAction(targetURL);
	}
	function openPhotoUploadModal() {
		$("#productFile").val("");
		$('#photoModal').modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});
	}

	function openSignatureUploadModal() {
		$("#signatureFile").val("");
		$('#signatureModal').modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});
	}

	function openEducatAttachModal() {
		$('#educatModal').modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});
	}

	function openProfAttachModal() {
		$('#profModal').modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true
		});
	}
</script>




 --%>