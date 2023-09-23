<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%

userId = "klease";
password = "J@hnGalt42";
String sql = "call getPassStatus("+session.getAttribute("enrollID")+")";




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

// resultSet.getInt("");
// resultSet.getString("fileURL")

if(resultSet.next()){

  if(resultSet.getInt("isPrinted") == 1) { %>

<h3>Pass <%=resultSet.getString("id")%> has been printed, out time is: <%=resultSet.getString("OutTime")%></h3>

<% 

String studentID = resultSet.getString("StudentID");
connection.close();
String url = "CheckStudentByNumber.jsp?StuID="+studentID;
response.sendRedirect(url);
}
else {out.println("Pass pending");}

connection.close();

} }

catch (Exception e) 
{
out.println("getPassStatus exception");
e.printStackTrace();
out.println(e.toString());
connection.close();
}


%>
