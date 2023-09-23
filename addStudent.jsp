<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes\basicDBinfo.jsp" %> 
<%



String sql = "call addStudent('"
+request.getParameter("campus")+"',"
+request.getParameter("idNum")+",'"
+request.getParameter("firstName")+"','"
+request.getParameter("lastName")+"','"
+request.getParameter("goesBy")+"',"
+request.getParameter("grade")+")";




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

// resultSet.getInt("");
// resultSet.getString("fileURL")

// int i = statement.executeUpdate(sql);
//out.println(i);
if (resultSet.next()) {
  
  //String url = "idLookUp.jsp?goToURL=teacherClaimStudent.jsp&returnParameterName=stuID&stuID="+resultSet.getInt("newStudentID");
  String url = "teacherClaimStudent.jsp?stuID="+resultSet.getInt("newStudentID");
  
  connection.close();
  response.sendRedirect(url);}
  else {%>
  Unable to add student;
<%}
} catch (Exception e) {
    e.printStackTrace();
    out.println(e.toString());
}



%>