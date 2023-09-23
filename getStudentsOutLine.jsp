<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%


String sql = "call getstudentsout(1)";




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

// resultSet.getInt("");
// resultSet.getString("fileURL")
if(resultSet.next()) {  %>
  <h2>Current Line</h2>
  <h1><%=resultSet.getString("GoesBy")%></h1>
<% 

while(resultSet.next()){ %>
  <h1><%=resultSet.getString("GoesBy")%></h1>
<% }}
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
}


%>
