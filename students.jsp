<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Students"; %>
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



String sql = "call getStudentsByTeacher ("+session.getAttribute("teacherID")+","+usePeriod+");";
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

 %>
 <style>
 table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding-left: 15px;
  padding-right: 15px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
 
 
 td img {
 height: 20px;}
 th img {
 height: 25px;}
 .center {
 text-align: center;
 }
 .seat{
 color: green;
 font-weight: bold;
 text-align: center;
 width: 25px;
 }

#menuItems {
  position:relative;
  left: 20px;
  top: 10px;
}
 </style> <%
  if(resultSet.next()){
	 %> <div id="menuItems"><form>Select Period: 
	 <input type="hidden" name="mode" value="1">
	 <input type="radio" onchange="this.form.submit();" id = "periodA" name = "period" value = "0"><label for "periodA">All</label>
	   <%=resultSet.getString("periodChoices")%>
     </form>
<form action="idLookUp.jsp">Add Student:
<input type="hidden" name="goToURL" value="teacherClaimStudent.jsp">
<input type="text" id="stuID" name="stuID" placeholder="Search by student ID #" required>
<input type="submit" value="Search">
</form>
</div>
  <table>
  <th></th>
  <th>Student ID</th>
  <th>Student Name</th>
  <th>Seat</th>
  <th>Passes Used<br>today/semester</th>
  <th><img src="img/Emergency.png"> Left</th>
  <th>Permissions</th>
  <th>Special</th>
  <th></th>
 <% 
 
 do{  %>
   <tr>
     <td>
       <%=resultSet.getString("indicators")%>
     </td>
     <td>
       <%=resultSet.getInt("IDnum")%>
     </td>
     <td>
       <%=resultSet.getString("firstName")%> (<%=resultSet.getString("goesBy")%>) <%=resultSet.getString("lastName")%>
     </td>
     <td class="seat"><%if (resultSet.getString("seat") != null) {%>
       <%=resultSet.getString("seat")%><%}
     else {%><img src="img/redQuestionMark.png">
    	 <% } %>
     </td>
     <td class="center">     
       <%=resultSet.getString("passesToday")%> / <%=resultSet.getString("allPasses")%>
     </td>
     <td class="center"><%=resultSet.getString("ePasses")%></td>
     <td>Campus: <%
       if(resultSet.getString("campusPassBlock").equals("0")){
        %> <img src="img/thumbsUp.jpg" > <%}
       else {
    	   %> <img src="img/thumbsDown.jpg" ><%}%> 
    	   Class: <%
       if(resultSet.getString("passBlock").equals("0")){
        %> <img src="img/thumbsUp.jpg" > <%}
       else {
    	   %> <img src="img/thumbsDown.jpg" ><%}%>
     </td>
     <td>
       <a href="studentMenu.jsp?enrollId=<%=resultSet.getString("enrollID")%>">Notes</a> | 
       <a href="editStudent.jsp?enrollId=<%=resultSet.getString("enrollID")%>">Edit</a>
     </td></tr>

<% }while(resultSet.next());// while %>
</table>
<% 
  }// if
  connection.close();
 }  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%>
