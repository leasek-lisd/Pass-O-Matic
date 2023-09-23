<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Pass History"; %>
<%@ include file="includes/navbar.jsp" %> 
<%@ include file="includes/basicDBinfo.jsp" %> 
<head> <title>Students - Pass O'Matic</title> </head> <body>
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

<%


String sql = "call getStudentPassHistory("+request.getParameter("enrollID")+");";




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
  <h2>Pass History for: </h2>
  <h1><%=resultSet.getString("FirstName")%> <%=resultSet.getString("LastName")%></h1>
<table class="demo" ><tbody>
<tr><th>Date</td><th>Name</td><th>Out Time</td><th>In Time</td><th>Duration</td><th>Pass Type</td>
<% 

do{ %>
  <tr><td><%=resultSet.getString("passdate")%></td><td><%=resultSet.getString("FirstName")%> <%=resultSet.getString("LastName")%></td><td><%=resultSet.getString("OutTime")%></td><td><%=resultSet.getString("InTime")%></td><td><%=resultSet.getString("TimeOut")%></td><td><%=resultSet.getString("label")%></td>
<% }while(resultSet.next());}
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%>
