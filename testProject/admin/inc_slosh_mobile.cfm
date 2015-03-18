<cfif cgi.REMOTE_ADDR IS "172.31.0.13X">

<cfdump var="#cookie#">


</cfif>

<cfif isDefined('cookie.ActiveDirectoryToken')>

<cftry>
<cfset SecretKey = "jdk934h1205jfqa">


<cfif LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),3,"|")) LT #CreateODBCDateTime(CreateDateTime(2011,02,10,13,00,00))#>

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

<cfhtmlhead text="<link href=#chr(34)#/admin/styles_mobile.css#chr(34)# rel=#chr(34)#stylesheet#chr(34)# type=#chr(34)#text/css#chr(34)#>">


<div id="cms-header">




  <div id="cms-header-logo">
    <a href="/admin/" target="_parent">
    <cfif GetStaff.samaccountname IS "jthornton" OR GetStaff.samaccountname IS "mlongley">
      <img src="/image/slosh_mobile.gif" width="98" height="35" border="0" alt="silCMS" />
      <cfhtmlhead text="<meta name='viewport' content='width=device-width, initial-scale=1, maximum-scale=1'>">   
    <cfelse>
      <img src="/image/slosh.gif" width="237" height="35" border="0" alt="silCMS" />
    </cfif>
    </a>
  </div>
  <div class="cms-header-right cms-header-text">
  
  
  
  
  <cfoutput>
  <cfif GetStaff.samaccountname IS "jthornton" OR GetStaff.samaccountname IS "mlongley">
   <b style="font-size:14px; color:yellow;">#GetStaff.givenname# #GetStaff.sn#</i></b>
  <cfelse>
   <b style="font-size:26px; color:yellow;">#GetStaff.givenname# #GetStaff.sn#</i></b>
  </cfif>
    <a href="/logout/?ref=#cgi.SCRIPT_NAME#" target="_parent">
    
  
    </cfoutput> 
    
      <img src="/admin/logoff.gif" width="80" height="20" border="0" alt="logout">
    </a>
  </div>
  <br clear="all" />
  <div id="cms-header-view" class="cms-header-text">
  
  
    <a href="/admin/" target="_parent" style="color:white;">
       Administration Home
    </a>
	
	<!--- Super amazing blah blah blah tech report alert --->
	<cfif GetStaff.samaccountname IS "mlongley" OR GetStaff.samaccountname IS "jthornton">
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
		}, 30000);
</script>
<div id="techAlert" style="display:inline"></div>
<!---</cfif>--->


</cfif>
	
  </div>
  


</div>


<cfif cgi.REMOTE_ADDR IS "172.31.0.13X">

<cfoutput>#LCase(ListGetAt(Decrypt(cookie.ActiveDirectoryToken,variables.SecretKey),3,"|"))#</cfoutput>

<cfdump var="#variables#">

</cfif>