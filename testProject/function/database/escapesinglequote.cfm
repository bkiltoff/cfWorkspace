
<CFFUNCTION NAME="EscapeSingleQuote" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<CFRETURN #REReplace(Arguments.text, "['']", "''", "ALL")#>
</CFFUNCTION>

