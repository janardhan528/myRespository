<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="css/style.css" type="text/css" /> -->
<title>
	<tiles:insertAttribute name="title" ignore="true"></tiles:insertAttribute>
</title>
</head>
<body>
 <div style="background-color: teal;padding-top: 3px;" align="center">
 <tiles:insertAttribute name="header">
 </tiles:insertAttribute>
 </div>  
 <div style="background-color:activeborder; float:left;padding:5px;width:15%;height: 100%;position: fixed;">
 <tiles:insertAttribute name="menu">
 </tiles:insertAttribute>
 </div>  
 <div style="float:right;;width:85%;">
 <tiles:insertAttribute name="body">
 </tiles:insertAttribute>
 </div>
 <div style="background-color:green; clear:both;bottom:0;padding-bottom: 0px;padding-top: 2px;position: fixed; width:100%;">
 <tiles:insertAttribute name="footer">
 </tiles:insertAttribute>
 </div>
</body>
</html>