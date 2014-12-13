<!DOCTYPE html>
<html> 
	<head> 
	    <title>Add Review</title> 
	</head> 
	<body> 
		<cfquery 
			name="addComment"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			INSERT INTO TBREVIEW (REVIEWID, TRIPID, RATING, COMMENTS) 
			VALUES ('3', '#form.tripid#', '#form.rating#', '#form.comment#')
		</cfquery>
		<h1>Comment Added</h1> 
		<cfoutput>You have added a comment!!! </cfoutput> 
	</body> 
</html>