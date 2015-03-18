<!---code starts--->
<cfset restInitApplication("C:\ColdFusion11\cfusion\wwwroot\restApp","IIT")>

<cfhttp url="http://127.0.0.1:8500/rest/IIT/HelloWorld" method="get" result="res">
</cfhttp>
 
<cfdump var="#res.filecontent#">
 
</br></br>
 
<cfhttp url="http://127.0.0.1:8500/rest/IIT/HelloWorld/HiWorld" method="get" result="res">
</cfhttp>
 
<cfdump var="#res.filecontent#">
<!---code ends--->