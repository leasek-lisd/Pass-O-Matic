<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%
String sql = "call insertnote("+"11,"+request.getParameter("enrollID")+")";




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


// resultSet = statement.executeQuery(sql);

// resultSet.getInt("");
// resultSet.getString("fileURL")

 int i = statement.executeUpdate(sql);

out.println(i);
if (i==1) {

}
connection.close();
String url = "SeatingChart.jsp?mode=3&period="+request.getParameter("period");
response.sendRedirect(url);
} catch (Exception e) {

e.printStackTrace();
}



%>