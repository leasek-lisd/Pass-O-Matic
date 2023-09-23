<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%
// int mode = 


int isMinimized = 0;
if( request.getParameter("isMinimized") != null && request.getParameter("isMinimized").equals("yes") ){
	  isMinimized = 1;
}
String sql = "call getLine("+request.getParameter("classID")+","+ isMinimized+");";


//////////////////////////////////////////////////////////////////////////////////////////////////
// out.println(sql);
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
// resultSet.getInt("");
// resultSet.getString("fileURL")
if(resultSet.next()) {  

	 if( isMinimized == 0){
 %>
  <div class = "listLabel bold">In Line</div>
 <% 
	 }
	 else {
		 %>
		  <span class = "listLabel bold">In Line</span> <% 
			 }


  


int i=1;
do { %>
<span class="name"><%=i%>. <%=resultSet.getString("studentName")%></span><br>
<% i++;}while(resultSet.next());
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
</div>