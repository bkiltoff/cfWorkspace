
<CFFUNCTION NAME="StripNewline" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<CFSET Local.text = #REReplace(Arguments.text, "[#Chr(10)#]", " ", "ALL")#>
	<CFSET Local.text = #REReplace(Local.text, "[#Chr(13)#]", " ", "ALL")#>

	<CFRETURN #Local.text#>
</CFFUNCTION>



