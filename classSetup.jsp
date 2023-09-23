<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Update/Add Student"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<style>
table {
width: 300px;
}

.labelCell {
  text-align: left;
  width: 125px;
}

.switch {
  position: relative;
  display: inline-block;
  width: 45px;
  height: 20px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 12px;
  width: 12px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(21px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 24px;
}

.slider.round:before {
  border-radius: 50%;
  }
.periodTitle {
  font-size: 1.25em;
  font-weight: bold;
}
.smallTitle {
  font-size: .5em;
  font-weight: bold;
}

.boldRed {
font-weight: bold;
color: red;
}
</style>
<%

String useClassID = "0";
if(request.getParameter("classID")!= null){
	useClassID = request.getParameter("classID");
}


String classID = "";
String periodNum = "";
String title = "";
String teacherID = "";
String roomID = "";
String classImage = "";

int numClasses = 0;
boolean busAlert;
boolean printPasses;
boolean selfServicePasses;
boolean ePasses;
boolean displayLinks;
boolean displayAnnouncements;
int termLimit = 0;
int ePassLimit = 0;

String sql = "call getClassSetUpInfo ("+request.getParameter("teacherID")+","+request.getParameter("periodNum")+","+useClassID+");";
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
 

 
 if(resultSet.next()){
	 
	 classID = resultSet.getString("classID");
	 periodNum = resultSet.getString("periodNum");
	 title = resultSet.getString("title");
	 teacherID = resultSet.getString("teacherID");
	 roomID = resultSet.getString("roomID");
	 classImage = resultSet.getString("classImage");

	 numClasses = resultSet.getInt("numClasses");
	 busAlert = resultSet.getBoolean("busAlert");
	 printPasses = resultSet.getBoolean("printPasses");
	 selfServicePasses = resultSet.getBoolean("selfServicePasses");
	 ePasses = resultSet.getBoolean("ePasses");
	 displayLinks = resultSet.getBoolean("displayLinks");
	 displayAnnouncements = resultSet.getBoolean("displayAnnouncements");
	 termLimit = resultSet.getInt("termLimit");
	 ePassLimit = resultSet.getInt("ePassLimit");
			 
			



  boolean classSelected = true;
  String useClass = "0";
  if( request.getParameter("classID") != null) {
	  useClass = request.getParameter("classID");
	  session.setAttribute("lastClass", request.getParameter("classID"));
	  classSelected = true;
  }

  else if( session.getAttribute("lastClass") != null) {
	  useClass = (String)session.getAttribute("lastClass");
	  classSelected = true;
  } 

%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.periodTitle{
font-size: 1.25em;
font-weight: bold:
}


</style>
<body>

<div class="periodTitle">Period: <%=periodNum %></div><%
// out.print(numClasses);
// if(numClasses > 1){
%>
Class:<br><form>
     <input type="hidden" name="periodNum" value="<%=request.getParameter("periodNum")%>" >
     <input type="hidden" name="teacherID" value="<%=request.getParameter("teacherID")%>" >
	 <input type="hidden" name="mode" value="1" > <%do{ %>
	 <input onchange="this.form.submit();" type="radio" id="classID<%=resultSet.getString("classID")%>" name="classID" value="<%=resultSet.getString("classID")%>" <%=(useClass.equals(resultSet.getString("classID")) ? "checked":"")%>>
  <label for="classID"><%=resultSet.getString("title")%></label><br>
<% }while(resultSet.next()); %>

</form> 
<%//}else 
	
	if( !useClassID.equals("0")){ %>



<form action="updateClass.jsp">
<br>
<table>
<input type="hidden" name="useClassID" value="<%=useClassID%>">

<tr><th class="labelCell">Title</th><td><input type="text" id="classTitle" name="classTitle" value="<%= title %>" maxlength="100" size="15"></td></tr>
<tr><th class="labelCell">Term Pass Limit</th><td><input type="text" id="termLimit" name="termLimit" value="<%=termLimit%>" size="5"></td></tr>
<tr><th class="labelCell">Emergency Pass Limit</th><td><input type="text" id="ePassLimit" name="ePassLimit" value="<%=ePassLimit%>" size="5"></td></tr>
<tr><td colspan="2" class="boldRed">Note: The total number of passes a student will be allowed to use is SUM of the Term Pass Limit and Emergency Pass Limit</td></tr>
<tr><td colspan="2"><input type="submit" value="Submit Changes"></td></tr>
<tr><td colspan="2"></td></tr>

</table>

<h2>Class Controls</h2>

<table>
<tr><td>Self Service Passes</td><td colspan="2">
<label class="switch">
  <input id="selfService" name = "selfService" type="checkbox" onchange = "processClick(<%out.print("'selfService'"); %>)" <%= (selfServicePasses ? "Checked":"")%>>
  <span class="slider round"></span>

</td></tr>
<tr><td>Emergency Passes</td><td colspan="2">
<label class="switch">
  <input id="emergency" name = "emergency" type="checkbox" onchange = "processClick(<%out.print("'emergency'"); %>)" <%= (ePasses ? "Checked":"")%>>
  <span class="slider round"></span>

</td></tr>

<tr><td>Display Announcements</td><td colspan="2">
<label class="switch">
  <input id="announcements" name = "announcements" type="checkbox" onchange = "processClick(<%out.print("'announcements'"); %>)" <%= (displayAnnouncements ? "Checked":"")%>>
  <span class="slider round"></span>

</td></tr>



<tr><td>Bus Alert</td><td>

<label class="switch">
  <input id="busAlert" name = "busAlert" type="checkbox" onchange = "processClick('busAlert')" <%= (busAlert ? "Checked":"")%>>
  <span class="slider round"></span><br>
  <div id="txtStudentsOut"></div>
</label></td></tr>
</table>



<script>
function processClick(switchID) {
    let checkbox = document.getElementById(switchID);
    console.log(switchID + ": "+checkbox.checked);
    
    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
       // document.getElementById("txtStudentsOut").innerHTML = 
        	console.log(this.responseText);
      }
    };
    var useURL = "updateClassSettings.jsp?setting="+switchID+"&value="+checkbox.checked+"&classID="+<%=classID%>
    console.log(useURL);
    xmlhttp3.open("GET",useURL,true);
    xmlhttp3.send();    
    
    
}
</script>

</form><%
session.setAttribute("lastClass", null);
 } 
 
 connection.close();
 }}  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}
session.setAttribute("lastClass", null);
  %>
</body>
</html>