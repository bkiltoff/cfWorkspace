<!---<!--- authenticate --->
<cfset adminObj = createObject("component","cfide.adminapi.administrator")>
<cfset adminObj.login("Ut%qBd##1xvQ8")>
<!--- get monitor object --->
<cfset sMonObj = createObject("component","cfide.adminapi.servermonitoring")>
<!--- kill thread --->
<cfset sMonObj.abortRequest("jrpp-4846")>--->





<cfthread action="terminate" name="4846"></cfthread>
