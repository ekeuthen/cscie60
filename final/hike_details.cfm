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
			<cfquery 
				name="ratingDetails"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT 
  					COUNT (V.REVIEWID) AS COUNT_REVIEWS,
  					AVG (V.RATING) AS AVE_RATING
				FROM 
				  	TBTRIP T,
				  	TBREVIEW V
				WHERE 
				  	T.TRIPNAME = '#form.hike#'
				  	AND T.TRIPID = V.TRIPID
			</cfquery>
			<h3>
				Mountains:
				<cfoutput query = "mountainDetails"> #MOUNTAIN# (#HEIGHT#') </cfoutput>
			</h3>
			<table>
				<cfoutput query="hikeDetails">
					<tr>
						<td>Region:</td>
						<td>#REGION#</td>
					</tr>
					<tr>
						<td>Distance (miles):</td>
						<td>#DISTANCE#</td>
					</tr>
					<tr>
						<td>Difficulty:</td>
						<td>#DIFFICULTY#</td>
					</tr>
					<tr>
						<td>Elevation Gain (feet):</td>
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
				</cfoutput>
				<cfoutput query="ratingDetails">
					<tr>
						<td>Average Rating:</td>
						<cfif #COUNT_REVIEWS# LESS THAN 1>
							<td>Not yet rated! (Add a review.)</td>
							<cfelse>
								<td>#AVE_RATING# / 5 (See & add review details.)</td>
						</cfif>
					</tr>
				</cfoutput>
			</table>
		</cfif>
			<br>
			<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to view details for another hike.</a>
		<cfinclude template = "footer.cfm">
	</body>
</html>