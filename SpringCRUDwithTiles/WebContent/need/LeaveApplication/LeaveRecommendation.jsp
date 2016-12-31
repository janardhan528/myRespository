<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>


	<div class="panel panel-info">
	<div class="panel-heading">
		<h3 class="panel-title">
		Leave Recommendation
		</h3>
	</div>
	<div class="panel-body">
	
	<jsp:include page="../../Marketing/Reports/LeaveFormat.jsp"></jsp:include> 
	<form:form method="post" action="leaveRecommendation.action" commandName="leaveAppVO" id="leaveApprovlaform" name="leaveApprovlaform" data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh" data-bv-submitbuttons='button[type="submit"]'
			 class="form-horizontal"  data-bv-live="enabled">
			<form:hidden path="leaveAppId"/>
				
				<div class="form-group text-center">
			
		
				<div class="form-group ">
					
					<label for="" class="control-label col-sm-offset-1  col-sm-2">Recommended Remarks</label>
					<div class="col-sm-8" id="">
						<form:textarea path="recommendedRemarks" cssClass="form-control" data-bv-notempty="true" data-bv-notempty-message="" />
					</div>
				</div>
			

	
				<div class="form-group ">
					 <label> <form:radiobutton path="leaveAppStatus" value="3" checked="true" />Recommended&nbsp;</label> 
					 <label> <form:radiobutton path="leaveAppStatus" value="2" />Not Recommended&nbsp;</label> 
					 
			
			</div>
			</div>
			
			<div class="form-group text-center">
				<button type="submit" value="addpo" id="addpobtn"
					class="btn btn-primary">Save</button>
				<c:if test="${moduleid!=18}">
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/leaveapp/leaveApprovalList')">Cancel</button>
					</c:if>
				<c:if test="${moduleid==18}">
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/leaveapp/leaveRecForUserAdmin?type=1')">Cancel</button>
					</c:if>
			</div>
	</form:form>
	</div>
	</div>
	<spring:message code='FUNWORK.FunworkStaticIP' var="staticURL_mainTemplate"/>
<% if (session.getAttribute("userContextVO") != null) { %>
	<c:set var="staticURL_mainTemplate" value="<%= ((UserContext) session.getAttribute(\"userContextVO\")).getStaticURL() %>" />
<% } %>
	<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/page.css" rel="stylesheet" />

<link href="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/table.css" rel="stylesheet" />

<script type="text/javascript" language="javascript" src="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>
	
	<script type="text/javascript"
	src="<c:url value='/resources/js/HR/funwork-leaveapplication.js'/>"></script>

<script>
	var pageContext = '${pageContext.request.contextPath}';

	$(document).ready(function() {

						LeaveApplication.callBootstrapValidator();
						
						});
	</script> --%>