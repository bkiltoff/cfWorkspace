<h2>Application Configuration</h2>

<cfquery name="GetApplication" datasource="sql.sno-isle.org">
SELECT
   application_name,
   application_url,
   description,
   user_description,
   process_steps  
FROM
   intranet.applications         
LEFT JOIN
   intranet.application_categories                
      ON application_categories.pk = applications.category_fk  
WHERE
   applications.pk = '#url.aid#'
</cfquery>

<br>

<form action="/admin/edit_details_action.cfm" method="post">

<cfoutput query="GetApplication">

<input name="aid" type="hidden" value="#url.aid#">

<table style="font-family:Calibri, Arial, Helvetica, sans-serif;">

<tr><td align="right" valign="top"><b>Application Name:</b></td><td><input name="application_name" type="text" value="#GetApplication.application_name#" size="55" maxlength="55"></td></tr>

<tr><td align="right" valign="top"><b>Application URL:</b></td><td><input name="application_url" type="text" value="#GetApplication.application_url#" size="55" maxlength="55"></td></tr>

<tr><td align="right" valign="top"><b>Description</b></td><td><textarea name="description" cols="80" rows="6" wrap="virtual">#GetApplication.description#</textarea></td></tr>

<tr><td align="right" valign="top"><b>Primary Users / Developers:</b></td><td><textarea name="user_description" cols="80" rows="6" wrap="virtual">#GetApplication.user_description#</textarea></td></tr>

<tr><td align="right" valign="top"><b>Process Steps:</b></td><td><textarea name="process_steps" cols="80" rows="10" wrap="virtual">#GetApplication.process_steps#</textarea></td></tr>

<tr><td align="right" valign="top"></td><td><input name="submit" type="submit" value="Save and Continue"></td></tr>

</table>

</cfoutput>

</form>