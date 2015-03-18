<cfparam name="attributes.application_name" default="0" type="any">

<cfquery name="GetAppDetails" datasource="sql.sno-isle.org">
SELECT *
FROM intranet.applications
WHERE pk = '#attributes.application_fk#';
</cfquery>

<cfset caller.app_name = GetAppDetails.application_name>

<!---these are a variety of security checks that detect nefarious logins.  As the threshholds exceed, the system will auto lock itself down.--->


<cfif cgi.REMOTE_ADDR CONTAINS "172.16." OR cgi.REMOTE_ADDR CONTAINS "172.31.">
<!---checks for fails by specific IP--->
<cfquery name="GetFails" datasource="sql.sno-isle.org">
SELECT login_datetime, username, user_ip, result
FROM intranet.admin_logins
WHERE login_datetime > #CreateDateTime(year(now()),month(now()),day(now()),0,0,0)#
AND result = 'FAIL'
AND user_ip = '#cgi.REMOTE_ADDR#'
</cfquery>

<cfif GetFails.RecordCount GT 20>

<div style="background-color:#F00; color:#FFF; font-family:arial; font-size:40px; padding:20px; text-align:center;">INTRANET ADMIN SECURITY LOCKOUT<br>SUBMIT TECH REPORT FOR ASSISTANCE</div>

<cfabort>

</cfif>


<!---exceeds fails of 500 in 1 day--->
<cfquery name="GetFails" datasource="sql.sno-isle.org">
SELECT login_datetime, username, user_ip, result
FROM intranet.admin_logins
WHERE login_datetime > #CreateDateTime(year(now()),month(now()),day(now()),0,0,0)#
AND result = 'FAIL'
</cfquery>

<cfif GetFails.RecordCount GT 500>


<div style="background-color:#F00; color:#FFF; font-family:arial; font-size:40px; padding:20px; text-align:center;">INTRANET ADMIN SECURITY LOCKOUT<br>SUBMIT TECH REPORT FOR ASSISTANCE</div>

<cfabort>

</cfif>

</cfif>




<cfinclude template="/includes/check_mobile.cfm">
<cfif variables.mobile_user IS "Y">
  <cfhtmlhead text='<meta name="viewport" content="width = device-width, init-scale = 1, user-scalable = no">'>
<cfelseif cgi.HTTP_USER_AGENT CONTAINS "iPad">
  <cfhtmlhead text='<meta name="viewport" content="width = 768, init-scale = 1, user-scalable = no">'>
</cfif>
<!---
<cfif cgi.HTTP_USER_AGENT CONTAINS "iPad">
  <cfhtmlhead text='<meta name="viewport" content="width = 768, init-scale = 1, user-scalable = no">'>
<cfelseif cgi.HTTP_USER_AGENT CONTAINS "iPhone">
  <cfhtmlhead text='<meta name="viewport" content="width = device-width, init-scale = 1, user-scalable = no">'>
</cfif>
--->

<!---password used to encrypt cookie data--->
<cfset SecretKey = "jdk934h1205jfqa">

<!---first checks to see if user is already authenticated--->
<cfif isDefined('cookie.ActiveDirectoryToken')>

<!---decrypts cookie data to get username, this variable is also here for backward compatibility, some apps use this var --->
<cfset samaccountname = LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),2,"|"))>


<!---this process is used to force everyone to log out in the system and re-login--->
<cfset CookieSet = LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),3,"|"))>
<cfif variables.CookieSet LT CreateDateTime(2015,01,28,09,11,00)>
<cflocation url="/logout/">
</cfif>


<!---checks to see if user is allowed access to the app--->
<cfquery name="CheckAccess" datasource="sql.sno-isle.org">
SELECT pk
FROM   intranet.security
WHERE  samaccountname_fk = '#variables.samaccountname#'
AND    application_fk    = '#attributes.application_fk#'

UNION

SELECT pk
FROM   intranet.applications
WHERE  pk        = '#attributes.application_fk#'
AND    all_staff = 'Y';
</cfquery>


<cfif CheckAccess.RecordCount IS 0>
<cfset AccessFail = "Y">
</cfif>

<!---This checks for Vendor, REF, Test, Temp and other Demo types of account.  On these accounts the department is always null.  This checks for department null value and if so does not permit access.--->
<cfquery name="GetADInfo" datasource="sql.sno-isle.org">
SELECT department
FROM   shared.active_directory
WHERE  samaccountname = '#variables.samaccountname#';
</cfquery>

<!---removed because temp employees don't have department, but need access.--->
<!---<cfif GetADInfo.department IS "">
<cfset AccessFail = "Y">
</cfif>--->


<!---if query contains any result the user is allowed--->
<cfif NOT isDefined('variables.AccessFail')>

