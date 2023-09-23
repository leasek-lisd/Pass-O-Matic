<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Update/Add Student"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<%


String usePeriod = "0";
if( request.getParameter("period") != null) {
	  usePeriod = request.getParameter("period");
	  session.setAttribute("lastPeriod", request.getParameter("period"));
}

else if( session.getAttribute("lastPeriod") != null) {
	  usePeriod = (String)session.getAttribute("lastPeriod");
}

String firstName = "";
String goesBy = "";
String lastName = "";
String studentID = "";
String grade = "";
String homeCampus = "";
String actionOption = "0";

boolean isAdd = false;

if(request.getParameter("isAdd").equals("1")){
	isAdd = true;
	actionOption = "1";
}

if(!isAdd){
String sql = "select firstName, goesBy, lastName, id as studentID, gradelevel as grade, homeCampus from students where id = 10"+request.getParameter("stuID")+";";
// sql = "call GetStudentsOut2 (128,2);";
// sql = "select 'Beavis' as goesBy, current_timestamp() as outTime, 0 as minutes union select 'Butthead' as goesBy, current_timestamp() as outTime, 3 as minutes";



//////////////////////////////////////////////////////////////////////////////////////////////////
//out.println(sql);
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
 

 
 if(resultSet.next()){
	 
 

 firstName = resultSet.getString("firstName");
 goesBy = resultSet.getString("goesBy");
 lastName = resultSet.getString("lastName");
 studentID = resultSet.getString("studentID");
 grade = resultSet.getString("grade");
 homeCampus = resultSet.getString("homeCampus"); 
 } 
 
 connection.close();
 }  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}
}
	 %>
 
<h2>Add Student</h2>

<form action="updateStudent.jsp" id="studentFrom">
  <input type="hidden" name="action" value = "<%=actionOption%>">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname" value="<%=firstName%>"  required>*<br><br>
    <label for="goesBy">Goes By:</label><br>
  <input type="text" id="goesBy" name="goesBy" value="<%=goesBy%>"><br><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname" value="<%=lastName%>"  required>*<br><br>
  <label for="studentID">Student ID #:</label><br>
  <input type="text" id="studentID" name="studentID" value="<%=studentID%>"  required>*<br>
  <br>
  <select name="grade" id="grade" required>
  <option value="">Grade</option>
  <option value="12" <% if(grade.equals("12")){out.print("selected");}%>>12</option>
  <option value="11" <% if(grade.equals("11")){out.print("selected");}%>>11</option>
  <option value="10" <% if(grade.equals("10")){out.print("selected");}%>>10</option>
  <option value="9" <% if(grade.equals("9")){out.print("selected");}%>>9</option>
</select>*

  <select name="homeCampus" id="homeCampus" required>
  <option value="">Home Campus</option>
  <option value="1">LHS Main</option>
  <option value="14">Harmon</option>
  <option value="9">Killough</option>
</select>*
  <br>
  <br>
  <input type="submit" value="Submit">
</form> 


 </body>
 