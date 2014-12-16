<h1>
	White Mountains Hiking Headquarters
</h1>
<ul>
	<cfif len(#GetAuthUser()#) IS NOT 0>
		<li>Welcome, <cfoutput>#GetAuthUser()#</cfoutput>!</li>
	</cfif>
  	<li><a href="hike_home.cfm" class="menu">Home</a></li>
  	<li><a href="pop_hikes.cfm" class="menu">Popular Hikes</a></li>
  	<li><a href="user_login.cfm" class="menu">Login</a></li>
  	<li><a href="logout.cfm" class="menu">Logout</a></li>
</ul>