<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ include file="includes/basicDBinfoStudent.jsp" %> 
<%

int curPeriod = 0;
int curTeacher = 0;
int curClassID= 0;
int secsLeft = 60;
String nextBellTime = null;

String sql = "call GetStudentData ("+request.getParameter("stuID")+");";
out.println("<!--" + sql+" -->");
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
	int nextX = 0;
	int foundCurrent = 0;
	 if(resultSet.next()){
		 curPeriod = resultSet.getInt("curPeriod");
		 curTeacher = resultSet.getInt("curTeacher");
		 curClassID = resultSet.getInt("curClassID");
		 nextBellTime = resultSet.getString("nextBellTime");
		 secsLeft  = resultSet.getInt("secondsLeft");

 %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/student.css">
</head>

<body>
<div id="overlay" onclick="off()"></div>
<div class = "timeDateHeader" id="time"></div>

<%
String nextClass = "";
do{ 
	switch(resultSet.getInt("periodNum")){
	  case 1:
		  nextClass = "first"; 
		  break;
	  case 2: 
		  nextClass = "second";
		  break;
	  case 3: 
		  nextClass = "third";
		  break;
	  case 4: 
		  nextClass = "fourth";
		  break;
	}
%>
  <style>
  .<%=nextClass%> {
  
  left:<%=nextX+foundCurrent%>px;
  }</style>
<div class="card <%
String announcements = "";


if(resultSet.getInt("currentClass")== 1){
	out.print("now");
	secsLeft = resultSet.getInt("secondsLeft");
	nextX += 270;
	foundCurrent = 0;}
	else {
	nextX += 175;
	out.print("other");}%> <%=nextClass%>">

  <img src="img/<%= resultSet.getString("classImage")%>" alt="Period #<%=resultSet.getInt("periodNum")%>" style="width:100%">
  <div class="container">
    <span class = "classTitle"><%=resultSet.getString("Title") %></span> <br>
    <span class = "classInfo"><%=resultSet.getString("teacherName") %><br><%=resultSet.getString("room") %> | <%=resultSet.getString("starttime") %> - <%=resultSet.getString("endtime") %></span> 
    <hr>
    <span id="announcements<%=resultSet.getInt("periodNum")%>">
    <%
    announcements = resultSet.getString("announcements");
    if(announcements.length()>0){
    %>
    <b>Announcements:</b>
      <%=announcements %><%} %>
      </span>
   </div><%
  if(resultSet.getInt("currentClass") == 1){%>
    <div class="container first" id="txtButtons">Loading....</div>
    <div class="container first" id="txtStudentsOut">Loading....</div>
    <div class="container first" id="txtLine">Loading....</div>
  <%}%>
  </div>

  <%
  } while(resultSet.next());
%>
  


<script type="text/javascript" src="js/buttons.js"></script> 
<script type="text/javascript" src="js/getLine.js"></script> 
<script type="text/javascript" src="js/getStudentsOut.js"></script> 
<script type="text/javascript" src="js/clock.js"></script> 

<%


if(nextBellTime !=null && secsLeft > 0){ %>
  <script type="text/javascript" src="js/countDown.js"></script>
  <script>
 setInterval(function(){updateCountDown("<%=nextBellTime%>")},1000);
  
    </script>
  <% } %>



<script>

<% if(curPeriod !=0){ %>
  getStudentsOut(<%=curTeacher%>,<%=curPeriod%>);
  getButtons(<%=request.getParameter("stuID")%>);
  getLine(<%=curClassID%>);
  
  setInterval(function(){
	  getStudentsOut(<%=curTeacher%>,<%=curPeriod%>);
	  getButtons(<%=request.getParameter("stuID")%>);
	  getLine(<%=curClassID%>);
  },1000);

  <% int refreshAt=300000; %>
  setInterval(function(){location.reload()},<%=refreshAt%>)
   <%}
else {%>
  setInterval(function(){location.reload()},600000);
  console.log("No Current Class");
<%}%>

</script> <%

}// if result next


 connection.close();
} // try 

catch (Exception e) {
  e.printStackTrace();
  out.println(e.toString());
 
}


if(request.getParameter("newPass")!=null){%>
  <script type="text/javascript" src="js/newPassOverlay.js"></script>
<%}%>

</body>
</html> 
