<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%String pageTitle = "All Open Passes"; %>
<%@ include file="includes/navbar.jsp" %> 
<%@ include file="includes/basicDBinfo.jsp" %> 
<%
boolean isCurrentPeriod;
int curPeriod = 0;
int curTeacher = 0;
int secsLeft = 0;
int busLeft = 90*60;
String announcements = "";
String sql = "call getTeacherData ("+session.getAttribute("teacherID")+",1);";
out.println("<!--" + sql+" -->");
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
	 
	int nextX;
	int foundCurrent = 0;
	 if(resultSet.next()){
		 curPeriod = resultSet.getInt("curPeriod");
		 curTeacher = resultSet.getInt("curTeacher");

 %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
 
  border-radius: 5px;
    position: absolute;
  top: 175px;
}

.other {
width: 150px;
}

.now {
width: 250px;

}

.first {
  left:10px;
  }
  
.second {
  left:10px;
  }
  
  .third {
  left:10px;
  }
  
  .fourth {
  left:10px;
  }
  

  
.bigDiv {
  width: 1500px;
  height: 800px;
  overflow: hidden;
  }

.currentPeriod {
font-size: 1.75em;
}

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

img {
  border-radius: 5px 5px 0 0;
}

.container {
  padding: 2px 16px;

}

.timeDateHeader {
  font-size: 2em;
  font-weight: heavy;
}

.classInfo {
  font-size: .5em;
  }
.classTitle {
  font-size: .75em;
  font-weight: bold;
  line-height: 2.5ex;
height: 5ex;
}

.otherList {
  font-size: .75em;
  }
ul { padding-left: 1.2em; }

.passBlob {
  position:relative;
  left:-50px;
  width: 500px;
  height: 200px;
  background-color: lightgrey;
  border-radius: 5px;
  padding: 5px;
}

/* Popup container - can be anything you want */
.passInfo {
  position: relative;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* The actual popup */
.passInfo .passPopup {
  visibility: hidden;
  position:relative;
  left:-50px;
  width: 500px;
  height: 200px;
  background-color: lightgrey;
  border-radius: 5px;
  padding: 5px;
  text-align: center;
  
  z-index: 1;
  

}

/* Popup arrow */
.passInfo .passPopup::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.passInfo .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;}
}


</style>
</head>

<body>

<div class = "timeDateHeader" id="time"></div>
<a href="getAllMyStudentsOut.jsp">View all open passes</a>

<div class="card <%
if(resultSet.getInt("currentClass")== 1){
	out.print("now");
	secsLeft = resultSet.getInt("secondsLeft");
	busLeft = resultSet.getInt("secondsToBus");
	nextX = 270;
	foundCurrent = 0;}
	else {
	nextX = 175;
	out.print("other");}%> first">

  <img src="img/<%= resultSet.getString("classImage")%>" alt="Avatar" style="width:100%">
  <div class="container">
    <div  class = "classTitle"><%=resultSet.getString("Title") %></div>
    <span class = "classInfo"><%=resultSet.getString("teacherName") %><br><%=resultSet.getString("room") %> | <%=resultSet.getString("starttime") %> - <%=resultSet.getString("endtime") %></span> 
    <br><span class = "classInfo"><a href="classSetup.jsp?periodNum=<%=resultSet.getString("periodNum") %>&teacherID=<%=session.getAttribute("teacherID")%>">(edit Class Details)</a></span>
   <hr>
      <span class = "classInfo"><a href="classAnnouncements.jsp?classID=<%=resultSet.getString("classID") %>">Edit Announcements</a></span><br>
     
    <%
    announcements = resultSet.getString("announcements");
    if(announcements.length()>0){
    %>
    <span><b>Announcements:</b></span>
      <%=announcements %><%} %>
   </div><%
  if(curPeriod == 1){%>
    
    <div class="container first" id="txtStudentsOut">Loading....</div>
    <div class="container first" id="txtLine">Loading....</div>
  <%}%>
  </div>
  <% resultSet.next(); %>
  <style>
  .second {
  left:<%=nextX+foundCurrent%>px;
  }</style>
<div class="card <%
    isCurrentPeriod = false;
if(resultSet.getInt("currentClass")== 1){
	out.print("now");
	secsLeft = resultSet.getInt("secondsLeft");
	busLeft = resultSet.getInt("secondsToBus");
	nextX += 250;
	foundCurrent = 0;
	isCurrentPeriod = true;}
	else {
	nextX += 175;
	out.print("other");}%> second">

  <img src="img/<%=resultSet.getString("classImage")%>" alt="Avatar" style="width:100%">
  <div class="container">
    <div  class = "classTitle"><%=resultSet.getString("Title") %></div>
    <span class = "classInfo"><%=resultSet.getString("teacherName") %><br><%=resultSet.getString("room") %> | <%=resultSet.getString("starttime") %> - <%=resultSet.getString("endtime") %></span> 
    <br><span class = "classInfo"><a href="classSetup.jsp?periodNum=<%=resultSet.getString("periodNum") %>&teacherID=<%=session.getAttribute("teacherID")%>">(edit Class Details)</a></span>
   <hr>
      <span class = "classInfo"><a href="classAnnouncements.jsp?classID=<%=resultSet.getString("classID") %>">Edit Announcements</a></span><br>
     
    <%
    announcements = resultSet.getString("announcements");

    if(announcements.length()>0){
    %>
    <span><b>Announcements:</b></span>
      <%=announcements %><%} %>
    </div><%
  if(curPeriod == 2){%>
   
    <div class="container second" id="txtStudentsOut">Loading....</div>
    <div class="container second" id="txtLine">Loading....</div>
  <%}%>
  </div>
  
    <% resultSet.next(); %>
  <style>
  .third {
  
  left:<%=nextX+foundCurrent%>px;
  }</style>
