<%-- 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<div class="box-header">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="box-title">Permission Slip Approval List</h3>
			</div>
			
		</div>
	</div>
<div class="box">
	
	<div class="box-body">
	<input type="hidden" id="checkBoxValue" value="${checkBoxValue}" />
	<input type="checkbox"  id="type" onclick="getAllPermissions()"/>View Other Permission Slips
		<div class="box-body table-responsive">
			<table class="table table-striped" id="frnListdt">
				<thead>
					<tr>
						
						<th style="width: 05%;">S.No.</th>
						<th style="width: 15%;">Emp Code</th>
						<th style="width: 25%;">Employee Name</th>
						<th style="width: 10%;">Applied On</th>
						<th style="width: 10%;">From Time</th>
						<th style="width: 15%;">Approx. Time</th>
						<th style="width: 25%;">Req. Approval For</th>
						<th style="width: 15%;">No.of Permissions in month</th>
						<th style="width: 15%;">Action</th>


					</tr>
				</thead>


				<tbody>
					<c:forEach items="${permissionsList}" var="permissionVO" varStatus="loopCounter">
						<c:if test="${permissionVO.permissionSlipId > 0}">
							<tr class="">
								<td><c:out value="${loopCounter.index+1}" /></td>
								<td><c:out value="${permissionVO.permissionSlipEmpCodes.employeeCode}" /></td>
								<td><c:out value="${permissionVO.permissionSlipEmpCodes.employeeFullName}" /></td>
								<td><fmt:formatDate value="${permissionVO.appliedOn}"
										pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
										<td><fmt:formatDate value="${permissionVO.permissionSlipFromTime}"
										pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
								<td><c:out value="${permissionVO.approxTime}" /></td>
								
								<td><c:out value="${permissionVO.empName}" /></td>
								
								<td><c:out value="${permissionVO.permissionsCount }" /></td>

								<td class="center">
									<button type="button" class="btn btn-default btn-xs"
										onclick='invokeAction("<%=request.getContextPath()%>/secured/permissionSlip/editApproval.action?permissionSlipId=<c:out value='${permissionVO.permissionSlipId}'/>")'>
										<span class="glyphicon glyphicon-edit"></span>
									</button>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>


			</table>
		</div>
	</div>
</div>
<spring:message code='FUNWORK.FunworkStaticIP' var="staticURL_mainTemplate"/>
<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticURL_mainTemplate" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>
<!--  Script for Datatable on content page  -->
<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/page.css" rel="stylesheet" />

<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/table.css" rel="stylesheet" />

<script type="text/javascript" language="javascript" src="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#frnListdt').dataTable({
			"bLengthChange" : false,
			"bFilter" : true,
			"bPaginate" : true,
			"pagingType" : "full_numbers",
			"order" : [ [ 0, 'asc' ] ],
		});
		var checkBoxValue=$('#checkBoxValue').val();
		
		if(checkBoxValue==1)
			{
			$("#type").prop("checked", true);
			}else
				{
				$("#type").prop("checked", false);
				}
		
	});
	
	function getAllPermissions()
	{
		var type=0;
		if($('#type').is(':checked'))
			{
			type=1;
			
			}
		invokeAction(pageContext + "/secured/permissionSlip/approvalList?type="
				+ type);
	}
</script>
 --%>