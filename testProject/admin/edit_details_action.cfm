<cfquery name="EditLog" datasource="sql.sno-isle.org">
UPDATE
   intranet.applications  
SET
   application_name = '#form.application_name#',
   application_url = '#form.application_url#',
   description = '#form.description#',
   user_description = '#form.user_description#',
   process_steps = '#form.process_steps#'  
WHERE
   pk = #form.aid#;
</cfquery>

<cflocation url="/admin/">