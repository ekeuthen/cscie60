<!DOCTYPE html>
<html>
	<head>
		<title>
			Hike Details
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<cfif isDefined("form.hike")>
			<h3>
				Hike Details: 
				<cfoutput>#form.hike#</cfoutput>
			</h3>
			<cfquery 
				name="hikeDetails"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT 
					T.DISTANCE AS DISTANCE,
					T.DIFFICULTY AS DIFFICULTY,
					T.ELEVATIONGAIN AS ELEVATIONGAIN,
					T.FEE AS FEE,
					T.DOGSALLOWED AS DOGS
				FROM 
					TBTRIP T
				WHERE T.TRIPNAME = '#form.hike#'
			</cfquery>
			<cfoutput query="hikeDetails">
				<table>
					<tr>
						<td>Distance:</td>
						<td>#DISTANCE#</td>
					</tr>
					<tr>
						<td>Difficulty:</td>
						<td>#DIFFICULTY#</td>
					</tr>
					<tr>
						<td>Elevation Gain:</td>
						<td>#ELEVATIONGAIN#</td>
					</tr>
					<tr>
						<td>Fee:</td>
						<td>#FEE#</td>
					</tr>
					<tr>
						<td>Dogs Allowed:</td>
						<td>#DOGS#</td>
					</tr>
				</table>
			</cfoutput>
		</cfif>
			<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to view details for another hike.</a>
		<cfinclude template = "footer.cfm">
	</body>
</html>