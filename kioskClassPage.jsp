<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<link rel="stylesheet" href="css/kiosk.css">
<%@ include file="includes/basicDBinfo.jsp" %> 

<%

int secsLeft = 0;
String usePeriod = (String)session.getAttribute("lastPeriod");

String sql = "call getKioskData ("+session.getAttribute("teacherID")+");";

//////////////////////////////////////////////////////////////////////////////////////////////////
//out.println(sql);
out.println("<!--" + sql+" -->");
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
 %>
 
 <body>



<div class="row"> 
<% 
String roomID = "";
if ( resultSet.next() ){
	
	secsLeft = resultSet.getInt("secondsLeft");
	%>
  
  
  <div id="overlay" class="purple" onclick="off()">
  <div id="bigText" class="white">Passing Period</div></div>

<% 
  if(resultSet.getInt("@curPeriod")!= 0){
  do { 

  roomID = resultSet.getString("room");%>

  <div class="column">
    <div class="card" data-href="kioskStudentPage.jsp?stuID=<%=resultSet.getString("studentID")%>"><%=resultSet.getString("displayName")%>
    </div>
     </div> 
     <%}  while( resultSet.next() );
     }%>
</div>
 </body>
 <script>
  document.addEventListener("DOMContentLoaded", () => {
	  const rows = document.querySelectorAll("div[data-href]");
	  console.log(rows);
	  rows.forEach(row => {
		  row.addEventListener("click", () => {
			  window.location.href = row.dataset.href;
		  })
	  })
  })
  
  </script>

</div>
<script>

function updateData(){
	const xmlhttp = new XMLHttpRequest();
	xmlhttp.onload = function() {
	  const myObj = JSON.parse(this.responseText);
	  console.log(myObj.color);
	  console.log(myObj.textColor);
	  console.log(myObj.displayText);
	$("#overlay").removeClass();
	$("#overlay").addClass(myObj.color);
	document.getElementById("bigText").innerHTML = myObj.displayText;

	$("#bigText").removeClass();
	//$
	$("#bigText").addClass(myObj.textColor);

	document.getElementById("bigText").innerHTML = myObj.displayText;


}
xmlhttp.open("GET", "roomData.jsp?room=<%=roomID%>");
xmlhttp.send();
}

updateData();
setInterval(function(){updateData();},2000);








</script>

  <%
}
else {%>
	  <div id="overlay" class="green" onclick="off()">
      <div id="bigText" class="white">No Class</div></div>
      <script>
      setTimeout(()=> {location.reload()},60000)
      </script>
<%}
	
  connection.close();
 }  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%>
<script>
function on() {
	  document.getElementById("overlay").style.display = "block";
	  console.log("on");
	}

	function off() {
		console.log("off");
	  document.getElementById("overlay").style.display = "none";
	  setTimeout(() => { on()},5000);
	}
	 on();

	 <% 
	out.print(secsLeft);
	 int refreshAt=3600*16*1000;
	 if(secsLeft > 0){
		 refreshAt =(secsLeft+1)*1000;}


	%>

	setTimeout(()=> {location.reload()},<%=refreshAt%>)

	</script>
