<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes\basicDBinfo.jsp" %> 
<%



String sql = "call classButtons('"
+request.getParameter("classID")+"','"
+request.getParameter("setting")+"','"
+request.getParameter("value")+"');";




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


// resultSet = statement.executeQuery(sql);

// resultSet.getInt("");
// resultSet.getString("fileURL")

int i = statement.executeUpdate(sql);
out.println(i);
if (i==1) {
out.println("yay");
}
connection.close();
//String url = "teacherDashboard.jsp";
//response.sendRedirect(url);%>
Ok
<%
} catch (Exception e) {
e.printStackTrace();
}



%>