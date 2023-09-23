<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ include file="includes/navbar.jsp" %> 
<%@ include file="includes/basicDBinfo.jsp" %> 
<html>
<head>
  <title>Seating Chart</title>
</head>
<style>
	.demo {
		border:1px solid #C0C0C0;
		border-collapse:collapse;
		padding:5px;
	}
	.demo th {
		border:1px solid #C0C0C0;
		padding:5px;
		background:#F0F0F0;
	}
	.demo td {
		border:1px solid #C0C0C0;
		padding:5px;
                height:50px;
                width:200px;
                margin-bottom: 0; 
                text-align: 
                center;
                font-size:16px
	}
       p {
               margin-top: 0; 
               margin-bottom: 0; 
               text-align: center;
               font-size:12px
         }
	.detail {font-size: 12px;
		}
	
a:link {   color:#000000;text-decoration: none; }
a:visited {   color:#000000;text-decoration: none; }
a:hover {   text-decoration: underline; }
  .mobileShow {display: none;}

  /* Smartphone Portrait and Landscape */
  @media only screen
    and (min-device-width : 180px)
    and (max-device-width : 360px){ 
      .mobileShow {display: inline;}
  }
</style>
<body>
<%

int mode = 0;
String sMode = "";
String url = "";

if(request.getParameter("mode") != null){
  if ( (request.getParameter("mode")).equals("3"))
    {
      url = "exit.jsp";
      mode = 3;}
    else{
      url = "studentMenu.jsp";
      mode = Integer.parseInt(request.getParameter("mode"));}
  }
  else {
    url = "studentMenu.php";
    mode = 1;}

userId = "klease";
password = "123456";
////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sql = "call seatingchart16("+request.getParameter("mode")+",129,"+request.getParameter("period")+")";
out.println(sql);
//////////////////////////////////////////////////////////////////////////////////////////////////

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
	out.print("try1");
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

%>


<% // @ include file="includes/classInfoMenu.jsp" %> 
<br><br>
<%
int nextSeat = 3;
  if (mode == 3){%> 
   <center> <a href="SeatingChart.jsp?mode=1&period=<%=request.getParameter("period")%>"><img src="img\exit.jpg" alt="Exit Ticket Mode" width=auto height="25"> <span style="font-size: 30px"> Exit Ticket Mode Enabled </span> <img src="img\exit.jpg" alt="Exit Ticket Mode" width=auto height="25"></a></center>
  <%}%>
  <h1>Select location for seat #<%=nextSeat%></h1>
<table class="demo">

<%

String[][] seatingChart = new String [13][13];
 while (resultSet.next()) { 
	// out.println(resultSet.getString("GoesBy")+"<br>");
	 
 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")] = resultSet.getString("Seat");
    	
 }

for(int i=1;i<=12;i++){
	out.println("<tr>");
	for(int j=1; j<=12; j++){%>
	<td><a href="setSeat.jsp?x=<%=j%>%>&y=<%=i%>&seatNum=<%=1%>">Pick Seat</a></td>
	<%	
//		out.print(seatingChart[j][i]);
		
	}
	out.println("</tr>");
}
connection.close();
} catch (Exception e) {

e.printStackTrace();
out.println("<!-- "+e.toString()+" -->");
out.println("try2");
// connection.close();
}



%>
</body>
</html>