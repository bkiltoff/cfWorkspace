
<CFFUNCTION NAME="MakeInputSafeForSQL" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
	<!--- Allow normal characters except ` --->
	<CFSET Local.text = #ScrubString(Arguments.text, "0123456789 \\abcdefghijklmnopqrstuvwxyz\[\]\{\}\(\)\+\*\=\-\_\|\&\^\%\$\##\@\!\~''""\<\>\,\.\?\/\;\:\n\t����ӿ���ڡ����")#>

	<CFSET Local.text = #StripHTML(Local.text)#>
	<CFSET Local.text = #EscapeBackslash(Local.text)#>
	<CFSET Local.text = #EscapeSingleQuote(Local.text)#>

	<CFRETURN #Local.text#>	
</CFFUNCTION>

