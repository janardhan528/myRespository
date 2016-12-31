var ODApplication = new function() {
	
	
	this.initializeAndValidateDatepicker = function() {

		$('#datetimepicker1,datetimepicker2,datetimepicker3').datetimepicker({
			pickTime : false,
			dateFormat : 'DD-MMM-YYYY',
			 daysOfWeekDisabled: [0, ""]
		});

		$('#datetimepicker1,datetimepicker2,datetimepicker3').on('dp.change dp.show',
				function(e) {
			if($('#odApplicationFromDate').val()!='')
				{
				ODApplication.getToDate();
				}
		
					var date_fld = $(e.currentTarget.children[0]).attr('name');
					// Validate the date when user change it
					$('#addODForm').data('bootstrapValidator').updateStatus(date_fld, 'NOT_VALIDATED', null).validateField(date_fld);
				});
		
	};
this.callBootstrapValidator = function() {

		
		$('#addODForm').bootstrapValidator({
			live : 'enabled',
			excluded: ':disabled',
			message : 'This value is not valid',

			fields : {
				odApplicationNoofDays : {
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
			
			var days=$('#odApplicationNoofDays').val();
			var hrs=$('#odApplicationFromSession').val();
			var fromDate=$('#odApplicationFromDate').val();
			
			var reg=new  RegExp("^[0-9]+(\.[0,5]{1})?$");
			if(days=='')
				{
				bootbox.alert("Enter Number of days", function() {
					
				});
				return false;
				}
			 if(!days.match(reg))
				{
				//alert("Enter only digit 5 after dicimal");
				bootbox.alert("Enter only digit 5 after dicimal", function() {
					
				});
				$('#odApplicationNoofDays').val("");
				}
			 
			 
			 if($('#odApplicationNoofDays').val()!="")
				 {
				 
			var flag=ODApplication.checkHoliday(fromDate);
			fromDate=fromDate+" "+hrs+":00";
			
							if(flag==0)
								{
								
								var payslipDistributed=ODApplication.paySlipDistributed(fromDate);
								
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
														
														
														
														//$('#odApplicationToDate').val(convertJSONDatetoFormat(leaveUtilVO.toDate));
														
														$('#odApplicationNoofDays').val(leaveUtilVO.noOfDays);
														var toDateHours=new Date(leaveUtilVO.toDate);
														if(toDateHours.getHours()==13)
															{
															
															$("#odApplicationToSession").val(toDateHours.getHours()+1);
															}
														else
															{
															if(toDateHours.getHours()==23)
															{
															$("#odApplicationToSession").val(toDateHours.getHours()-9);
															}
															else
																{
																$("#odApplicationToSession").val(toDateHours.getHours());
																}
															}
														
														var days=$('#odApplicationNoofDays').val();
														var fromSession=$('#odApplicationFromDate').val();
														var toSession=$("#odApplicationToSession").val();
														var fromSession=$("#odApplicationFromSession").val();
														
														if(fromSession == 14 &&  toSession == 14)
															{
															
															if (days.indexOf(".")==-1) {
																
																$('#odApplicationToDate').val(convertJSONDatetoFormat(leaveUtilVO.backOnDuty));
														    }
															}else
																{
																$('#odApplicationToDate').val(convertJSONDatetoFormat(leaveUtilVO.toDate));
																}
														
														
														var fromValidation=$('#addODForm').data('bootstrapValidator');
													 	fromValidation.updateStatus("odApplicationFromDate" , 'NOT_VALIDATED', null).validateField("odApplicationFromDate");
													 	fromValidation.updateStatus("odApplicationToDate" , 'NOT_VALIDATED', null).validateField("odApplicationToDate");
														
														
													}
												});
									        
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
								$('#odApplicationFromDate').val("");
								$('#odApplicationToDate').val("");
								$('#odApplicationNoofDays').val("");
								var fromValidation=$('#addODForm').data('bootstrapValidator');
							 	fromValidation.updateStatus("odApplicationFromDate" , 'NOT_VALIDATED', null).validateField("odApplicationFromDate");
							 	fromValidation.updateStatus("odApplicationToDate" , 'NOT_VALIDATED', null).validateField("odApplicationToDate");
							 	fromValidation.updateStatus("odApplicationNoofDays" , 'NOT_VALIDATED', null).validateField("odApplicationNoofDays");
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
						
						//alert("Payslip was already distributed, so you cannot apply Leave for this Date");
						
						bootbox.alert("Payslip was already distributed, so you cannot apply Leave for this Date", function() {
							
						});
						$('#odApplicationFromDate').val("");
						$('#odApplicationToDate').val("");
						var fromValidation=$('#addODForm').data('bootstrapValidator');
					 	fromValidation.updateStatus("odApplicationFromDate" , 'NOT_VALIDATED', null).validateField("odApplicationFromDate");
					 	fromValidation.updateStatus("odApplicationToDate" , 'NOT_VALIDATED', null).validateField("odApplicationToDate");
					 	
						payslipDistrbuted=true;
						return payslipDistrbuted;
						}
				}
			});return payslipDistrbuted;
			
		}
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