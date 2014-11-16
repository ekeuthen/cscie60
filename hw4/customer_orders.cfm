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
					V.VENDORNAME as VENDORNAME,
					OI.QUANTITY as QUANTITY,
					OI.ITEMPRICE as ITEMPRICE
				FROM 
					TBORDER O,
					TBORDERITEM OI,
					TBPRODUCT P,
					TBCUSTOMER C,
					TBVENDOR V
				WHERE 
					C.CUSTOMERID = O.CUSTOMERID
					AND O.ORDERNO = OI.ORDERNO
					AND OI.PRODUCTID = P.PRODUCTID
					AND OI.VENDORID = V.VENDORID
					AND CUSTOMERNAME = '#FORM.CUSTOMER#'
				ORDER BY
					ORDERNO, ORDERITEMNO
			</cfquery>
			<cfif len(#customerOrders.ORDERNO#) IS 0>
				<h1>Customer "<cfoutput>#FORM.CUSTOMER#</cfoutput>" has not yet placed any orders.</h1>
				<cfelse>
					<h1>Orders for <cfoutput>#FORM.CUSTOMER#</cfoutput>:</h1>
					    <table>
					    	<tr>
					    		<th>Order - Item</th>
					    		<th>Date</th>
					    		<th>Product</th>
					    		<th>Vendor</th>
					    		<th>Quantity</th>
					    		<th>Price ($)</th>
					    		<th></th>
					    	</tr>
					    	<cfoutput query="customerOrders">
					    		<cfform name="selectOrderItem" action="order_item_details.cfm" method="post">
								    <tr>
								    	<td>#ORDERNO# - #ORDERITEMNO#</td>
								    	<td>#DateFormat("#ORDERDATE#", "short")#</td>
								    	<td>#PRODUCTNAME#</td>
								    	<td>#VENDORNAME#</td>
								    	<td>#QUANTITY#</td>
								    	<td>#ITEMPRICE#</td>
								    	<td>
								    		<input type="hidden" name="orderno" value="#ORDERNO#">
								    		<input type="hidden" name="orderitemno" value="#ORDERITEMNO#">
								    		<input type="submit" value="Update">
								    	</td>
								    </tr>
								</cfform>
						    </cfoutput>
					    </table>
				    <h4>Click update button to modify quantity and / or price details for a specific order item.</h4>
			</cfif>
		</cfif>
		<cfinclude template = "footer.cfm">
	</body>
</html>