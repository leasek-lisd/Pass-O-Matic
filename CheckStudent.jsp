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

<style>
.button {

   
   text-decoration: none;
     border-radius: 10px;
  padding: 10px;
}

.green {
   border: 1px solid green;
   background-color: green;
}

.red {
   border: 1px solid red;
   background-color: red;
}

.blue {
   border: 1px solid darkblue;
   background-color: darkblue;
}

   	a.text-link{
        color: white;  /* Inherit color from parent */
        text-decoration: none; /* Removes underline */
       
        font-size: 25px;
        line-height: 25px;
        
    }
</style>
<script>




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
    xmlhttp3.open("GET","getStudentsOut.jsp?",true);
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
String sqlStatus = "call CheckStudentByIDNumber ("+request.getParameter("StuID")+");";
out.println(sqlStatus+"<br>");
//////////////////////////////////////////////////////////////////////////////////////////////////
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
int height = 50;
int width = 100;

boolean canUseEmergency = true;
boolean canGetInLine = true;
boolean canPrintPass = true;
String reasonMessage = "";

if(resultSet.next()){

// out.print("colcount: "+resultSet.getMetaData().getColumnCount()+"!!");
if(true||(resultSet.getInt("ClassID")==2)||(resultSet.getInt("ClassID")==3)){%>

<%}%>
Hello <%=resultSet.getString("StudentName")%>,<br><br>
<%
// out.println("is out: " + resultSet.getInt("@isOut"));

if (resultSet.getInt("@isOut") >= 1) {

String studentID = resultSet.getString("StudentID");
connection.close();
out.print("Check In Button");
// response.sendRedirect("passprinted.jsp?StuID="+studentID);


}
else {


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

if(canPrintPass){ %>
<div class="green button">
<a class="text-link" href="CreateStudentPass.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>"> Click for Self Service Pass</a>
</div>
<%}

if(canGetInLine&&!canPrintPass){ %>
<div class="blue button">
<a href="GetInLine.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>">Get In Line</a>
</div>
<div id="txtStudentsOut">Connection Error</div>
<%}
{ %>
<br>You can get in line:"
<br><a href="GetInLine.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>"><img src="img/line.png"></a>
<div id="txtStudentsOut">Connection Error</div>
<%}

if(canUseEmergency&&!canPrintPass){ %>
<div class="red button">
<a class="text-link" href="CreateStudentPass.jsp?StuID=<%=resultSet.getInt("StudentID")%>&PassType=ER&Enroll=<%=resultSet.getInt("enrollid")%>"> Click for Emergency Pass</a>
</div>
<div id="txtStudentsOut">Connection Error</div>
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
</td><td>  </td>
<td> <div id="txtStudentLine">Connection Error</div> </td></tr>
</table>
</body>
</html>