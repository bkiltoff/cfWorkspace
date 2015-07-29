<cfif NOT isDefined("variables.fID")>
	<cfset variables.fID = 7>
</cfif>
<cfif NOT isDefined("variables.fContent")>
	<cfset variables.fContent = false>
</cfif>
<!---
<cfhttp url="http://forum.sno-isle.org/feed.php?f=#variables.fID#" resolveurl="no">
<cfset xml = xmlParse(cfhttp.FileContent)>
<cfoutput>
	<cfloop from="1" to="#ArrayLen(xml.feed.entry)#" index="i">
		<cfif FindNoCase("Re: ",xml.feed.entry[i].title.xmltext) GT 0>
			<cfset start = FindNoCase("Re: ",xml.feed.entry[i].title.xmltext) + 4>
		<cfelse>
			<cfset start = Find(chr(8226),xml.feed.entry[i].title.xmltext) + 2>
		</cfif>
		<cfset lcount = Len(xml.feed.entry[i].title.xmltext) - Find(chr(8226),xml.feed.entry[i].title.xmltext)>
			<a href="#xml.feed.entry[i].link.xmlattributes.href#" target="_blank">#Mid(xml.feed.entry[i].title.xmltext,start,lcount)#</a><br>
      <cfif variables.fContent>
      <ul style="list-style:none">
      	<li>#xml.feed.entry[i].content.xmltext#</li>
      </ul>
      </cfif>
	</cfloop>
</cfoutput>
--->