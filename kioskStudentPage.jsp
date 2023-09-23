<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ include file="includes/basicDBinfo.jsp" %> 
<%
boolean isCurrentPeriod;
int curPeriod = 0;
int curTeacher = 0;
int curClassID= 0;
int secsLeft = 60;

String sql = "call GetStudentData ("+request.getParameter("stuID")+");";
// out.println(sql+"<br>");
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
		 curClassID = resultSet.getInt("curClassID");

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
  top: 100px;
}

.other {
width: 150px;
}

.now {
width: 250px;

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
  font-size: 1em;
  font-weight: bold;
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

<h1><%= resultSet.getString("firstName")%> <%=resultSet.getString("lastName")%></h1>

    <div class="container first" id="txtButtons">Loading....</div>
    <div class="container first" id="txtStudentsOut">Loading....</div>
    <div class="container first" id="txtLine">Loading....</div>




  
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
    xmlhttp3.open("GET","getStudentsOut.jsp?teacherID=<%=curTeacher%>&period=<%=curPeriod%>",true);
    xmlhttp3.send();
}

function getButtons() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtButtons").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","CheckStudent2.jsp?src=kiosk&StuID=<%=request.getParameter("stuID")%>",true);
    xmlhttp3.send();
}

function getLine() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtLine").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getLine.jsp?classID=<%=curClassID%>",true);
    xmlhttp3.send();
}



getStudentsOut();
getButtons();
getLine();



		
	
setInterval(function(){
	getStudentsOut()
	getButtons()
	getLine()
}, 2500);
<% 
int refreshAt=60000;


%>
setInterval(function(){
<%
String url = "kioskClassPage.jsp";
%>
window.location.href ="<%=url%>";
},<%=refreshAt%>)
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
