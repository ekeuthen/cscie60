<!DOCTYPE html>
<html>
	<head>
		<title>
			Login
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<h3>Login required to view and add reviews.</h3>
		<br>
		<h3>If you do not have an account, please <a href="create_account.cfm">create an account</a>.</h3>
		<cfset myaction="forceUserLogin.cfm">
		<cfform action="#myaction#" name="login" method="post" preservedata="yes">
			<label for="UserLogin">
				User Name
			</label>
			<cfinput name="UserLogin" id="UserLogin" required="Yes" maxlength="20" cols="20" rows="1">
			</cfinput>
			<br>
			<label for="UserPassword">
				Password
			</label>
			<cfinput name="UserPassword" id="UserPassword" required="Yes" maxlength="20" cols="20" rows="1" type="password">
			</cfinput>
			<br>
			<input type="Submit" value="Login" name="submit">
		</cfform>
	</body>
</html>