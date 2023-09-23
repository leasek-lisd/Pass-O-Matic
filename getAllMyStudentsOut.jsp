<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "All Students Out"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%


String sql = "call GetAllMyStudentsOut ("+session.getAttribute("teacherID")+ ");";
// sql = "call GetStudentsOut2 (128,2);";
// sql = "select 'Beavis' as goesBy, current_timestamp() as outTime, 0 as minutes union select 'Butthead' as goesBy, current_timestamp() as outTime, 3 as minutes";



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
<body>
  <h3>Student(s) Out</h3>
  <table class="demo">
  <th>Student</th><th>Pass Type</th><th>Out Time</th>
  <th>In Time</th>
  <th>Time Out<br>(m/s)</th><th>Room</th><th>Teacher</th><th>Change End Time</th>
 <% 
 
 while(resultSet.next()) {  %>
   <tr>
     <td>
       <%=resultSet.getString("studentName")%>
     </td>
     <td>
       <%=resultSet.getString("passType")%>
     </td>
     <td>
       <%=resultSet.getString("outTime")%>
     </td>
     <td>
       <%=resultSet.getString("inTime")%>
     </td>          
     
     <td>
       <%=resultSet.getString("minutesOut")%>:<%=resultSet.getString("secondsOut")%>
     </td>
     <td>
       <%=resultSet.getString("room")%>
     </td>
     <td>
       <%=resultSet.getString("teacher")%>
     </td>
     <td>
     <a href = "updatePasses.jsp?action=awol&passID=<%=resultSet.getString("id")%>">AWOL</a> | 
     <a href = "updatePasses.jsp?action=delete&passID=<%=resultSet.getString("id")%>">Delete</a><br> 
     <a href = "updatePasses.jsp?action=inAtEnd&passID=<%=resultSet.getString("id")%>">Use end of class</a> | 
     <a href = "updatePasses.jsp?action=inAtStart&passID=<%=resultSet.getString("id")%>">Use Out Time</a> | 
     <a href = "updatePasses.jsp?action=now&passID=<%=resultSet.getString("id")%>">Use current Time</a>
     
     </td>
     
     </tr>

<% } %>
</table>
<% 
  
 
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%>
</body>
