


<cfmodule template="/admin/authenticate.cfm" application_fk="51">
<cfinclude template="/includes/check_mobile.cfm">
 	
<cfheader name="X-UA-Compatible" value="IE=edge">
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>
      silCMS: Sno-Isle Libraries Content Management Solution
    </title>





  </head>
  <body>
  	<cfif variables.mobile_user IS "Y">
		<cfinclude template="/admin/inc_slosh_mobile.cfm">
    <cfelse>
		<cfinclude template="/admin/inc_slosh.cfm">
    </cfif>
