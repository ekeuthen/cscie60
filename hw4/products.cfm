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
		</cfoutput>
		<cfif isDefined("form.submitButton")>
			<h1>
		    	Quotes for <cfoutput>#form.product#</cfoutput>:
		    </h1>
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
		    	<cfoutput query="productQuotes">
				    <tr>
				    	<td>
				    		#VENDORID#
				    	</td>
				    	<td>
				    		#VENDORNAME#
				    	</td>
				    	<td>
				    		#ITEMPRICE#
				    	</td>
				    </tr>
			    </cfoutput>
		    </table>
		</cfif>
	</body>
</html>