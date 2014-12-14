<!DOCTYPE html>
<html>
	<head>
		<title>
			Hike Home
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<br>
		<br>
		<cfquery 
			name="regionList"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			SELECT REGIONNAME FROM TBREGION ORDER BY REGIONNAME
		</cfquery>
		<cfquery 
			name="difficultyList"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			SELECT DISTINCT DIFFICULTY FROM TBTRIP ORDER BY DIFFICULTY
		</cfquery>
		<cfoutput>
		<div class="visible">
			<h3>
				Select your hiking trip criteria:
			</h3>
			<cfform name="hikeSearch">
				<label for="distance">Maximum distance (miles)</label>
				<cfselect name="distance"
					id="distance"
					required="No"
					mulitple="No">
					<option value="13">Any</option> 
					<!--When user selects "Any" maximum distance the system will interpret this as 13 miles, as this is the max.  -->
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="5">5</option>
					<option value="8">8</option>
					<option value="13">13</option>
				</cfselect>
				<label for="difficulty">Difficulty</label>
				<cfselect name="difficulty"
					query="difficultyList"
					value="difficulty"
					required="No"
					mulitple="No"
					id="difficulty">
				</cfselect>
				<label for="region">Region</label>
				<cfselect name="region"
					query="regionList"
					value="regionname"
					required="No"
					multiple="No"
					id="region">
				</cfselect>
				<br>
				<input type="Submit" value="Find a hiking trip!" name="submit">
			</cfform>
		</div>
		</cfoutput>
		<cfif isDefined("form.submit")>
			<cfquery 
				name="hikeTripList"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT DISTINCT
					T.TRIPNAME AS TRIP,
					T.DISTANCE AS DISTANCE,
					T.DIFFICULTY AS DIFFICULTY,
					R.REGIONNAME AS REGION
				FROM
					TBTRIP T,
					TBMOUNTAIN M,
					TBREGION R,
					TBTRIPLOCATION TL
				WHERE
					T.TRIPID = TL.TRIPID
					AND TL.MOUNTAINID = M.MOUNTAINID
					AND M.REGIONID = R.REGIONID
					AND R.REGIONNAME = '#FORM.region#'
					AND T.DIFFICULTY = '#FORM.difficulty#'
					AND T.DISTANCE <= '#FORM.distance#'
			</cfquery>
			<cfif len(#hikeTripList.DIFFICULTY#) IS NOT 0> <!--Validate results are returned. -->
				<h3>The following hiking trips meet the search criteria:</h3>
			    <table>
			    	<tr>
			    		<th>Trip</th>
			    		<th>Distance (miles)</th>
			    		<th>Difficulty</th>
			    		<th>Region</th>
			    	</tr>
			    	<cfoutput query="hikeTripList">
			    		<cfform name="selectHike" action="hike_details.cfm" method="post">
							<tr>
							    <td>
							    	<input type="submit" value="#TRIP#" class="link">
							    	<input type="hidden" value="#TRIP#" name="hike">
							    </td>
							    <td>#DISTANCE#</td>
							    <td>#DIFFICULTY#</td>
							    <td>#REGION#</td>
							</tr>
						</cfform>
				    </cfoutput>
			    </table>
			</cfif>
			<cfif len(#hikeTripList.DIFFICULTY#) IS  0> <!--Alert user if results are not returned. -->
				<h3>There are no hiking trips that meet the search criteria.  Please try again.  </h3>
			</cfif>
		</cfif>
		<cfinclude template = "footer.cfm">
	</body>
</html>