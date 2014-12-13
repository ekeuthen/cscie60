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
					Hike Reviews: #form.hike#
				<h3>
				</h3>
			</cfoutput>
			<div>
				<h3>
					Add a review:
				</h3>
				<cfoutput>
					<cfform name="addReview" action="update_action.cfm" method="post">
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
						<textarea name="comment" id="comment" required="No" type="text area" size="50" maxlength="256">
						</textarea>
						<br>
						<input name="tripid" id="tripid" type="hidden" value="#form.tripid#">
						<input type="Submit" value="Submit Review!" name="submit">
					</cfform>
				</cfoutput>
			</div>
		</cfif>
		<br>
		<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to view details for another hike.</a>
		<cfinclude template = "footer.cfm">
	</body>
</html>