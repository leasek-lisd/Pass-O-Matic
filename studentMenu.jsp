<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Student Menu"; %>
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
                width:100px;
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





////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sql = "call getnotemenu2 ("+request.getParameter("StuID")+")";
// out.println(sql+"<br>");
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

%>


<table class="demo" >
	<tbody>
<tr>
  
<td> <a href="insertNote.jsp?period=2&StuID=<%=request.getParameter("StuID")%>&NoteID=11"><img height="100" src="img/Notes/exit.png"><br>Exit Ticket</a></td>

<td><a href="passMenu.jsp?StuID=<%=request.getParameter("StuID")%>&enrollID=<%=request.getParameter("enrollID")%>"><img src="img\Notes\receipt_printer.png" alt="Pass Menu" width="auto" height="100">Issue Pass</a> </td>
<td><a href="StudentDashboard.jsp?stuID=<%=request.getParameter("StuID")%>&roomID=<%=request.getParameter("roomID")%>" target = "_blank"><img src="img\Notes\receipt_printer.png" alt="Student Pass View" width="auto" height="100"><br>Student Dashboard</a> </td>


<td><a href="PassHistory.jsp?enrollID=<%=request.getParameter("enrollID")%>" ><img src="img\Notes\passhistory.jpg" alt="Pass History" width="auto" height="100"><br>Pass History</a> </td>

<td><a href="CommentHistory.jsp?StuID=<%=request.getParameter("StuID")%>"><img src="img\Notes\passhistory.jpg" alt="Comment History" width="auto" height="100"><br>Comment History</a> </td>



<td><a href="assignSeat.jsp?enrollID=<%=request.getParameter("enrollID")%>&seatID=0"><img src="img\Notes\profile.jpg" alt="Student Profile" width="auto" height="100"><br>Unassign Seat</a> </td></tr>





<%


if(resultSet.next()){

int rows = resultSet.getInt("Rowz");
int cols = resultSet.getInt("Cols");

    for (int x = 0; x <= rows; x++) {
      out.println ("<tr>");
      for (int y = 0; y < cols; y++) {
    	  out.println ("<td>");
        out.println("<!--"+x+","+y+"-->");
        if(resultSet.getInt("RowNum") == x && resultSet.getInt("ColNum") == y   ){%>  
          <a href="insertNote.jsp?enrollID=<%=request.getParameter("enrollID")%>&NoteID=<%=resultSet.getString("noteid")%>">
          <img src="img\Notes\<%=resultSet.getString("Icon")%>"  width=auto height="100"><br>
          <%=resultSet.getString("label")%></a></td>
 <%          out.println("</td>");
         resultSet.next();
         }  // if 
       
      }  // for x 
      out.println("</tr>");
    } // for y

}// if result next


 connection.close();
} // try 

catch (Exception e) {
out.println("oops");
e.printStackTrace();
connection.close();
}



%>
</body>
</html>