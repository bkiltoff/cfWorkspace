
<CFFUNCTION NAME="MakeInputStringSafeForSQL" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<CFSET Local.text = #MakeInputSafeForSQL(Arguments.text)#>
	<CFSET Local.text = #StripNewline(Local.text)#>
	<CFSET Local.text = #Trim(Local.text)#>

	<CFRETURN #Local.text#>	
</CFFUNCTION>

