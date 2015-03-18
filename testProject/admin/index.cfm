<cfquery name="GetCategories" datasource="sql.sno-isle.org">
SELECT   pk,
         category_name
FROM     intranet.application_categories
ORDER BY sort;
</cfquery>
<br>

<cfif cgi.REMOTE_ADDR IS "172.31.0.2X1">
<cfset samaccountname = "cwerle">
</cfif>



<div class="admin-apps">
  <div class="admin-apps-col"> <cfoutput query="GetCategories" maxrows="3" startrow="1">
      <cfquery name="GetApps" datasource="sql.sno-isle.org">
SELECT   pk              ,
         application_name,
         application_url,
		 description
FROM     intranet.applications
WHERE    category_fk = '#GetCategories.pk#'
AND admin = 'N'
ORDER BY application_name;
</cfquery>
      <b>#GetCategories.category_name#</b>
      <ul>
        <cfloop query="GetApps">
          <cfquery name="CheckOK" datasource="sql.sno-isle.org">
SELECT application_name,
       application_url
FROM   intranet.applications,
       intranet.security
WHERE  applications.pk   = security.application_fk
AND    applications.pk   = '#GetApps.pk#'
AND    samaccountname_fk = '#variables.samaccountname#'

UNION

SELECT application_name,
       application_url
FROM   intranet.applications
WHERE  all_staff       = 'Y'
AND    applications.pk = '#GetApps.pk#';
      </cfquery>
         
           <cfif CheckOK.RecordCount GT 0>
             <li><a href="#GetApps.application_url#" title="#GetApps.description#"> #GetApps.application_name# </a> <cfif GetStaff.samaccountname IS "Xmlongley" OR GetStaff.samaccountname IS "Xjthornton"><a href="/admin/edit_details.cfm?aid=#GetApps.pk#"><img src="/image/Pencil-icon.png" width="14" height="14" border="0"></a></cfif></li>
               </cfif>
               
               
          
        </cfloop>
      </ul>
    </cfoutput> </div>
  <div class="admin-apps-col"> <cfoutput query="GetCategories" startrow="4">
      <cfquery name="GetApps" datasource="sql.sno-isle.org">
SELECT   pk              ,
         application_name,
         application_url,
		 description
FROM     intranet.applications
WHERE    category_fk = '#GetCategories.pk#'
AND admin = 'N'
ORDER BY application_name;
</cfquery>
      <b>#GetCategories.category_name#</b>
      <ul>
        <cfloop query="GetApps">
          <cfquery name="CheckOK" datasource="sql.sno-isle.org">
SELECT application_name,
       application_url
FROM   intranet.applications,
       intranet.security
WHERE  applications.pk   = security.application_fk
AND    applications.pk   = '#GetApps.pk#'
AND    samaccountname_fk = '#variables.samaccountname#'

UNION

SELECT application_name,
       application_url
FROM   intranet.applications
WHERE  all_staff       = 'Y'
AND    applications.pk = '#GetApps.pk#';
</cfquery>
         
           
            <cfif CheckOK.RecordCount GT 0>
              <li>  <a href="#GetApps.application_url#" title="#GetApps.description#"> #GetApps.application_name# </a> <cfif GetStaff.samaccountname IS "Xmlongley" OR GetStaff.samaccountname IS "Xjthornton"><a href="/admin/edit_details.cfm?aid=#GetApps.pk#"><img src="/image/Pencil-icon.png" width="14" height="14" border="0"></a></cfif>
           </li>
             
               </cfif>
             
      
        </cfloop>
      </ul>
    </cfoutput> </div>

<cfif GetStaff.samaccountname IS "mlongley" OR GetStaff.samaccountname IS "jthornton">

<br clear="all">

<br>

<cfoutput>
 <cfquery name="GetApps" datasource="sql.sno-isle.org">
SELECT   pk              ,
         application_name,
         application_url,
		 description
FROM     intranet.applications
WHERE    admin = 'Y'
ORDER BY application_name;
</cfquery>
      <b>Private Admin</b>
      <ul>
        <cfloop query="GetApps">
          <cfquery name="CheckOK" datasource="sql.sno-isle.org">
SELECT application_name,
       application_url
FROM   intranet.applications,
       intranet.security
WHERE  applications.pk   = security.application_fk
AND    applications.pk   = '#GetApps.pk#'
AND    samaccountname_fk = '#variables.samaccountname#'

UNION

SELECT application_name,
       application_url
FROM   intranet.applications
WHERE  all_staff       = 'Y'
AND    applications.pk = '#GetApps.pk#';
</cfquery>
          <li> 
           
             <a href="#GetApps.application_url#" title="#GetApps.description#"> #GetApps.application_name# </a> <cfif GetStaff.samaccountname IS "Xmlongley" OR GetStaff.samaccountname IS "Xjthornton"><a href="/admin/edit_details.cfm?aid=#GetApps.pk#"><img src="/image/Pencil-icon.png" width="14" height="14" border="0"></a></cfif>
             
       </li>
        </cfloop>
      </ul>
    </cfoutput>

</cfif>


