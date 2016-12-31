<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Leave Application List</title>
</head>
<body>
	<div class="box-header">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="box-title">Leave Application List</h3>
			</div>
			<div class="col-sm-6">
				<button class="btn btn-primary btn-xs pull-right" id="addleave"
					data-toggle="tooltip" data-original-title="Add  Leave"
					data-placement="left"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/leaveapp/leaveAppform.action')">
					&nbsp;<i class="fa  fa-plus"></i>&nbsp;
				</button>
			</div>
		</div>
	</div>
	<div class="box">

		<div class="box-body">
			<div class="box-body table-responsive">
				<table class="table table-striped" id="leaveListdt">
					<thead>
						<tr>
							<th width="10%">Employee Code</th>
							<th width="55%">Employee Name</th>
							<th width="10%">NO of Days</th>
							<th width="10%">From Date</th>
							<th width="10%">To Date</th>
							<th width="5%">Action</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${leaveAppList}" var="leaveAppVOList"
							varStatus="loopCounter">
							<tr>
								<td><c:out value="${loopCounter.index+1 }"/></td>
								<td><c:out
										value="${leaveAppVOList.leaveAppEmp.employeeCode }" /></td>
								<td><c:out
										value="${leaveAppVOList.leaveAppEmp.employeeName }" /></td>
								<td><c:out value="${leaveAppVOList.leaveAppNoofDays}" /></td>
								<td>
						<fmt:formatDate value="${leaveAppVOList.leaveAppFromDate }" pattern="dd-MMM-yyyy" var="newdatevar" />
						<c:out value="${newdatevar}" /></td>
								<td><span style="display: none;"><fmt:formatDate
											value="${leaveAppVOList.leaveAppFromDate}"
											pattern="YYYY/MM/dd" var="newdatevarH2" /> <c:out
											value="${newdatevarH2}" /></span> <fmt:formatDate
										value="${leaveAppVOList.leaveAppFromDate}"
										pattern="dd-MMM-YYYY" var="newdatevar1" /> <c:out
										value="${newdatevar1}" /></td>
								<td><fmt:formatDate
										value="${leaveAppVOList.leaveAppToDate }"
										pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
								<td class="center">
									<button type="button" class="btn btn-default btn-xs"
										data-toggle="tooltip" data-original-title="Edit  Leave"
										data-placement="left"
										onclick='invokeAction("<%=request.getContextPath()%>/secured/leaveapp/editLeaveApp.action?leaveappId=<c:out value='${leaveAppVOList.leaveAppId}'/>")'>
										<span class="glyphicon glyphicon-edit"></span>
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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
		href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/page.css"
		rel="stylesheet" />

	<link
		href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/table.css"
		rel="stylesheet" />

	<script type="text/javascript" language="javascript"
		src="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>

	<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
			$('[data-toggle="tooltip"]').tooltip();
			$('#leaveListdt').dataTable({
				"bLengthChange" : true,
				"bInfo" : true,
				"order" : [ [ 3, 'desc' ] ],
			});
		});
	</script>
</body>
</html> --%>