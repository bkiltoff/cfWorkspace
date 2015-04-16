
<!---
Variables Required:	None
Variables Optional:	Attributes.Optional
			Attributes.Default
			Attributes.UserAssigned

Description:		This tag provides a form field variable called 'Area'.

Example:		<CF_custom_area>
--->

<CFIF IsDefined('Attributes.UserAssigned') AND LEN(#Attributes.UserAssigned#)>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="SelectArea" DATASOURCE="#Application.DataSource#">
SELECT id, name
FROM traffic.area
WHERE self_assign='yes'
ORDER BY name
</CFQUERY>
</CFLOCK>

<CFELSE>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="SelectArea" DATASOURCE="#Application.DataSource#">
SELECT id, name
FROM traffic.area
ORDER BY name
</CFQUERY>
</CFLOCK>

</CFIF>



<SELECT NAME="Area">
<CFIF IsDefined('Attributes.Optional') AND #Attributes.Optional# IS "true">
<OPTION VALUE=""></OPTION>
</CFIF>

<OPTION VALUE="">Information Technology</OPTION>

<CFOUTPUT QUERY="SelectArea">
	<CFIF IsDefined('Attributes.Default') AND #SelectArea.id# IS #Attributes.Default#>
		<OPTION VALUE="#SelectArea.id#" SELECTED>#SelectArea.name#</OPTION>
	<CFELSE>
		<OPTION VALUE="#SelectArea.id#">#SelectArea.name#</OPTION>
	</CFIF>
</CFOUTPUT>
</SELECT>
