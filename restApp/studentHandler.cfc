<!---
--->
<cfcomponent restpath="student" rest="true">
	<cfquery name="testQuery" datasource="sql.sno-isle.org">
	SELECT Count(*)
	FROM Table_1
	</cfquery>
	<cffunction name="getmethod" access="remote" output="no" returntype="Any" httpmethod="get" description="A method to handle get calls in student resource.">
	    <cfreturn #testQuery#>
	</cffunction>
</cfcomponent>