<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Update/Add Student"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<style>
  body{
  color:maroon;
  }
  
  h2 {
  color: black;}
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
.formDiv{padding-left: 75px;}
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
String idNum = "0";

boolean isAdd = false;

if(request.getParameter("isAdd") != null){
	out.print("isAdd");
	actionOption = request.getParameter("isAdd");
	isAdd = actionOption.equals("1");
}

if(!isAdd){
String sql = "select distinct firstName, goesBy, lastName, s.id as studentID, s.idNum, gradelevel as grade, homeCampus"+ 
" from students s join enrollments e on e.student = s.id where e.id  = "+request.getParameter("enrollID")+";";
// sql = "call GetStudentsOut2 (128,2);";
// sql = "select 'Beavis' as goesBy, current_timestamp() as outTime, 0 as minutes union select 'Butthead' as goesBy, current_timestamp() as outTime, 3 as minutes";



//////////////////////////////////////////////////////////////////////////////////////////////////
out.println("<!--" + sql+" -->");
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%

 
 if(resultSet.next()){
	 
 

 firstName = resultSet.getString("firstName");
 goesBy = resultSet.getString("goesBy");
 lastName = resultSet.getString("lastName");
 studentID = resultSet.getString("studentID");
 grade = resultSet.getString("grade");
 homeCampus = resultSet.getString("homeCampus"); 
 if(homeCampus == null){homeCampus = "";};
 idNum = resultSet.getString("idNum");
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
 <div class="formDiv">
<h2>Add Student</h2>

<form action="updateStudent.jsp" id="studentFrom">
  <input type="hidden" name="studentID" value = "<%=studentID%>">
  <input type="hidden" name="action" value = "<%=actionOption%>">
  <label for="fname">First name:</label><br>
  <input type="text" id="firstName" name="firstName" value="<%=firstName%>"  required>*<br><br>
    <label for="goesBy">Goes By:</label><br>
  <input type="text" id="goesBy" name="goesBy" value="<%=goesBy%>"><br><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lastName" name="lastName" value="<%=lastName%>"  required>*<br><br>
  <label for="studentID">Student ID #:</label><br>
  <input type="text" id="idNum" name="idNum" value="<%=idNum%>"  required>*<br>
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
  <option value="LHS" <% if(homeCampus.equals("LHS")){out.print("selected");}%>>LHS Main</option>
  <option value="LHSH" <% if(homeCampus.equals("LHSH")){out.print("selected");}%>>Harmon</option>
  <option value="LHSK" <% if(homeCampus.equals("LHSK")){out.print("selected");}%>>Killough</option>
</select>*
  <br>
  <br>
  <input type="submit" value="Submit">
</form> 

</div>
 </body>
 