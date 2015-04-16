<CFFUNCTION NAME="MayAccessObject" RETURNTYPE="boolean">
<CFARGUMENT NAME="object" TYPE="numeric" REQUIRED="yes">

<CFSET Local.Object = #MakeInputNumberSafeForSQL(Arguments.Object)#>

<!--- Verify that the object exists as an auth_object in the database --->
<CFTRY>

<CFLOCK TYPE="ReadOnly" SCOPE="Application" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="ObjectCheck" DATASOURCE="#Application.DataSource#">
SELECT name
FROM traffic.auth_object
WHERE id='#Local.Object#'
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Database">
	<CFTHROW MESSAGE="#CFCATCH.Message#" DETAIL="#CFCATCH.Detail#" TYPE="Custom.Tag.Database">
</CFCATCH>

</CFTRY>

<CFIF NOT IsDefined('ObjectCheck.RecordCount') OR #ObjectCheck.RecordCount# NEQ 1>
	<CFTHROW MESSAGE="Object Does Not Exist" DETAIL="The declared authorization object does not exist in the table of objects" TYPE="Custom.Tag.AuthObjectDoesNotExist">
</CFIF>


<!--- We now see a valid object.  Check permission. --->

<CFIF NOT IsDefined('ActiveDirectoryAuthenticatedUsername')>
	<CFTHROW MESSAGE="Not Authenticated" DETAIL="You are not authenticated via Active Directory" TYPE="Custom.Tag.NotAuthenticated">
</CFIF>


<!--- Does the username have a permission entry for the object? --->
<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Permission" DATASOURCE="#Application.DataSource#">
SELECT auth_permission.id AS permission_id,
	auth_user.name AS user_name,
	auth_object.id AS object_id,
	auth_object.name AS object_name
FROM traffic.auth_permission
	INNER JOIN traffic.auth_user ON traffic.auth_permission.auth_user_fk = traffic.auth_user.id
	INNER JOIN traffic.auth_object ON traffic.auth_permission.auth_object_fk = traffic.auth_object.id
WHERE	auth_user.name=LCASE('#ActiveDirectoryAuthenticatedUsername#') AND
	auth_object.id='#Local.Object#'
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Database">
	<CFTHROW MESSAGE="#CFCATCH.Message#" DETAIL="#CFCATCH.Detail#" TYPE="Custom.Tag.Database">
</CFCATCH>

</CFTRY>


<CFIF IsDefined('Permission.RecordCount') AND #Permission.RecordCount# EQ 1>
	<!--- User has permission --->
	<CFRETURN "true">
</CFIF>

<CFIF IsDefined('Permission.RecordCount') AND #Permission.RecordCount# GT 1>
	<CFTHROW MESSAGE="Not Authorized" DETAIL="You have multiple permission assignments for this object.  Please contact administrator." TYPE="Custom.Tag.NotAuthorized">
</CFIF>

<!--- Otherwise the user does not have permission --->
<CFRETURN "false">

</CFFUNCTION>

