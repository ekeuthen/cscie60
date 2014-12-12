<!DOCTYPE html>
<html>
	<head>
		<title>
			Hike Reviews
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<cfif isDefined("form.hike")>
			<cfoutput>
				<h3>
					Hike Reviews: #form.hike#
				</h3>
			</cfoutput>
			<div>
				<h3>
					Add a review:
				</h3>
				<cfform name="addReview">
					<label for="rating">Rating (5 = awesome)</label>
					<cfselect name="rating"
						id="rating"
						required="Yes"
						mulitple="No">
						<option value="1">1</option> 
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</cfselect>
					<label for="comment">Comment</label>
					<cfinput name="comment" id="comment" required="No" type="text" size="50" maxlength="256"> 
					<br>
					<input type="Submit" value="Submit Review!" name="submit">
				</cfform>
			</div>
			<cfif isDefined("form.submit")>
				<cfquery 
					name="addComment"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					INSERT INTO TBREVIEW (REVIEWID, TRIPID, RATING, COMMENTS) 
					VALUES ('7', '11', '3.5', 'AUTO TEST')
				</cfquery>
				<cfelse>
			</cfif>
		</cfif>
		<br>
		<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to view details for another hike.</a>
		<cfinclude template = "footer.cfm">
	</body>
</html>