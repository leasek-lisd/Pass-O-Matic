<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "All Students Out"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%


String sql = "call GetAllStudentsOut ();";
// sql = "call GetStudentsOut2 (128,2);";
// sql = "select 'Beavis' as goesBy, current_timestamp() as outTime, 0 as minutes union select 'Butthead' as goesBy, current_timestamp() as outTime, 3 as minutes";



//////////////////////////////////////////////////////////////////////////////////////////////////
// out.println(sql);
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
  <h3>Student(s) Out</h3>
  <table>
  <th>Student</th><th>Pass Type</th><th>Minutes Out</th><th>Room</th><th>Teacher</th>
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
       <%=resultSet.getString("minutes")%>:<%=resultSet.getString("seconds")%>
     </td>
     <td>
       <%=resultSet.getString("room")%>
     </td>
     <td>
       <%=resultSet.getString("teacher")%>
     </td></tr>

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
