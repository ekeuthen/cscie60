<!DOCTYPE html>
<html>
	<head>
		<title>
			Customer Orders
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<h1>Select a Customer:<h1>
		<cfquery 
			name="customerList"
			datasource="#Request.DSN#"
			username="#Request.username#"
			password="#Request.password#">
			SELECT CUSTOMERNAME FROM TBCUSTOMER
		</cfquery>
		<cfoutput>
			<cfform name="customerSelection">
			    <cfselect name="customer" 
			        query="customerList" 
			        value="customername" 
			        display="customername" 
			        required="Yes" 
			        multiple="No" 
			        size="4"
			        message="Please select a customer before sumbitting form!"> 
			    </cfselect> 
			    <br>
			    <input type="Submit" value="Submit" name="submitButton">
			</cfform>
		</cfoutput>
		<cfif isDefined("form.submitButton")>
		    <cfquery 
				name="customerOrders"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				SELECT 
					O.ORDERNO as ORDERNO,
					O.ORDERDATE as ORDERDATE,
					OI.ORDERITEMNO as ORDERITEMNO,
					P.PRODUCTNAME as PRODUCTNAME,
					OI.VENDORID as VENDORID,
					OI.QUANTITY as QUANTITY,
					OI.ITEMPRICE as ITEMPRICE
				FROM 
					TBORDER O,
					TBORDERITEM OI,
					TBPRODUCT P,
					TBCUSTOMER C
				WHERE 
					C.CUSTOMERID = O.CUSTOMERID
					AND O.ORDERNO = OI.ORDERNO
					AND OI.PRODUCTID = P.PRODUCTID
					AND CUSTOMERNAME = '#FORM.CUSTOMER#'
			</cfquery>
			<h1>Customer Orders:</h1>
		    <table>
		    	<tr>
		    		<th>
		    			Order Number
		    		</th>
		    		<th>
		    			Order Date
		    		</th>
		    		<th>
		    			Order Item Number
		    		</th>
		    		<th>
		    			Order Product Name
		    		</th>
		    		<th>
		    			Order Vendor ID
		    		</th>
		    		<th>
		    			Quantity
		    		</th>
		    		<th>
		    			Item Price
		    		</th>
		    	</tr>
		    	<cfoutput query="customerOrders">
				    <tr>
				    	<td>
				    		#ORDERNO#
				    	</td>
				    	<td>
				    		#ORDERDATE#
				    	</td>
				    	<td>
				    		#ORDERITEMNO#
				    	</td>
				    	<td>
				    		#PRODUCTNAME#
				    	</td>
				    	<td>
				    		#QUANTITY#
				    	</td>
				    	<td>
				    		#ITEMPRICE#
				    	</td>
				    	<td>
				    		#ORDERITEMNO#
				    	</td>
				    </tr>
			    </cfoutput>
		    </table>
		</cfif>
		<cfinclude template = "footer.cfm">
	</body>
</html>