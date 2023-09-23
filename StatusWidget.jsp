<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%
String sql = "call PassHome ()";


%>
<html lang="en" >

<head>

  <meta charset="UTF-8">
  <meta http-equiv="refresh" content="300">
  <title>Homepage - E205</title>

<style>
.imgBox {
border: 1px solid;
  width: 30%;
}
.hpLists {
  width: 30%;
tr, td{
border: 1px solid;
  
}

h1 {
  color:black;
  font-size: 38px;
}
h2 {
  font-size: 32px;
}
h3 {
  font-size: 18px;
}
h6 {
  font-size: 16px;
}
* {
  box-sizing: border-box;
}
table.center {
  width: 100%;
  border: 1px solid;
  margin-left: auto;
  margin-right: auto;

}



body {
  padding-bottom: 5rem;
}

h1, h2, p {
  padding: 0 5%;
}
</style>





<script>
  window.console = window.console || function(t) {};
</script>

  
  
  <script>
function getStatusImage() {

  var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("imgStatus").innerHTML = this.responseText;
      }
    };
    xmlhttp.open("GET","GetStatus.jsp",true);
    xmlhttp.send();
}
function getStudentsOut() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtStudentsOut").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getStudentsOut.jsp",true);
    xmlhttp3.send();
}
function getStudentLine() {

    var xmlhttp4 = new XMLHttpRequest();
    xmlhttp4.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtStudentLine").innerHTML = this.responseText;
      }
    };
    xmlhttp4.open("GET","getLine.jsp",true);
    xmlhttp4.send();
}

getStudentLine()
getStudentsOut()
getStatusImage();
setInterval(function(){
	
        getStudentLine()
	getStudentsOut()
	getStatusImage() // this will run after every 5 seconds
  }, 2500);
  if (document.location.search.match(/type=embed/gi)) {
    window.parent.postMessage("resize", "*");
  }
</script>
</head>


<br><br>



 

</p>


<table class="center" border=0>
<tr><td id= "timer" colspan = "3" style="text-align: center;">hello timer<p id="timer"></td></tr>
<tr><td id="imgRotator" class = "imgBox"><img width = 300" src = "img/notGetPaid.jpg"></td>
<td id="statusImg"><div id="imgStatus">imgStatusImg</div></td>
<td class = "hpLists" id="hpLists">
  <div id="txtStudentsOut">Connection Error</div> 
  <div id="txtStudentLine">Connection Error</div> 
</td></tr>




</table>














<%

String bellTime = "";
String busTime = "" ;
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

// resultSet.getInt("");
// resultSet.getString("fileURL")

// int i = statement.executeQuery(sql);

// out.println(i);
if(resultSet.next()) {
  bellTime = resultSet.getString("BellTime");
  busTime = resultSet.getString("BusTime");
}
connection.close();

} catch (Exception e) {
out.println(e.toString());
}



%>
<script>
// Set the date we're counting down to
var countDownDate = new Date("<%=bellTime%>").getTime();

// Update the count down every 1 second
var x = setInterval(function() {
var bt = 0;
  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000)+1;

  // Display the result in the element with id="demo"
  document.getElementById("timer").innerHTML = "<h1 style=\"text-align: center;\">"+hours + "h "
  + minutes + "m " + seconds + "s "+"</h1>";

document.getElementById("icon").innerHTML = "aaa";

  // If the count down is finished, write some text
 // if (distance > 0 && bt==0 ) {
 if (minutes == 14) {
  //  clearInterval(x);
    
//    document.getElementById("icon").innerHTML = bt+" <audio  autoplay=\"autoplay\"><source src=\"Sounds/Sonar_Shot.wav\" type=\"audio/wav\"></audio>";
 // document.getElementById("icon").innerHTML = " <br><img src=\"img/bus.png\" alt=\"Bus Time\">";
  window.location.replace("pht2.php");  
 // controls= \"controls\"
//    bt++;
  }
}, 1000);
</script>