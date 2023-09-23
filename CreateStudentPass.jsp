<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfoStudent.jsp" %> 
<%

String comment = request.getParameter("StuID");
String sql = "call NewHallPass8("+request.getParameter("StuID")+",'"+request.getParameter("PassType")+"',"+request.getParameter("Enroll")+")";

session.setAttribute("enrollID",request.getParameter("Enroll"));

String url = "";
//////////////////////////////////////////////////////////////////////////////////////////////////
out.println(sql);
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



// out.println(i);

connection.close();
if(request.getParameter("src")!=null && request.getParameter("src").equals("teacher")){
	url = "SeatingChart.jsp?mode=1";
}
else if(request.getParameter("src")!=null && request.getParameter("src").equals("kiosk")){
	url = "kioskClassPage.jsp?mode=1&period="+request.getParameter("period");}
else {
    url = "StudentDashboard.jsp?newPass=yes&stuID="+request.getParameter("StuID");
}
 
} catch (Exception e) {
// out.println("oops");
e.printStackTrace();
out.println(e.toString());
connection.close();
}

response.sendRedirect(url);

%>
<script>
function getPassStatus() {

  var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("passStatus").innerHTML = this.responseText;
      }
    };
    xmlhttp.open("GET","getPassStatus.jsp",true);
    xmlhttp.send();
}

getPassStatus();
setInterval(function(){getPassStatus()},500);
</script>

<body>
<div id="passStatus">passStatus</div> 
</body>