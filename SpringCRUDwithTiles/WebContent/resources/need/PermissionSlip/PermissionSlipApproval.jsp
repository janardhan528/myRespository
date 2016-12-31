<%-- <%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


	<div class="box-header">
		<h3 class="box-title">
		Permission Slip Approval
		</h3>
	</div>
	<div class="box">
	
	<div class="box-body">
	
	<jsp:include page="../../Marketing/Reports/PermissionFormat.jsp"></jsp:include> 
	<form:form method="post" action="updatePermissionApproval.action" commandName="permissionSlipVO" id="permissionSlipApprovlaform" name="permissionSlipApprovlaform" data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh" data-bv-submitbuttons='button[type="submit"]'
			 class="form-horizontal"  data-bv-live="enabled">
			
				<form:hidden path="permissionSlipEmpCodes.employeeId"/>
				<form:hidden path="permissionSlipId"/>
				<form:hidden path="urgentApproval"/>
				<form:hidden path="permissionSlipFromTime" />
				<form:hidden path="permissionsCount" />
				<div class="form-group text-center">
			
		
				<div class="form-group ">
					
					<label for="" class="control-label col-sm-offset-1  col-sm-2">Approval Remarks</label>
					<div class="col-sm-8" id="">
						<form:textarea path="approvalRemarks" cssClass="form-control" data-bv-notempty="true" data-bv-notempty-message="" />
					</div>
				</div>
			

	
				<div class="form-group ">
					 <label> <form:radiobutton path="permissionSlipStatus" value="2" checked="true" />Approved&nbsp;</label> 
					 <label> <form:radiobutton path="permissionSlipStatus" value="0" />Not Approved&nbsp;</label> 
					 
			
			</div>
			</div>
			
			<div class="form-group text-center">
				<button type="submit" value="addpo" id="addpobtn" onclick="javascript:return PermissionSlip.CheckPermission();"
					class="btn btn-primary">Save</button>
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/permissionSlip/approvalList?type=0')">Cancel</button>

			</div>
	</form:form>
	</div>
	</div>
	<script type="text/javascript"
	src="<c:url value='/resources/js/HR/funwork-permissionSlip.js'/>"></script>
<spring:message code='FUNWORK.FunworkStaticIP' var="staticURL_mainTemplate"/>

<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticURL_mainTemplate" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>
<link href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/page.css"	rel="stylesheet" />
<link href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/table.css"	rel="stylesheet" />
<script type="text/javascript" src="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>


<script>
	var pageContext = '${pageContext.request.contextPath}';

	$(document).ready(function() {

		PermissionSlip.callBootstrapValidator();
						});
	
	
	</script> --%>