<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfoStudent.jsp" %> 
<%
String sql = "call ReturnStudentByNumber("+request.getParameter("StuID")+")";




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
// out.println(i);

out.println("Welcome Back");
String url;
out.print("'"+request.getParameter("src")+"'");
if(request.getParameter("src")!=null && request.getParameter("src").equals("teacher")){
	url = "SeatingChart.jsp?mode=1";
}
else if(request.getParameter("src")!=null && !request.getParameter("src").equals("student") ){
	url = "kioskClassPage.jsp?mode=1&period="+request.getParameter("period");}
else {
    url = "StudentDashboard.jsp?stuID="+request.getParameter("StuID");
}
connection.close();
out.print(url);
response.sendRedirect(url);

} catch (Exception e) {
e.printStackTrace();
}



%>