<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>

<%@ include file="includes/basicDBinfo.jsp" %> 

<link rel="stylesheet" href="css/largeStatus.css">

<%
boolean isCurrentPeriod;
int curPeriod = 0;
int curTeacher = 0;
int secsLeft = 0;
int busLeft = 90*60;
String nextBellTime = null;
String tomorrow = null;

int curClassID= 0;
String announcements = "";
String sql = "call getTeacherData ("+session.getAttribute("teacherID")+",1);";
out.println("<!--" + sql+" -->");
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
	 
	int nextX;
	int foundCurrent = 0;
	 if(resultSet.next()){
		 curPeriod = resultSet.getInt("curPeriod");
		 curTeacher = resultSet.getInt("curTeacher"); %>

<body>
<div class="countDownContainer">Next Bell:<br>
  <div class = "timeDateHeader" id="time">Loading...</div>

</div>

<%
  do{ out.println("<!-- loop -->");
    tomorrow = resultSet.getString("tomorrow");
    if(resultSet.getInt("currentClass")== 1){
	  secsLeft = resultSet.getInt("secondsLeft");
	  busLeft = resultSet.getInt("secondsToBus");
	  curClassID = resultSet.getInt("curClassID");
	  nextBellTime = resultSet.getString("nextBellTime");
	  secsLeft =  resultSet.getInt("secondsLeft");%>
	  

    <div class="card now first"> 
	  <img src="img/<%=resultSet.getString("classImage") %>" alt="Avatar" style="width:100%">
	  
	    <div class="container">
    <div  class = "classTitle"><%=resultSet.getString("Title") %></div>
    <span class = "classInfo"><%=resultSet.getString("teacherName") %><br><%=resultSet.getString("room") %> | <%=resultSet.getString("starttime") %> - <%=resultSet.getString("endtime") %></span> 
  <hr>
    <%
    announcements = resultSet.getString("announcements");
    if(announcements.length()>0){
    %>
    <span class = "classTitle">Announcements:</span>
      <span class = "classInfo"><%=announcements %></span><%} %>
  
  </div>
	  

    </div>
    
    <div class="passDiv" id="txtStudentsOut">Waiting For</div>
    <div class="lineDiv" id="txtLine">Class to Start</div>
    <div id="imgStatus"></div>
 </body> 
 <script type="text/javascript" src="js/getStudentsOut.js"></script>
 <script type="text/javascript" src="js/getLine.js"></script>
 <script type="text/javascript" src="js/updateData.js"></script>
 <script type="text/javascript" src="js/wheelsOnTheBus.js"></script>

  
  <script>
  <% if(curPeriod !=0){ %>
  getStudentsOut(<%=curTeacher%>,<%=curPeriod%>);
  getLine(<%=curClassID%>);
  updateData(<%=session.getAttribute("lastRoom")%>);
  
  setInterval(function(){
	  getStudentsOut(<%=curTeacher%>,<%=curPeriod%>);
	  getLine(<%=curClassID%>);
    updateData(<%=session.getAttribute("lastRoom")%>);
	}, 500);

  <% int refreshAt=300000; %>
  setInterval(function(){location.reload()},<%=refreshAt%>)
   <%}
else {%>
  setInterval(function(){location.reload()},600000);
  console.log("No Current Class");
<%}%>


<%
int busAt=busLeft*1000;

if(secsLeft < 300){
	busAt = 1000000000;}
if(resultSet.getBoolean("busAlert")&&secsLeft>=300&&resultSet.getString("curPeriod")!=null){%>
setTimeout(()=> {wheels();},<%=busAt%>);
<%}%>


</script>
<% }
  }while(resultSet.next() && secsLeft == 0); 

	 }


if(nextBellTime !=null ){ %>
 <script type="text/javascript" src="js/countDown.js"></script>
 <script>
setInterval(function(){updateCountDown("<%=nextBellTime%>")},1000);
 
   </script>
 <%  } 
else { %>
<script type="text/javascript" src="js/countDown.js"></script>
<script>
setInterval(function(){updateCountDown("<%=tomorrow%>")},1000);

  </script>
<%  } 
  resultSet.close();
  statement.close();
 connection.close();


} // try 

catch (Exception e) {
  out.println("oops");
  e.printStackTrace();
  out.println(e.toString());
 
}



%>

</html> 
