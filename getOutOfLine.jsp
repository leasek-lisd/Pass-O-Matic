<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfoStudent.jsp" %> 
<%

// This template will execute a SQL statement and then if successfull it will redirect to
// the designated URL

// Note: It is for SQL statements that do NOT have a returned result set

//////////////////////////////////////////////////////////////////////////////////////////////////

// SQL Statement to be executed (replace with your statement)

String sql = "call getOutOfLine("+request.getParameter("enrollID")+")";
String url = "";
//////////////////////////////////////////////////////////////////////////////////////////////////


out.println(sql);  // uncomment if you want to output your SQL statement
int i = 0;
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


 i = statement.executeUpdate(sql);
 
 if(request.getParameter("src")!=null && request.getParameter("src").equals("teacher")){
		url = "SeatingChart.jsp?mode=1";
	}
	else if(request.getParameter("src")!=null && request.getParameter("src").equals("kiosk")){
		url = "kioskClassPage.jsp?mode=1&period="+request.getParameter("period");}
	else {
	    url = "StudentDashboard.jsp?stuID="+request.getParameter("StuID");
	}
	 

connection.close();

} catch (Exception e) {
e.printStackTrace();
out.println(e.toString());
}

if (i==1) {
// String url = "StudentDashboard.jsp?stuID="+request.getParameter("StuID");
response.sendRedirect(url);
}
else {
  out.println("Error Occured");}

%>