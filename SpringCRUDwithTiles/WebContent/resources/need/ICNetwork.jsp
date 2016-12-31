<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page import="com.avantel.funwork4.common.context.UserContext"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<div class="box-header">
	<div class="row">
		<div class="col-sm-6">
			<h3 class="box-title">Network Access</h3>

		</div>
	</div>
</div>
<div class="box">
	<div class="box-body">
		<form:form method="POST" action="itemOneTimeCreation.action"
			commandName="itemCreationVO" id="icNetworkAccess"
			name="icNetworkAccess" data-bv-message="This value is not valid"
			data-bv-feedbackicons-validating="glyphicon glyphicon-refresh"
			data-bv-submitbuttons='button[type="submit"]' data-bv-live="enabled"
			cssClass="form-horizontal">
	<input type="hidden" id="prodDisplayName" />
	<input type="hidden" id="parentDisplayName" />
	<input type="hidden" id="parentrootName" />
	<input type="hidden" id="val" value="2"/>
	<input type="hidden" id="parentSlno" value="1"/>
	<form:hidden path="itemMasterCode"/>
	<form:hidden path="itemMasterName"/>
	<form:hidden path="itemCodeformType" value="ICNWA"/>
	
			<div class="row">
				<div class="form-group col-sm-4">
					<label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Product:</label>
					<div class="col-sm-12">
						<form:select path="" id="icNWProductId" class="form-control selectized"
							placeholder="Select Product" data-bv-notempty="true"
							data-bv-notempty-message="Product is required" onchange="onChangetypeofProduct();">
						</form:select>
						
					</div>
				</div>

				<div class="form-group col-sm-4">
				<input type="hidden" id="typeProductDisplayName" />
					<label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Type Of Product:</label>
					<div class="col-sm-12">
						<form:select path="" id="icNWtypeofProduct" class="form-control selectized"
							placeholder="Select type of product" data-bv-notempty="true"
							data-bv-notempty-message="Type of Product is required" onchange="loadTypeofProductChange();">
						</form:select>
						
					</div>
				</div>

				<div class="form-group col-sm-4">
					<span id="desc"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Desc:</label></span>
						<input type="hidden" id="descDisplayName" />
						<span id="subtype"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Sub Types:</label></span>
					<div class="col-sm-12">
						<form:select path="" id="NWDescription" class="form-control selectized"
							placeholder="Select sub type" data-bv-notempty="true"
							data-bv-notempty-message="Subtype is required">
						</form:select>
						
					</div>
				</div>

				
			</div>

			<div class="row">
			<div class="form-group col-sm-4">
					<span id="variancespan"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Variance:</label></span>
						<span id="kvatypes"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">KVA Types:</label></span>
						<span id="powerspan"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Power:</label></span>
						<input type="hidden" id="varianceDisplayName" />	
					<div class="col-sm-12">
						<form:select path="" id="NWVariance" class="form-control selectized"
							placeholder="Select variance" data-bv-notempty="true"
							data-bv-notempty-message="variance is required">
						</form:select>
						
					</div>
				</div>			
			<div id="revisionDiv">
				<div class="form-group col-sm-4">
					<span id="revision"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Revision:</label></span>
					<span id="variancespan5"><label for="dep" class="control-label col-sm-12"
						style="text-align: left;">Variance:</label></span>						
						<input type="hidden" id="revisionDisplayName" />	
					<div class="col-sm-12">
						<form:select path="" id="NWRevision" class="form-control selectized"
							placeholder="Select variance" data-bv-notempty="true"
							data-bv-notempty-message="variance is required">
						</form:select>
						
					</div>
					</div>
				</div>
				<div class="form-group col-sm-4">
				<div class="form-group col-sm-3">
					<label for="subject" class="control-label col-sm-12"
						style="text-align: left;">K:</label>
					<div class="col-sm-12">
						<form:input path="" id="KValue" cssClass="form-control"
							data-bv-notempty="false"
							data-bv-notempty-message="Subject could not be empty"
							readonly="true" value="X" />
					</div>
				</div>
				<div class="form-group col-sm-3">
					<label for="subject" class="control-label col-sm-12"
						style="text-align: left;">L:</label>
					<div class="col-sm-12">
						<form:input path="" id="LValue" cssClass="form-control"
							data-bv-notempty="false"
							data-bv-notempty-message="Subject could not be empty"
							readonly="true" value="X" />
					</div>
				</div>
				
				</div>

				
			</div>
			
			
			<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<div id="itemCodeName" style="display: none;" class="box box-info">
					<div class="box-body">
						<div class="row">

							<div class="col-sm-2">Item Code :</div>
							<div class="col-sm-6">
								<table width="100%" class="table table-striped">
									<tr>
										<th>A</th>
										<th>B</th>
										<th>C</th>
										<th>D</th>
										<th>E</th>
										<th>F</th>
										<th>G</th>
										<th>H</th>
										<th>I</th>
										<th>J</th>
										<th>K</th>
										<th>L</th>
									</tr>
									<tr>
										<td><span id="Avalue"></span></td>
										<td><span id="Bvalue"></span></td>
										<td><span id="Cvalue"></span></td>
										<td><span id="Dvalue"></span></td>
										<td><span id="Evalue"></span></td>
										<td><span id="Fvalue"></span></td>
										<td><span id="Gvalue"></span></td>
										<td><span id="Hvalue"></span></td>
										<td><span id="Ivalue"></span></td>
										<td><span id="Jvalue"></span></td>
										<td><span id="Kvalue"></span></td>
										<td><span id="Lvalue"></span></td>
									</tr>
								</table>
							</div>

						</div>
						<br>
						<div class="row">

							<div class="col-sm-2">Item Name:</div>
							<div class="col-sm-10">
								<span id="itemNameValue"></span>
							</div>

						</div>
						<br>
						<div class="row">
							<div class="col-sm-4"></div>
							<div class="col-sm-4 text-center">
								<button type="button" class="btn btn-primary" onclick="GetItemCodeCount()">Next</button>
				                <button type="button" class="btn btn-primary" onclick="CancelCode();">Cancel</button>
				
							</div>
							<div class="col-sm-4"></div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2"></div>

		</div>

            <div id="generateDiv">
			<div class="form-group text-center">
				<br /> <br />
				<button type="button" class="btn btn-primary"
					onclick="javascript:return generateProduct();" value="update">Generate</button>
				
			</div>
			</div>
			
			
		</form:form>
	</div>
