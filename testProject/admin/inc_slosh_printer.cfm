<cfif isDefined('cookie.ActiveDirectoryToken')>

<cftry>
<cfset SecretKey = "jdk934h1205jfqa">


<cfif LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),3,"|")) LT #CreateODBCDateTime(CreateDateTime(2011,02,10,13,00,00))#>

</cfif>


<cfset samaccountname = LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),2,"|"))>

<cfquery name="GetStaff" datasource="sql.sno-isle.org">
SELECT *                          
FROM   shared.active_directory
WHERE  samaccountname = '#variables.samaccountname#'
</cfquery>





<cfcatch type="Any"><cflocation url="/logout/"></cfcatch>
</cftry>

<cfelse>
	<cflocation url="/logout/">
</cfif>

