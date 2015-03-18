<CFFUNCTION NAME="GetActiveDirectoryAuthenticatedUsername" RETURNTYPE="string" OUTPUT="false">

<CFIF IsDefined('Variables.ActiveDirectoryAuthenticatedUsername') AND LEN(#Variables.ActiveDirectoryAuthenticatedUsername#) GT 0>
	<CFRETURN "#Variables.ActiveDirectoryAuthenticatedUsername#">
<CFELSE>
	<CFRETURN "Unknown User">
</CFIF>
</CFFUNCTION>
