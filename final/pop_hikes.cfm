<!DOCTYPE html>
<html>
	<head>
		<title>
			Popular Hikes
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<h3>Popular Hikes</h3>
		<cfquery 
			name="popHikes"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			SELECT 
				T.TRIPNAME AS TRIP,
				AVG (R.RATING) AS AVG_RATING
			FROM 
				TBTRIP T,
				TBREVIEW R
			WHERE 
				T.TRIPID = R.TRIPID
			GROUP BY T.TRIPNAME
			ORDER BY AVG_RATING DESC
		</cfquery>
		<table>
			<tr>
				<th>Hike</th>
				<th>Average Rating</th>
			</tr>
			<cfoutput query="popHikes">

				<cfform name="selectHike" action="hike_details.cfm" method="post">
					<tr>
					    <td>
					    	<input type="submit" value="#TRIP#" class="link">
					    	<input type="hidden" value="#TRIP#" name="hike">
					    </td>
					    <td>#AVG_RATING#</td>
					</tr>
				</cfform>
			</cfoutput>
		</table>
		<cfinclude template = "footer.cfm">
	</body>
</html>