<cftry>

<!---this logs the users visit to this app--->
<cfquery name="LogAccess" datasource="sql.sno-isle.org">
INSERT
INTO   intranet.adminusage
       (
              user_fk       ,
              application_fk,
              userip        ,
              useragent     ,
              datetimeinserted
       )
       VALUES
       (
              '#variables.samaccountname#' ,
              '#attributes.application_fk#',
              '#cgi.REMOTE_ADDR#'          ,
              '#cgi.HTTP_USER_AGENT#'      ,
              #CreateODBCDateTime(now())#
       );
</cfquery>

<cfcatch type="Any">


</cfcatch>

</cftry>


<cfelse>

<!---<cfmail to="mlongley@sno-isle.org" from="auto-generated@sno-isle.org" subject="Admin: Access Denied" type="html"><cfdump var="#variables#"></cfmail>--->


<!---displays message to user that they don't have access to the app--->
<table width="520" align="center" cellpadding="10" cellspacing="0" bgcolor="#DFECFF" style="margin-top:100px; font-family:Calibri, Arial, Helvetica, sans-serif;">
  <tr>
    <td colspan="2">
       <a href="http://sno-isle.org/"><img src="http://sno-isle.org/images_global/sil-logo-275x107.png"></a>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <br />
      
      <p style="color:red;"><b>*** ACCESS DENIED ***</b></p>
      
      <p>You're logged in as: <cfoutput><b>#variables.samaccountname#</b></cfoutput> &nbsp;&nbsp; <a href="/admin/logout.cfm">not you?</a></p>
      <p>
        Our records show you don't have permission to access.<br>If you need access, <a href="/applications/traffic/current/send.cfm">please submit a tech report</a>.
      </p>
 
      <br />
      <br />
    </td>
  </tr>
</table>
<table align="center" style="font-family:Calibri, Arial, Helvetica, sans-serif;">
  <tr>
    <td colspan="2" align="center" bgcolor="#FFFFFF" style="font-size:11px;">
      <cfoutput>
        #cgi.REMOTE_ADDR#  #Left(cgi.HTTP_USER_AGENT,65)# #now()#
      </cfoutput>
    </td>
  </tr>
</table>

<cfabort>

</cfif>

<!---if a authenticated cookie is not set aka the user hasn't logged in yet--->
<cfelse>

<!---checks to see if user entered username and password and is trying to authenticate--->
<cfif isDefined('form.username')>

<!---tries to authenticate to LDAP server with user's username and password, if it succeed then user entered valid username/password combination, if either username or password is not valid/correct it will fail--->
<cftry>
<cfquery name="GetADInfo" datasource="sql.sno-isle.org">
SELECT distinguishedname
FROM   shared.active_directory
WHERE  samaccountname = '#form.username#'
</cfquery>

<cfldap action="query"
	name="ValidateUser"
	start="ou=Employees,dc=windows,dc=sno-isle,dc=org"
	scope="subtree"
	attributes="SamAccountName"
	filter="(SamAccountName=#form.username#)"
	server="172.16.1.173"
	username="#GetADInfo.distinguishedName#"
	password="#form.password#">

<cfcatch type="Any">







<!---if it fails it sets this message--->
<cfset loginerror = "Either your username or your password is incorrect or expired. Please make sure to use the username and password you use to login to your Windows PC on the staff network.<br><br>It's possible your Windows login has expired and is waiting for you to login to a staff PC under your own name (no reference desk logins) to reset your password.  Please close this window, reboot your machine and login to Windows with your own username and try again.<br><br>If you continue to receive this message and you know you have your correct username and password and its not expired, please <a href='https://intranet.sno-isle.org/applications/traffic/current/' style='color:red;'>submit a tech report</a> for assistance.">

</cfcatch>
</cftry>

<!---checks to see if user is trying to log in under generic reference desk logins which aren't allowed.--->
<cfif len(form.username) IS "6" AND form.username CONTAINS "ref">
	<cfset loginerror = "Reference desk logins are not allowed, please use your personal Windows login.">
</cfif>

<!---if an error was not set, sets encrypted cookies containing the username--->
<cfif NOT isDefined('loginerror')>

<!---logs the success--->

<cfquery name="AddResolution" datasource="sql.sno-isle.org">
INSERT INTO intranet.admin_logins
            (
                        login_datetime,
                        username      ,
                        user_ip       ,
                        result
            )
            VALUES
            (
                        #CreateODBCDateTime(now())#,
                        '#form.username#'          ,
                        '#cgi.REMOTE_ADDR#'        ,
                        'SUCCESS'
            );
</cfquery>


<!---one last check to purge and straggler login pieces from prior logins--->
<cfset StructClear(cookie)>
<cfoutput>
  <cfloop collection="#cookie#" item="this">
    <cfcookie name="#this#" value="X" expires="now" domain=".sno-isle.org">
  </cfloop>
