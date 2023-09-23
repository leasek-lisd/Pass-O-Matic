<%@ page import="com.lisd.cs.util.DBUtil" %>

<%
String driverName = "com.mysql.jdbc.Driver";

////////////////////////////////////////////////////////////////////////////////////////////////////

////////   Database Connection Info ///////////////////////////////////////////////////////////////

//if(session.getAttribute("teacherID")==null){
//	response.sendRedirect("http://kjeil.com/lhs");
//}

String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "passomatic"; 
String userId = "klease"; 
String password = "123456";
String userName = "klease"; 
// String userIdCI = "klease"; 
// String passwordCI = "J@hnGalt42";

// userId = "klease";
// password = "J@hnGalt42";

%>