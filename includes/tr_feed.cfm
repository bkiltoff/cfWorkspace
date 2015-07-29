<cfquery name="LastFiveTR" datasource="sql.sno-isle.org">
	SELECT report.id, report.description
	FROM traffic.report
	JOIN traffic.report_area ON report.current_area_id = report_area.id
	JOIN traffic.area ON report_area.area_id = area.id
	WHERE area.it = 'yes'
	ORDER BY report.created DESC
	LIMIT 5;
</cfquery>

<cfoutput query="LastFiveTR">
	<p>
  	<a href="https://intranet.sno-isle.org/applications/traffic/current/report_show.cfm?ID=#LastFiveTR.id#" target="_blank">#LastFiveTR.id#</a>
    <br />
		<div class="tech#LastFiveTR.id# techdefault">
			<div class="techcontent">
    		#LastFiveTR.description#
	  		</div>
			<div class="techreadmore">
			</div>
		</div>
  </p>
</cfoutput>
