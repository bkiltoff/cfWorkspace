<CFAPPLICATION
	NAME="tech_report"
	CLIENTMANAGEMENT="No"
	SESSIONMANAGEMENT="No"
	SETCLIENTCOOKIES="No"
	SETDOMAINCOOKIES="No">

<CFLOCK TYPE="Exclusive" SCOPE="Application" TIMEOUT="10" THROWONTIMEOUT="No">
<CFIF NOT IsDefined('Application.Initialized')>
	<CFSET Application.DataSource = "sql.sno-isle.org">
	<CFSET Application.Initialized = TRUE>
</CFIF>
</CFLOCK>


<CFINCLUDE TEMPLATE="function/all.cfm">


<!---<!--- Make sure the database is available --->
<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="DatabaseCheck" DATASOURCE="#Application.DataSource#">
SELECT NOW()
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Database">
	<CFOUTPUT>
	<P>Sorry, the database is not available right now.  Try again later, fucker.</P>
	</CFOUTPUT>
	<CFABORT/>
</CFCATCH>

</CFTRY>
--->







<!---<!--- Authenticate --->
<CFTRY>

<CF_AUTHENTICATE>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>Authentication system error: #CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>

        <CFABORT/>
</CFCATCH>

</CFTRY>

--->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Technology Reports</TITLE>
<LINK HREF="stylesheet/default.css" REL="stylesheet" TYPE="text/css" TITLE="default">
</HEAD>
<BODY STYLE="margin: 0;">





<!---<CFINCLUDE TEMPLATE="admin/inc_slosh.cfm">--->

<!--- Bring window to front --->
<SCRIPT TYPE="text/javascript" LANGUAGE="JavaScript">
window.focus();
</SCRIPT>

<table width="95%" align="center" cellpadding="1" bgcolor="#FFFFFF">
<tr>

	<td><h1 style="color:#5073A2;"><b>Technology Report</b></h1></td>
	<td align="right" valign="bottom">[ <a href="./">Home</a> ] [ <a href="send.cfm">New Report</a> ] [ <a href="search.cfm">Search</a> ]</td>
</tr>
</table>


	<table width="95%" align="center" cellpadding="1" bgcolor="#5073A2">
	<tr>
	<td bgcolor="#eeeeee" style="padding: 15px;"> 

