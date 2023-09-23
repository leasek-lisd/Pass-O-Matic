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
if(request.getParameter("idNum")!=null){

	if(isAdmin.equals("0")){
		  sql = "call getStudentHistoryTeacher ("+request.getParameter("idNum")+");";
		//  out.println("1" + sql);
		} else if(isAdmin.equals("1")){
		  sql = "call getStudentHistoryAdmin ("+request.getParameter("idNum")+");";
		 // out.println("2" + sql);
		}




//////////////////////////////////////////////////////////////////////////////////////////////////
//out.println(sql);
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
 </style> <%
  if(resultSet.next()){%>
	  <div class="name"><%=resultSet.getString("firstName")%> <%=resultSet.getString("lastName")%><br>

	  
	  
  <table>
  <th></th>
  <th>When</th>
  <th>Event</th><%
  if(isAdmin.equals("1")){
  %>

  <th>Teacher</th>
  <th>Class</th>
  <%} %>
 

 <% 
 
 do{  %>
   <tr>
     <td></td>
     <td><%=resultSet.getString("eventTime")%></td>
     <td><%=resultSet.getString("eventDescription")%></td><%
    		 if(isAdmin.equals("1")){ %>
     <td><%=resultSet.getString("teacherName")%></td>
     <td><%=resultSet.getString("className")%></td>

  <%}else if (0==1) { %>
	<td><a href="problemPasses.jsp?passID=<%=resultSet.getString("passID")%>">Edit</a></td>
 <% } %>
  </tr>

<% }while(resultSet.next());// while %>
</table>
<% 
  }// if
  connection.close();
 }  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}
}

%>
