
<CFFUNCTION NAME="MakeInputSafeForSQL" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<!--- Allow normal characters except ` --->
	<CFSET Local.text = #ScrubString(Arguments.text, "0123456789 \\abcdefghijklmnopqrstuvwxyz\[\]\{\}\(\)\+\*\=\-\_\|\&\^\%\$\##\@\!\~''""\<\>\,\.\?\/\;\:\n\tñáÁóÓ¿éÉúÚ¡íÍÑü")#>

	<CFSET Local.text = #StripHTML(Local.text)#>
	<CFSET Local.text = #EscapeBackslash(Local.text)#>
	<CFSET Local.text = #EscapeSingleQuote(Local.text)#>

	<CFRETURN #Local.text#>	
</CFFUNCTION>

