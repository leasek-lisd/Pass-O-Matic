<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes\basicDBinfo.jsp" %> 
<%



String sql = "call addStudent2('"
+request.getParameter("campus")+"',"
+request.getParameter("idNum")+",'"
+request.getParameter("firstName")+"','"
+request.getParameter("lastName")+"','"
+request.getParameter("goesBy")+"',"
+request.getParameter("idNum")+","
+request.getParameter("grade")+")";




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

resultSet = statement.executeQuery(sql);

// int i = statement.executeUpdate(sql);
out.println(i);
int stuID = 0;
if (resultSet.next()){
stuID=resultSet.getInt(stuID);
}
connection.close();
String url = "teacherClaimStudent.jsp?stuID="+stuID;
response.sendRedirect(url);%>
<a href="<%=url%>">continue</a>
<%
} catch (Exception e) {
e.printStackTrace();
}



%>