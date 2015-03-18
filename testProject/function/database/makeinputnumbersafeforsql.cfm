
<CFFUNCTION NAME="MakeInputNumberSafeForSQL" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<CFSET Local.text = #ScrubString(Arguments.text, "0123456789")#>

	<CFRETURN #Local.text#>	
</CFFUNCTION>

