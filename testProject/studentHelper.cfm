<cfset restInitApplication("C:\ColdFusion11\cfusion\wwwroot\testSite\restApp","IIT")>

<cfhttp url="http://127.0.0.1:8500/rest/IIT/student" method="get">
  
<cfoutput>#cfhttp.filecontent#</cfoutput>