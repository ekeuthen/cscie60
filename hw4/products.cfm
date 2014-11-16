<!DOCTYPE html>
<html>
	<head>
		<title>
			Product Quotes
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<h1>Select a Product:<h1>
		<cfquery 
			name="productList"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			SELECT PRODUCTNAME FROM TBPRODUCT
		</cfquery>
		<cfoutput>
			<cfform name="productSelection">
			    <cfselect name="product" 
			        query="productList" 
			        value="productname" 
			        display="productname" 
			        required="Yes" 
			        multiple="No" 
			        size="5"
			        message="Please select a product before sumbitting form!"> 
			    </cfselect> 
			    <br>
			    <input type="Submit" value="Submit" name="submitButton">
			</cfform>
		</cfoutput>
		<cfif isDefined("form.submitButton")>
			<cfquery
				name="numQuotes"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT COUNT (*) AS QUOTES,					
				P.PRODUCTNAME
				FROM TBPRODUCT P,
				TBITEM I
				WHERE P.PRODUCTID = I.PRODUCTID
				AND P.PRODUCTNAME = '#form.product#'
				GROUP BY P.PRODUCTNAME
			</cfquery>
			<cfif #numQuotes.QUOTES# EQUAL 1>
				<h1>
					<cfoutput query="numQuotes">#QUOTES#</cfoutput> Quote for <cfoutput>#form.product#</cfoutput>:
				</h1>
				<cfelseif len(#numQuotes.QUOTES#) IS 0>
					<h1>
						0 Quotes for <cfoutput>#form.product#</cfoutput>
					</h1>
				<cfelse>
					<h1>
						<cfoutput query="numQuotes">#QUOTES#</cfoutput> Quotes for <cfoutput>#form.product#</cfoutput>:
					</h1>
			</cfif>
			<cfif len(#numQuotes.QUOTES#) IS NOT 0>
			    <cfquery 
					name="productQuotes"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					SELECT 
						I.VENDORID as VENDORID, 
						V.VENDORNAME as VENDORNAME, 
						I.ITEMPRICE as ITEMPRICE
					FROM 
						TBPRODUCT P,
						TBITEM I,
						TBVENDOR V
					WHERE 
						PRODUCTNAME = '#FORM.PRODUCT#'
						AND P.PRODUCTID = I.PRODUCTID
						AND I.VENDORID = V.VENDORID
				</cfquery>
			    <table>
			    	<tr>
			    		<th>Vendor ID</th>
			    		<th>Vendor Name</th>
			    		<th>Price Quote ($)</th>
			    	</tr>
			    	<cfoutput query="productQuotes">
					    <tr>
					    	<td>#VENDORID#</td>
					    	<td>#VENDORNAME#</td>
					    	<td>#ITEMPRICE#</td>
					    </tr>
				    </cfoutput>
			    </table>
			</cfif>
			<cfif #numQuotes.QUOTES# LESS THAN 3>
				<h1 class="error">Warning!  Each product must have quotes from at least three vendors.</h1>
			</cfif>
		</cfif>
		<cfinclude template = "footer.cfm">
	</body>
</html>