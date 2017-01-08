<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<link href="<c:url value='/resources/funwork-template/datatable/page.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/funwork-template/datatable/table.css'  />" rel="stylesheet" />
<link href="<c:url value='/resources/css/jquery.treeview.css'  />" rel="stylesheet" />
<div class="box-header">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="box-title">Change Password</h3>
			</div>
		</div>
	</div>
<div class="box">
	<div class="box-body">
		<form:form method="POST" action="save.action" commandName="password"
			id="addCOForm" name="addCOForm"
			data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled"
			cssClass="form-horizontal">


			<div class="row">
			<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-6">
					<label for="inputName" class="control-label col-sm-4">User
						Id:</label>
					<div class="form-group col-sm-8">
						<form:input path="userId" value="" cssClass="form-control"
							placeholder="" data-bv-notempty="true" readonly="true"/>
					</div>
				</div>
			</div>
			<div class="row">
			<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-6">
					<label for="inputName" class="control-label col-sm-4">User
						Name:</label>
					<div class="form-group col-sm-8">
						<form:input path="userName" value="" cssClass="form-control"
							placeholder="" data-bv-notempty="true" readonly="true"/>
					</div>
				</div>
			</div>

			<div class="row">
			<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-6">
					<label for="inputName" class="control-label col-sm-4">Old
						Password:</label>
					<div class="form-group col-sm-8">
						<form:password  path="userPassword" value=""
							cssClass="form-control" placeholder="" data-bv-notempty="true" 
							data-bv-notempty-message="Old  Password is required" onblur="checkPassword()"/>
							<form:hidden path="oldPassword"/>
					</div>
				</div>
			</div>
			<div class="row">
			<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-6">
					<label for="inputName" class="control-label col-sm-4">New
						Password:</label>
					<div class="form-group col-sm-8">
						<form:password  path="newPassword"  value=""
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" />
							 
					</div>
					
				&nbsp;	<span class="glyphicon glyphicon-lock"></span>
					
				</div>
			</div>

			<div class="row">
			<div class="form-group col-sm-3"></div>
				<div class="form-group col-sm-6">
					<label for="inputName" class="control-label col-sm-4">Confirm
						Password:</label>
					<div class="form-group col-sm-8">
						<form:password  path="confirmPassword" value=""
							cssClass="form-control" placeholder="" data-bv-notempty="true"
							data-bv-notempty-message="" />
					</div>
				</div>
			</div>

			<div class="form-group text-center">
				<br /> <br />
				<button type="submit" class="btn btn-primary">Save</button>
				<button type="button" class="btn btn-primary"
					onclick="invokeAction('<%=request.getContextPath()%>/secured/password')">
					Cancel</button>
			</div>
		</form:form>
	</div>
</div>
<script type="text/javascript"
	src="<c:url value='/resources/funwork-template/datatable/jquery.dataTables.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/funwork-template/treeview/jquery.treeview.js'/>"></script>
	<script type="text/javascript"
	src="<c:url value='/resources/js/General/funwork-password.js'/>"></script>
	

<script type="text/javascript" charset="utf-8">
 var pageContext = '${pageContext.request.contextPath}';
	$(document).ready(function() {
		 PASSWORD.callBootstrapValidator();
	}); 
	
	function checkPassword(){
	var userPassword=$("#userPassword").val();
	var oldPassword=$("#oldPassword").val();
	
	if(userPassword.indexOf('#') > -1)
		userPassword=userPassword.replace("#", "%23");
	
	//var uri = pageContext+"/secured/password/getEncPwd?enteredPwd="+userPassword;
	//var res = encodeURI(uri);
		
	$.ajax({
    	url : pageContext+"/secured/password/getEncPwd?enteredPwd="+userPassword,    
            type : 'get',
            //dataType : 'json',
            contentType : 'application/json',
            //mimeType : 'application/json',
            success : function(encPwd) {
            	if(encPwd != oldPassword)
            		{
            		bootbox.alert("Entered Old Password is Wrong", function() {
        			});
        			return;
            		}
            },
            error : function(data, status, er) {
                    console.log("json error: " + data + " status: " + status
                                    + " er:" + er);
            }
	    });
	}
	function getSuccessMsg()
	{
        // var targetURL=pageContext+"/secured/supplierenquiry/list";
        invokeAction(pageContext+"/j_spring_security_logout");
	}
</script>
