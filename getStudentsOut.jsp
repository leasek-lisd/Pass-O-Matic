<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 

<style>
.studentRed {
  color: red;
  font-weight: bold;
  font-size: 1.25em;
}
</style>
<%
int isMinimized = 0;
if( request.getParameter("isMinimized") != null && request.getParameter("isMinimized").equals("yes") ){
	  isMinimized = 1;
}

String sql = "call GetStudentsOut2 ("+ request.getParameter("teacherID") +","+ request.getParameter("period")+ ","+ isMinimized+");";
// sql = "call GetStudentsOut2 (128,2);";
// sql = "select 'Beavis' as goesBy, current_timestamp() as outTime, 0 as minutes union select 'Butthead' as goesBy, current_timestamp() as outTime, 3 as minutes";



//////////////////////////////////////////////////////////////////////////////////////////////////
//out.println(sql);
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
 if(resultSet.next()){
	 if( isMinimized == 0){
 %>
  <div class = "listLabel bold">Student(s) Out</div>
 <% 
	 }
	 else {
		 %>
		  <span class = "listLabel bold">Student(s) Out</span> <% 
			 }
 do {
	 String numClass = "name";
	 if(resultSet.getInt("minutes")>10){
		 numClass = "studentRed";
	 }
	 %>
   <span class="name <%=numClass%>"><%=resultSet.getString("displayName")%> (<%=resultSet.getString("minutes")%>)</span><br>
<% }while(resultSet.next());
  
 }
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%>
