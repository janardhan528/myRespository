<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<div class="box-header">
	<div class="row">
		<div class="col-sm-6">
			<h3 class="box-title">Holidays List</h3>

		</div>
	</div>
</div>
<div class="box">
	<div class="box-body">
		<form:form method="POST" action="save.action"
			commandName="holidaySummaryVO" id="addHolidayForm"
			name="addHolidayForm" data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled"
			class="form-horizontal">

			<br />
			<div class="row">
				<div class="form-group col-sm-5">
					<label for="docType" class="control-label col-sm-6"><spring:message
							code="" />Branch:</label>
					<spring:message code="mtrl.frn.ssDesc-error" var="frn_ssDesc" />
					<div class="col-sm-6">
						<form:select path="branchId" class="form-control selectized"
							placeholder="select" cssClass="form-control"
							data-bv-notempty="true" data-bv-notempty-message="${frn_ssDesc}">


						</form:select>
						<input type="hidden" id="selectedBranchId" />
					</div>
				</div>

				<div class="form-group col-sm-4">
					<label for="docType" class="control-label col-sm-6"><spring:message
							code="" />Year: </label>
					<spring:message code="mtrl.frn.ssDesc-error" var="frn_ssDesc" />
					<div class="col-sm-4">
						<form:select path="year" class="form-control selectized"
							placeholder="select" cssClass="form-control"
							data-bv-notempty="true" data-bv-notempty-message="${frn_ssDesc}">
							<form:option value="2013">2013</form:option>
							<form:option value="2014">2014</form:option>
							<form:option value="2015">2015</form:option>
							<form:option value="2016">2016</form:option>
							<form:option value="2017">2017</form:option>

						</form:select>

					</div>
				</div>

				<div class="form-group col-sm-2">
					<button type="button" class="btn btn-primary" value="save"
						onclick="Holidays.getHolidaysList('${pageContext.request.contextPath}');">GetList</button>
				</div>

				<a href="#"
					onclick="Holidays.getSundays('${pageContext.request.contextPath}')">Display
					Sundays</a>

			</div>

			<br />
			<div class="row">
				<div class="col-sm-offset-2 col-sm-8">
					<div class="box-body table-responsive"
						style=" max-height: 300px;">
						<table class="table table-striped" id="holidayGrid">
							<thead>
								<tr>
									<!-- <th>SlNo.</th> -->
									<th style="width: 15%;">Date</th>
									<th style="width: 10%;">Day</th>
									<th style="width: 25%;">Description</th>
									<th style="width: 7%;">Action</th>

								</tr>
							</thead>
							<c:set var="hrdetailsSize" value="0" />
							<c:set var="holidays" value="${holidaySummaryVO.holidays}" />
							<tbody>


								<c:forEach items="${holidays}" var="detail"
									varStatus="loopCounter">
									<c:set var="hrdetailsSize" value="${hrdetailsSize + 1}" />
									<tr id="productsGridRow${loopCounter.count}"
										detailid="${loopCounter.index}">
										<td><form:hidden path="holidays[${loopCounter.index}].sno"
										fwformfield="sno" /> <span
									id="holidays${loopCounter.index}.sno.txt">${loopCounter.index+1}</span></td>
										<td><form:hidden
												path="holidays[${loopCounter.index}].deleteIndicator"
												class="mainDeleteindicator" value="false" /> <form:hidden
												path="holidays[${loopCounter.index}].holidayId"
												fwformfield="holidayId" /> <form:hidden
												path="holidays[${loopCounter.index}].holidayBranch.branchMasterId"
												fwformfield="holidayBranch.branchMasterId" /> <form:hidden
												class="holidayDateClass"
												path="holidays[${loopCounter.index}].holidayDate"
												fwformfield="holidayDate" /> <span
											id="holidays${loopCounter.index}.holidayDate.txt"> <fmt:formatDate
													value="${detail.holidayDate}" pattern="DD-MMM-YYYY"
													var="newdatevar" />
										</span></td>


										<td><form:hidden
												path="holidays[${loopCounter.index}].holidayWeekDay"
												fwformfield="holidayWeekDay" /> <span
											id="holidays${loopCounter.index}.holidayWeekDay.txt">${detail.holidayWeekDay}</span></td>

										<td><form:hidden
												path="holidays[${loopCounter.index}].holidayDescription"
												fwformfield="holidayDescription" /> <span
											id="holidays${loopCounter.index}.holidayDescription.txt">${detail.holidayDescription}</span></td>




										<td class="center">
											<button type="button" class="btn btn-default btn-xs"
												onclick="Holidays.openEditHolidayModal(this);">
												<span class="glyphicon glyphicon-edit"></span>
											</button>&nbsp;
											<button type="button" class="btn btn-default btn-xs"
												onclick="COMMON.commondeleteRow(this,'holidays${loopCounter.index}\\.deleteIndicator');">
												<span class="glyphicon glyphicon-trash"></span>
											</button>
										</td>

									</tr>
								</c:forEach>

							</tbody>

						</table>
						<input type="hidden" id="hrdetailsSize" value="${hrdetailsSize}" />
					</div>
					<br />
					<div align="">

						<button type="button" class="btn btn-primary btn-xs"
							data-toggle="tooltip" data-original-title="Add"
							data-placement="right" onclick="Holidays.openHoliday();">
							&nbsp;<i class="fa  fa-plus"></i>&nbsp;
						</button>
					</div>
				</div>
			</div>
			<br />
			<br />

			<br />
			<br />
			<div class="form-group text-center">
				<br /> <br />
				<button type="submit" class="btn btn-primary" value="save"
					onclick="javascript:return Holidays.CheckLineItemExist();">Save</button>
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/holidays/list.action')">Cancel</button>

			</div>

		</form:form>
		<div class="modal fade bs-example-modal-lg" id="holidayModel"
			tabindex="0" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							id="documentchildClose" aria-hidden="true">&times;</button>
						<h4 class="modal-title text-center">Add Days</h4>
					</div>
					<div class="modal-body">

						<form:form method="POST" commandName="holidaysVO"
							id="addHolidayDetailForm" name="addHolidayDetailForm"
							data-bv-message="This value is not valid"
							data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
							data-bv-submitbuttons='button[type="submit"]'
							data-bv-live="enabled" class="form-horizontal">


							<div class="form-group ">
								<label for="WorkReportDate " class="control-label col-sm-4"><spring:message
										code="" />Date :</label>

								<div class="col-sm-6">
									<div class="input-group date" id="datetimepicker1"
										data-date-format="DD-MMM-YYYY">
										<form:input path="holidayDate" value=""
											cssClass="form-control" readonly="true"
											placeholder="DD-MMM-YYYY" data-bv-notempty="true"
											data-bv-notempty-message="Date is required" />
										<span class="input-group-addon"><span
											class="glyphicon-calendar glyphicon"></span> </span>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label for="inputName" class="control-label col-sm-4"><spring:message
										code="" />Day: </label>


								<div class="col-sm-6">
									<form:input path="holidayWeekDay" value=""
										cssClass="form-control" placeholder="" data-bv-notempty="true"
										data-bv-notempty-message="Day is required" />

								</div>
							</div>


							<div class="form-group">
								<label for="inputName" class="control-label col-sm-4"><spring:message
										code="" />Description: </label>

								<div class="col-sm-6">
									<form:input path="holidayDescription" value=""
										cssClass="form-control" placeholder="" data-bv-notempty="true"
										data-bv-notempty-message="description is required" />
								</div>
							</div>

							<div align="center">
								<span id="holidaySpan"></span>
							</div>

							<div class="form-group text-center">
								<button type="submit" class="btn btn-primary">Save
									changes</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>

							</div>


						</form:form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>

		</div>
	</div>
