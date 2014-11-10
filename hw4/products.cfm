<html>
	<head>
		<title>
			Product Quotes
		</title>
	</head>
	<body>
		<h1>Select a Product:<h1>
		<cfquery 
			name="productList"
			datasource="cscie60"
			username=""
			password="">
			select productname from tbproduct
		</cfquery>
		<cfoutput>
			<!--<cfform name="productSelection" action="submit.cfm"> -->
			    <cfselect name="product" 
			        query="productList" 
			        value="productname" 
			        display="productname" 
			        required="Yes" 
			        multiple="No" 
			        size="8"> 
			    </cfselect> 
			    <br>
			    <!--<input type="Submit" value="Submit"> -->
			    <h1>
			    	<Number> Quotes for <Product>:
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
			</cfform>
		</cfoutput>
	</body>
</html>