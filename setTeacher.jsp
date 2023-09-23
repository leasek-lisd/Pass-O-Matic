<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Seating Chart"; %>
<%@ include file="includes/navbar.jsp" %> 
<%@ include file="includes/basicDBinfo.jsp" %> 


<%

session.setAttribute("teacherID",request.getParameter("teacherID"));
session.setAttribute("lastRoom", null);
session.setAttribute("lastPeriod", null);
String sql = "call getTeacherList();";

//out.print(session.getAttribute("teacherID"));


//////////////////////////////////////////////////////////////////////////////////////////////////
//out.println(sql);
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
// resultSet.getInt("");
// resultSet.getString("fileURL")%> 
<table> <%
while(resultSet.next()) {  
	if(request.getParameter("teacherID")!=null && request.getParameter("teacherID").equals(resultSet.getString("teacherID"))){
		session.setAttribute("lastRoom",resultSet.getString("homeRoom"));
	//	out.print("X"+ (String)session.getAttribute("lastRoom") +"X");
	}
	
	%>
	<tr><td><a href="setTeacher.jsp?teacherID=<%=resultSet.getString("teacherID") %>&homeRoom=<%=resultSet.getString("homeRoom")%>"><%=resultSet.getString("teacherName") %></a></td><td>Room: <%=resultSet.getString("homeRoom") %> <%=resultSet.getString("teacherClasses") %></td></tr> <%
	
	
  
	/*
	if(resultSet.getInt("periodNum") == 1){
    session.setAttribute("firstPeriodClassID",resultSet.getInt("classID"));
    session.setAttribute("firstPeriodClassRoom",resultSet.getString("classRoom"));
    session.setAttribute("firstPeriodClassTitle",resultSet.getString("title"));
  }
  else if(resultSet.getInt("periodNum") == 2){
	    session.setAttribute("secondPeriodClassID",resultSet.getInt("classID"));
	    session.setAttribute("secondPeriodClassRoom",resultSet.getString("classRoom"));
	    session.setAttribute("secondPeriodClassTitle",resultSet.getString("title"));
  }
  else if(resultSet.getInt("periodNum") == 3){
	    session.setAttribute("thirdPeriodClassID",resultSet.getInt("classID"));
	    session.setAttribute("thirdPeriodClassRoom",resultSet.getString("classRoom"));
	    session.setAttribute("thirdPeriodClassTitle",resultSet.getString("title"));
}
  else if(resultSet.getInt("periodNum") == 4){
	    session.setAttribute("fourthPeriodClassID",resultSet.getInt("classID"));
	    session.setAttribute("fourthPeriodClassRoom",resultSet.getString("classRoom"));
	    session.setAttribute("fourthPeriodClassTitle",resultSet.getString("title"));
}*/
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