</div>

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

<script type="text/javascript" language="javascript"
	src="http://<c:out value="${staticURL_mainTemplate}"/>/resources/funwork-template/datatable/jquery.dataTables.min.js"></script>
<script type="text/javascript"
	src="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/jstree/jstree.min.js"></script>
	<script type="text/javascript"
	src="<c:url value='/resources/js/General/funwork-itemCodification.js'/>"></script>
<link
	href="http://<c:out value="${staticURL_mainTemplate}" />/resources/funwork-template/jstree/themes/default/style.min.css"
	rel="stylesheet" />
<script type="text/javascript">
	var pageContext = '${pageContext.request.contextPath}';
	$(document).ready(function() {
		$("#subtype").hide();
		$("#kvatypes").hide();
		$("#variancespan5").hide();
		$("#revisionDiv").hide();
		$("#powerspan").hide();
		icMainDropDown('icNWProductId',11);
		loadTypeofproduct('icNWtypeofProduct',1,'01');
		loadTypeofproduct('NWDescription',2,'01');
		loadTypeofproduct('NWVariance',3,'01');
		
		
		
       
	});
	
	function loadTypeofproduct(dropdownId,level,parentId){
		$.getJSON(pageContext + "/secured/itemMaster/getNetworkAccessCodeJson.action?level="+level+"&parentId="+parentId, {
				
			}, function(mainCodeList) {

				var selectize = $('#'+dropdownId).selectize({
					plugins : [ 'remove_button' ],
					delimiter : ',',
					create : false
				})[0].selectize;

				selectize.addOption({
					value : "",
					text : "Select"
				});
				var details = mainCodeList;

				selectize.clearOptions();
				for (var i = 0; i < details.length; i++) {

					selectize.addOption({
						value : details[i].naCode,
						text : details[i].naDescription
					});
				}
				
				selectize.addItem(details[0].naCode);	
				


			});
		
		
	}
	
	
	
	function onChangetypeofProduct(){
		var parentId=$("#icNWProductId").val();
		if(parentId=='01'){
			$("#revisionDiv").hide();
			$("#kvatypes").hide();
			$("#powerspan").hide();
			$("#variancespan").show();
			loadTypeofproduct('icNWtypeofProduct',1,parentId);
			loadTypeofproduct('NWDescription',2,parentId);
			loadTypeofproduct('NWVariance',3,parentId);
			
		}else if(parentId=='02'){			
				bootbox.alert("Data Not Available", function() {
				});
				var selectize1 = $('#icNWtypeofProduct').selectize({
					
				})[0].selectize;
				selectize1.clearOptions();
				
              var selectize2 = $('#NWDescription').selectize({
					
				})[0].selectize;
              selectize2.clearOptions();
              
              var selectize3 = $('#NWVariance').selectize({
					
				})[0].selectize;
             selectize3.clearOptions();
             
             var selectize4 = $('#NWRevision').selectize({
					
				})[0].selectize;
          selectize4.clearOptions();
				return true;				
			
		}else if(parentId=='03'){
			$("#revisionDiv").show();
			$("#variancespan5").hide();
			$("#revision").show();
			$("#kvatypes").hide();
			$("#powerspan").hide();
			$("#variancespan").show();
			loadTypeofproduct('icNWtypeofProduct',1,parentId);
			loadTypeofproduct('NWDescription',2,'10');
			loadTypeofproduct('NWVariance',3,'10');
			loadTypeofproduct('NWRevision',4,'10');
			
		}else if(parentId=='04'){
			bootbox.alert("Data Not Available", function() {
			});
			var selectize1 = $('#icNWtypeofProduct').selectize({
				
			})[0].selectize;
			selectize1.clearOptions();
			
          var selectize2 = $('#NWDescription').selectize({
				
			})[0].selectize;
          selectize2.clearOptions();
          
          var selectize3 = $('#NWVariance').selectize({
				
			})[0].selectize;
         selectize3.clearOptions();
         
         var selectize4 = $('#NWRevision').selectize({
				
			})[0].selectize;
      selectize4.clearOptions();
			return;
		}else if(parentId=='05'){
			$("#revisionDiv").show();
			$("#desc").hide();
			$("#subtype").show();
			$("#variancespan").hide();
			$("#kvatypes").show();
			$("#revision").hide();
			$("#variancespan5").show();
			$("#powerspan").hide();
			loadTypeofproduct('icNWtypeofProduct',1,'03');
			loadTypeofproduct('NWDescription',2,'03');
			loadTypeofproduct('NWVariance',3,'03');
			loadTypeofproduct('NWRevision',4,'03');
		}else if(parentId=='06'){
			bootbox.alert("Data Not Available", function() {
			});
			var selectize1 = $('#icNWtypeofProduct').selectize({
				
			})[0].selectize;
			selectize1.clearOptions();
			
          var selectize2 = $('#NWDescription').selectize({
				
			})[0].selectize;
          selectize2.clearOptions();
          
          var selectize3 = $('#NWVariance').selectize({
				
			})[0].selectize;
         selectize3.clearOptions();
         
         var selectize4 = $('#NWRevision').selectize({
				
			})[0].selectize;
      selectize4.clearOptions();
			return true;
		}
		
		
	}
	
	function loadTypeofProductChange(){
		var parentId=$("#icNWProductId").val();
		var typeofProductID=$("#icNWtypeofProduct").val();
		if(parentId=='03'){			
			if(typeofProductID==0){
				$("#variancespan").show();
				$("#kvatypes").hide();
				$("#powerspan").hide();
			loadTypeofproduct('NWDescription',2,'10');
			loadTypeofproduct('NWVariance',3,'10');
			loadTypeofproduct('NWRevision',4,'10');
			}else if(typeofProductID==1){
				$("#variancespan").show();
				$("#kvatypes").hide();
				$("#powerspan").hide();
				loadTypeofproduct('NWDescription',2,'11');
				loadTypeofproduct('NWVariance',3,'11');
				loadTypeofproduct('NWRevision',4,'11');
			}else if(typeofProductID==2){
				$("#variancespan").hide();
				$("#kvatypes").hide();
				$("#powerspan").show();
				loadTypeofproduct('NWDescription',2,'12');
				loadTypeofproduct('NWVariance',3,'12');
				loadTypeofproduct('NWRevision',4,'12');
			}else if(typeofProductID==3){
				
				$("#variancespan").hide();
				$("#kvatypes").hide();
				$("#powerspan").show();
				loadTypeofproduct('NWDescription',2,'13');
				loadTypeofproduct('NWVariance',3,'13');
				loadTypeofproduct('NWRevision',4,'13');
			}else if(typeofProductID==4){
				$("#variancespan").hide();
				$("#kvatypes").hide();
				$("#powerspan").show();
				loadTypeofproduct('NWDescription',2,'14');
				loadTypeofproduct('NWVariance',3,'14');$("#parentSlno").val()
				loadTypeofproduct('NWRevision',4,'14');
			}else if(typeofProductID==5){
				$("#variancespan").hide();
				$("#kvatypes").hide();
				$("#powerspan").show();
				loadTypeofproduct('NWDescription',2,'15');
				loadTypeofproduct('NWVariance',3,'15');
				loadTypeofproduct('NWRevision',4,'15');
			}else if(typeofProductID==6){
				$("#variancespan").hide();
				$("#kvatypes").hide();
				$("#powerspan").show();
				loadTypeofproduct('NWDescription',2,'16');
				loadTypeofproduct('NWVariance',3,'16');
				loadTypeofproduct('NWRevision',4,'16');
			}else if(typeofProductID==7){
				$("#variancespan").hide();
				$("#kvatypes").hide();
				$("#powerspan").show();
				loadTypeofproduct('NWDescription',2,'17');
				loadTypeofproduct('NWVariance',3,'17');
				loadTypeofproduct('NWRevision',4,'17');
			}
		}
	}
	
	
	function generateProduct(){
		$("#itemCodeName").show();
		$("#generateDiv").hide();
		var flag=validations();
		if(flag){		
		var productName=$("#icNWProductId").text();
		var icNWtypeofProductName=fixedEncodeURIComponent($("#icNWtypeofProduct").text());
		var NWDescriptionName=fixedEncodeURIComponent($("#NWDescription").text().trim());
		var NWVarianceName=$("#NWVariance").text().trim();
		if(NWVarianceName!='Not Specified'){
			NWVarianceName=fixedEncodeURIComponent($("#NWVariance").text().trim());
		}else{
			NWVarianceName=$("#NWVariance").text().trim();
		}
		
		$("#itemCodeName").show();
		var NWRevisionName=$("#NWRevision").text();
		var KValueName=$("#KValue").text();
		var LValueName=$("#LValue").text();	
		var parentname = "Network Access";
		var parentSlnoValue="Finished Products";
		var itemNametext='';
		  
		 $.ajax({
			url : pageContext+"/secured/itemMaster/getMainDisplayTextByDescJson.action?desc="+productName,
			type : "GET",
			async: false,
			contentType: 'application/json',
			success: function(productDisplayName) {
				$("#prodDisplayName").val(productDisplayName);				
			}
		});
		 
		$.ajax({			
			url : pageContext+"/secured/itemMaster/getNADisplayTextByCodeJson.action?desc="+icNWtypeofProductName,
			type : "GET",
			async: false,
			contentType:  "application/json; charset=ISO-8859-1",
			success: function(NWtypeofProductName) {
				$("#typeProductDisplayName").val(NWtypeofProductName);				
			}
		});
		
		if(NWDescriptionName!='Not Specified'){
		$.ajax({
			url : pageContext+"/secured/itemMaster/getNADisplayTextByCodeJson.action?desc="+NWDescriptionName,
			type : "GET",
			async: false,
			contentType:"application/json; charset=ISO-8859-1",
			success: function(NWtypeofProductName) {
				$("#descDisplayName").val(NWtypeofProductName);				
			}
		});
		}
		
		if(NWVarianceName!='Not Specified'){
		$.ajax({
			url : pageContext+"/secured/itemMaster/getNADisplayTextByCodeJson.action?desc="+NWVarianceName,
			type : "GET",
			async: false,
			contentType: "application/json; charset=ISO-8859-1",
			success: function(Data) {			
				$("#varianceDisplayName").val(Data);				
			}
		});
		}
		
		$.ajax({
			url : pageContext+"/secured/itemMaster/getMainDisplayTextByDescJson.action?desc="+parentname,
			type : "GET",
			async: false,
			contentType: 'application/json',
			success: function(productDisplayName) {
				$("#parentDisplayName").val(productDisplayName);				
			}
		});
		
		
		$.ajax({
			url : pageContext+"/secured/itemMaster/getMainDisplayTextByDescJson.action?desc="+parentSlnoValue,
			type : "GET",
			async: false,
			contentType: 'application/json',
			success: function(productDisplayName) {
				console.log(productDisplayName);
				$("#parentrootName").val(productDisplayName);				
			}
		}); 
		
		
		if(NWRevisionName!='Not Specified'){
			$.ajax({
				url : pageContext+"/secured/itemMaster/getNADisplayTextByCodeJson.action?desc="+NWRevisionName,
				type : "GET",
				async: false,
				contentType: "application/json; charset=ISO-8859-1",
				success: function(NWtypeofProductName) {
					$("#revisionDisplayName").val(NWtypeofProductName);				
				}
			});
			}
		
		
		var parentId=$("#icNWProductId").val();
		
		if(parentId=='01'){
		itemNametext=$("#parentrootName").val()+" "+$("#parentDisplayName").val()+" "+$("#prodDisplayName").val()+" "+
		$("#typeProductDisplayName").val()+" "+$("#descDisplayName").val()+" "+$("#varianceDisplayName").val();
		$("#itemMasterName").val(itemNametext);
		}else{
			itemNametext=$("#parentrootName").val()+" "+$("#parentDisplayName").val()+" "+$("#prodDisplayName").val()+" "+
			$("#typeProductDisplayName").val()+" "+$("#descDisplayName").val()+" "+$("#varianceDisplayName").val()+" "+$("#revisionDisplayName").val();
			$("#itemMasterName").val(itemNametext);
		}
		
		
		
		
		
		$("#itemNameValue").text(itemNametext);
		
		binditemCodeTableValue();
		}
	}
	
	function binditemCodeTableValue(){
		var parentId=$("#icNWProductId").val();
		var parentValue=splitNumberValue(parentId);	
		var descData=$("#NWDescription").val().trim();
		var descValue=splitNumberValue(descData);
		var varianceData=$("#NWVariance").val().trim();
		var varianceValue=[];
		if(varianceData.length<2){
			varianceValue[0]=0;
			varianceValue[1]=varianceData;
			
		}else{
			varianceValue=splitNumberValue(varianceData);
		}
		
		
		var revisionData='';
		
		$("#Avalue").text($("#parentSlno").val());
		$("#Bvalue").text($("#val").val());
		$("#Cvalue").text(parentValue[0]);
		$("#Dvalue").text(parentValue[1]);
		$("#Evalue").text($("#icNWtypeofProduct").val());
		$("#Fvalue").text(descValue[0]);
		$("#Gvalue").text(descValue[1]);
		
		if(parentId==01){			
			
			if($("#NWRevision").val()!=null){
				$("#Hvalue").text($("#NWRevision").val());
				revisionData=$("#NWRevision").val().trim();
			    }else{
			    	$("#Hvalue").text(0);
			    	revisionData=0;			    	
			    }
			
			$("#Ivalue").text(varianceValue[0]);
			$("#Jvalue").text(varianceValue[1]);
			
		}else{
			$("#Hvalue").text(varianceValue[0]);
			$("#Ivalue").text(varianceValue[1]);
			if($("#NWRevision").val()!=null){
			$("#Jvalue").text($("#NWRevision").val());
			revisionData=$("#NWRevision").val().trim();
		    }else{
		    	$("#Jvalue").text(0);
		    	revisionData=0;		    	
		    }
		}
		$("#Kvalue").text($("#KValue").val());
		$("#Lvalue").text($("#LValue").val());
		
		var itemCode=$("#parentSlno").val()+$("#val").val()+parentId+$("#icNWtypeofProduct").val().trim()+descData+varianceData+revisionData+$("#KValue").val().trim()+$("#LValue").val().trim();
		
		$("#itemMasterCode").val(itemCode);
		
	}
	
	
	function splitNumberValue(value){
	    output = [],
	    sNumber = value.toString();
	     for (var i = 0, len = sNumber.length; i < len; i += 1) {
	      output.push(+sNumber.charAt(i));
	       }
         return output;
	}
	
	var parentId=$("#icNWProductId").val();
	
	function validations(){
		if($("#icNWProductId").val()==''){
			bootbox.alert("Please select Product", function() {
			});
			return false;
		}
		if($("#icNWtypeofProduct").val()==''){
			bootbox.alert("Please select Type of Product", function() {
			});
			return false;
		}
		if($("#NWDescription").val()==''){
			bootbox.alert("Please select Description", function() {
			});
			return false;
		}
		if($("#NWVariance").val()==''){
			bootbox.alert("Please select Variance", function() {
			});
			return false;
		}
		if(parentId!='01'){
		if($("#NWRevision").val()==''){
			bootbox.alert("Please select Revision", function() {
			});
			return false;
		}
		}
		return true;
		
	}
	
	
	
