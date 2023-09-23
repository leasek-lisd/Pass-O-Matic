<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ include file="includes/basicDBinfoStudent.jsp" %> 
<html>
<head>
  
</head>

<style>
.button {

   text-align: center;
   text-decoration: none;
     border-radius: 10px;
  padding: 10px;
  width:150px;
}

.green {
   border: 1px solid green;
   background-color: green;
}

.red {
   border: 1px solid black;
   background-color: red;
}

.blue {
   border: 1px solid darkblue;
   background-color: darkblue;
}

.maroon {
   border: 1px solid maroon;
   background-color: maroon;
}

.white {
   border: 1px solid black;
   background-color: white;
}

   	a.text-link{
        color: white;  /* Inherit color from parent */
        text-decoration: none; /* Removes underline */
        text-align: center;
        font-size: 1.5em;
            
    }
       	a.text-link-red{
        color: red;  /* Inherit color from parent */
        text-decoration: none; /* Removes underline */
        text-align: center;
        font-size: 1.5em;
            
    }
    .passTitle{
      text-align: center;
      font-size: 1.2em;
      
    }
    .passReason{
      font-size: .8em;
      text-align: center;
      font-weight: bold;
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


<%}%>
<table>
<tr>

<td>
<%

////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sqlStatus = "call checkPassEligibility ("+request.getParameter("StuID")+");";
//out.println(sqlStatus+"<br>");
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


resultSet = statement.executeQuery(sqlStatus);
int height = 50;
int width = 100;

boolean canUseEmergency = true;
boolean canGetInLine = true;
boolean canPrintPass = true;
String reasonMessage = "";

if(resultSet.next()){
	
	canGetInLine = resultSet.getBoolean("canGetInLine");
	canPrintPass = resultSet.getBoolean("canPrintPass");
	canUseEmergency = resultSet.getBoolean("canUseEmergency");
	reasonMessage = resultSet.getString("message");
	
//	out.print("<br>Get in Line: "+canGetInLine+"<br>");
//	out.print("<br>Print Pass: "+canPrintPass+"<br>");
//	out.print("<br>Emergency: "+canUseEmergency+"<br>");
//	out.print("<br>Reason: "+reasonMessage+"<br>");
//	out.print(resultSet.getBoolean("isNext"));
//	out.print("<br><br>");
	
	if(resultSet.getBoolean("isOut")){%>
	<div class="maroon button">
	   <a class="text-link" href = "ReturnStudentByNumber.jsp?src=<%=request.getParameter("src")%>&StuID=<%=request.getParameter("StuID")%>&period=<%=resultSet.getInt("curPeriod")%>">Check In</a>
	</div>
	<%}
	else if( (resultSet.getBoolean("isNext") || !resultSet.getBoolean("inLine")  ) && canPrintPass ) {%>
		<div class="passTitle">Self Service Pass</div>
		<div class="passTitle">Available</div>
		<div class="green button">
<a class="text-link" href="CreateStudentPass.jsp?src=<%=request.getParameter("src")%>&StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>&period=<%=resultSet.getInt("curPeriod")%>"> Click for Self Service Pass</a>
</div>
	<% }
	else if( 
			
			resultSet.getBoolean("inLine")&&resultSet.getBoolean("canUseEmergency")
			
			
			) {	%>
		<div class="white button">
		<a class="text-link-black" href="getOutOfLine.jsp?src=<%=request.getParameter("src")%>&StuID=<%=resultSet.getInt("StudentID")%>&enrollID=<%=resultSet.getInt("enrollid")%>">Get Out Of Line</a>
		</div>  
		
		<div class="red button">
		<a class="text-link" href="CreateStudentPass.jsp?src=<%=request.getParameter("src")%>&StuID=<%=resultSet.getInt("StudentID")%>&PassType=ER&Enroll=<%=resultSet.getInt("enrollid")%>">Emergency Pass</a>
		</div><% 
	}
	else if( resultSet.getBoolean("inLine")&&!resultSet.getBoolean("canUseEmergency")) {	
		out.print("Get out of line Button <br>");
	}
	else {%>
		<div class="passTitle">Self Service Pass</div>
		<div class="passTitle">Not Available</div> 
		<div class="passReason"><br>(<%=reasonMessage %>)</div><br>
		<%
		if(canUseEmergency){%>
		
		<div class="red button">
<a class="text-link" href="CreateStudentPass.jsp?src=<%=request.getParameter("src")%>&StuID=<%=resultSet.getInt("StudentID")%>&PassType=ER&Enroll=<%=resultSet.getInt("enrollid")%>">Emergency Pass</a>
</div><br>
	<%}
		
		if(canGetInLine){%>
		
		  <div class="blue button">
            <a class="text-link" href="GetInLine.jsp?src=<%=request.getParameter("src")%>&StuID=<%=resultSet.getInt("StudentID")%>&PassType=RS&Enroll=<%=resultSet.getInt("enrollid")%>">Get In Line</a>
          </div><br>
			<br>
		<% }
		
	}
}

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
<td> </td></tr>
</table>
</body>
</html>