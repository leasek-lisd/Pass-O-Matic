<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes\basicDBinfo.jsp" %> 
<%

// This template will execute a SQL statement and then if successfull it will redirect to
// the designated URL

// Note: It is for SQL statements that do NOT have a returned result set

//////////////////////////////////////////////////////////////////////////////////////////////////

// SQL Statement to be executed (replace with your statement)

String sql = "call ReturnStudentByNumber("+request.getParameter("StuID")+")";

//////////////////////////////////////////////////////////////////////////////////////////////////


// out.println(sql);  // uncomment if you want to output your SQL statement

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


int i = statement.executeUpdate(sql);


connection.close();

} catch (Exception e) {
e.printStackTrace();
out.println(e.toString());
}

if (i==1) {
String url = "SeatingChart.jsp?mode=1&period="+request.getParameter("period");
response.sendRedirect(url);
}
else {
  out.println("Error Occured");}

%>