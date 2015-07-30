<cfset trello				= 	structNew() >
	<cfset trello["apiURL"]		= 	"https://api.trello.com/1/">
    <cfset trello["sKey"]		= 	"f4f9f26d29e5d54bad8b04933669645f">
    <cfset trello["sSecret"]	= 	"ec051d22dfbec605b5eb1a38048016c2c833f862dbadd14c7ede8fe99ab737ae">
    <cfset trello["sToken"]		=	"cc9b63fc41bc0921c6bdc612f0322556332e765284d1e854762201e0a63f6b75">

<cfset apiQualifier="boards/y8XWCtp7/cards">
<cfset sUrl=#trello["apiURL"]# & #apiQualifier# >

<!--- gets all cards off of the "Tech Feed" board. Will need to use 
a different API qualifier to get cards by list --->    
<cfhttp url=#sUrl# method="get">
	<cfhttpparam name="key" 			type="URL"	 	value=#trello["sKey"]#>
   	<cfhttpparam name="token" 			type="URL" 		value=#trello["sToken"]#>
    <cfhttpparam name="filter"			type="URL"		value="open">
    <cfhttpparam name="fields"			type="URL"		value="name,desc,due">
</cfhttp>

<cfset trelloData =	DeserializeJSON(cfhttp.FileContent)>
<cfset cardCount = ArrayLen(trelloData)>
<cfoutput>
<!--- <cfdump var=#trelloData#> --->
		<h2>IT Activity</h2>
       	<cfloop index="i" from="1" to="#cardCount#">
        <cfset card=trelloData[i]>
        <cfset cardID="card" & i>
            	<div class="card">
                    <div class="cardName">
                        #HTMLEditFormat(card.name)#
                        <cfif card.due NEQ "null">
                            <div class="cardDue">
                                Planned Completion: #cleanUpTrelloDate(card.due)#
                            </div>
                        </cfif>
                    </div>
                    <div class="cardDesc">
                        #HTMLEditFormat(card.desc)#
                    </div>
				</div>
                <br>
	    </cfloop>
</cfoutput>

<cfscript>
	/*cleanup a trello date [2015-07-31T19:00:00.000Z] to just the year-month-day string*/
	private String function cleanUpTrelloDate(String TrelloDate)
	{
		revDate = "";
		if(Len(TrelloDate) >= 10){
			revDate = Left(TrelloDate,10);
		}
		else{
		revDate = TrelloDate;
		}
		return DateFormat(revDate,"full");
	}
</cfscript>