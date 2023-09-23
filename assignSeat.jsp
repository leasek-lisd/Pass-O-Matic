<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes\basicDBinfo.jsp" %> 
<%
String sql = "call assignSeat("+request.getParameter("enrollID")+","+request.getParameter("seatID")+")";




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
String url = "";
while (resultSet.next()) {
	
	url = "SeatingChart.jsp?roomID="+resultSet.getString("roomID")+"&period="+resultSet.getString("periodNum")+"&mode=1";
	
}
connection.close();

//out.print(url);
response.sendRedirect(url);
} catch (Exception e) {
e.printStackTrace();
}



%>