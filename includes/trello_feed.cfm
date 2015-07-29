<cfset apiQualifier="boards/y8XWCtp7/cards">
<cfset sUrl=#application.trello["apiURL"]# & #apiQualifier# >

<cfhttp url=#sUrl# method="get">
	<cfhttpparam name="key" 			type="URL"	 	value=#application.trello["sKey"]#>
   	<cfhttpparam name="token" 			type="URL" 		value=#application.trello["sToken"]#>
    <cfhttpparam name="filter"			type="URL"		value="open">
    <cfhttpparam name="fields"			type="URL"		value="name,desc,due">
</cfhttp>

<cfset trelloData =	DeserializeJSON(cfhttp.FileContent)>
<cfoutput>
<!--- <cfdump var=#trelloData#> --->
    <ul>
    	<cfloop index="card" array=#trelloData#>
			<li>
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
            </li>
	    </cfloop>
    </ul>
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