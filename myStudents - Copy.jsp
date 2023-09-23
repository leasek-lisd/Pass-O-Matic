<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@page import="java.sql.ResultSetMetaData"%> 
<%String pageTitle = "My Students"; %>
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



String sql = "call getStudentsByTeacherSelect ("+session.getAttribute("teacherID")+","+usePeriod+");";
// sql = "call GetStudentsOut2 (128,2);";
// sql = "select 'Beavis' as goesBy, current_timestamp() as outTime, 0 as minutes union select 'Butthead' as goesBy, current_timestamp() as outTime, 3 as minutes";



//////////////////////////////////////////////////////////////////////////////////////////////////
out.println("<!-- sql: "+sql+" -->");
%>
<%@ include file="includes/openRecordset.jsp" %>

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
  padding: 15px;
  
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

.activity{
height:40px;
text-align: right;
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

.detail {
  font-size: .6em;
  font-weight: bold;
  color: red;
}
  
.classStatus {
  height: 18px;
  width: 18px;
  border-radius: 18px;
  display: inline-block;
}  

.red {
  background-color: red;
}

.yellow {
  background-color: yellow;
}

.green {
  background-color: green;
}

.blue {
  background-color: blue;
}
 </style> <%
  if(resultSet.next()){
	/*  ResultSetMetaData rsMetaData = resultSet.getMetaData();
	  int count = rsMetaData.getColumnCount();
      for(int i = 1; i<=count; i++) {
         out.println(rsMetaData.getColumnName(i)+i);
      }
*/	  
	 %> <div id="menuItems"><form>Select Period: 
	 <input type="hidden" name="mode" value="1">
	 <input type="radio" onchange="this.form.submit();" id = "periodA" name = "period" value = "0"<%
	   if(usePeriod.equals("0")){out.print("checked");}
	 %>><label for "periodA">All</label>
	   <%=resultSet.getString("periodChoices")%>
     </form>
<form action="idLookUp.jsp">Find Student:
<input type="hidden" name="goToURL" value="teacherClaimStudent.jsp?">
<input type="hidden" name="returnParameterName" value="stuID">
<input type="text" id="stuID" name="stuID" placeholder="Search by student ID #" required>
<input type="submit" value="Search">
</form>
</div>
  <table>
  <th></th>
  <th>Student ID</th>
  <th>Student Name</th>
  <th>Period</th>
  <th class="center">Seat</th>
  <th class="center">Passes Used<br><span class="detail">today/semester</span></th>
  <th class="center"><img src="img/Emergency.png"> Left</th>
  <th>Permissions</th>
  <th>Link<br>Status</th>
 

 <% 
 
 do{  %>
   <tr>
     <td class="activity">
       <%=resultSet.getString("indicators")%>
     </td>
     <td>
       <%=resultSet.getInt("IDnum")%>
     </td>
     <td>
       <div><%=resultSet.getString("firstName")%> (<%=resultSet.getString("goesBy")%>) <%=resultSet.getString("lastName")%></div>
       <div><a href="studentMenu.jsp?enrollID=<%=resultSet.getString("enrollID")%>&StuID=<%=resultSet.getString("studentID")%>">Options</a> | 
       <a href="editStudent.jsp?enrollID=<%=resultSet.getString("enrollID")%>">Edit</a> | <a href="studentHistory.jsp?idNum=<%=resultSet.getString("enrollID")%>">View History</a> | 
       <a href="teacherClaimStudent.jsp?stuID=<%=resultSet.getString("studentID")%>">Schedule</a> | <a href="passMenu.jsp?enrollID=<%=resultSet.getString("enrollID")%>">Pass Menu</a></div>
     </td>
     <td class="center"><%=resultSet.getString("periodNum")%>
     </td>
     <td class="seat"><%if (resultSet.getString("seat") != null) {%>
       <%=resultSet.getString("seat")%><%}
     else {%><img src="img/redQuestionMark.png">
    	 <% } %>
     </td>
     <td class="center">     
       <div><%=resultSet.getString("passesToday")%> / <%=resultSet.getString("allPasses")%></div>
	<span class=detail>Limit: <%=resultSet.getString("passLimit")%> + <%=resultSet.getString("addlPasses")%> <a href="addToLimit.jsp?type=n&enrollID=<%=resultSet.getString("enrollID")%>"><br>Add +</a></span>
     </td>
     <td class="center"><div><%=resultSet.getString("ePassesLeft")%></div>
	<span class=detail>Limit: <%=resultSet.getString("numEPasses")%> + <%=resultSet.getString("addlEPasses")%> <a href="addToLimit.jsp?type=e&enrollID=<%=resultSet.getString("enrollID")%>"><br>Add +</a></span>
</td>
     <td class="center">Campus: <%
       if(resultSet.getString("campusPassBlock").equals("0")){
        %> <img src="img/thumbsUp.jpg" > <%}
       else {
    	   %> <img src="img/thumbsDown.jpg" ><%}%> 
    	
    	Class: <div class="classStatus <%=resultSet.getString("classStatus") %>"></div>
    	   
    	   
    	   Individual: <a href="changeStudentBlock.jsp?studentID=<%=resultSet.getString("studentID")%>&currentStatus=<%=resultSet.getString("passBlock")%>"><%
       if(resultSet.getString("passBlock").equals("0")){
        %> <img src="img/thumbsUp.jpg" > <%}
       else {
    	   %> <img src="img/thumbsDown.jpg" ><%}%></a>
  
       
     </td>
     <td class="center"><div class="classStatus <%=resultSet.getString("linkStatus") %>"></div></tr>

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
