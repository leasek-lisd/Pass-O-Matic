<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Student History"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<%


String isAdmin = "0";
if( request.getParameter("admin") != null) {
	  isAdmin = request.getParameter("admin");
	
}
String sql = "";


if(isAdmin.equals("1")){%>
<br>
<form action="idLookUp.jsp">
Enter Student Number: <input type="text" name="stuID">
<input type="hidden" name="goToURL" value="studentHistory.jsp?admin=1&">
<input type="hidden" name="returnParameterName" value="idNum">
<input type="submit" value="Find Student">
</form>
<%}
if(request.getParameter("classID")!=null){
  sql = "call getAnnouncements("+request.getParameter("classID")+");";




//////////////////////////////////////////////////////////////////////////////////////////////////
out.println("<!--" + sql+" -->");
try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;

try {
connection = DriverManager.getConnection(
connectionUrl + dbName, userId, password);
statement = connection.createStatement();


 resultSet = statement.executeQuery(sql);

 %>
 <style>
 table {
  border-collapse: collapse;
  border-spacing: 0;
 
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 15px;
  
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
 
 
 td img {
 height: 20px;}
 th img {
 height: 25px;}
 .center {
 text-align: center;
 }
 .seat{
 color: green;
 font-weight: bold;
 text-align: center;
 width: 25px;
 }

.name {
font-size:2em;
color:maroon;
padding:20px;}
#menuItems {
  position:relative;
  left: 20px;
  top: 10px;
}

.detail {
  font-size: .75em
  color: black;}
  
  .formHide {
     cursor:pointer;
     color:blue;
     text-decoration:underline;
     font-size:.6em;
}

 </style> <%
  if(resultSet.next()){%>
	  <div class="name">Current Announcements</div>

	  
	  
  <table>
  <th></th>
  <th>Text</th>
  <th>Important</th>
  
  
  
 

 <% 
 
 do{  %>
   <tr>
     
  
     
  <td><%=resultSet.getString("example")%></td>
  <td>Move <% 
    if(resultSet.getInt("sortOrder") > 10 ){
  %><a href = "moveAnnouncement.jsp?direction=-1&announcementID=<%=resultSet.getString("id")%>"><img height = "8px" src="img/upArrow.png"></a> 
   <%} 
   
   if(resultSet.getInt("sortOrder") != resultSet.getInt("maxSortOrder")) {%>  
  <a href = "moveAnnouncement.jsp?direction=1&announcementID=<%=resultSet.getString("id")%>"><img height = "8px" src="img/downArrow.png"></a>
  <%} %><br>
  </td>
  <td><%=resultSet.getString("displayText")%></td>
  <td><span class = "formHide" id="spn<%=resultSet.getString("id")%>">Update</span></td><td>
  <a href = "moveAnnouncement.jsp?direction=0&announcementID=<%=resultSet.getString("id")%>"><img src="img/trashCan.png"></a>
  </td></tr>
  
  
  <tr>
  
  <td colspan="3"><style> #form<%=resultSet.getString("id")%>{display: none; }</style>
  
  <form id="form<%=resultSet.getString("id")%>" action="updateAnnouncement.jsp">
  <input type="hidden" name="class" value="<%=request.getParameter("classID")%>">
<input type="hidden" name="announcementID" value="<%=resultSet.getString("id")%>">
<input type="hidden" name="sortOrder" value="<%=resultSet.getString("sortOrder")%>">
<table>
<tr>
<td>
<div><div class="label">Display Text</div>
  <input type="text" id="displayText" name="displayText" value="<%=resultSet.getString("displayText")%>">
</div>
  </td><td>
  <span><div>Link</div>
  <input type="checkbox" id="isLink" name="isLink" value="1" <%= ( resultSet.getBoolean("isLink") ? "checked" : "") %>>
</span>
</td><td>
<span><div>URL</div>
  <input type="text" id="url" name="url" value="<%=resultSet.getString("url")%>" <%= ( resultSet.getBoolean("isLink") ? "" : "disabled")%>>
</span>
</td><td>

  <input type="checkbox" id="isBold" name="isBold" value="1" <%= ( resultSet.getBoolean("isBold") ? "checked" : "")%> <%= ( resultSet.getBoolean("isLink") ? "disabled" : "")%>>
  <label for="isBold"> Bold</label><br>
    
  </td><td>
  <input type="submit" value="Change">
  </td></tr></table>
</form>
<script>

var toggle = 0;

document.getElementById("isLink").onchange = manageChange("isLink");
	
	
function manageChange(changed) {
if (toggle == 0){
  enable(changed);
  toggle = 1;}
else {
  
  toggle = 0;
 
  document.getElementById("url").value = "";
  disable(changed);
  }
};
</script>
  
  
  
  

<!-- <button id="btn<%=resultSet.getString("id")%>">Store Parameters</button> -->

<script>
//    const btn<%=resultSet.getString("id")%> = document.getElementById('btn<%=resultSet.getString("id")%>');
      const spn<%=resultSet.getString("id")%> = document.getElementById('spn<%=resultSet.getString("id")%>');
//    btn<%=resultSet.getString("id")%>.addEventListener('click', () => {
    spn<%=resultSet.getString("id")%>.addEventListener('click', () => {
    const form<%=resultSet.getString("id")%> = document.getElementById('form<%=resultSet.getString("id")%>');
  
    if (form<%=resultSet.getString("id")%>.style.display === 'block') {
      // 👇️ this SHOWS the form
      form<%=resultSet.getString("id")%>.style.display = 'none';
    } else {
      // 👇️ this HIDES the form
      form<%=resultSet.getString("id")%>.style.display = 'block';
    }
  });
</script></td>

<td></td>
  </tr>

<% }while(resultSet.next());// while %>
 
</table>
<% 
  // if
  connection.close();
 } } // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());

}
}
%>
<div class="name">Add Announcement:</div>
<form action="updateAnnouncement.jsp">
<input type="hidden" name="class" value="<%=request.getParameter("classID")%>">
<input type="hidden" name="announcementID" value="0">
<input type="hidden" name="sortOrder" value="1000">
<table>
<tr>
<td>
<div><div class="label">Display Text</div>
  <input type="text" id="displayText" name="displayText" value="">
</div>
  </td><td>
  <span><div>Link</div>
  <input type="checkbox" id="isNewLink" name="isLink" value="1">
</span>
</td><td>
<span><div>URL</div>
  <input type="text" id="urlNew" name="url" value="" disabled>
</span>
</td><td>

  <input type="checkbox" id="isBold" name="isBold" value="1">
  <label for="isBold"> Bold</label><br>
     
  </td><td>
  <input type="submit" value="Add">
  </td><td>X</td></tr></table>
</form>
<script>
function enable(inURL) {
	document.getElementById(inURL).disabled = false;
	}

	function disable(inURL) {
	document.getElementById(inURL).disabled = true;
	}

var toggleNew = 0;
document.getElementById("isNewLink").onchange = function() {
	

if (toggleNew == 0){
  enable("urlNew");
  toggleNew = 1;}
else {
  
  toggleNew = 0;
  // var bikeBox = document.getElementById("bikeType");
  document.getElementById("urlNew").value = "";
  disable("urlNew");
  }
};
</script>