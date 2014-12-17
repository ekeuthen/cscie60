<!DOCTYPE html>
<html>
	<head>
		<title>
			Create Account
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<h3>Create Account</h3>
		<cfform action="create_account.cfm" name="login" method="post" preservedata="yes">
			<label for="fname">
				First Name
			</label>
			<cfinput name="fname" id="fname" required="Yes" maxlength="20" cols="20" rows="1">
			</cfinput>
			<br>
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
			<input type="Submit" value="Create Account" name="submit">
		</cfform>
		<cfif isDefined("form.submit")>
			<cfquery 
				name="createAccount"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				INSERT INTO TBLOGIN (UNAME, PWD, FNAME, USERVIEW) 
				VALUES (
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#form.UserLogin#'>, 
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#form.UserPassword#'>, 
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value='#form.fname#'>,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="gen_user">)
			</cfquery>
			<h3>Thank you, account created!</h3>
		</cfif>
		<cfinclude template = "footer.cfm">
	</body>
</html>