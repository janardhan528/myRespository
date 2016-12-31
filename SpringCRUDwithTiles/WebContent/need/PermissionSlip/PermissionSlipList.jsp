<%-- 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<div class="box">
	<div class="box-header">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="box-title">Permission Slip</h3>
			</div>
			<div class="col-sm-6">
				<button class="btn btn-primary btn-xs pull-right" id="addCO"  data-toggle="tooltip"
					data-original-title="Add  Permission" data-placement="left"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/permissionSlip/new.action')">
					&nbsp;<i class="fa  fa-plus"></i>&nbsp;</button>
			</div> 
		</div>
	</div>
	<div class="box-body">
		<div class="box-body table-responsive">
			<table class="table table-striped" id="permissinSlipListdt">
				<thead>
					<tr>
						
						<!-- <th style="width: 5%;">S.No.</th> -->
						<th style="width: 10;">Emp Code</th>
						<th style="width: 60%;">Employee Name</th>
						<th style="width: 20%;">Applied On</th>
						<th style="width: 5%;">Action</th>


					</tr>
				</thead>


				<tbody>
					<c:forEach items="${permissionsList}" var="permissinSlipVO" varStatus="loopCounter">
						<c:if test="${permissinSlipVO.permissionSlipId > 0}">
							<tr class="">
								<td><c:out value="${loopCounter.index+1}" /></td>
								<td><c:out value="${permissinSlipVO.permissionSlipEmpCodes.employeeCode}" /></td>
								<td><c:out value="${permissinSlipVO.permissionSlipEmpCodes.employeeFullName}" /></td>
								<td><fmt:formatDate value="${permissinSlipVO.appliedOn}"
										pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>

								<td>
									<span style="display:none;"><fmt:formatDate value="${permissinSlipVO.appliedOn}"
											pattern="YYYY/MM/dd" var="newdatevarH2" /> <c:out
											value="${newdatevarH2}" /></span>
									<fmt:formatDate value="${permissinSlipVO.appliedOn}"
											pattern="dd-MMM-YYYY" var="newdatevar1" /> <c:out
											value="${newdatevar1}" /></td>
								<td class="center">
									<button type="button" class="btn btn-default btn-xs" data-toggle="tooltip"
data-original-title="Edit  Permission" data-placement="left"
										onclick='invokeAction("<%=request.getContextPath()%>/secured/permissionSlip/edit.action?permissionSlipId=<c:out value='${permissinSlipVO.permissionSlipId}'/>")'>
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
		$('[data-toggle="tooltip"]').tooltip();
		$('#permissinSlipListdt').dataTable({
			"bLengthChange" : true,
			"bInfo" : true,
			"order" : [ [ 2, 'desc' ] ],
		});
	});
</script>
 --%>