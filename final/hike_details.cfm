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
		<h3>
			Hike Details: 
			<cfoutput>#form.hike#</cfoutput>
		</h3>
		<table>
			<tr>
				<td>Distance:</td>
				<td></td>
			</tr>
			<tr>
				<td>Difficulty:</td>
				<td></td>
			</tr>
			<tr>
				<td>Elevation Gain:</td>
				<td></td>
			</tr>
			<tr>
				<td>Fee:</td>
				<td></td>
			</tr>
			<tr>
				<td>Parking:</td>
				<td></td>
			</tr>
			<tr>
				<td>Dogs Allowed:</td>
				<td></td>
			</tr>
		</table>
		<cfinclude template = "footer.cfm">
	</body>
</html>