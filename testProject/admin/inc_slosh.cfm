<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-845744-11', 'sno-isle.org');
  ga('send', 'pageview');

</script>


<cfif cgi.REMOTE_ADDR IS "172.31.0.13X">

<cfdump var="#cookie#">


</cfif>

<cfif isDefined('cookie.ActiveDirectoryToken')>

<cftry>
<cfset SecretKey = "jdk934h1205jfqa">


<cfif LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),3,"|")) LT #CreateODBCDateTime(CreateDateTime(2014,07,22,12,38,00))#>
<cflocation url="/logout/">
</cfif>


<cfset samaccountname = LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),2,"|"))>

<cfquery name="GetStaff" datasource="sql.sno-isle.org">
SELECT *                          
FROM   shared.active_directory
WHERE  samaccountname = '#variables.samaccountname#'
</cfquery>








<cfcatch type="Any"><cflocation url="/logout/"></cfcatch>
</cftry>

<cfelse>
	<cflocation url="/logout/">
</cfif>

<cfhtmlhead text="<link href=#chr(34)#/admin/styles.css#chr(34)# rel=#chr(34)#stylesheet#chr(34)# type=#chr(34)#text/css#chr(34)#>">


<cftry>
<cfif isDefined('cookie.ActiveDirectoryToken')>

<cfset SecretKey = "jdk934h1205jfqa">

<cfset samaccountname = LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),2,"|"))>

<cfquery name="GetStaffDetails" datasource="sql.sno-isle.org" cachedwithin="#CreateTimeSpan(0,0,15,0)#">
SELECT samaccountname, givenname, sn, title
FROM shared.active_directory
WHERE samaccountname = '#variables.samaccountname#'
</cfquery>

<cfquery name="GetPages" datasource="sql.sno-isle.org">
SELECT visibility.name as visibility, grouping.name as name, givenname, sn, telephonenumber, page.id, grouping.name as grouping, page.title_prefix, page.title, mail, expiration
FROM web_page.page
LEFT JOIN shared.active_directory ON active_directory.samaccountname = page.editor_fk
LEFT JOIN web_page.visibility ON visibility.id = page.visibility_fk
LEFT JOIN web_page.grouping ON grouping.id = page.grouping_fk
WHERE author_fk = '#GetStaffDetails.samaccountname#'
AND expiration < #CreateODBCDate(now()-395)#
AND archive <> 'Y';
</cfquery>

<cfif GetPages.RecordCount GT 0>
<!--- <cfmail to="mlongley@sno-isle.org" from="auto-generated@sno-isle.org" subject="Expired page red banner #GetStaffDetails.samaccountname#" type="html"><cfdump var="#cgi#"></cfmail> --->
<cfoutput>

<cfset bHeight = "150">

<cfif GetStaffDetails.samaccountname IS "jmulhall">
<cfset bHeight = "150">
</cfif>


<div style="font-family:Arial; background-color:red; width:100%; height:#variables.bHeight#px; text-align:center; color:white; padding-top:35px; font-size:30px;"><b style="font-size:40px;">#GetStaffDetails.givenname# #GetStaffDetails.sn#</b><br>WARNING! You have #GetPages.RecordCount# <cfif GetPages.RecordCount IS 0>pages that need<cfelseif GetPages.RecordCount IS 1>page that needs<cfelse>pages that need</cfif> review.  <a href="/applications/pagereview/" style="color:white; text-decoration:underline;">Review today</a>!</div>
</cfoutput>
</cfif>

</cfif>
<cfcatch type="any"></cfcatch>
</cftry>


<div id="cms-header">




  <div id="cms-header-logo">
    <a href="/admin/" target="_parent">
      <img src="/image/slosh.gif" width="237" height="35" border="0" alt="silCMS" />
    </a>
  </div>
  <div id="cms-header-view" class="cms-header-text">
  
  
    <a href="/admin/" target="_parent" style="color:white;">
       Administration Home
    </a>
	
	<!--- Super amazing blah blah blah tech report alert --->
	<cfif GetStaff.samaccountname IS "jthornton" OR GetStaff.samaccountname IS "rkerr" OR GetStaff.samaccountname IS "mwilson" OR GetStaff.samaccountname IS "reads">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;




<!---<cfif cgi.REMOTE_ADDR IS "172.31.1.19">--->
<script type="text/javascript">

	function httpGet(theUrl)
	{
		var xmlHttp = null;
		
		xmlHttp = new XMLHttpRequest();
		xmlHttp.open("GET", theUrl, false);
		xmlHttp.send(null);
		return xmlHttp.responseText;
	}

	setTimeout(function(){
		document.getElementById('techAlert').innerHTML=httpGet("/dev/jacob/techalerttest/techalert.cfm");
		if (document.getElementById('mTechBody') != null)
			{
				document.getElementById('mTechBody').innerHTML=httpGet("/dev/jacob/trmobile/home/");
			}
		window.name=document.title;
		if (httpGet("/dev/jacob/techalerttest/techalert.cfm?titletext=y") != '') 
			{
				document.title=httpGet("/dev/jacob/techalerttest/techalert.cfm?titletext=y")
			}
			}, 250);
	setInterval(function(){
		document.getElementById('techAlert').innerHTML=httpGet("/dev/jacob/techalerttest/techalert.cfm");
		if (document.getElementById('mTechBody') != null)
			{
				document.getElementById('mTechBody').innerHTML=httpGet("/dev/jacob/trmobile/home/");
			}
		if (httpGet("/dev/jacob/techalerttest/techalert.cfm?titletext=y") != '') 
			{
				document.title=httpGet("/dev/jacob/techalerttest/techalert.cfm?titletext=y")
			}
		else
			{
				document.title=window.name
			}
		}, 60000);
</script>
<div id="techAlert" style="display:inline"></div>
<!---</cfif>--->


</cfif>
	
  </div>
  


  
  <div class="cms-header-right cms-header-text">
  
  
  
  
  <cfoutput>
   <b style="font-size:26px; color:yellow;">#GetStaff.givenname# #GetStaff.sn#</i></b>
    <a href="/logout/?ref=#cgi.SCRIPT_NAME#" target="_parent">
    
  
    </cfoutput> 
    
      <img src="/admin/logoff.gif" width="80" height="20" border="0" alt="logout">
    </a>
  </div>
</div>


<cfif cgi.REMOTE_ADDR IS "172.31.0.13X">

<cfoutput>#LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),3,"|"))#</cfoutput>

<cfdump var="#variables#">

</cfif>