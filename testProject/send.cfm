




<FORM ACTION="send_save.cfm" METHOD="POST" NAME="send" ENCTYPE="multipart/form-data">

<P>Enter a description of the problem.  Start with a brief summary and then give
as many details as possible: error messages, property tag number, Library Online workstation number,
URLS, patron card number, phone number, or
e-mail address, the time the problem happens, if the problem happens consistently or
if it comes and goes, etc. Describe one problem per report.</P>

<TEXTAREA NAME="Description" COLS="80" ROWS="15" CLASS="required" WRAP="hard"></TEXTAREA>

<BR>
<BR>

<TABLE SUMMARY="">

<!--- <CFIF #MayAccessObject("5")#> --->
<CFIF true>
<TR>
<TD CLASS="formheading">Create on behalf of</TD>
<TD STYLE="padding-right: 2em;">
<CF_custom_author OPTIONAL="true">
</TR>
</CFIF>



<TR>
<TD CLASS="formheading">
The problem is located at
</TD>
<TD>

<CF_custom_locations Optional="true" SelfSelect="true">

</TD>
</TR>
<TR>
<TD CLASS="formheading">Equipment Type</TD>
<TD STYLE="padding-right: 2em;">
<CF_custom_equipmenttype>
</TD>
</TR>

<TR>
<TD CLASS="formheading">Property Tag Number</TD>
<TD STYLE="padding-right: 2em;">
<INPUT NAME="EquipmentTag" TYPE="text" SIZE="6" MAXLENGTH="6">


<SCRIPT TYPE="text/javascript" LANGUAGE="Javascript">
//<!--
function check_prop(property_tag)
{
	window.open('https://intranet.sno-isle.org/applications/tets/traffic/?eid=' + property_tag,'Item','fullscreen=no,width=480,height=480,left=100,top=100,toolbar=no,titlebar=no,menubar=no,directories=no,resizable=yes,scrollbars=yes,status=yes,location=no');
}
-->
</SCRIPT>
<INPUT TYPE="button" ONCLICK="check_prop(document.send.EquipmentTag.value);" VALUE="Verify">


</TD>
</TR>

<TR>
<TD CLASS="formheading">Library Online Workstation Number</TD>
<TD STYLE="padding-right: 2em;">
<INPUT NAME="LOLName" TYPE="text" SIZE="5" MAXLENGTH="5">
</TD>
</TR>

<TR>
<TD CLASS="formheading">Equipment Location</TD>
<TD STYLE="padding-right: 2em;"><INPUT NAME="EquipmentLocation" TYPE="text" MAXLENGTH="255"></TD>
</TR>

<TR>
<TD CLASS="formheading">Notify This Group</TD>
<TD STYLE="padding-right: 2em;"><CF_CUSTOM_SEND_AREA USERASSIGNED="true" OPTIONAL="true"></TD>
</TR>

<TR>
<TD CLASS="formheading">Attach a screenshot (PNG format)</TD>
<TD STYLE="padding-right: 2em;"><INPUT TYPE="file" NAME="File"></TD>
</TR>


</TABLE>


<BR>
<INPUT NAME="Command" TYPE="submit" VALUE="Send" ONCLICK="return confirm('Really Send?'); if(this.value == 'Send') this.form.submit(); this.value = 'Please Wait';">
</FORM>

