
<H1>Saving Your Technology Report</H1>


<!--- Check if required form fields are defined --->
<CFTRY>

<!--- Store the input errors for later reporting --->
<CFSET InputErrors = ArrayNew(1)>


<!--- Check each form field --->

<CFIF IsDefined('Form.Description') AND LEN(#Form.Description#)>
	<CFSET Form.Description = #MakeInputSafeForSQL(Form.Description)#>

	<CFIF LEN(#Form.Description#) LT 20>
	<CFSET ArrayAppend(InputErrors, "We need more details than that!")>
	</CFIF>
<CFELSE>
	<CFSET ArrayAppend(InputErrors, "Enter a description of the problem.")>
</CFIF>


<CFIF IsDefined('Form.Location') AND LEN(#Form.Location#)>
	<CFSET Form.Location = #MakeInputNumberSafeForSQL(Form.Location)#>

	<CFIF LEN(#Form.Location#) LT 1 OR NOT IsNumeric(#Form.Location#) OR #Form.Location# LT 1>
	<CFSET ArrayAppend(InputErrors, "The location ID is malformatted.")>
	</CFIF>
<CFELSE>
	<CFSET ArrayAppend(InputErrors, "Enter the location of the problem.")>
</CFIF>




<!--- Optional fields --->

<CFIF IsDefined('Form.Area') AND LEN(#Form.Area#)>
	<CFSET Form.Area = #MakeInputNumberSafeForSQL(Form.Area)#>

	<CFIF LEN(#Form.Area#) LT 1 OR NOT IsNumeric(#Form.Area#)>
	<CFSET ArrayAppend(InputErrors, "The area is malformatted.")>
	</CFIF>
</CFIF>

<CFIF IsDefined('Form.Author') AND LEN(#Form.Author#)>
	<CFSET Form.Author = #MakeInputStringSafeForSQL(Form.Author)#>

	<CFIF LEN(#Form.Author#) LT 1>
	<CFSET ArrayAppend(InputErrors, "The author name is malformatted.")>
	</CFIF>
</CFIF>


<CFIF IsDefined('Form.EquipmentType') AND LEN (#Form.EquipmentType#)>
	<CFSET Form.EquipmentType = #MakeInputNumberSafeForSQL(Form.EquipmentType)#>

	<CFIF LEN(#Form.EquipmentType#) LT 1 OR NOT IsNumeric(#Form.EquipmentType#) OR #Form.EquipmentType# LT 1>
	<CFSET ArrayAppend(InputErrors, "The equipment type ID is malformatted")>
	</CFIF>	
</CFIF>

<CFIF IsDefined('Form.EquipmentTag') AND LEN(#Form.EquipmentTag#)>
	<CFSET Form.EquipmentTag = #MakeInputNumberSafeForSQL(Form.EquipmentTag)#>

	<CFIF LEN(#Form.EquipmentTag#) IS NOT 6 OR NOT IsNumeric(#Form.EquipmentTag#) OR #Form.EquipmentTag# LT 1>
	<CFSET ArrayAppend(InputErrors, "The property tag number should be a six digit number. <B>Do not enter a bogus property tag number</B>.")>
	</CFIF>
</CFIF>

<CFIF IsDefined('Form.EquipmentLocation') AND LEN(#Form.EquipmentLocation#)>
	<CFSET Form.EquipmentLocation = #MakeInputStringSafeForSQL(Form.EquipmentLocation)#>

	<CFIF LEN(#Form.EquipmentLocation#) LT 1>
	<CFSET ArrayAppend(InputErrors, "The location description is malformatted.")>
	</CFIF>
</CFIF>

<CFIF IsDefined('Form.LOLName') AND LEN(#Form.LOLName#)>
	<CFSET Form.LOLName = #MakeInputStringSafeForSQL(Form.LOLName)#>

	<CFIF LEN(#Form.LOLName#) LT 4>
	<CFSET ArrayAppend(InputErrors, "The Library Online Workstation Number is malformatted.")>
	</CFIF>
</CFIF>

<CFIF IsDefined('Form.File') AND LEN(#Form.File#) GT 0>
        <CFIF Val(CGI.CONTENT_LENGTH) GT 1000000>
                <CFSET ArrayAppend(InputErrors, "The attachment is too big. File must be smaller than 1MB.")>
        </CFIF>
</CFIF>





<!--- If there were any problems, throw an error --->
<CFIF ArrayLen(InputErrors) GT 0>
	<CFTHROW TYPE="user_input" MESSAGE="Form incomplete">
</CFIF>

<!--- Catch error for incomplete form input --->
<CFCATCH TYPE="user_input">

<CF_custom_sound_error_input>

<CFOUTPUT>
<P>The form is incomplete.  Please press your back button and fill in the requested information.</P>
<UL>
<CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(InputErrors)#">
<LI>#InputErrors[i]#</LI>
</CFLOOP>
</UL>
</CFOUTPUT>
<CFEXIT/>
</CFCATCH>

<!--- End check if required form fields are defined --->
</CFTRY>





<!--- Insert the report information into the database --->
<CFSET sql="
INSERT INTO traffic.report SET
created=NOW(),
description='#Form.Description#',
location_id='#Form.Location#',
">

<CFIF IsDefined('Form.Author') AND LEN(#Form.Author#)>
	<CFSET sql = #sql# & " username_fk='#Lcase(Form.Author)#',">
<CFELSE>
	<CFSET sql = #sql# & " username_fk='#GetActiveDirectoryAuthenticatedUsername()#',">
</CFIF>

<CFIF IsDefined('Form.LOLName') AND LEN(#Form.LOLName#)>
<CFSET sql = #sql# & " lolname='#Ucase(Form.LOLName)#',">
</CFIF>

<CFIF IsDefined('Form.EquipmentLocation') AND LEN(#Form.EquipmentLocation#)>
<CFSET sql = #sql# & " equipment_location='#Form.EquipmentLocation#',">
</CFIF>

<CFIF IsDefined('Form.EquipmentType') AND LEN(#Form.EquipmentType#)>
<CFSET sql = #sql# & " equipment_type_id='#Form.EquipmentType#',">
</CFIF>

<CFIF IsDefined('Form.EquipmentTag') AND LEN(#Form.EquipmentTag#)>
<CFSET sql = #sql# & " equipment_property_tag='#Form.EquipmentTag#',">
</CFIF>

<!--- Strip training comma --->
<CFSET sql =  ReReplace(sql, ",$", "")>

<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="InsertReport" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>

</CFTRY>



<!--- Get the primary key of the report we just inserted --->
<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="InsertReportID" DATASOURCE="#Application.DataSource#">
SELECT LAST_INSERT_ID() as id
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>

</CFTRY>




<!--- Insert the status information into the database --->
<CFSET sql="
INSERT INTO traffic.report_status SET
created=NOW(),
report_id='#InsertReportID.id#',
status_id='1',
username_fk='#GetActiveDirectoryAuthenticatedUsername()#'">

<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="InsertReportStatus" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>

</CFTRY>




<!--- Set the current_status_id to the id of the status record we just created --->
<CFSET sql="
UPDATE traffic.report SET
current_status_id=LAST_INSERT_ID()
WHERE id='#InsertReportID.id#'">

<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="UpdateCurrentStatus" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>

</CFTRY>










<CFIF IsDefined('Form.Area') AND LEN(#Form.Area#)>

<!--- Insert the area information into the database --->
<CFSET sql="
INSERT INTO traffic.report_area SET
created=NOW(),
report_id='#InsertReportID.id#',
username_fk='#GetActiveDirectoryAuthenticatedUsername()#',
area_id='#Form.Area#'
">

<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="InsertArea" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>

</CFTRY>



<!--- Update the report's current_area_id --->
<CFSET sql="
UPDATE traffic.report SET
current_area_id=LAST_INSERT_ID()
WHERE id='#InsertReportID.id#'
">

<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="UpdateCurrentArea" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>

</CFTRY>




<P>Area changed.</P>



<!--- Get the info of everyone subscribed to this area, except me --->
<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Subscriber" DATASOURCE="#Application.DataSource#">
SELECT worker_area.username_fk,
	shared.active_directory.mail,
	shared.active_directory.givenname,
	shared.active_directory.sn
FROM traffic.worker_area
	LEFT JOIN shared.active_directory ON traffic.worker_area.username_fk = shared.active_directory.samaccountname
WHERE worker_area.area_id = '#Form.Area#'
	AND worker_area.username_fk != '#GetActiveDirectoryAuthenticatedUsername()#'
	AND shared.active_directory.mail IS NOT NULL
</CFQUERY>
</CFLOCK>


<!--- Get my info too --->
<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Me" DATASOURCE="#Application.DataSource#">
SELECT *
FROM shared.active_directory
WHERE samaccountname='#GetActiveDirectoryAuthenticatedUsername()#'
</CFQUERY>
</CFLOCK>



<!--- Get the description of the tech report --->
<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="30" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Report" DATASOURCE="#Application.DataSource#">
SELECT report.description,
	shared.active_directory.givenname AS name_first,
	shared.active_directory.sn AS name_last,
	shared.library.name AS branch
FROM traffic.report
	LEFT JOIN shared.active_directory ON traffic.report.username_fk = shared.active_directory.samaccountname
	LEFT JOIN shared.library ON traffic.report.location_id = shared.library.id
WHERE report.id='#InsertReportID.id#'
</CFQUERY>
</CFLOCK>




<CFLOOP QUERY="Subscriber">

<CFMAIL FROM="#Me.mail#"
        TO="#Subscriber.mail#"
        SUBJECT="TR assigned: #LEFT(Report.description, 50)#..."
        TYPE="HTML">

<P>A Technology report has been assigned to an area you are subscribed to.</P>

<P><EM>#Report.description#</EM> #Report.name_first# #Report.name_last#, problem in #Report.branch#</P>

<P>Technology Report
<A HREF="https://intranet.sno-isle.org/applications/traffic/current/report_show.cfm?ID=#InsertReportID.id#">#InsertReportID.id#</A>.</P>
</CFMAIL>

<CFOUTPUT>
<P>#Subscriber.givenname# #Subscriber.sn# (#Subscriber.mail#) gets an e-mail.</P>
</CFOUTPUT>

</CFLOOP>



</CFIF>






<CFIF IsDefined('Form.File') AND LEN(#Form.File#)>

<!--- Insert the note --->
<CFTRY>

<CFSET sql="
INSERT INTO traffic.report_note SET
created=NOW(),
report_id='#InsertReportID.Id#',
username_fk='#GetActiveDirectoryAuthenticatedUsername()#',
note='Attachment'
">

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="InsertNote" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
        <P>Couldn't save note.</P>
        <CFEXIT/>
</CFCATCH>

</CFTRY>


<!--- Get the primary key of the note we just inserted to use later when adding an attachment--->
<CFTRY>

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="InsertedNoteID" DATASOURCE="#Application.DataSource#">
SELECT report_note.id AS Id
FROM traffic.report_note
WHERE report_note.report_id = #InsertReportID.ID#
ORDER BY report_note.id DESC
LIMIT 1
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
        <CFEXIT/>
</CFCATCH>

</CFTRY>




<!--- add the attachment if available --->

<CFIF IsDefined('Form.File') AND LEN(#Form.File#) AND IsDefined('InsertedNoteId.Id') and LEN(#InsertedNoteId.Id#)>

<CFTRY>
<CFFILE ACTION="UPLOAD"
        FILEFIELD="File"
        DESTINATION="/var/www/intranet/html/applications/traffic/current/attachment/t#InsertedNoteID.Id#"
        NAMECONFLICT="MakeUnique"
        ACCEPT="image/png,image/pjpeg,image/jpeg,image/x-png"
        MODE="644"
        >

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
<CFEXIT/>
</CFCATCH>
</CFTRY>


<CFTRY>
<CFFILE ACTION="RENAME"
        SOURCE="/var/www/intranet/html/applications/traffic/current/attachment/t#InsertedNoteId.Id#"
        DESTINATION="/var/www/intranet/html/applications/traffic/current/attachment/attachment#InsertedNoteId.Id#.png"
        MODE="644"
        >

<CFCATCH TYPE="Any">
        <CFOUTPUT>
        <P>#CFCATCH.Message# #CFCATCH.Detail#</P>
        </CFOUTPUT>
<CFEXIT/>
</CFCATCH>
</CFTRY>


<!--- Update note record with actual filename --->
<CFTRY>
<CFSET sql="
UPDATE traffic.report_note SET attachment_filename='attachment#InsertedNoteId.Id#.png'
WHERE report_note.id = #InsertedNoteId.Id#
LIMIT 1
">

<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="10" THROWONTIMEOUT="Yes">
<CFQUERY NAME="UpdateNote" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
        <P>Couldn't update note.</P>
        <CFEXIT/>
</CFCATCH>
</CFTRY>

<P>Attachment saved.</P>

</CFIF>


</CFIF>












<P>Your report has been received.</P>




<!--- Send mail to tech liaisons in the same branch --->

<!--- Discover the e-mail address of the tech report sender --->

<CFSET sql="
SELECT mail
FROM shared.active_directory
WHERE samaccountname='#GetActiveDirectoryAuthenticatedUsername()#'
">

<CFTRY>
<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="30" THROWONTIMEOUT="Yes">
<CFQUERY NAME="Sender" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>
</CFTRY>


<CFIF NOT IsDefined('Sender.RecordCount') OR #Sender.RecordCount# NEQ 1>
<P>Error looking up your e-mail address.</P>
<CFEXIT/>
</CFIF>


<!--- Find the name of the location where the problem is located --->

<CFSET sql="
SELECT name,
	abbreviation
FROM shared.library
WHERE id='#Form.Location#'
">

<CFTRY>
<CFLOCK SCOPE="Application" TYPE="ReadOnly" TIMEOUT="30" THROWONTIMEOUT="Yes">
<CFQUERY NAME="NotificationLocation" DATASOURCE="#Application.DataSource#">
#PreserveSingleQuotes(sql)#
</CFQUERY>
</CFLOCK>

<CFCATCH TYPE="Any">
	<CFOUTPUT>
	<P>#CFCATCH.Message# #CFCATCH.Detail#</P>
	</CFOUTPUT>
	<CFEXIT/>
</CFCATCH>
</CFTRY>


<!--- Send mail to each branch notification list, unless the report is from SRV --->

<CFIF NotificationLocation.abbreviation NEQ "SRV">

<CFMAIL FROM="#Sender.mail#"
        TO="#NotificationLocation.abbreviation#-techs@sno-isle.org"
        SUBJECT="New Technology Report #InsertReportID.Id# At #NotificationLocation.name#"
        TYPE="HTML">

<P>Technology Report #InsertReportID.Id#</P>
<P><I>#Form.description#</I></P>

<P>Technology Report
<A HREF="https://intranet.sno-isle.org/applications/traffic/current/report_show.cfm?ID=#InsertReportID.Id#">
#InsertReportID.Id#</A>.</P>

</CFMAIL>

<CFOUTPUT>
<P>Sent mail to #NotificationLocation.abbreviation#-techs@sno-isle.org</P>
</CFOUTPUT>

</CFIF>




<CFHEADER NAME="Refresh" VALUE="5; URL=./">
