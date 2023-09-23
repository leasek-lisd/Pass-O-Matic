<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes\basicDBinfo.jsp" %> 
<%
String url = "";

String isLink = "0";
if(request.getParameter("isLink") != null){
	isLink = request.getParameter("isLink");
}


String isBold = "0";
if(request.getParameter("isBold") != null){
	isBold = request.getParameter("isBold");
}

int useSortOrder = 0;
if(request.getParameter("announcementID").equals("0") && request.getParameter("announcementID")!= null){
	useSortOrder = Integer.parseInt(request.getParameter("sortOrder")) + 5;}
else {
	useSortOrder = Integer.parseInt(request.getParameter("sortOrder"));}



String sql = "call updateAnnouncement('"
+request.getParameter("announcementID")+"',"
+request.getParameter("class")+",'"
+request.getParameter("displayText")+"','"
+request.getParameter("url")+"',"
+isLink+","
+isBold+","
+useSortOrder+")";




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
if (i>=0) {
	url = "classAnnouncements.jsp?classID="+request.getParameter("class");
out.println("url");
}
connection.close();
 
response.sendRedirect(url);
%>
<a href="<%=url%>">continue</a>
<%
} catch (Exception e) {
e.printStackTrace();
}



%>