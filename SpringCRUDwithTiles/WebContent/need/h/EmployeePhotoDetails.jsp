<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@page import="com.avantel.funwork4.common.context.UserContext"%> --%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<div class="panel60 panel-info">
	<div class="panel-heading">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="panel-title">Employee List</h3>
			</div>
			
		</div>
	</div>
	<div class="panel-body">
		<div class="dtable">
			<table cellpadding="0" cellspacing="0" border="0"
				class="display table table-bordered" id="empListdt">
				<thead>
					<tr>

						<th style="width:10%">Employee Code</th>
						<th style="width:20%">Employee Name</th>
						<th style="width:15%">Employee Department</th>
						<th style="width:15%">Designation</th>
						<th style="width:5%">Photo</th>

					</tr>
				</thead>

				<c:if test="${!empty employeelist}">
					<tbody>
						<c:forEach items="${employeelist}" var="employeelist">
							<c:if test="${employeelist.employeeId > 0}">
								<tr class="">



									<td><c:out value="${employeelist.employeeCode}" /></td>
									<td><c:out value="${employeelist.employeeName}" /></td>
									<td><c:out value="${employeelist.hrDepartment.departmentName}" /></td>
									<td><c:out value="${employeelist.designation.designationName}" /></td>
									<td class="center">
										<c:if test="${employeelist.empPhotoEncodedString ne null}">
										    <img src="data:image/jpeg;base64,${employeelist.empPhotoEncodedString}" alt="No Image"  
										    height="80" width="80"/>
										  </c:if>
									</td>


								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</c:if>

			</table>
		</div>
	</div>
</div>

<spring:message code='FUNWORK.FunworkStaticIP' var="staticURL_mainTemplate"/>
<%-- 
<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticURL_mainTemplate" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %> --%>
<link href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/page.css"	rel="stylesheet" />
<link href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/table.css"	rel="stylesheet" />
<script type="text/javascript" src="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>


<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$('#empListdt').dataTable({
			"bLengthChange" : true,
			"bInfo" : true,
		});
	});
</script>
