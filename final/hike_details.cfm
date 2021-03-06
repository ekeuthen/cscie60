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
		<cfif isDefined("form.hike")> <!---ensure that user is looking for details of specific hike --->
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
					R.REGIONNAME AS REGION,
					T.TRIPID AS TRIPID,
					P.PHOTOURL AS PHOTO
				FROM 
					TBTRIP T,
					TBREGION R,
					TBMOUNTAIN M,
					TBTRIPLOCATION L,
					TBPHOTO P
				WHERE 
					T.TRIPNAME = '#form.hike#'
					AND T.TRIPID = L.TRIPID
					AND L.MOUNTAINID = M.MOUNTAINID
					AND M.REGIONID = R.REGIONID
					AND T.TRIPID = P.TRIPID(+)
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
					T.TRIPID AS TRIPID, 
  					COUNT (V.REVIEWID) AS COUNT_REVIEWS,
  					AVG (V.RATING) AS AVE_RATING
				FROM 
				  	TBTRIP T,
				  	TBREVIEW V
				WHERE 
				  	T.TRIPNAME = '#form.hike#'
				  	AND T.TRIPID = V.TRIPID
				 GROUP BY T.TRIPID
			</cfquery>
			<h3 class="visible">
				Mountains:
				<cfoutput query = "mountainDetails"> #MOUNTAIN# (#HEIGHT#') </cfoutput>
			</h3>
			<span>
				<span class="left">
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
						<tr>
							<td>Average Rating:</td>
							<cfoutput>
								<cfform name="reviews" action="hike_reviews.cfm" method="post">
									<input type="hidden" value="#form.hike#" name="hike">
									<input type="hidden" value="#hikeDetails.TRIPID#" name="tripid">
									<cfif len(#ratingDetails.TRIPID#) IS NOT 0>
										<td>
											#NumberFormat(ratingDetails.AVE_RATING, '_.0')# / 5.0
											<input type="submit" value="See & add review details" class="link">
										</td>
										<cfelse>
											<td>
												Not yet rated!
												<input type="submit" value="Add a review" class="link">
											</td>
									</cfif>
								</cfform>
							</cfoutput>
						</tr>
					</table>
				</span>
				<span class="right">
					<cfoutput query="hikeDetails">
						<cfif len(#PHOTO#) IS NOT 0>
							<img src="#PHOTO#" alt="white mountains hike photo" height="250" width="480">
							<cfelse>
								<img src="#PHOTO#" alt="sorry - no photo yet!" height="250" width="480">
						</cfif>
					</cfoutput>
				</span>
			</span>
			<br>
			<cfelse>
				<br>
				<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to select a hike.</a>
		</cfif>
		<br>
		<cfinclude template = "footer.cfm">
	</body>
</html>