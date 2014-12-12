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
				SELECT DISTINCT
					T.DISTANCE AS DISTANCE,
					T.DIFFICULTY AS DIFFICULTY,
					T.ELEVATIONGAIN AS ELEVATIONGAIN,
					T.FEE AS FEE,
					T.DOGSALLOWED AS DOGS,
					R.REGIONNAME AS REGION
				FROM 
					TBTRIP T,
					TBREGION R,
					TBMOUNTAIN M,
					TBTRIPLOCATION L
				WHERE 
					T.TRIPNAME = '#form.hike#'
					AND T.TRIPID = L.TRIPID
					AND L.MOUNTAINID = M.MOUNTAINID
					AND M.REGIONID = R.REGIONID
			</cfquery>
			<cfquery 
				name="mountainDetails"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT DISTINCT
					M.MOUNTAINNAME AS MOUNTAIN,
					M.HEIGHT AS HEIGHT
				FROM 
					TBTRIP T,
					TBREGION R,
					TBMOUNTAIN M,
					TBTRIPLOCATION L
				WHERE 
					T.TRIPNAME = '#form.hike#'
					AND T.TRIPID = L.TRIPID
					AND L.MOUNTAINID = M.MOUNTAINID
			</cfquery>
			<h3>
				Mountains:
				<cfoutput query = "mountainDetails"> #MOUNTAIN# (#HEIGHT#) </cfoutput>
			</h3>
			<cfoutput query="hikeDetails">
				<table>
					<tr>
						<td>Region:</td>
						<td>#REGION#</td>
					</tr>
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
						<td>
							<cfif #FEE# is 1>
								Yes
								<cfelse>
									No
							</cfif>
						</td>
					</tr>
					<tr>
						<td>Dogs Allowed:</td>
						<td>
							<cfif #DOGS# is 1>
								Yes
								<cfelse>
									No
							</cfif>
						</td>
					</tr>
				</table>
			</cfoutput>
		</cfif>
			<br>
			<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to view details for another hike.</a>
		<cfinclude template = "footer.cfm">
	</body>
</html>