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
		<cfinclude template="forceUserLogin.cfm">
		<cfif isDefined("form.submit")>
			<cfquery 
				name="addComment"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				INSERT INTO TBREVIEW (TRIPID, RATING, COMMENTS) 
				VALUES (
					'#form.tripid#', 
					'#form.rating#', 
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#form.comment#'>)
			</cfquery>
		</cfif>
		<cfif isDefined("form.tripid")>
			<cfoutput>
					Hike Reviews: #form.hike#
				<h3>
				</h3>
			</cfoutput>
			<div class="visible">
				<h3>
					Add a review:
				</h3>
				<cfoutput>
					<cfform name="addReview" action="hike_reviews.cfm" method="post">
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
						<textarea name="comment" id="comment" required="No" maxlength="256" cols="40" rows="3">
						</textarea>
						<br>
						<input name="tripid" id="tripid" type="hidden" value="#form.tripid#">
						<input name="hike" id="hike" type="hidden" value="#form.hike#">
						<input type="Submit" value="Submit Review!" name="submit">
					</cfform>
				</cfoutput>
			</div>
			<br>
			<cfquery 
				name="reviewDetails"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT
					R.RATING AS RATING,
					R.COMMENTS AS COMMENTS,
					R.CREATEDATE AS CDATE
				FROM 
					TBREVIEW R
				WHERE 
					R.TRIPID = '#form.tripid#'
				ORDER BY
					R.CREATEDATE DESC
			</cfquery>
			<cfif len(#reviewDetails.RATING#) IS NOT 0>
				<table id="reviewList">
					<tr>
						<th>
							Date
						</th>
						<th>
							Rating
						</th>
						<th>
							Comment
						</th>
					</tr>
					<cfoutput query="reviewDetails">
						<tr>
							<td>
								#DateFormat("#CDATE#", "short")#
							</td>
							<td>
								#RATING#
							</td>
							<td>
								#COMMENTs#
							</td>
						<tr>
					</cfoutput>
				</table>
			</cfif>
			<cfelse>
				<br>
				<a href="hike_home.cfm">Please return to White Mountain Hiking Headquarters home to select a hike.</a>
		</cfif>
		<cfinclude template = "footer.cfm">
	</body>
</html>