
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>IT Dashboard</title>
<script src="/scripts/jquery-1.9.1.min.js"></script>
<script src="/scripts/jquery.li-scroller.1.0.js"></script>
<script src="/scripts/api.js"></script>
<link type="text/css" rel="stylesheet" href="/stylesheet/li-scroller.css">
</head>

<body>


<style type="text/css">
	.techdefault {
		margin-top:10px;
	}
	.techcontent {
		position:relative;
	}
	.techreadmore {
		float:right;
	}
	/*css for the three content wells*/
	.boxDiv {
		width:30%;		height:600px;
		float:left;
		overflow:hidden;
		box-sizing:border-box;
		border:thin solid #000000;
	}
	.smBoxDiv {
		width:100%; 
		border-top:thin solid #000000; 
		padding:10px; 
		box-sizing:border-box;	
	}
	
	.bannerLinks {
		width:100%;		height:150px;
		box-sizing:border-box;
		border:thin solid #000000; 
		overflow:hidden;
	}
	
	.bannerLink {
		float:left; 		width:25%; 
		height:150px; 	
		text-align:center; 
		box-sizing:border-box; 	
		border-right:thin solid #000000; 
		padding-top:15px;
	}
	
	.linkLogo {
		height: 100px; 
		width: auto; 

		max-height: 150px;
	}
	
</style>

<script type="text/javascript">
$(function() {
	var slideHeight = 42;
	var nrTotal = $('.techdefault').length;
	$(".techdefault").each(function() {
		var $this = $(this);
		var $content = $this.children(".techcontent");
		var conHeight = $content.height();
/*		var $fade = $this.find(".techfade");
		$fade.css("visibility", "hidden");
*/		if (conHeight >= slideHeight) {
			var $readMore = $this.find(".techreadmore");
			$content.css("height", slideHeight + "px");
			$content.css("overflow", "hidden");
/*			$fade.css("visibility", "visible");
			$fade.fadeIn();
*/			$readMore.append("<a href='#'>More</a>");
			if (nrTotal === 1) {
				$content.animate({
					height: conHeight + 10
				}, "normal");
				$readMore.children('a').text("");
/*				$fade.fadeOut();
*/			}
			$readMore.children("a").bind("click", function(event) {
				var curHeight = $content.height();
				if (curHeight == slideHeight) {
					$content.animate({
						height: conHeight + 10
					}, "normal");
					$(this).text("Close");
/*					$fade.fadeOut();
*/				} else {
					$content.animate({
						height: slideHeight
					}, "normal");
					$(this).text("More");
/*					$fade.fadeIn();
*/				}
				return false;
			});
		}
	});

  $("ul#ticker01").liScroll({travelocity: .05});

});
</script>


<!---Links/Icons--->
<div class="bannerLinks">
	<a href="https://intranet.sno-isle.org"	target="_blank"	style="text-decoration:none;">
	    <div class="bannerLink">
			<img src="/assets/intranetLogo.PNG" class="linkLogo" />
        </div>
    </a>
	<a href="https://intranet.sno-isle.org/?ID=123"	target="_blank" style="text-decoration:none;">
    	<div class="bannerLink">
        	<img src="/assets/libOnline.png" class="linkLogo" />
        </div>
    </a>
	<a href="https://workforcenow.adp.com/public/index.htm"target="_blank">
    	<div class="bannerLink">
        	<img src="/assets/adp.png" class="linkLogo" />
        </div>
    </a>
 	<a href="https://whentowork.com/logins.htm" target="_blank">
    	<div class="bannerLink" >
        	<img src="/assets/w2w_logo_nblue.jpg" class="linkLogo" />
        </div>
    </a>
</div>
<!---Alerts--->
<ul id="ticker01">
	<cfinvoke component="/cfc/dashboard" method="pullAlerts" returnvariable="fResult" fID="999" />
    
	<cfoutput>#fResult#</cfoutput>
</ul>
<!---Content Well 1--->
<div class="boxDiv">
	Content Well 1
	<div class="smBoxDiv">
	  	<h2>Latest Tech Reports</h2>
  		<cfinclude template="/includes/tr_feed.cfm">
	</div>
</div>
<!---Content Well 2--->
<div class="boxDiv" style="width:40%;">
	Content Well 2
	<div class="smBoxDiv">
		<a href="http://dude-image.sno-isle.org/ALL.png" target="_blank">
        	<img src="http://dude-image.sno-isle.org/ALL.png" style="width:100%;" alt="Network Status" />
        </a>
    </div>
</div>
<!---Content Well 3--->
<div class="boxDiv">
	Show Case
	<div class="smBoxDiv">
  		<h2># of cards in Trello Lists</h2>
	  	<cfinclude template="/includes/trello_feed.cfm">
	</div>
</div>
</body>
</html>
