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
			<h3 class="box-title">Leave/OD Application</h3>
		</div>

	</div>
</div>
<div class="box">

	<div class="box-body">
		<div class="row">
			<div class="form-group col-sm-12">
				<h4 class="box-title">Leave Recommendation List</h4>
				<div class="box box-info">
					<div class="box-body">
						<div class="box-body table-responsive">
							<table class="table table-bordered table-striped"
								id="leaveRecommendedList">
								<thead>
									<tr>

										<!-- <th style="width: 5%;">S.No.</th> -->
										<th style="width: 10%;">Emp Code</th>
										<th style="width: 50%;">Emp Name</th>
										<th style="width: 10%;">Leave From</th>
										<th style="width: 10%;">Leave To</th>
										<th style="width: 10%;">No. Of Days</th>
										<th style="width: 5%;">Action</th>


									</tr>
								</thead>


								<tbody>
									<c:forEach items="${leaveAppList}" var="leaveAppVO"
										varStatus="loopCounter">
										<c:if test="${leaveAppVO.leaveAppId > 0}">
											<c:if test="${leaveAppVO.leaveAppStatus==1}">
												<tr class="">
													<td><c:out value="${loopCounter.index+1}" /></td>
													<td><c:out
															value="${leaveAppVO.leaveAppEmp.employeeCode}" /></td>
													<td><c:out
															value="${leaveAppVO.leaveAppEmp.employeeFullName}" /></td>
													<td><fmt:formatDate value="${leaveAppVO.leaveAppFromDate}" pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
													<td><span style="display: none;"><fmt:formatDate
																value="${leaveAppVO.leaveAppFromDate}"
																pattern="YYYY/MM/dd" var="newdatevarH2" /> <c:out
																value="${newdatevarH2}" /></span> <fmt:formatDate
															value="${leaveAppVO.leaveAppFromDate}"
															pattern="dd-MMM-yyyy" var="newdatevar1" /> <c:out
															value="${newdatevar1}" /></td>
													<td><fmt:formatDate
															value="${leaveAppVO.leaveAppToDate}"
															pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
															value="${newdatevar}" /></td>

													<td><c:out value="${leaveAppVO.leaveAppNoofDays}" /></td>

													<td class="center">
														<button type="button" class="btn btn-default btn-xs"
															data-toggle="tooltip"
															data-original-title="Edit Leave Recommendation"
															data-placement="left"
															onclick='invokeAction("<%=request.getContextPath()%>/secured/leaveapp/editLeaveRecommendation.action?leaveappId=<c:out value='${leaveAppVO.leaveAppId}'/>")'>
															<span class="glyphicon glyphicon-edit"></span>
														</button>
													</td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</tbody>


							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="form-group col-sm-12">
				<h4 class="box-title">Leave Approval List</h4>
				<div class="box box-info">
					<div class="box-body">
						<div class="box-body table-responsive">
							<table class="table table-bordered table-striped"
								id="leaveApprovalList">
								<thead>
									<tr>

										<!-- <th style="width: 5%;">S.No.</th> -->
										<th style="width: 10%;">Emp Code</th>
										<th style="width: 50%;">Emp Name</th>
										<th style="width: 10%;">Leave From</th>
										<th style="width: 10%;">Leave To</th>
										<th style="width: 10%;">No. Of Days</th>
										<th style="width: 5%;">Action</th>


									</tr>
								</thead>


								<tbody>
									<c:forEach items="${leaveAppList}" var="leaveAppVO"
										varStatus="loopCounter">
										<c:if test="${leaveAppVO.leaveAppId > 0}">
											<c:if test="${leaveAppVO.leaveAppStatus==3}">
												<tr class="">
													<td><c:out value="${loopCounter.index+1}" /></td>
													<td><c:out
															value="${leaveAppVO.leaveAppEmp.employeeCode}" /></td>
													<td><c:out
															value="${leaveAppVO.leaveAppEmp.employeeFullName}" /></td>
													<td><fmt:formatDate value="${leaveAppVO.leaveAppFromDate}" pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
													<td><span style="display: none;"><fmt:formatDate
																value="${leaveAppVO.leaveAppFromDate}"
																pattern="YYYY/MM/dd" var="newdatevarH2" /> <c:out
																value="${newdatevarH2}" /></span> <fmt:formatDate
															value="${leaveAppVO.leaveAppFromDate}"
															pattern="dd-MMM-yyyy" var="newdatevar1" /> <c:out
															value="${newdatevar1}" /></td>
													<td><fmt:formatDate
															value="${leaveAppVO.leaveAppToDate}"
															pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
															value="${newdatevar}" /></td>

													<td><c:out value="${leaveAppVO.leaveAppNoofDays}" /></td>

													<td class="center">
														<button type="button" class="btn btn-default btn-xs"
															data-toggle="tooltip"
															data-original-title="Edit Leave Approval"
															data-placement="left"
															onclick='invokeAction("<%=request.getContextPath()%>/secured/leaveapp/editLeaveApproval.action?leaveappId=<c:out value='${leaveAppVO.leaveAppId}'/>")'>
															<span class="glyphicon glyphicon-edit"></span>
														</button>
													</td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</tbody>


							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="form-group col-sm-12">
				<h4 class="box-title">OD Recommendation List</h4>
				<div class="box box-info">
					<div class="box-body">
						<div class="box-body table-responsive">
							<table class="table table-bordered table-striped" id="odReccList">
								<thead>
									<tr>

										<!-- <th style="width: 5%;">S.No.</th> -->
										<th style="width: 10%;">Emp Code</th>
										<th style="width: 50%;">Emp Name</th>
										<th style="width: 10%;">OD From</th>
										<th style="width: 10%;">OD To</th>
										<th style="width: 10%;">No. Of Days</th>
										<th style="width: 5%;">Action</th>


									</tr>
								</thead>


								<tbody>
									<c:forEach items="${odList}" var="odAppVO"
										varStatus="loopCounter">
										<c:if test="${odAppVO.odApplicationId > 0}">
											<c:if test="${odAppVO.odApplicationStatus ==1 }">
												<tr class="">
													<td><c:out value="${loopCounter.index+1}" /></td>
													<td><c:out
															value="${odAppVO.odApplicationEmpCodes.employeeCode}" /></td>
													<td><c:out
															value="${odAppVO.odApplicationEmpCodes.employeeFullName}" /></td>
													<td><fmt:formatDate value="${odAppVO.odApplicationFromDate}" pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
													<td><span style="display: none;"><fmt:formatDate
																value="${odAppVO.odApplicationFromDate}"
																pattern="YYYY/MM/dd" var="newdatevarH2" /> <c:out
																value="${newdatevarH2}" /></span> <fmt:formatDate
															value="${odAppVO.odApplicationFromDate}"
															pattern="dd-MMM-yyyy" var="newdatevar1" /> <c:out
															value="${newdatevar1}" /></td>
													<td><fmt:formatDate
															value="${odAppVO.odApplicationToDate}"
															pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
															value="${newdatevar}" /></td>

													<td><c:out value="${odAppVO.odApplicationNoofDays}" /></td>

													<td class="center">
														<button type="button" class="btn btn-default btn-xs"
															data-toggle="tooltip"
															data-original-title="Edit OD Recommendation"
															data-placement="left"
															onclick='invokeAction("<%=request.getContextPath()%>/secured/odApp/editODRecommendation.action?odApplicationId=<c:out value='${odAppVO.odApplicationId}'/>")'>
															<span class="glyphicon glyphicon-edit"></span>
														</button>
													</td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</tbody>


							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="form-group col-sm-12">
				<h4 class="box-title">OD Approval List</h4>
				<div class="box box-info">
					<div class="box-body">
						<div class="box-body table-responsive">
							<table class="table table-bordered table-striped" id="odAppList">
								<thead>
									<tr>

										<!-- <th style="width: 5%;">S.No.</th> -->
										<th style="width: 10%;">Emp Code</th>
										<th style="width: 50%;">Emp Name</th>
										<th style="width: 10%;">OD From</th>
										<th style="width: 10%;">OD To</th>
										<th style="width: 10%;">No. Of Days</th>
										<th style="width: 5%;">Action</th>


									</tr>
								</thead>


								<tbody>
									<c:forEach items="${odList}" var="odAppVO"
										varStatus="loopCounter">
										<c:if test="${odAppVO.odApplicationId > 0}">
											<c:if test="${odAppVO.odApplicationStatus == 3}">
												<tr class="">
													<td><c:out value="${loopCounter.index+1}" /></td>
													<td><c:out
															value="${odAppVO.odApplicationEmpCodes.employeeCode}" /></td>
													<td><c:out
															value="${odAppVO.odApplicationEmpCodes.employeeFullName}" /></td>
													<td><fmt:formatDate value="${odAppVO.odApplicationFromDate}" pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
										value="${newdatevar}" /></td>
													<td><span style="display: none;"><fmt:formatDate
																value="${odAppVO.odApplicationFromDate}"
																pattern="YYYY/MM/dd" var="newdatevarH2" /> <c:out
																value="${newdatevarH2}" /></span> <fmt:formatDate
															value="${odAppVO.odApplicationFromDate}"
															pattern="dd-MMM-yyyy" var="newdatevar1" /> <c:out
															value="${newdatevar1}" /></td>
													<td><fmt:formatDate
															value="${odAppVO.odApplicationToDate}"
															pattern="dd-MMM-yyyy" var="newdatevar" /> <c:out
															value="${newdatevar}" /></td>

													<td><c:out value="${odAppVO.odApplicationNoofDays}" /></td>

													<td class="center">
														<button type="button" class="btn btn-default btn-xs"
															data-toggle="tooltip"
															data-original-title="Edit OD Approval"
															data-placement="left"
															onclick='invokeAction("<%=request.getContextPath()%>/secured/odApp/editODApproval.action?odApplicationId=<c:out value='${odAppVO.odApplicationId}'/>")'>
															<span class="glyphicon glyphicon-edit"></span>
														</button>
													</td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</tbody>


							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>
<!--  Script for Datatable on content page  -->
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

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$('#leaveRecommendedList').dataTable({
			"bLengthChange" : true,
			"bInfo" : true,
			"order" : [ [ 3, 'desc' ] ],
			"pagingType" : "full_numbers",
		});
		$('#leaveApprovalList').dataTable({
			"bLengthChange" : true,
			"bInfo" : true,
			"order" : [ [ 3, 'desc' ] ],
			"pagingType" : "full_numbers",
		});
		$('#odReccList').dataTable({
			"bLengthChange" : true,
			"bInfo" : true,
			"order" : [ [ 3, 'desc' ] ],
			"pagingType" : "full_numbers",
		});
		$('#odAppList').dataTable({
			"bLengthChange" : true,
			"bInfo" : true,
			"order" : [ [ 3, 'desc' ] ],
			"pagingType" : "full_numbers",
		});
	});
</script>
 --%>