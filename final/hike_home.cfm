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
		<cfquery 
			name="regionList"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			SELECT REGIONNAME FROM TBREGION ORDER BY REGIONNAME
		</cfquery>
		<cfoutput>
			<h1>
				Select your hike criteria:
			</h1>
			<div>
			<cfform name="hikeSearch">
				<h3>
					Maximum distance (miles)
				</h3>
				<cfselect name="distance"
					required="No"
					mulitple="No">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="5">5</option>
					<option value="8">8</option>
					<option value="13">13</option>
				</cfselect>
				<h3>
					Maximum difficulty
				</h3>
				<cfselect name="difficulty"
					required="No"
					mulitple="No">
					<option value="easy">Easy</option>
					<option value="easy_moderate">Easy - Moderate</option>
					<option value="moderate">Moderate</option>
					<option value="moderate_sterenuous">Moderate - Strenuous</option>
					<option value="strenuous">Strenuous</option>
				</cfselect>
				<h3>
					Region
				</h3>
				<cfselect name="region"
					query="regionList"
					value="regionname"
					required="No"
					multiple="Yes">
				</cfselect>
				<br>
				<br>
				<input type="Submit" value="Find me a hike!" name="submit">
			</cfform>
		</div>
		</cfoutput>
		<cfinclude template = "footer.cfm">
	</body>
</html>