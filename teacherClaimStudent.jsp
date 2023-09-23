<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Change Schedule"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<head> <title>Students - Pass O'Matic</title> </head> <body>
<style>

	.remove {
		font-size: 8px;
		color: red;
	}
	.demo {
		border:1px solid #C0C0C0;
		border-collapse:collapse;
		padding:15px;
	}
	.demo th {
		border:1px solid #C0C0C0;
		padding:5px;
		background:#F0F0F0;
	}
	.demo td {
		border:1px solid #C0C0C0;
		padding:15px;
                text-align: center;
                font-size:12px
	}

</style>
<br>
<form action="idLookUp.jsp">
  Enter Student Number: <input type="text" name="stuID">
  <input type="hidden" name="goToURL" value="teacherClaimStudent.jsp?">
<input type="hidden" name="returnParameterName" value="stuID">
  <input type="submit" value="Find Student">
</form>
<%

 if( (request.getParameter("stuID") != null)  )  {

String sql = "call getStudentScheduleTeacherView("+request.getParameter("stuID")+","+session.getAttribute("teacherID")+ ")";




//////////////////////////////////////////////////////////////////////////////////////////////////
out.println(sql);
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
%> <table class="demo" ><tbody> 
<tr><th>Period</th><th>Student</th><th>Current Class</th><th>Teacher / Room</th><th>Add</th><th>Your Class</th><th>Room</th>
<%
// resultSet.getInt("");
// resultSet.getString("fileURL")
while(resultSet.next()) {  %>
  <tr>
    <td><%= resultSet.getInt("periodNum")%></td>
    <td><div><%= resultSet.getString("firstName")+" "+resultSet.getString("lastName") %></div><%
   // if(  resultSet.getString("name") != null ){
    	if(  resultSet.getInt("newClassID") == resultSet.getInt("classID") ){
    %>
    <span class="remove"><a href="changeEnrollment.jsp?stuID=<%= request.getParameter("stuID")%>&oldE=<%= resultSet.getInt("enrollmentID")%>&newClass=0&period=<%= resultSet.getInt("periodNum")%>">Remove</a>
    </span>
    <% } %>
    </td>
    <td><%= resultSet.getString("classTitle")%></td>
    <td><%= resultSet.getString("name")+ " / "+ resultSet.getString("room")%></td>
    <td><a href="changeEnrollment.jsp?stuID=<%= request.getParameter("stuID")%>&oldE=<%= resultSet.getInt("enrollmentID")%>&newClass=<%= resultSet.getInt("newClassID")%>&period=<%= resultSet.getInt("periodNum")%>"><img height="15px" src="img/leftArrow.png"></a></td>
    <td><%= resultSet.getString("newClassTitle")%></td>
    <td><%= resultSet.getString("newClassRoom")%></td>


<% }
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}
}

%>
