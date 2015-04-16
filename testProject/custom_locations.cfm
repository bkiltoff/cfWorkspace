
<!---
Variables Required:	None
Variables Optional:	Attributes.Optional
			Attributes.SelfSelect

Description:		This tag provides a form field variable called 'Locations'.

Example:		<CF_custom_locations>
--->


<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Locations" DATASOURCE="#Application.DataSource#">
SELECT id,
	name,
	abbreviation
FROM shared.library
ORDER BY name
</CFQUERY>
</CFLOCK>


<CFTRY>
<CFQUERY NAME="NetworkCheck" DATASOURCE="#Application.DataSource#">
SELECT INET_NTOA(address),
        INET_NTOA(mask),
        purpose,
	library_fk,
        library.name AS library_name
FROM shared.ip
        LEFT JOIN shared.library ON shared.ip.library_fk = shared.library.id
WHERE address = INET_ATON('#CGI.REMOTE_ADDR#') & mask
</CFQUERY>

<CFCATCH TYPE="Database">
        <CFTHROW MESSAGE="#CFCATCH.Message#" DETAIL="#CFCATCH.Detail#" TYPE="Custom.Tag.Database">
</CFCATCH>
</CFTRY>



<SELECT NAME="Location">
<CFIF IsDefined('Attributes.Optional') AND #Attributes.Optional# IS "true">
<OPTION VALUE=""></OPTION>
</CFIF>
<CFOUTPUT QUERY="Locations">

<CFIF IsDefined('Attributes.SelfSelect') AND #Attributes.SelfSelect# IS "true" AND #Locations.id# IS #NetworkCheck.library_fk#>
	<OPTION VALUE="#Locations.id#" SELECTED>#Locations.name#</OPTION>
<CFELSE>
	<OPTION VALUE="#Locations.id#">#Locations.name#</OPTION>
</CFIF>

</CFOUTPUT>
</SELECT>

