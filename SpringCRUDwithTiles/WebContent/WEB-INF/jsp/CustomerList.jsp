<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css">
<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>

    

<div class="panel60 panel-info">
	<div class="panel-heading">
		<div class="row">
			<div class="col-sm-10">
				<h3 class="panel-title">Customer Details</h3>

			</div>
			<div class="col-sm-2">
			<a href="../SpringCRUDwithTiles/addCustomerPage">Add Customer</a>

			</div>

		</div>
	</div>

<div class="panel-body">
	<div class="dtable">
		<table class="table table-striped table-bordered"  id="customerList">
			<thead>
				<tr>
					<th>S.no</th>
					<th>Name</th>
					<th>Address</th>	
					<th></th>	
					<th></th>					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${customerVOList}" var="customer" varStatus="loopCounter">
					<tr>
						<td><c:out value="${loopCounter.count}" /></td>
						<td><c:out value="${customer.customerName}" /></td>
						<td><c:out value="${customer.customerAddress}" /></td>					
						<td>
						<a href="<c:url value='/edit/${customer.customerId}' />" >Edit</a></td>
						<td>
						<a href="<c:url value='/delete/${customer.customerId}' />" >Delete</a></td>
					</tr>
				</c:forEach>
				
				
			</tbody>
		</table>
		</div>
		
			

	</div>
	</div>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#customerList').dataTable( {
			"bLengthChange": true,
			"bInfo": true,
		} );
	} );
</script>   