</div>
<table style="display: none;">
	<tr detailid="0" id="addHolidayTemplate" class="odd">

		<!-- <td><input type="hidden" value="" name="holidays[-id-].sno"
			id="holidays-id-.sno" fwformfield="sno"> <span
			id="holidays-id-.sno.txt"></span></td> -->
		<td><input type="hidden" name="holidays[-id-].deleteIndicator"
			class="mainDeleteindicator" id="holidays-id-.deleteIndicator"
			value="false" /> <input type="hidden" value=""
			name="holidays[-id-].holidayId" id="holidays-id-.holidayId" /><input
			type="hidden" value=""
			name="holidays[-id-].holidayBranch.branchMasterId"
			id="holidays-id-.holidayBranch.branchMasterId"
			fwformfield="holidayBranch.branchMasterId"> <input
			type="hidden" value="" name="holidays[-id-].holidayDate"
			class="holidayDateClass" id="holidays-id-.holidayDate"
			fwformfield="holidayDate"> <span
			id="holidays-id-.holidayDate.txt"></span></td>

		<td><input type="hidden" value=""
			name="holidays[-id-].holidayWeekDay" id="holidays-id-.holidayWeekDay"
			fwformfield="holidayWeekDay"> <span
			id="holidays-id-.holidayWeekDay.txt"></span></td>

		<td><input type="hidden" value=""
			name="holidays[-id-].holidayDescription"
			id="holidays-id-.holidayDescription" fwformfield="holidayDescription">
			<span id="holidays-id-.holidayDescription.txt"></span></td>




		<td class="center">
			<button type="button" class="btn btn-default btn-xs"
				onclick="Holidays.openEditHolidayModal(this);">
				<span class="glyphicon glyphicon-edit"></span>
			</button>&nbsp;
			<button type="button" class="btn btn-default btn-xs"
				onclick="COMMON.commondeleteRow(this,'holidays-id-\\.deleteIndicator');">
				<span class="glyphicon glyphicon-trash"></span>
			</button>
		</td>


	</tr>
</table>
<input type="hidden" id="currentrow" value="" />
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


<script type="text/javascript"
	src="<c:url value='/resources/js/HR/funwork-holidays.js'/>"></script>
<script type="text/javascript"
	src="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>
<script>
	var pageContext = '${pageContext.request.contextPath}';

	$(document).ready(
			function() {
				$('[data-toggle="tooltip"]').tooltip();
				COMMON.loadDropDowns(pageContext
						+ "/secured/branch/getbranchjson", '#branchId',
						'branchMasterId', 'branchMasterName',
						'#selectedBranchId');
				Holidays.initializeAndValidateDatepicker();
				Holidays.callBootstrapValidator();
				$('#year').selectize();

			});
</script>
 --%>