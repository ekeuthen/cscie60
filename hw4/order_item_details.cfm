<!DOCTYPE html>
<html>
	<head>
		<title>
			Order Item Details
		</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<cfinclude template = "header.cfm">
		<cfquery 
			name="orderDetails"
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
				OI.ITEMPRICE as ITEMPRICE,
				C.CUSTOMERNAME as CUSTOMER
			FROM 
				TBORDER O,
				TBORDERITEM OI,
				TBPRODUCT P,
				TBVENDOR V,
				TBCUSTOMER C
			WHERE 
				OI.ORDERNO = 2
				AND OI.ORDERITEMNO ='01'
				AND O.ORDERNO = OI.ORDERNO
				AND OI.PRODUCTID = P.PRODUCTID
				AND OI.VENDORID = V.VENDORID
				AND C.CUSTOMERID = O.CUSTOMERID
		</cfquery>
		<h1>
			Update order item details for:
		</h1>
		<cfform name="updateOrderItem" action="order_item_details.cfm" method="post">
			<cfoutput query="orderDetails">
				<table>
					<tr>
						<th>Order - Item</th>
						<td>#ORDERNO# - #ORDERITEMNO#</td>
					</tr>
					<tr>
						<th>Customer</th>
						<td>#CUSTOMER#</td>
					</tr>
					<tr>
						<th>Date</th>
						<td>#DateFormat("#ORDERDATE#", "short")#</td>
					</tr>
					<tr>
						<th>Product</th>
						<td>#PRODUCTNAME#</td>
					</tr>
					<tr>
						<th>Vendor</th>
						<td>#VENDORNAME#</td>
					</tr>
					<tr>
						<th>Quantity</th>
						<td>
							<table>
								<tr>
									<td>Existing: #QUANTITY#</td>
									<td>New: <input name="quantity" type="number" step="1" min="0" value="#QUANTITY#" required="yes"></td></td>
								</tr>
							</table>
						</td>	
					</tr>
					<tr>
						<th>Price ($)</th>
						<td>
							<table>
								<tr>
									<td>Existing: #ITEMPRICE#</td>
									<td>New: <input name="price" type="number" step=".01" min="0" value="#ITEMPRICE#" required="yes"></td></td>
								</tr>
							</table>
					</tr>
				</table>
			</cfoutput>
		    <br>
			<input type="Submit" value="Submit" name="submitButton">
			<br>
		</cfform>
		<cfif IsDefined("Form.submitButton")>
			<cfquery 
				name="updateOrderItem"
	            datasource="#Request.DSN#"
	            username="#Request.username#"
	            password="#Request.password#">
	          	UPDATE 
	          		TBORDERITEM
	            SET
	               QUANTITY ='#Form.quantity#',
	               ITEMPRICE = '#Form.price#'
	            WHERE 
	            	ORDERNO = 2
					AND ORDERITEMNO ='01'
	        </cfquery>
	        <cflocation url="order_item_details.cfm">
		</cfif>
		<br>
		<a href=http://cscie60.dce.harvard.edu/~ekeuthen/customer_orders.cfm>Return to customer / order list</a>
		<cfinclude template = "footer.cfm">
	</body>
</html>