</cfoutput>



<cfset CookieString = "OK|#form.username#|#now()#">

<!---if the user checked the box to remember username/password--->
<cfif isDefined('form.remember')>

<cfcookie
	name="ActiveDirectoryToken"
    value="#Encrypt(variables.CookieString,variables.SecretKey)#"
    expires="7"
    domain=".sno-isle.org">
 
    
<!---<cfcookie
	name="aUser"
    value="#form.username#"
    expires="7"
    domain=".sno-isle.org">

<cfcookie
	name="sil"
    value="#Encrypt(form.username,"snoisle")#"
    expires="7"
    domain=".sno-isle.org">--->

<cfelse>

<cfcookie
	name="ActiveDirectoryToken"
    value="#Encrypt(variables.CookieString,variables.SecretKey)#"
    domain=".sno-isle.org">
    
<!---<cfcookie
	name="aUser"
    value="#form.username#"
    domain=".sno-isle.org">

<cfcookie
	name="sil"
    value="#Encrypt(form.username,"snoisle")#"
    domain=".sno-isle.org">
--->
</cfif>




<!---after setting the cookies, sends them back on their way to the app--->
<cflocation url="#cgi.script_name#?#cgi.QUERY_STRING#" addtoken="yes">


<cfelse>


<!---logs the fail--->
<cfquery name="AddResolution" datasource="sql.sno-isle.org">
INSERT INTO intranet.admin_logins
            (
                        login_datetime,
                        username      ,
                        user_ip       ,
                        result
            )
            VALUES
            (
                        #CreateODBCDateTime(now())#,
                        '#form.username#'          ,
                        '#cgi.REMOTE_ADDR#'        ,
                        'FAIL'
            );
</cfquery>



</cfif>

</cfif>


<!DOCTYPE HTML>
<html>
<head>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-845744-11', 'sno-isle.org');
  ga('send', 'pageview');

</script>

</head>

<body>

<!---if a form submission hasn't ocurred and a cookie is not set the user gets the login box--->
<form action="<cfoutput>#cgi.script_name#?#cgi.QUERY_STRING#</cfoutput>" method="post" name="login">

<table width="520" align="center" cellpadding="10" cellspacing="0" bgcolor="#DFECFF" style="margin-top:100px; font-family:Calibri, Arial, Helvetica, sans-serif;">
  <tr >
    <td colspan="2" align="center">
      <a href="http://sno-isle.org/"><img src="http://sno-isle.org/images_global/sil-logo-275x107.png"></a>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <strong>You are entering a secure area, expressly for the use of Sno-Isle Libraries employees.  Unauthorized access and/or use is expressly prohibited.</strong>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <b style="color:red;">Use your Windows Network Login</b><br /><br />
      <table align="center">
        <tr>
          <td align="right">
            <b>Username:</b>
          </td>
          <td>
            <input name="username" type="text" size="20" maxlength="55" />
          </td>
        </tr>
        <tr>
          <td align="right">
            <b>Password:</b>
          </td>
          <td>
            <input name="password" type="password" size="20" maxlength="55" />
          </td>
        </tr>
      </table>
    </td>
  </tr>

<!---if a previously submit occured and an error was set display this message in a new login box for them to try again--->
<cfif isDefined('variables.loginerror')><tr><td colspan="2" style="font-size:12px; color:#F00;"><cfoutput>#variables.loginerror#</cfoutput></td></tr></cfif>


<cfif attributes.application_fk IS NOT 71>
<tr>
  <td colspan="2" align="center">
    <input name="remember" type="checkbox" value="yes">
     Keep me logged in<br><br><i style="font-size:13px;">It's not safe to remain logged in on shared reference desk computers.</i>
     <br><i style="font-size:13px;">After logging out, it's safest to close all your browser windows.</i>
  </td>
</tr>
</cfif>

<tr>
  <td colspan="2" align="center">
    <input name="aSubmit" type="submit" value="    Ok    " />
    <input name="aReset" type="reset" value=" Reset " />
  </td>
</tr>
</table>

<table align="center" style="font-family:Calibri, Arial, Helvetica, sans-serif;">
<tr>
	<td colspan="2" align="center" bgcolor="#FFFFFF" style="font-size:11px;">
		<cfoutput>#cgi.REMOTE_ADDR#  #Left(cgi.HTTP_USER_AGENT,65)# #now()#</cfoutput>
    </td>
</tr>
</table>
</form>

<!---sets the focus into the username box on the form--->
<script type="text/javascript" language="JavaScript">
document.forms['login'].elements['username'].focus();
</script>

</body>
</html>

<cfabort>

</cfif>
