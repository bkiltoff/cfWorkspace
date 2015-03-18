

<H3>Reports</H3>
<DIV STYLE="padding: 1em;">

<FORM ACTION="report_show.cfm" METHOD="GET">
<INPUT TYPE="text" Name="Id" SIZE="5" MAXLENGTH="20">
Enter your receipt number and press  Enter
</FORM>




<CFTRY>
<CFIF #MayAccessObject("1")#>

<FORM ACTION="report_list.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="Command" VALUE="Incoming"> Reports
<INPUT NAME="Status" VALUE="1" TYPE="hidden">
<INPUT NAME="NoClaim" VALUE="true" TYPE="hidden">
<INPUT NAME="NoArea" VALUE="true" TYPE="hidden">
<INPUT NAME="SortOrder" VALUE="DESC" TYPE="hidden">
</FORM>


<FORM ACTION="report_list.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="Command" VALUE="My Areas"> 
<INPUT TYPE="checkbox" NAME="NoClaim" VALUE="true"> Unclaimed
<INPUT NAME="Status" VALUE="1" TYPE="hidden">
<INPUT NAME="Area" VALUE="0" TYPE="hidden">
<INPUT NAME="SortOrder" VALUE="DESC" TYPE="hidden">
</FORM>
</LI>


<FORM ACTION="report_list.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="Command" VALUE="Claimed"> Reports
<INPUT NAME="Status" VALUE="1" TYPE="hidden">
<CFOUTPUT>
<INPUT NAME="Claim" VALUE="#GetActiveDirectoryAuthenticatedUsername()#" TYPE="hidden">
</CFOUTPUT>
<INPUT NAME="SortOrder" VALUE="DESC" TYPE="hidden">
</FORM>


</CFIF>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>
</CFTRY>
</DIV>


<H3>Search</H3>

<DIV STYLE="padding-left: 1em;">
<FORM ACTION="report_list.cfm" METHOD="GET" NAME="myform">




<TABLE SUMMARY="">
<TR>
<TD>From</TD>
<TD><CF_custom_date FORMFIELDNAME="From" OPTIONAL="true"></TD>
</TR>

<TR>
<TD>To</TD>
<TD><CF_custom_date FORMFIELDNAME="To" OPTIONAL="true"></TD>
</TR>

<TR>
<TD>Status</TD>
<TD><CF_custom_status Optional="true" Default="1"></TD>
</TR>

<CFIF #MayAccessObject("1")#>
<TR>
	<TD>Area</TD>
	<TD>
		<CF_custom_area Optional="true" DEFAULT="1" MyAreas="true" ItAreas="true">
		<INPUT TYPE="checkbox" NAME="NoArea" VALUE="true"> List only Unassigned
	</TD>
</TR>
<CFELSE>
<TR>
	<TD>Area</TD>
	<TD>
		<CF_custom_area Optional="true" DEFAULT="1">
	</TD>
</TR>
</CFIF>

<CFTRY>
<CFIF #MayAccessObject("1")#>

<TR>
	<TD>Alert Icons</TD>
	<TD>
		<SELECT NAME="AlertIcons">
		<OPTION>Hide</OPTION>
		<OPTION>Show</OPTION>
		</SELECT>
	</TD>
</TR>

<TR>
	<TD>Claim</TD>
	<TD>
		<CF_custom_claim Optional="true">
		<INPUT TYPE="checkbox" NAME="NoClaim" VALUE="true"> List only Unclaimed
	</TD>
</TR>
</CFIF>
<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>
</CFTRY>

<TR>
	<TD>Author</TD>
	<TD>
		<CF_custom_author Optional="true">
	</TD>
</TR>


<CFTRY>
<CFIF #MayAccessObject("1")#>
<TR>
	<TD>Rating</TD>
	<TD>
		<CF_custom_rating Optional="true">
	</TD>
</TR>
</CFIF>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>
</CFTRY>


<CFIF #MayAccessObject("1")#>
<TR>
<TD>Driving Group</TD>

<CFTRY>
	<TD><CF_custom_driving_group Optional="true"></TD>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>
</CFTRY>
</TR>

</CFIF>


<TR>
<TD>District</TD>

<CFTRY>
	<TD><CF_custom_region Optional="true"></TD>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>
</CFTRY>
</TR>


<TR>
<TD>Location</TD>

<CFTRY>
<CFIF #MayAccessObject("1")#>
	<TD><CF_custom_locations Optional="true"></TD>
<CFELSE>
	<TD><CF_custom_locations Optional="true" SELFSELECT="true"></TD>
</CFIF>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>
</CFTRY>
</TR>



<TR>
<TD>Property Tag</TD>
<TD><INPUT TYPE="text" NAME="EquipmentPropertyTag" SIZE="6" MAXLENGTH="6"></TD>
</TR>
<TR>
<TD>Text search</TD>
<TD><INPUT TYPE="text" NAME="TextSearch" VALUE="" MAXLENGTH="255"></TD>
</TR>

<TR>
<TD>Sort By</TD>
<TD>
	<SELECT NAME="SortBy">
	<OPTION>Property Tag Number</OPTION>
	<OPTION>Date Created</OPTION>
	<OPTION>Text Search</OPTION>

	<CFIF #MayAccessObject("1")#>
	<OPTION>Priority</OPTION>
	</CFIF>
	</SELECT>
</TD>
</TR>


<TR>
<TD>Sort Order</TD>
<TD>
<SELECT NAME="SortOrder">
<OPTION VALUE="DESC">Descending</OPTION>
<OPTION VALUE="ASC">Ascending</OPTION>
</SELECT>
</TD>
</TR>
</TABLE>

<INPUT TYPE="submit" NAME="Command" VALUE="Search">



</FORM>

</DIV>


</DIV>
