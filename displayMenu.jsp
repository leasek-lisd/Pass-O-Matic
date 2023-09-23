<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%String pageTitle = "Teacher Dashboard"; %>
<%@ include file="includes/navbar.jsp" %> 
<%@ include file="includes/basicDBinfo.jsp" %> 

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
  
  border-radius: 5px;
    position: absolute;
  top: 150px;
}

.other {
width: 150px;
}

.now {
width: 250px;

}

.first {
  left:10px;
  }
  
.second {
  left:10px;
  }
  
  .third {
  left:10px;
  }
  
  .fourth {
  left:10px;
  }
  

  
.bigDiv {
  width: 1500px;
  height: 800px;
  overflow: hidden;
  }

.currentPeriod {
font-size: 1.75em;
}

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

img {
  border-radius: 5px 5px 0 0;
}

.container {
  padding: 2px 16px;

}

.timeDateHeader {
  font-size: 2em;
  font-weight: heavy;
}

.classInfo {
  font-size: .5em;
  }
.classTitle {
  font-size: 1em;
  font-weight: bold;
  line-height: 2.5ex;
height: 5ex;
}

.otherList {
  font-size: .75em;
  }
ul { padding-left: 1.2em; }

.passBlob {
  position:relative;
  left:-50px;
  width: 500px;
  height: 200px;
  background-color: lightgrey;
  border-radius: 5px;
  padding: 5px;
}

/* Popup container - can be anything you want */
.passInfo {
  position: relative;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* The actual popup */
.passInfo .passPopup {
  visibility: hidden;
  position:relative;
  left:-50px;
  width: 500px;
  height: 200px;
  background-color: lightgrey;
  border-radius: 5px;
  padding: 5px;
  text-align: center;
  
  z-index: 1;
  

}

/* Popup arrow */
.passInfo .passPopup::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.passInfo .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;}
}


</style>
</head>
<body>
<%

String announcements = "";
int roomID = 0;
String sql = "select distinct r.id, r.room, c.periodNum  from rooms r join classes c on c.room=r.id where c.teacher="+session.getAttribute("teacherID")+" order by r.room;";
// out.println(sql+"<br>");
 %>
<%@ include file="includes/openRecordset.jsp" %>
 <%
	 
	int nextX;
	int foundCurrent = 0;
	 while(resultSet.next()){%>
		


<%
}// if result next


 connection.close();
} // try 

catch (Exception e) {
out.println("oops");
e.printStackTrace();
out.println(e.toString());
// connection.close();
}


if(session.getAttribute("lastRoom") != null){
%><br>
<a href="kioskClassPage.jsp" target="_blank">Kiosk Display (any period)</a><br>
<a href="largeStatus.jsp" target="_blank">Click for Large Status Display</a><br>
 <a href="miniWidget.jsp" target="_blank">Click for Mini Widget</a><br>
  

 
<%}%>
</body>
</html> 
