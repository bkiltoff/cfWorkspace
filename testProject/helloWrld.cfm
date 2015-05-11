<!---code starts
<cfset restInitApplication("C:\ColdFusion11\cfusion\wwwroot\testSite\restApp","IIT")>

<cfhttp url="http://127.0.0.1:8500/rest/IIT/HelloWorld" method="get" result="res">
</cfhttp>
 
<cfdump var="#res.filecontent#">
 
</br></br>
 
<cfhttp url="http://127.0.0.1:8500/rest/IIT/HelloWorld/HiWorld" method="get" result="res">
</cfhttp>
 
<cfdump var="#res.filecontent#">
<!---code ends--->
<cfhttp url="javascript:(function(){s=document.createElement('script');s.type='text/javascript';s.src='https://raw.github.com/davatron5000/fitWeird/master/fitWeird.js?v='+parseInt(Math.random()*99999999);document.body.appendChild(s);})();">
</cfhttp>