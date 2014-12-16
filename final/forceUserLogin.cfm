<!DOCTYPE html>
<html>
	<head>
		<title>
			Logout
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cflogin>
			<cfif not ((isDefined("FORM.userLogin")) and
				isDefined ("FORM.userPassword"))>
				<cfinclude template="login.cfm">
				<cfabort>
				<cfelse>
					<cfquery name="getUser"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						SELECT *
						FROM TBLOGIN
						WHERE UNAME = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#Form.UserLogin#">
							AND PWD = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#Form.UserPassword#">
					</cfquery>
					<cfif getUser.recordCount EQ 1>
						<cfloginuser
							name="#getUser.fname#"
							password="#Form.UserPassword#"
							roles="#getUser.userview#">
						<cfinclude template="header.cfm">
						<h3>Login complete!</h3>
						<cfelse>
							<div class="error">
								Sorry, the username and password combination is not recognized.  Please try again.  
								<br />
							</div>
							<cfinclude template="login.cfm">
							<cfabort>
					</cfif>
			</cfif>
		</cflogin>
	</body>
</html>