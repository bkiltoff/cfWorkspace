<cfcomponent output="false">
	<!----------------------------------------------------------------------------->
    <!---onApplicationStart()--->
    <!----------------------------------------------------------------------------->
    <cffunction name="onApplicationStart" >
        <cfset this.serialization.preservecaseforstructkey = true>
        <cfset application.trello				= 	structNew() >
        <cfset application.trello["apiURL"]		= 	"https://api.trello.com/1/boards/">
        <cfset application.trello["sKey"]		= 	"f4f9f26d29e5d54bad8b04933669645f">
        <cfset application.trello["sSecret"]	= 	"ec051d22dfbec605b5eb1a38048016c2c833f862dbadd14c7ede8fe99ab737ae">
		<cfset application.trello["sToken"]		=	"cc9b63fc41bc0921c6bdc612f0322556332e765284d1e854762201e0a63f6b75">
        <cfreturn>	
    </cffunction>
</cfcomponent>