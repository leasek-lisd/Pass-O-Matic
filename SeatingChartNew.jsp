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
	

  .mobileShow {display: none;}

  /* Smartphone Portrait and Landscape */
  @media only screen
    and (min-device-width : 180px)
    and (max-device-width : 360px){ 
      .mobileShow {display: inline;}
  }
  
  select{
  width: 100%;
  max-width: 150%
  font-size: .75em;
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
out.print(session.getAttribute("teacherID"));
////////   Database Connection Info ///////////////////////////////////////////////////////////////
 String sql = "call getSeatingChart("+request.getParameter("mode")+","+request.getParameter("period")+","+session.getAttribute("teacherID")+")";
//out.println(sql);
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

 // @ include file="includes/classInfoMenu.jsp"  
%>

<br><br>
<table class="demo">
<%
  if(resultSet.next()){
	 %> Select Period:<br><form>
	 <input type="hidden" name="mode" value="1">
	 <%=resultSet.getString("periodChoices")%></form> <%
    for (int y = 1; y <= 12; y++) {
      out.println ("<tr>");
      for (int x = 1; x <= 12; x++) {
  //  	out.println(x+","+y+" </td><td>");
         out.print("<td>");
         switch(resultSet.getInt("stateCode")){
     	 case 0:
    		 //out.print(""+x+","+y);
    		 break;
    	 case 1: %>
    	   <form action="assignSeat.jsp" id="freeStudentForm<%=resultSet.getString("seatNum")%>">
           <input type="hidden" name="roomID" value="<%=request.getParameter("roomID")%>">
           <input type="hidden" name="seatID" value="<%=resultSet.getString("seatNum")%>">
           <input type="hidden" name = "mode" value="<%=request.getParameter("mode")%>">
           <input type="hidden" name="period" value="<%=resultSet.getString("periodNum")%>">
           <select id="enrollID" name="enrollID" form="freeStudentForm<%=resultSet.getString("seatNum")%>" onchange="this.form.submit()">
           <option value="" disabled selected>Assign Student</option>
    	    <%=resultSet.getString("dropDownCode")%>
    	    </select></form>
    	    <%
             break;
    	 default: %>
    	        <a href="<%=url%>?period=<%=resultSet.getString("periodNum")%>&StuID=<%=resultSet.getString("studentID")%>&roomID=<%=request.getParameter("roomID")%>"><strong>
    	                  <%=resultSet.getString("goesBy")%></strong>
    	                  <p><%=resultSet.getString("LastName")%></p>
    	                  <span class = "detail"> <%

    	                   

    	                 out.print(resultSet.getString("grade")+"/");
    	        %><%=resultSet.getString("IDnum")%></span> Seat:<%=resultSet.getString("seatNum")%>
    <%	 } resultSet.next();
%></td>
    	
    	
    <%  }%> </tr>
  <%}  
    
  } else {out.print("Connection Error");}


out.println("</table>");






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