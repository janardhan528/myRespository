var PermissionSlip = new function() {
	
	
	this.initializeAndValidateDatepicker = function() {
		
		$('#datetimepicker1').datetimepicker({
			format: 'DD-MMM-YYYY HH:mm',
			pickTime : true,
			dateFormat : 'DD-MMM-YYYY HH:mm'
		});

		$('#datetimepicker1').on('dp.change dp.show', function(e) {
			var date_fld = $(e.currentTarget.children[0]).attr('name');
			// Validate the date when user change it
			$('#permissionForm')
			// Get the bootstrapValidator instance
			.data('bootstrapValidator')
			// Mark the field as not validated, so it'll be re-validated when
			// the user change date
			.updateStatus(date_fld, 'NOT_VALIDATED', null)
			// Validate the field
			.validateField(date_fld);
		});
	};
this.callBootstrapValidator = function() {

		
		$('#permissionForm').bootstrapValidator({
			live : 'enabled',
			excluded: ':disabled',
			message : 'This value is not valid',

			fields : {
				/*approxTime : {
					validators : {
						numeric : {
							message : 'Please enter valid Hours'
						},
						notEmpty : {
							message : 'Please enter Hours'
						},
						callback : {
							message : 'Days should be grater than zero',
							 callback: function(value, validator) {
								 var qtyVal=parseFloat(value);
								 if(qtyVal>0){
									 return true;
								 }else{
									 return false;
								 }
									 
							 }
						}
					}
				},*/
			}

		});
		};
		
		this.CheckPermission=function()
		{
			var remarks=$('#approvalRemarks').val();
			var permissionSlipId=$('#permissionSlipId').val();
			var empId=$('#permissionSlipEmpCodes\\.employeeId').val();
			var type=$('input[name=permissionSlipStatus]:checked').val();
			var permissionDate = $("#permissionSlipFromTime").val();
			var approvedPermissions=parseInt($("#permissionsCount").val()) + 1;
			isExits=false;
			if(type!=2)
				{
				return true;
				}
			if(type==2)
				{
				var status=$('input[name=permissionSlipStatus]:checked').val();
				$.ajax({
					url : pageContext
							+ "/secured/permissionSlip/checkPermissions?empId="+empId+"&fromDate="+permissionDate,
							
					type : 'get',
					dataType : 'json',
					contentType : 'application/json',
					mimeType : 'application/json',
					success : function(data) {
						
						if(data==true)
							{
							bootbox.confirm("Limit has been exceeded for the  month ,Do you want to Make it as Emergency Approval ? Permissions in the month "+approvedPermissions, function(result) {
								if(result){
									//$('#urgentApproval').val(true);
									bootbox.hideAll();
									invokeAction(pageContext + "/secured/permissionSlip/updateUrgentPermissionSlip?remarks="+remarks+"&type=1"+"&status="+status+"&permissionSlipId="+permissionSlipId);
								}
								else
									{
									
									//$('#urgentApproval').val(false);
									//invokeAction(pageContext + "/secured/permissionSlip/updateUrgentPermissionSlip?remarks="+remarks+"&type=0"+"&status="+0+"&permissionSlipId="+permissionSlipId);
									invokeAction(pageContext + "/secured/permissionSlip/approvalList?type=0");
									}
							});
							}else
								{
								invokeAction(pageContext + "/secured/permissionSlip/updateUrgentPermissionSlip?remarks="+remarks+"&type=0"+"&status="+status+"&permissionSlipId="+permissionSlipId);
								}
							
					},error : function(data, status, er) {
						
						console.log("json error: " + data + " status: " + status
								+ " er:" + er);
						
					}
				});
				}
			
				return isExits;
		};
		
};