
<cfhttp url="https://api.trello.com/1/boards/y8XWCtp7" method="get">
	<cfhttpparam name="key" 			type="URL"	 	value="f4f9f26d29e5d54bad8b04933669645f">
   	<cfhttpparam name="token" 			type="URL" 		value="cc9b63fc41bc0921c6bdc612f0322556332e765284d1e854762201e0a63f6b75">
    <cfhttpparam name="lists"			type="URL"		value="open">
    <cfhttpparam name="list_fields"		type="URL"		value="name">
    <cfhttpparam name="fields"			type="URL"		value="name,desc">
</cfhttp>

<cfset trelloData =	DeserializeJSON(cfhttp.FileContent)>

<cfdump var="#trelloData#">

<cfoutput>

</cfoutput>