<cftry>
  <cfquery name="LogAccess" datasource="sql.sno-isle.org">
INSERT
INTO   intranet.adminusage
       (
              user_fk       ,
              application_fk,
              userip        ,
              useragent     ,
              datetimeinserted
       )
       VALUES
       (
              '#variables.samaccountname#' ,
              '41'                         ,
              '#cgi.REMOTE_ADDR#'          ,
              '#cgi.HTTP_USER_AGENT#'      ,
              #CreateODBCDateTime(now())#
       );
</cfquery>
  <cfcatch type="Any">
   
  </cfcatch>
</cftry>