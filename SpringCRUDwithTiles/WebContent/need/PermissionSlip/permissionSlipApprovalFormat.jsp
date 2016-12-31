<%-- <%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<spring:message code='FUNWORK.FunworkStaticIP' var="staticSiteURL_mainTemplates"/>

<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticSiteURL_mainTemplates" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>


<link href="http://<c:out value="${staticSiteURL_mainTemplates}" />/resources/funwork-template/datatable/page.css" rel="stylesheet" />
<link href="http://<c:out value="${staticSiteURL_mainTemplates}" />/resources/funwork-template/datatable/table.css" rel="stylesheet" />
<link href="http://<c:out value="${staticSiteURL_mainTemplates}" />/resources/funwork-template/treeview/jquery.treeview.css" rel="stylesheet" />
<link href="http://<c:out value="${staticSiteURL_mainTemplates}" />/resources/funwork-template/themes/oe/css/base.css" rel="stylesheet" />


<div class="openerp  oe_form_container">
	<div class="oe_application oe_form">
		<div class=" oe_form_sheetbg">

			<div class="oe_form_sheet oe_form_sheet_width">
				<div align="center">
					<h3>
						<label class="oe_form_label oe_align_center"> Permission Slip
							</label>

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
													${permissionSlipVO.permissionSlipEmpCodes.employeeName} </span>
											</td>
										</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label oe_align_right"
												for="oe-field-input-17"> Employee Code</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${permissionSlipVO.permissionSlipEmpCodes.employeeCode} </span>
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
													${permissionSlipVO.permissionSlipDept.departmentName} </span>
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
													${permissionSlipVO.permissionSlipPurpose} </span>
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
													<fmt:formatDate
														value="${permissionSlipVO.appliedOn}"
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
													Time</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													<fmt:formatDate
														value="${permissionSlipVO.permissionSlipFromTime}"
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
													Time</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													<fmt:formatDate
														value="${permissionSlipVO.approxTime}"
														pattern="dd-MMM-yyyy" var="newdatevar" />
													<c:out value="${permissionSlipVO.approxTime}" />
											</span>
											</td>
									</tr>
										<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label oe_align_right"
												for="oe-field-input-17"> Employee Name</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${permissionSlipVO.permissionSlipEmpCodes.employeeFullName} </span>
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


									<tr class="oe_form_group_row">
											<td class="oe_form_group_cell oe_form_group_cell_label"
												width="1%" colspan="1"><label
												class=" oe_form_label oe_align_right"
												for="oe-field-input-17"> Authorised By:</label></td>
											<td class="oe_form_group_cell" width="99%" colspan="1">
												<span
												class="oe_form_field oe_form_field_many2one oe_form_field_with_button oe_form_required">
													${permissionSlipVO.permissionSlipReqApprovalFor} </span>
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
 --%>