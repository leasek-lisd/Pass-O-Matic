<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "New Student"; %>
<%@ include file="includes/navbar.jsp" %>
<%@ include file="includes\basicDBinfo.jsp" %> 
<%
String sql = "call findStudentID("+request.getParameter("stuID")+")";



//////////////////////////////////////////////////////////////////////////////////////////////////
// out.println(sql);
int studentNum = 0;
String url = request.getParameter("goToURL")+"?stuID="+studentNum;

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
// out.println(i);
if (resultSet.next()) {
	studentNum = resultSet.getInt("studentID");
  //  out.print(studentNum+"<br>");
}
connection.close();
url = request.getParameter("goToURL")+request.getParameter("returnParameterName")+"="+studentNum;
//out.print(url);
 
} catch (Exception e) {
e.printStackTrace();
}

if(studentNum == 0) {%>
	<form action="idLookUp.jsp">
<h3>Search Again</h3>
  Enter Student Number: <input type="text" value="<%=request.getParameter("stuID")%>" name="stuID">
  <input type="hidden" name="goToURL" value="teacherClaimStudent.jsp">
  <input type="submit" value="Search Again">
</form><br>
<h3>Add Student</h3>
<table>

<form action="addStudent.jsp">
<tr><td>  Student First Name: </td><td><input type="text" name="firstName"></td></tr>
<tr><td>  Student Last Name: </td><td><input type="text" name="lastName"></td></tr>
<tr><td>Student Goes By Name: </td><td><input type="text" name="goesBy"></td></tr>
<tr><td>Grade: </td><td><input type="text" name="grade"></td></tr>
<tr><td>Campus: </td><td><select id="campus" name="campus">
<option value="1">LHS Main</option>
<option value="14">Harmon</option>
<option value="9">Killough</option>
</select>
  <input type="hidden" name="goToURL" value="teacherClaimStudent.jsp">
  <input type="hidden" name="idNum" value="<%=request.getParameter("stuID")%>">
  </td></tr>
  </table>
  <br>
  <input type="submit" value="Add Student">
</form>
	
<%}

else {

out.print(url);	
response.sendRedirect(url);
   
}
%>