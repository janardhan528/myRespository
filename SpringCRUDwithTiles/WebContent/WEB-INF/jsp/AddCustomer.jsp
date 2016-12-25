<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.3/css/bootstrapValidator.min.css">


<script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.5/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/spin.js/2.3.2/spin.min.js"></script>

<div class="panel60 panel-info">
	<div class="panel-heading">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="panel-title">Customer Details</h3>

			</div>

		</div>
	</div>

<div class="panel-body">
<!-- add customer page 1-->

<c:url var="actionUrl" value="/saveOrUpdate" />

<form:form id="customerForm" name="customerForm" commandName="customerVOCommond" method="post"
	action="${actionUrl}" 
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]'  class="form-horizontal">


		<form:input path="customerId" type="hidden" />

		
		
				
		<div class="form-group">
			<label  class="control-label col-sm-3"  for="customerName">Customer Name</label>
			<div class="col-sm-6"><form:input path="customerName" cssClass="form-control" placeholder="name" data-bv-notempty="true"
						data-bv-notempty-message="Please enter name "/>
		</div></div>
		

		
		
	
				
		<div class="form-group">
			<label  class="control-label col-sm-3" for="customerAddress">Customer Address</label>
		<div class="col-sm-6">	<form:input path="customerAddress" cssClass="form-control"  placeholder="address" data-bv-notempty="true"
						data-bv-notempty-message="Please enter Address1 "/>
		</div></div>



			<div class="row">
				<div class="col-sm-offset-3 col-sm-4">
					<button type="submit" value="Submit" class="btn btn-primary">Submit
					</button>
					<a href="<c:url value='/listCustomers' />">Cancel</a>
					<button type="button" class="btn btn-primary" value="cancel"
						onclick="invokeAction('<%=request.getContextPath()%>/listCustomers.action')">Back</button>

				</div>
			</div>
			
		
		<button type="button" class="btn btn-primary" onclick="getCustomerList();"  id="custId">Show All Customer</button>
		
		
		</form:form>
		
	
	
	
	
	
	
	
	
	
		<!-- Data table filling  -->

<!-- pop up -->



		<div class="modal fade bs-example-modal-lg" id="customerListModelID" tabindex="0"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							id="documentchildClose" aria-hidden="true">&times;</button>

					</div>
					<div class="modal-body">

							<div class="row">
								<div class="col-sm-8">
									<div class="dtable" id="customerTable" style="min-height: 60px;">
										<table class="table table-striped table-bordered"
											id="customerListID">
											<thead>
												<tr>
													<th>S.no</th>
													<th>Name</th>
													<th>Address</th>
	
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
	
									</div>
								</div>
							</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>



	</div>
</div>

<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	
	callValidator();
	bindCustomerTable();
});

function callValidator()
{
		
		$('#customerForm').bootstrapValidator({
			live: 'enabled',
			message: 'This value is not valid',
		
				fields : {
					
				}
			});
		

}

function invokeAction(navigation){
	window.location.href=navigation;
}





 //json call       if you want to check this JSON call uncomment below function and  comment the ajax call function
 
/* function getCustomerList()
{
	
	var pageContext = '${pageContext.request.contextPath}';
	$.getJSON(pageContext + "/customersListJSON.action", {
	}, function(customerList) {
		var dataTbl = $('#customerListID').dataTable();
		if(customerList.length>0){			
			dataTbl.fnClearTable();
			dataTbl.fnAddData(customerList);
		}
	});
} */












function bindCustomerTable() {
	$('#customerListID').dataTable(
					
			{
			"aoColumns" : [
			               {
								"mDataProp" : "customerId",
								"mRender" : function(customerId, type,full) {
								return "<a href='#' onclick='getCustomer(this)'>"+customerId+"</a>"; 
									return customerId;
								}

						   },
			               {
								"mDataProp" : "customerName",
								"mRender" : function(customerName,type, full) {
								return customerName;
								}
							},
							{
								"mDataProp" : "customerAddress",
								"mRender" : function(customerAddress,type, full) {
									return customerAddress;
								}
							},
										

						],
						"paging" : false,
						"scrollY" : 200,
						"bFilter": false,
						"bSearchable":false,
						"bInfo":false,
						"bLength" : false,
						"bPaginate": false,
						"order" : [ [ 0, 'asc' ] ],
			});
}
 
 
 //ajax call
 function getCustomerList()
{
	
	 
	 
	 var opts = {
			  lines: 13, // The number of lines to draw
			  length: 10, // The length of each line
			  width: 8, // The line thickness
			  radius: 20, // The radius of the inner circle
			  corners: 1, // Corner roundness (0..1)
			  rotate: 0, // The rotation offset
			  direction: 1, // 1: clockwise, -1: counterclockwise
			  color: '#000', // #rgb or #rrggbb or array of colors
			  speed: 1, // Rounds per second
			  trail: 60, // Afterglow percentage
			  shadow: false, // Whether to render a shadow
			  hwaccel: false, // Whether to use hardware acceleration
			  className: 'spinner', // The CSS class to assign to the spinner
			  zIndex: 2e9, // The z-index (defaults to 2000000000)
			  top: '50%', // Top position relative to parent
			  left: '50%' // Left position relative to parent
			}; 
			
				
	
	var dataTbl = $('#customerListID').dataTable();
		
	dataTbl.fnClearTable();
	var pageContext = '${pageContext.request.contextPath}';
	
		var target = document.getElementById('customerTable'); 
		var spinner = new Spinner(opts).spin(target); 
		$.ajax({
			url : pageContext + "/customersListJSON.action",
			type : "GET",
			dataType : "json",
			//data : JSON.stringify(data),
			contentType : 'application/json',
			mimeType : 'application/json',
			
			success : function(data) {
				console.log("SUCCESS: ", data);
					var dataTbl = $('#customerListID').dataTable();
					dataTbl.fnClearTable();
					if (data.length > 0) {
						
						dataTbl.fnAddData(data);
					}
					else{
						dataTbl.fnClearTable();
					}
				spinner.stop();
				openCustomerListModel();
			},
			error : function(e) {
				console.log("ERROR: ", e);
				display(e);
			},
			done : function(e) {
				console.log("DONE");
			}
			
		});
} 
 
 this.openCustomerListModel=function() {

		$("#customerListModelID").find("input[type=text], textarea").val("");
		$("#currentrow").val("");
		$("#customerListModelID").modal({
			"backdrop" : "static",
			"keyboard" : false,
			"show" : true

		});

	};
	
	
	function getCustomer(customer)
	{
		
		$('#customerForm').bootstrapValidator('resetForm', true);
		
		var list=$("#customerListID").DataTable();			
	 	var trData=$(customer).parents("tr");	
	    var data = list.row(trData).data();	
	    
	    
		$("#customerName").val(data.customerName);	
		$("#customerAddress").val(data.customerAddress); 
		
		
		$('#customerListModelID').modal('hide');
	}
 </script>
