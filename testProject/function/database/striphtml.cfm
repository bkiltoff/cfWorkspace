
<CFFUNCTION NAME="StripHTML" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<!--- Remove HTML tags --->
	<CFSET Local.text = #REReplace(Arguments.text, "<[^>]*>", "", "ALL")#>

	<!--- Remove entities --->
	<CFSET Local.text = #REReplace(Local.text, "&(##[[:digit:]]]]+|[[:alpha:]]+);", "", "ALL")#>

	<CFRETURN #Local.text#>
</CFFUNCTION>
