<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Seating Chart"; %>
<%@ include file="includes/navbar.jsp" %> 
<%@ include file="includes/basicDBinfo.jsp" %> 

<%
  String usePeriod = "0";
  if( request.getParameter("period") != null) {
	  usePeriod = request.getParameter("period");
	  session.setAttribute("lastPeriod", request.getParameter("period"));
  }

  else if( session.getAttribute("lastPeriod") != null) {
	  usePeriod = (String)session.getAttribute("lastPeriod");
  }


%>

<html>
<head>
  <title>Seating Chart</title>
</head>
<style>
	.demo {
		border:0px solid #C0C0C0;
		border-collapse:collapse;
		padding:15px;
	}
	.demo th {
		border:0px solid #C0C0C0;
		padding:5px;
		background:#F0F0F0;
	}
	tr, td {
		border:0px solid #C0C0C0;
		padding:5px;
                height:50px;
                width:200px;
                margin-bottom: 0; 
                text-align: 
                center;
                font-size:16px
                position: relative;
                position: relative;
	}			
       p {
               margin-top: 0; 
               margin-bottom: 0; 
               text-align: center;
               font-size:12px
         }
	.detail {font-size: 12px;
		}
	.exitRed {
			
		padding:5px;
                height:50px;
                width:200px;
                margin-bottom: 0; 
                text-align: 
                center;
                font-size:16px;
	 
	  background-color: red;
	  position: relative;
	}
	
	.exitGreen {
			
		padding:5px;
                height:50px;
                width:200px;
                margin-bottom: 0; 
                text-align: center;
                font-size:16px;
	  background-color: green;
	  position: relative;
	}
	
	.exitWhite {
			
		padding:5px;
                height:50px;
                width:200px;
                margin-bottom: 0; 
                text-align: 
                center;
                font-size:16px;
	  background-color: white;
	  position: relative;
	}

  a.exit {
  font-size:8px;
  
  }
  a.exitLink {
  color: white;
  }
    a.studentInfo {
  color: black;
  text-decoration:none;
  }
  a.studentInfo:hover {text-decoration:underline;}
  .mobileShow {display: none;}
    
.ribbon {
   height: 10px;
  width: 14px;
  font-size: 10px;
  padding: 2px;
  position: absolute;
  left: 0px;
  top: 0px;
  text-align: center;
  border-radius: 5px 0px 5px 0px;
  z-index: 1;
  
  background-color: maroon;
  color: white;
 
}

.topper {
position: relative;
top 10px;
z-index: 100;
}
 .borderBox {
 position: absolute;
   width:95%;
   height: 90%;
   border: solid maroon 2px;
     left: 0px;
  top: 0px;
  border-radius: 5px;
 }
.farRight {
  transform: rotate(90deg);
}

  /* Smartphone Portrait and Landscape */
@media print {
#choices { display:none; }
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
 //out.print(session.getAttribute("teacherID"));
////////   Database Connection Info ///////////////////////////////////////////////////////////////
 String sql = "call getSeatingChart("+request.getParameter("mode")+","+usePeriod+","+session.getAttribute("teacherID")+")";
 out.println("<!--" + sql+" -->");
//////////////////////////////////////////////////////////////////////////////////////////////////
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
int height = 50;
int width = 100;

 // @ include file="includes/classInfoMenu.jsp"  
%>

<br>

<span id="choices">
<%
  if(resultSet.next()){
	 %> <form>Select Period: 
	 <input type="hidden" name="mode" value="1">
	 <%=resultSet.getString("periodChoices")%>
	 <%
  if (mode == 3){%> 
   <center> <a href="SeatingChart.jsp?mode=1&period=<%=request.getParameter("period")%>"><img src="img\exit.jpg" alt="Exit Ticket Mode" width=auto height="25"> <span style="font-size: 30px"> Exit Ticket Mode Enabled </span> <img src="img\exit.jpg" alt="Exit Ticket Mode" width=auto height="25"></a></center>
  <%}
  else{%>
  <a href="SeatingChart.jsp?mode=3"><img src="img\exitsign.jpg" alt="Exit Ticket Mode" width=auto height="25">Enable Exit Ticket Mode</a>
  <%} %></form></span>
  <%
    if(resultSet.getBoolean("canAutoAssign")){ %>
    	<button onclick="myFunction()">Randomly Assign Students</button> 
    <script>
      function myFunction() {
        let text = "Warning: This action will randomly assign all students to different seats! \n There is NO undo! \n Press a button!\nEither OK or Cancel.";
        if (confirm(text) == true) {
        	window.location.href = "randomAssign.jsp?room=<%=resultSet.getString("roomID")%>&period=<%=resultSet.getString("periodNum")%>";
        } 
}
</script> 
    	
    	<%
    }
  %>
  <hr>
	 <table class="demo"> <%
    for (int y = 1; y <= 14; y++) {
      out.println ("<tr>");
      for (int x = 1; x <= 14; x++) {
  //  	out.println(x+","+y+" </td><td>");
      //   out.print("<td>");
         switch(resultSet.getInt("stateCode")){
     	 case 0:
     		out.print("<td>");
    		 //out.print(""+x+","+y);
    		 break;
    	 case 1: 
    	   if(resultSet.getInt("@outCount")>0){%>
    	   <td><br>
    	   <form action="assignSeat.jsp" id="freeStudentForm<%=resultSet.getString("seatNum")%>">
           
           <input type="hidden" name="roomID" value="<%=resultSet.getString("roomID")%>">
           <input type="hidden" name="seatID" value="<%=resultSet.getString("seatNum")%>">
           <input type="hidden" name = "mode" value="<%=request.getParameter("mode")%>">
           <input type="hidden" name="period" value="<%=resultSet.getString("periodNum")%>">
           <select class="topper" id="enrollID" name="enrollID" form="freeStudentForm<%=resultSet.getString("seatNum")%>" onchange="this.form.submit()">
           <option value="" selected>Assign Student</option>
    	    <%=resultSet.getString("dropDownCode")%>
    	    </select><span class="ribbon"><%=resultSet.getString("seatNum")%></span>
    	    <span class="borderBox"></span></form>
    	    <%}    	 
    		 
    	   else { %>
    	   <td>
    	     <img height = "100%" src="img/vacant.png">
    		   <span class="ribbon"><%=resultSet.getString("seatNum")%></span>
    		   <span class="borderBox"></span>
    	   <% }
   	    break;
   	 case 2: %>
   	   <td><img height="100%" src="<%=resultSet.getString("image")%>"><%
   		 break;
    	 
   	 default: %>
    	        <td class = "<%=resultSet.getString("exitState")%>">
    	        <a <%=resultSet.getString("exitLink")%> href="<%=url%>?seat=<%=resultSet.getString("seatNum")%>&period=<%=resultSet.getString("periodNum")%>&enrollID=<%=resultSet.getString("enrollID")%>&StuID=<%=resultSet.getString("studentID")%>&roomID=<%=resultSet.getString("roomID")%>"><strong>
    	                  <%=resultSet.getString("goesBy")%></strong>
    	                  <p><%=resultSet.getString("LastName")%></p>
    	                  <span class = "detail"> <%

    	                   

    	                 out.print(resultSet.getString("grade")+"/");
    	        %><%=resultSet.getString("IDnum")%></span> <span class="ribbon"><%=resultSet.getString("seatNum")%></span><span class="borderBox"></span>
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