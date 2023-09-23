<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%

String driverNameAD = "com.mysql.jdbc.Driver";

////////////////////////////////////////////////////////////////////////////////////////////////////

////////   Database Connection Info ///////////////////////////////////////////////////////////////

 String connectionUrlAD = "jdbc:mysql://localhost:3306/";
 String dbNameAD = "deployomatic"; 
 String userIdAD = "localwebapp"; 
 String passwordAD = "LH$CSrules23";
////////////////////////////////////////////////////////////////////////////////////////////////////

////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sqlAD = "call getassignmentsbyteacher(1)";

//////////////////////////////////////////////////////////////////////////////////////////////////

try {
Class.forName(driverNameAD);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connectionAD = null;
Statement statementAD = null;
ResultSet resultSetAD = null;

try {
connectionAD = DriverManager.getConnection(
connectionUrlAD + dbNameAD, userIdAD, passwordAD);
statementAD = connectionAD.createStatement();


resultSetAD = statementAD.executeQuery(sqlAD);

// resultSet.getInt("");
// resultSet.getString("fileURL")


%>
<select id="assignment" name="assignmentSelected" onchange="this.form.submit()">

<%

while (resultSetAD.next()) { %>
<option value="<%=resultSetAD.getString("id")%>"<%
  if( (resultSetAD.getString("id")).equals(assignmentNum))
      {out.print(" selected");}%>><%=resultSetAD.getString("label")%></option>
<% } %>
</select> 

<%
connectionAD.close();
} catch (Exception e) {
out.println("oops");
e.printStackTrace();
}



%>