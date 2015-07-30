<cfsavecontent variable="headIns">
    <style>
<!--- 	
<!--- All this styling for the sake of flipping cards
but now I don't really like flipping cards so I'm going to look into a different way
to present Trello card information --->

		/* entire container, keeps perspective */
		.flip-container {
			perspective: 1000;
			width: 90%;
			padding: 10px;
		}

		/* flip the pane when hovered */
		.flip-container:hover .flipper {
			transform: rotateY(180deg);
		}
	
		
		/* flip speed goes here */
		.flipper {
			padding:5px;
			box-sizing:content-box;	
			border:thin  solid #000000;
			width:100%;
			height:60px;
			transition: 0.6s;
			transform-style: preserve-3d;
 			position: relative; 
		}
		
		
		/* front pane, placed above back */
		.front {
			z-index: 2;
			/* for firefox 31 */
			transform: rotateY(0deg);
			backface-visibility: hidden;
			padding:10px;
<!--- 			float: left;
 --->			position: absolute;
			top: 0;
			left: 0;
		}
		
		/* back, initially hidden pane */
		.back {
			transform: rotateY(180deg);
			backface-visibility: hidden;
			padding: 10px;
<!--- 			float: right;
 --->			position: relative;
			top: 0;
			left: 0;
		}
 --->

	.card{
			box-sizing:content-box;	
			border:thin  solid #000000;
			width:100%;		
			padding-bottom:5px;
	}
	.cardDue{
		font-size:small;
		font-style:italic;
		color:red;
		padding-left:10px;
	}
	
	.cardName{
		font-size:large;
		padding-left:5px;
		padding-top:10px;
	}
	.cardDesc{
		font-size:medium;
		padding-left:15px;
		padding-top:5px;
	}

	</style>
</cfsavecontent>

<cfhtmlhead text=#headIns#>

<cfinclude template="trello_feed.cfm">
 