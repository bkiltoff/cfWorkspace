
<!---
Variables Required:	None
Variables Optional:	Attributes.Optional

Description:		This tag provides a form field variable called 'Author'.

Example:		<CF_custom_author>
--->


<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="DirectoryInformation" DATASOURCE="#Application.DataSource#">
SELECT DISTINCT report.username_fk,
	shared.active_directory.givenname,
	shared.active_directory.sn
FROM traffic.report
	INNER JOIN shared.active_directory ON traffic.report.username_fk = shared.active_directory.samaccountname
ORDER BY givenname, sn
</CFQUERY>
</CFLOCK>

<SELECT NAME="Author">
<CFIF IsDefined('Attributes.Optional') AND #Attributes.Optional# IS "true">
<OPTION VALUE=""></OPTION>
</CFIF>
<CFOUTPUT QUERY="DirectoryInformation">
	<OPTION VALUE="#DirectoryInformation.username_fk#">#DirectoryInformation.givenname# #DirectoryInformation.sn#</OPTION>
</CFOUTPUT>
</SELECT>

