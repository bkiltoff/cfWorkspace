
<!---
Variables Required:	None

Description:		This tag provides a form field variable called 'EquipmentType'.

Example:		<CF_custom_equpmenttype>
--->

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Types" DATASOURCE="#Application.DataSource#">
SELECT id, name
FROM traffic.equipment_type
ORDER BY name
</CFQUERY>
</CFLOCK>

<SELECT NAME="EquipmentType">
<CFOUTPUT QUERY="Types">
<OPTION VALUE="#Types.id#">#Types.name#</OPTION>
</CFOUTPUT>
<OPTION VALUE="" SELECTED></OPTION>
</SELECT>