<div class="card <%
if(resultSet.getInt("currentClass")== 1){
	out.print("now");
	secsLeft = resultSet.getInt("secondsLeft");
	busLeft = resultSet.getInt("secondsToBus");
	nextX += 250;
	foundCurrent = 100;}
	else {
	nextX += 175;
	out.print("other");}%> third">

  <img src="img/<%=resultSet.getString("classImage")%>" alt="Avatar" style="width:100%">
  <div class="container">
    <div  class = "classTitle"><%=resultSet.getString("Title") %></div>
    <span class = "classInfo"><%=resultSet.getString("teacherName") %><br><%=resultSet.getString("room") %> | <%=resultSet.getString("starttime") %> - <%=resultSet.getString("endtime") %></span> 
    <br><span class = "classInfo"><a href="classSetup.jsp?periodNum=<%=resultSet.getString("periodNum") %>&teacherID=<%=session.getAttribute("teacherID")%>">(edit Class Details)</a></span>
   <hr>   <span class = "classInfo"><a href="classAnnouncements.jsp?classID=<%=resultSet.getString("classID") %>">Edit Announcements</a></span><br>
     
     <%
     
    announcements = resultSet.getString("announcements");
    if(announcements.length()>0){
    %>
    <span><b>Announcements:</b></span>
      <%=announcements %><%} %>
   </div><%
  if(curPeriod == 3){%>
    
    <div class="container third" id="txtStudentsOut">Loading....</div>
    <div class="container third" id="txtLine">Loading....</div>
  <%}%>
  </div>
    <% resultSet.next(); %>
  <style>
  .fourth {
  
  left:<%=nextX+foundCurrent%>px;
  }</style>
<div class="card <%
if(resultSet.getInt("currentClass")== 1){
	out.print("now");
	secsLeft = resultSet.getInt("secondsLeft");
	busLeft = resultSet.getInt("secondsToBus");
	nextX += 250;
	foundCurrent = 175;}
	else {
	nextX += 150;
	out.print("other");}%> fourth">

  <img src="img/<%=resultSet.getString("classImage")%>" alt="Avatar" style="width:100%">
  <div class="container">
    <div  class = "classTitle"><%=resultSet.getString("Title") %></div>
    <span class = "classInfo"><%=resultSet.getString("teacherName") %><br><%=resultSet.getString("room") %> | <%=resultSet.getString("starttime") %> - <%=resultSet.getString("endtime") %></span> 
    <br><span class = "classInfo"><a href="classSetup.jsp?periodNum=<%=resultSet.getString("periodNum") %>&teacherID=<%=session.getAttribute("teacherID")%>">(edit Class Details)</a></span>
   <hr>
   <span class = "classInfo"><a href="classAnnouncements.jsp?classID=<%=resultSet.getString("classID") %>">Edit Announcements</a></span><br>
     <%
    announcements = resultSet.getString("announcements");
    if(announcements.length()>0){
    %>
    <span><b>Announcements:</b></span>
      <%=announcements %><%} %>
   </div><%
  if(curPeriod == 4){%>
   
    <div class="container fourth" id="txtStudentsOut">Loading....</div>
    <div class="container fourth" id="txtLine">Loading....</div>
  <%}%>
  </div>

  
<script>
// When the user clicks on div, open the popup
function myFunction() {
  var popup = document.getElementById("passDiv");
  popup.classList.toggle("show");
}
</script>


<script>
function getStudentsOut() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtStudentsOut").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getStudentsOut.jsp?teacherID=<%=resultSet.getInt("curTeacher")%>&period=<%=resultSet.getInt("curPeriod")%>",true);
    xmlhttp3.send();
}



function getLine() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtLine").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getLine.jsp?classID=<%=request.getParameter("classID")%>",true);
    xmlhttp3.send();
}

function displayDateTime(){
	// get a new date (locale machine date time)
	var date = new Date();
	// get the date as a string
	var n = date.toDateString();
	// get the time as a string
	var time = date.toLocaleTimeString();

	// find the html element with the id of time
	// set the innerHTML of that element to the date a space the time
	document.getElementById('time').innerHTML = n + ' ' + time; 
}

function wheels(){
	var audio = new Audio('sounds/WheelsOnTheBus.wav')
	console.log("Playing wav");
	audio.play();
}

getStudentsOut();

displayDateTime();

setInterval(function(){displayDateTime();},1000);

setInterval(function(){getStudentsOut()}, 2500);
// setup refresh
<% 
  int refreshAt=300000; 
  
  if(secsLeft == 0){
    refreshAt = 60000;
  }
  else if (secsLeft <= 300) {
	refreshAt = secsLeft*1100;
  }
%>

setTimeout(()=> {location.reload()},<%=refreshAt%>)


<%
int busAt=busLeft*1000;

if(secsLeft < 300){
	busAt = 1000000000;}
%>


setTimeout(()=> {wheels();},<%=busAt%>);

</script>
<%

}// if result next


 connection.close();
} // try 

catch (Exception e) {
out.println("oops");
e.printStackTrace();
out.println(e.toString());
connection.close();
}



%>
</body>
</html> 
