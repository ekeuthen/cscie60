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
				<h3>Login complete.  You may now <a href="hike_reviews.cfm">add and read reviews</a>.</h3>
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