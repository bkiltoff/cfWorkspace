
<CFFUNCTION NAME="ScrubString" RETURNTYPE="string">
<CFARGUMENT NAME="text" TYPE="string" REQUIRED="yes">
<CFARGUMENT NAME="acceptable_characters" TYPE="string" REQUIRED="yes" DEFAULT="1234567890 abcdefghijklmnopqrstuvwxyz">

	<CFRETURN #ReReplaceNoCase(Arguments.text, "[^#Arguments.acceptable_characters#]", "", "ALL")#>
</CFFUNCTION>

