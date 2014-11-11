<html>
	<head>
		<title>
			Product Quotes
		</title>
		<style type="text/css">
			body {
				font-family: verdana, tahoma, helvetica, arial, sans-serif;
			}
			table {
			    border-collapse: collapse;
			}
			table, th, td {
			    border: 1px solid black;
			}
			td, th {
			    padding: 15px;
			}
		</style>
	</head>
	<body>
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
			        size="8"> 
			    </cfselect> 
			    <br>
			    <input type="Submit" value="Submit" name="submitButton">
			</cfform>
			<cfif isDefined("form.submitButton")>
				<h1>
			    	Quotes for <cfoutput>#form.product#</cfoutput>:
			    </h1>
			    <table>
			    	<tr>
			    		<th>
			    			Vendor ID
			    		</th>
			    		<th>
			    			Vendor Name
			    		</th>
			    		<th>
			    			Price Quote
			    		</th>
			    	</tr>
			    </table>
			</cfif>
		</cfoutput>
	</body>
</html>