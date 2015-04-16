
<!---
Variables Required:	None

Description:		This tag creates the HTML to play a sound.

Example:		<CF_custom_sound_error_input>
--->


<!--- Find the url for the error sound --->
<CFLOCK TYPE="ReadOnly" SCOPE="Application" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Sound" DATASOURCE="#Application.DataSource#">
SELECT value as url
FROM traffic.system_definition
WHERE name='url_sound_error_input'
</CFQUERY>
</CFLOCK>

<CFOUTPUT>
<BGSOUND SRC="#Sound.url#">
</CFOUTPUT>