function icMainDropDown(dropDownId,mainParentId) {

			$.getJSON(pageContext + "/secured/itemMaster/getMainCodeByParentJson.action?mainParentId="+mainParentId, {
				
			}, function(mainCodeList) {
				mainProductsList = mainCodeList;
				var selectize = $('#'+dropDownId).selectize({
					plugins : [ 'remove_button' ],
					delimiter : ',',
					create : false
				})[0].selectize;

				selectize.addOption({
					value : "",
					text : "Select"
				});
				var details = mainCodeList;

				selectize.clearOptions();
				for (var i = 0; i < details.length; i++) {

					selectize.addOption({
						value : details[i].mainCode,
						text : details[i].mainDescription
					});
					
					
				}
				selectize.addItem(details[0].mainCode);	

				
			});
			
		};
		
		function GetItemCodeCount() {
			$.ajax({
						url : "${pageContext.request.contextPath}/secured/itemMaster/itemCodeCount.action?drgCode="
								+ strCode,
						type : "GET",
						contentType : 'application/json',
						success : function(data, textStatus, jqXHR) {
							if(data > 0)
							{
								alert("Item Code Already Exist");
								
							}
							else
							{
								GetItemCreationPage();
							} 
						},
						error : function(jqXHR, textStatus, errorThrown) {
						}
					});
		}
		
		function GetItemCreationPage() {
			var strDisplayName=fixedEncodeURIComponent($("#itemNameValue").text());
			var	strCode=$("#itemMasterCode").val();
			invokeAction("${pageContext.request.contextPath}/secured/itemMaster/itemCreation?Name="
					+ strDisplayName + "&Code=" + strCode + "&pcbType=ICNWA");

		}
		
		
		function CancelCode() {
			$("#itemCodeName").hide();
			$("#generateDiv").show();
		}
	
	
	
	
</script>




 --%>