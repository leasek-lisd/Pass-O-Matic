<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Room Layout"; %>
<%@ include file="includes/navbar.jsp" %>  
<%@ include file="includes/basicDBinfo.jsp" %> 

<%
  String useRoom = "0";
  if( request.getParameter("room") != null) {
	  useRoom = request.getParameter("room");
	  session.setAttribute("lastRoom", request.getParameter("room"));
  }

  else if( session.getAttribute("lastRoom") != null) {
	  useRoom = (String)session.getAttribute("lastRoom");
  }
// out.print(useRoom);
String addURL = "setSeat.jsp?objectType=0&";
String addWord = "Seat";
String objectType = "0";
if(request.getParameter("roomObjectType") != null){
	objectType = request.getParameter("roomObjectType");
	addURL = "setSeat.jsp?objectType="+request.getParameter("roomObjectType")+"&";

}

%>

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
                width:150px;
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
    and (max-device-width : 200px){ 
      .mobileShow {display: inline;}
  }
  .seat {
  background-color: lightgreen;
  }
  .tip {
    font-size: .5em;
    font-weight: bold;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js">
</script>
<body>
<%

int mode = 0;
String sMode = "";
String url = "";


 
userId = "klease";
password = "123456";
////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sql = "call getBlankChart("+useRoom+","+session.getAttribute("teacherID")+")";
out.println("<!--" + sql+" -->");
//////////////////////////////////////////////////////////////////////////////////////////////////
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
int height = 50;
int width = 100;

%>


<% // @ include file="includes/classInfoMenu.jsp" %> 

<%
int nextSeat = 3;

  String[][][] seatingChart = new String [15][15][2];
if (resultSet.next()){
  
  nextSeat = resultSet.getInt("nextSeat");
  %><br>
  <form>Select Classroom 
  <%=resultSet.getString("roomChoices")%>
 <%if(!useRoom.equals("0"))
 {String output="";%>
  </form>
  <form>

  
  Add a:
  <input type="radio" id="0" onchange="this.form.submit();" name="roomObjectType" value="0" <% 
    if(objectType.equals("0")){out.print("checked");}%>>Student Seat
  <input type="radio" id="1" onchange="this.form.submit();" name="roomObjectType" value="1"<% 
    if(objectType.equals("1")){out.print("checked");}%>>Teacher Desk
  <input type="radio" id="2" onchange="this.form.submit();" name="roomObjectType" value="2"<% 
    if(objectType.equals("2")){out.print("checked");}%>>Door
  <input type="radio" id="3" onchange="this.form.submit();" name="roomObjectType" value="3"<% 
    if(objectType.equals("3")){out.print("checked");}%>>Screen
</form>
<table class="demo">
<tr><td colspan="14">
  <h1>Select location for <%
    switch (objectType){
    case "0":
    	out.print("seat #"+nextSeat);
    	break;
    case "1":
    	out.print("Teacher Desk");
    	break;
    case "2": 
    	out.print("Door");
    	break;
    case "3":
    	out.print("Screen");
    	break;
    }%></h1></td></tr>


<%
   do { 
	 nextSeat = resultSet.getInt("nextSeat");
	// out.println(resultSet.getString("GoesBy")+"<br>");
	 if( !resultSet.getString("objectType").equals("0")){
		 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")][0] = "-1";
		 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")][1]= (resultSet.getString("image"));
	 }else if(resultSet.getInt("seatNum") != 0){
		 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")][0] = resultSet.getString("seatNum");
		 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")][1] = "";
	 }	 
	 else {
		 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")][0] = "0";
		 seatingChart[resultSet.getInt("x")][resultSet.getInt("y")][1] = "";
	 }
 }while (resultSet.next());
/*for (int j=0; j<=14; j++){
	for (int i=0; i<=14; i++){	
	out.println("("+j+","+i+"): "+ seatingChart[j][i][0]+" "+ seatingChart[j][i][1]);
	
}} */ 
for(int i=1;i<=14;i++){
	out.println("<tr>");
	for(int j=1; j<=14; j++){
	if(	seatingChart[j][i][0].equals("0")){%>
	  <td class = "empty" data-href="setSeat.jsp?objectType=<%=objectType%>&action=1&room=<%=useRoom%>&x=<%=j%>&y=<%=i%>&seatNum=<%=nextSeat%>"><span class="tip">Click To Select</span><%}
	
	
	else if(	seatingChart[j][i][0].equals("-1")) 
	{%><td class = "seat"  data-href="setSeat.jsp?action=0&room=<%=request.getParameter("room")%>&objectType=<%=objectType%>&x=<%=j%>&y=<%=i%>&seatNum=<%=seatingChart[j][i][0]%>">
	<img height = "100%" src="<%=seatingChart[j][i][1]%>"><br>
	<span class="tip">Click to Delete</span>
	<%}
	
	
	else
	  {%><td class = "seat"  data-href="setSeat.jsp?action=0&room=<%=request.getParameter("room")%>&objectType=<%=objectType%>&x=<%=j%>&y=<%=i%>&seatNum=<%=seatingChart[j][i][0]%>">
		Seat: <%=seatingChart[j][i][0]%><br>
		<span class="tip">Click to Delete</span>
		<%
		
	}
	
	%></td>
	<%	
	//	out.print(seatingChart[j][i]);
		
	}
	out.println("</tr>");
} 
}else {out.println("Please Select Room");}
connection.close();
}}
 catch (Exception e) {

e.printStackTrace();
out.println("<!-- "+e.toString()+" -->");
out.println("try2");
// connection.close();
}



%>

<script>
  document.addEventListener("DOMContentLoaded", () => {
	  const rows = document.querySelectorAll("td[data-href]");
	  console.log(rows);
	  rows.forEach(row => {
		  row.addEventListener("click", () => {
			  window.location.href = row.dataset.href;
		  })
	  })
  })
  
  </script>
  
</body>
</html>