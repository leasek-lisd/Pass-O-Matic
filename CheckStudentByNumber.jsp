<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ include file="includes/basicDBinfo.jsp" %> 
<html>
<head>
  <title>Seating Chart</title>
</head>
<meta http-equiv="refresh" content="10">
<script>


function getDeployments() {

 //   var xmlhttp = new XMLHttpRequest();
 //   xmlhttp.onreadystatechange = function() {
 //     if (this.readyState == 4 && this.status == 200) {
 //       document.getElementById("deployList").innerHTML = this.responseText;
 //     }
 //   };
 //   xmlhttp.open("GET","http://studentxampp.lisd.local/passomatic/lastDeployments.php",true);
 //   xmlhttp.send();
}

function getStatusImage() {

  var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("imgStatus").innerHTML = this.responseText;
      }
    };
//    xmlhttp.open("GET","http://studentxampp.lisd.local/passomatic/getstatus.php",true);
//    xmlhttp.send();
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
 getDeployments()
 getStudentLine()
 getStudentsOut()
 getStatusImage();
 setInterval(function(){
	getDeployments()
        getStudentLine()
	getStudentsOut()
	getStatusImage() // this will run after every 5 seconds
  }, 2500);
</script>
<style> 
th, td {
  padding: 15px;
}
</style>
<body>

<a href="http://studentxampp.lisd.local:8080/candles/setStudentID.jsp?studentID=<%=request.getParameter("StuID")%>">FOREX Sim</a>

 <%
  LocalDate localDate = LocalDate.now();

        DayOfWeek dayOfWeek
            = DayOfWeek.from(localDate);

if(dayOfWeek.getValue() == 3){%>

<a href="https://docs.google.com/forms/d/e/1FAIpQLSe808JM1NNiYtdDmujlKLv6EJiiJfQahvJouivtbdHXqRUxIQ/viewform" >Click Here To Sign In For UIL Computer Club (Must be present)</a>
<%}%>
<table>
<tr>

<td>
<%

////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sql = "call CheckStudentByIDNumber ("+request.getParameter("StuID")+");";
 out.println(sql+"<br>");
//////////////////////////////////////////////////////////////////////////////////////////////////

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
int height = 50;
int width = 100;

boolean canUseEmergency = true;
boolean canGetInLine = true;
boolean canPrintPass = true;
String reasonMessage = "";

if(resultSet.next()){

// out.print("colcount: "+resultSet.getMetaData().getColumnCount()+"!!");
if(true||(resultSet.getInt("ClassID")==2)||(resultSet.getInt("ClassID")==3)){%>

<a href="<%=resultSet.getString("classURL")%>"><h6><%=resultSet.getString("classURLlabel")%></h6></a>
<%}%>
Hello <%=resultSet.getString("StudentName")%>,<br><br>
<%
// out.println("is out: " + resultSet.getInt("@isOut"));

if (resultSet.getInt("@isOut") >= 1) {

String studentID = resultSet.getString("StudentID");
connection.close();

response.sendRedirect("passprinted.jsp?StuID="+studentID);


}
else {

 //   LocalDateTime startClass = LocalDateTime.parse(resultSet.getString("starttime"));
 //   LocalDateTime endClass = LocalDateTime.parse(resultSet.getString("endttime"));

    
//    DateTime startClass = new DateTime(time);
//    DateTime endClass = new DateTime(time + 120_000); // add 2 minutes for example
//    Minutes minutes = Minutes.minutesBetween(startClass, endClass);
//    out.println(startClass); 


if(resultSet.getInt("classStatus") == 0){
  reasonMessage += "Your teacher has disabled passes for the class<br>";
   canUseEmergency = false;
   canGetInLine = false;
   canPrintPass = false;
}

if(resultSet.getInt("passblock") == 1){
  reasonMessage += "Your self service pass privledges have been disabled<br>";
   canUseEmergency = false;
   canGetInLine = false;
   canPrintPass = false;
}

if(resultSet.getInt("minutesLeft") < 15){
  reasonMessage += "There are only "+resultSet.getInt("minutesLeft")+" minutes left in class<br>";
   canUseEmergency = false;
   canGetInLine = false;
   canPrintPass = false;
}

if(resultSet.getInt("minutesIn") < 15){
  reasonMessage += "Passes not available until 15 minutes into class<br>";
   canPrintPass = false;
}



if(resultSet.getInt("@passestoday") > 0){
  reasonMessage += "You have already used a pass<br>";
   canPrintPass = false;
   canGetInLine = false;
}
// out.println(resultSet.getInt("@nextinline"));
if( (resultSet.getInt("@numinline") > 0)&& ( resultSet.getInt("@nextinline") != resultSet.getInt("StudentID") ) ){
  reasonMessage += "There are others in line<br>";
   canPrintPass = false;
}

if(resultSet.getInt("@inLine") > 0){
  reasonMessage += "You are already in line<br>";
   canGetInLine = false;
}

if(resultSet.getInt("@StudentsOut") > 0){
  reasonMessage += "Other student is out<br>";
   canPrintPass = false;
}

if(resultSet.getInt("@passesleft") <= 0){
  reasonMessage += "You are out of Emergency Passes<br>";
   canUseEmergency = false;
 //  canPrintPass = false;
}

}

if((reasonMessage.length()>0)&&(!canPrintPass)){
out.println("Self Service Pass Not Available:<br>");
out.println(reasonMessage);}
else {}
// out.println("<br>can print pass: "+canPrintPass);
// out.println("<br>can go in line "+canGetInLine);
// out.println("<br>can use emergency: "+canUseEmergency);

if(canPrintPass){ 
out.println("Self Service pass available.  Click below to print");%>
<br><a href="CreateStudentPass.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>"><img src="img/RRE.jpg"></a>
<%}

if(canGetInLine&&!canPrintPass){ %>
<br>You can get in line:"
<br><a href="GetInLine.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>"><img src="img/line.png"></a>
<%}

if(canUseEmergency&&!canPrintPass){ 
out.println("<br>But you can use an Emergency Pass, you have "+resultSet.getInt("@passesleft")+" passes left<br>Click below to print");%>
<br><a href="CreateStudentPass.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=ER&Enroll=<%=resultSet.getInt("enrollid")%>"><img src="img/Emergency.png"></a>
<%}


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
</td><td> <div id="txtStudentsOut">Connection Error</div> </td>
<td> <div id="txtStudentLine">Connection Error</div> </td></tr>
</table>
</body>
</html>