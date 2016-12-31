var LeaveApplication = new function() {
	
	
	this.initializeAndValidateDatepicker = function() {

		$('#datetimepicker1,datetimepicker2,datetimepicker3').datetimepicker({
			pickTime : false,
			dateFormat : 'DD-MMM-YYYY',
			daysOfWeekDisabled: [0, ""]
		});

		$('#datetimepicker1,#datetimepicker2,#datetimepicker3').on('dp.change dp.show',
				function(e) {
					if($('#leaveAppFromDate').val()!='')
						{
						LeaveApplication.getToDate();
						}
				
					var date_fld = $(e.currentTarget.children[0]).attr('name');
					// Validate the date when user change it
					$('#addleaveForm').data('bootstrapValidator').updateStatus(date_fld, 'NOT_VALIDATED', null).validateField(date_fld);
				});
		
		
	};
this.callBootstrapValidator = function() {

		
		$('#addleaveForm').bootstrapValidator({
			live : 'enabled',
			message : 'This value is not valid',
			excluded: ':disabled',

			fields : {
				
				leaveAppNoofDays : {
					validators : {
						numeric : {
							message : 'Please enter valid Days'
						},
						notEmpty : {
							message : 'Please enter Days'
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
				},
				leaveAppNoofDays:{
					validators : {
						numeric : {
							message : 'Please enter valid Days'
						},
						callback : {	
					message : 'Leave can be applied for half or full day only...',
					callback : function(value, validator) {
						var days=value;
						if (days != "") {
							var reg=new  RegExp("^[0-9]+(\.[0,5]{1})?$");
							 if(!days.match(reg))
								{
								 return false;
								}
						}
						return true;
					}
				}
					}
				} 
			}

		});
		};
		
		this.getEls=function(pageContext)
		{
			var empId=$('#leaveAppEmp\\.employeeId').val();
			
			$
			.ajax({
				url : pageContext
						+ "/secured/leaveapp/getELs?empId="+empId,
						
				type : 'get',
				dataType : 'json',
				contentType : 'application/json',
				mimeType : 'application/json',
				success : function(els) {
					$('#el').val(els);
				}
			});
			
		}
		this.getCls=function(pageContext)
		{
			var empId=$('#leaveAppEmp\\.employeeId').val();
			$
			.ajax({
				url : pageContext
						+ "/secured/leaveapp/getCLs?empId="+empId,
						
				type : 'get',
				dataType : 'json',
				contentType : 'application/json',
				mimeType : 'application/json',
				success : function(cls) {
					$('#cl').val(cls);
				}
			});
			
		};
		
		this.getToDate=function()
		{
			
			var days=$('#leaveAppNoofDays').val();
			var hrs=$('#leaveAppFromSession').val();
			var fromDate=$('#leaveAppFromDate').val();
			if(days=='')
			{
			bootbox.alert("Enter Number of days", function() {
				
			});
			return false;
			}
			if (days != "") {
			var reg=new  RegExp("^[0-9]+(\.[0,5]{1})?$");
			
			 if(!days.match(reg))
				{
				//alert("Enter only digit 5 after dicimal");
//				bootbox.alert("Enter only digit 5 after dicimal....", function() {
//					
//				});
				$('#leaveAppNoofDays').val("");
				}
			 
			
			 if($('#leaveAppNoofDays').val()!="")
				 {
				
			var flag=LeaveApplication.checkHoliday(fromDate);
			fromDate=fromDate+" "+hrs+":00";
			
							if(flag==0)
								{
								
								var payslipDistributed=LeaveApplication.paySlipDistributed(fromDate);
								
								if(payslipDistributed==false)
									{
									
											console.log("date is",pageContext
														+ "/secured/leaveapp/geToDate?days="
														+ days + "&fromDate=" + fromDate);
												$
												.ajax({
													url : pageContext
															+ "/secured/leaveapp/geToDate?days="
															+ days + "&fromDate=" + fromDate,

													type : 'get',
													dataType : 'json',
													contentType : 'application/json',
													mimeType : 'application/json',
													success : function(leaveUtilVO) {
														
														
														
														$('#leaveAppNoofDays').val(leaveUtilVO.noOfDays);
														var toDateHours=new Date(leaveUtilVO.toDate);
														
														if(toDateHours.getHours()==13)
															{
															
															$("#leaveAppToSession").val(toDateHours.getHours()+1);
															}
														else
															{
															if(toDateHours.getHours()==23)
																{
																$("#leaveAppToSession").val(toDateHours.getHours()-9);
																}
															else
																{
																$("#leaveAppToSession").val(toDateHours.getHours());
																}
															
															}
														
														
														$('#leaveAppBackonDuty').val(convertJSONDatetoFormat(leaveUtilVO.backOnDuty));
														
														var days=$('#leaveAppNoofDays').val();
														var fromSession=$('#leaveAppFromSession').val();
														var toSession=$("#leaveAppToSession").val();
														
														if(fromSession == 14 &&  toSession == 14)
															{
															
															if (days.indexOf(".")==-1) {
																$('#leaveAppToDate').val(convertJSONDatetoFormat(leaveUtilVO.backOnDuty));
														    }
															}else
																{
																$('#leaveAppToDate').val(convertJSONDatetoFormat(leaveUtilVO.toDate));
																}
														var fromValidation=$('#addleaveForm').data('bootstrapValidator');
													 	fromValidation.updateStatus("leaveAppFromDate" , 'NOT_VALIDATED', null).validateField("leaveAppFromDate");
													 	fromValidation.updateStatus("leaveAppToDate" , 'NOT_VALIDATED', null).validateField("leaveAppToDate");
													 	fromValidation.updateStatus("leaveAppBackonDuty" , 'NOT_VALIDATED', null).validateField("leaveAppBackonDuty");
														
													}
												});
												
									        
								}
										
									
								
								}
						
					
		}
			
			}
			
		};
		
		
		this. getDay=function(day) {
			
			var weekday = new Array(7);
			weekday[0] = "Sunday";
			weekday[1] = "Monday";
			weekday[2] = "Tuesday";
			weekday[3] = "Wednesday";
			weekday[4] = "Thursday";
			weekday[5] = "Friday";
			weekday[6] = "Saturday";

			var dayName = weekday[day];
			
			return dayName;
		};
		this.checkHoliday=function(fromDate)
		{
			var holidayVariable=0;
			
			 $
				.ajax({
					url : pageContext
							+ "/secured/leaveapp/checkHoliday?fromDate="
							+ fromDate ,

					type : 'get',
					dataType : 'json',
					contentType : 'application/json',
					mimeType : 'application/json',
					success : function(flag) {
						
						if(flag==true)
							{
							//alert("Seleted Day is Holiday..You can't Apply Leave");
							bootbox.alert("Seleted Day is Holiday..You can't Apply Leave", function() {
								$('#leaveAppFromDate').val("");
								$('#leaveAppToDate').val("");
								$('#leaveAppBackonDuty').val("");
								$('#leaveAppNoofDays').val("");
								var fromValidation=$('#addleaveForm').data('bootstrapValidator');
							 	fromValidation.updateStatus("leaveAppFromDate" , 'NOT_VALIDATED', null).validateField("leaveAppFromDate");
							 	fromValidation.updateStatus("leaveAppToDate" , 'NOT_VALIDATED', null).validateField("leaveAppToDate");
							 	fromValidation.updateStatus("leaveAppBackonDuty" , 'NOT_VALIDATED', null).validateField("leaveAppBackonDuty");
							 	fromValidation.updateStatus("leaveAppNoofDays" , 'NOT_VALIDATED', null).validateField("leaveAppNoofDays");
								holidayVariable=1;
								
								return holidayVariable;
							});
							
							
							}
						
					}
						
	});return holidayVariable;
		};
		
		this.paySlipDistributed=function(fromDate)
		{
			
			var payslipDistrbuted=false;
			$
			.ajax({
				url : pageContext
						+ "/secured/leaveapp/checkPaySlipGenerated?fromDate="
						+ fromDate ,

				type : 'get',
				dataType : 'json',
				contentType : 'application/json',
				mimeType : 'application/json',
				success : function(flag) {
					console.log("return",flag);
					if(flag==true)
						{
						$('#leaveAppToDate').val("");
						$('#leaveAppBackonDuty').val("");
						$('#leaveAppFromDate').val("");
						$('#datetimepicker1').data("DateTimePicker").clear();
						//alert("Payslip was already distributed, so you cannot apply Leave for this Date");
						
						bootbox.alert("Payslip was already distributed, so you cannot apply Leave for this Date", function() {
							
						});
						
						
						var fromValidation=$('#addleaveForm').data('bootstrapValidator');
					 	fromValidation.updateStatus("leaveAppFromDate" , 'NOT_VALIDATED', null).validateField("leaveAppFromDate");
					 	fromValidation.updateStatus("leaveAppToDate" , 'NOT_VALIDATED', null).validateField("leaveAppToDate");
					 	fromValidation.updateStatus("leaveAppBackonDuty" , 'NOT_VALIDATED', null).validateField("leaveAppBackonDuty");
					 	
						payslipDistrbuted=true;
						console.log("return in payslip",payslipDistrbuted)
						return payslipDistrbuted;
						}
				}
			});return payslipDistrbuted;
			
		};
		this.getLastPaySlipDate=function()
		{
			$.ajax({
				url : pageContext
						+ "/secured/leaveapp/getLastPaySlipDate",

				type : 'get',
				dataType : 'json',
				contentType : 'application/json',
				mimeType : 'application/json',
				success : function(lastPayslipGeneratedDate) {
					if(lastPayslipGeneratedDate!='')
						{
						
						var payslipDate=new  moment(lastPayslipGeneratedDate);
						var lockMinDate=payslipDate.toDate();
						var minLocKDate=new  moment(lockMinDate);
						minLocKDate=minLocKDate.add(25,'d');
						$('#datetimepicker1').data("DateTimePicker").minDate(minLocKDate.toDate());
						//$('#datetimepicker1').data("DateTimePicker").minDate(ldate.toDate());
						}
					
				}
			});
		};
};