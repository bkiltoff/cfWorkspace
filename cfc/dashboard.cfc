<cfcomponent>
	<cffunction name="pullAlerts" access="public" returntype="string">
		<cfargument name="fID" type="string" required="yes">
		<cfset fResult="">
		<cfhttp url="http://forum.sno-isle.org/feed.php?f=#arguments.fID#" resolveurl="no">
		<cfset xml = xmlParse(cfhttp.FileContent)>
    <cfif isDefined("xml.feed.entry")>
			<cfloop from="1" to="#ArrayLen(xml.feed.entry)#" index="i">
				<cfif FindNoCase("Re: ",xml.feed.entry[i].title.xmltext) GT 0>
					<cfset start = FindNoCase("Re: ",xml.feed.entry[i].title.xmltext) + 4>
				<cfelse>
					<cfset start = Find(chr(8226),xml.feed.entry[i].title.xmltext) + 2>
				</cfif>
				<cfset lcount = Len(xml.feed.entry[i].title.xmltext) - Find(chr(8226),xml.feed.entry[i].title.xmltext)>
					<cfset fResult = fResult & '<li><span>***ALERT***</span><a href="#xml.feed.entry[i].link.xmlattributes.href#" target="_blank">#Mid(xml.feed.entry[i].title.xmltext,start,lcount)#</a></li>'>
			</cfloop>
    <cfelse>
    	<cfset fResult = "<li><span class='inspir'>We're in the pipe, five by five.</span><a>&nbsp;</a></li><li><span class='inspir'>Oh, hi. So, how are you holding up? BECAUSE I'M A POTATO!</span><a>&nbsp;</a></li><li><span class='inspir'>You must construct additional pylons.</span><a>&nbsp;</a></li><li><span class='inspir'>Do or do not, There is no try.</span><a>&nbsp;</a></li><li><span class='inspir'>It's dangerous to go alone; take this!</span><a>&nbsp;</a></li><li><span class='inspir'>I'm sorry, Dave, I'm afraid I cant do that.</span><a>&nbsp;</a></li>">
    </cfif>  
		<cfreturn fResult>
	</cffunction>
</cfcomponent>