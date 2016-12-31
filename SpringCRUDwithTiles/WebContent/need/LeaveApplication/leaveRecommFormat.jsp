<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="com.avantel.funwork4.common.context.UserContext"%>



<div class="openerp  oe_form_container">
	<div class="oe_application oe_form">
		<div class=" oe_form_sheetbg">

			<div class="oe_form_sheet oe_form_sheet_width">
				<div align="center">
					<h3>
						<label class="oe_form_label oe_align_center"> Leave
							Application</label>

					</h3>
				</div>
				<table class="oe_form_group " cellspacing="0" cellpadding="0"
					border="0">
					<tbody>
						<tr class="oe_form_group_row">
							<td class="oe_form_group_cell" width="50%" colspan="1">
								<table class="oe_form_group " cellspacing="0" cellpadding="0"
									border="0">
									<tbody>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label oe_align_right"
												for="oe-field-input-17"> Employee Name</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppEmp.employeeFullName} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-20" data-original-title="" title="">
													Applied on</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													<fmt:formatDate value="${leaveAppVO.appliedOn}"
														pattern="dd-MMM-yyyy" var="newdatevar" />
													<c:out value="${newdatevar}" />
											</span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-20" data-original-title="" title="">
													Designation</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppDesg.designationName} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-20" data-original-title="" title="">Department</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppDept.departmentName} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-20" data-original-title="" title="">From
													Date</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppFromDate} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-20" data-original-title="" title="">To
													Date</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppToDate} </span>
											</td>
										</tr>

										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-20" data-original-title="" title="">No
													of Days</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppNoofDays} </span>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td class="oe_form_group_cell oe_group_right" width="50%"
								colspan="1">
								<table class="oe_form_group " cellspacing="0" cellpadding="0"
									border="0">
									<tbody>

										<label class=" oe_form_label oe_align_right"
											for="oe-field-input-21"> Available Leaves</label>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label oe_align_right"
												for="oe-field-input-21"> CL</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_datepicker_root oe_form_field_datetime oe_form_required">${leaveAppVO.rmaMasterCustomerName}</span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-22" data-original-title="" title="">
													EL</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${rmaMaster.rmaMasterCustomerCity} </span>
											</td>
										</tr>

										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-22" data-original-title="" title="">
													Purpose</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppPurpose} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-22" data-original-title="" title="">
													Back on Duty</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppBackonDuty} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label_help oe_align_right"
												for="oe-field-input-22" data-original-title="" title="">
													Address on Leave</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${leaveAppVO.leaveAppAddress} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
															<td class="oe_form_group_cell oe_form_group_cell_label"
																width="1%" colspan="1"><label
																class=" oe_form_label_help oe_align_right"
																for="oe-field-input-22" data-original-title="" title="">
																	Recommended Remarks</label></td>
															<td class="oe_form_group_cell" width="99%" colspan="1">
																<span
																class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
																	${leaveAppVO.recommendedRemarks} </span>
															</td>
														</tr>
														<tr class="oe_form_group_row">
															<td class="oe_form_group_cell oe_form_group_cell_label"
																width="1%" colspan="1"><label
																class=" oe_form_label_help oe_align_right"
																for="oe-field-input-22" data-original-title="" title="">
																		Recommended By</label></td>
															<td class="oe_form_group_cell" width="99%" colspan="1">
																<span
																class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
																	${leaveAppVO.recommendedBy} </span>
															</td>
														</tr>
														
														<tr class="oe_form_group_row">
															<td class="oe_form_group_cell oe_form_group_cell_label"
																width="1%" colspan="1"><label
																class=" oe_form_label_help oe_align_right"
																for="oe-field-input-20" data-original-title="" title="">Date</label></td>
															<td class="oe_form_group_cell" width="99%" colspan="1">
																<span
																class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
																	${leaveAppVO.recommendedDate} </span>
															</td>
														</tr>

									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>

			</div>

		</div>
	</div>
</div>
<spring:message code='FUNWORK.FunworkStaticIP' var="staticURL_mainTemplate"/>
<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticURL_mainTemplate" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>
<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/page.css" rel="stylesheet" />

<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/table.css" rel="stylesheet" />
<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/treeview/jquery.treeview.css" rel="stylesheet" />
<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/themes/oe/css/base.css" rel="stylesheet" />
 --%>