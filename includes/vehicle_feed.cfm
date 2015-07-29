<!---<script type="text/javascript"><!--- Copied from example, need to study --->
$(function() {
var authenticationCallback,
		api = GeotabApi(function(authenticationCallback){
	window.addEventListener("load", function() {
		var
		server = "onboard.geotab.com",
		userName = "***",
		password = "***",
		database = "Sno_isle";
		
		authenticationCallback(server, database, userName, password, function(errorString) {
			alert(errorString);
		});
	}, false);
});
var results = [];

window.addEventListener("load", function() {console.log("SUCCESS");});

api.call("Get", {
    typeName: "DeviceStatusInfo"
}, function (statusInfos) {
    var coordinates = [];
    statusInfos.forEach(function (statusInfo) {
        coordinates.push({
            x: statusInfo.longitude,
            y: statusInfo.latitude
        });
    });
    api.call("GetAddresses", {
        coordinates: coordinates
    }, function (addressResults) {
        for (var i = 0; i < statusInfos.length; i++) {
            results.push({
                device: statusInfos[i].log.device,
                isDriving: statusInfos[i].isDriving,
                address: addressResults[i]
            });
        }
    });
});
console.log(results);
});
</script>--->
<cfset gTURL = 'https://onboard.geotab.com/apiv1/GetVersion'>
<!---<cfset gTBaseURL = 'https://onboard.geotab.com/apiv1/Get?typeName=Device&credentials='>--->
<!---<cfset gTCredentials = '{"database":"Sno_isle","userName":"***","password":"***"}'>
<cfset gTURL = gtBaseURL & URLEncodedFormat(gTCredentials)>--->
<cfhttp url='#gTURL#' resolveurl="no" method="get">
<cfhttpparam type="header" name="Accept-Encoding" value="*">
<cfhttpparam type="header" name="TE" value="deflate;q=0">
<!---
	<cfhttpparam type="header" name="Accept" value="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8">
	<cfhttpparam type="header" name="Accept-Encoding" value="gzip, deflate">
	<cfhttpparam type="header" name="Accept-Language" value="en-US,en;q=0.5">
	<cfhttpparam type="header" name="Connection" value="keep-alive">
	<!---<cfhttpparam type="url" name="credentials" value='{"database":"Sno_isle","userName":"***","password":"***"}' encoded="no">--->
	--->
</cfhttp>
<cfdump var="#cfhttp#">
<cfdump var="#gtURL#">
<cfoutput>#cfhttp.FileContent#</cfoutput>