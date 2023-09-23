<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Student History"; %>
<%@ include file="includes/navbar.jsp" %> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<%


String isAdmin = "0";
if( request.getParameter("admin") != null) {
	  isAdmin = request.getParameter("admin");
	
}
String sql = "select url, label from links where displayTo >= -1";


//////////////////////////////////////////////////////////////////////////////////////////////////
//out.println(sql);
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

 %>
 <style>
 table {
  border-collapse: collapse;
  border-spacing: 0;
 
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 15px;
  
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
 
 
 td img {
 height: 20px;}
 th img {
 height: 25px;}
 .center {
 text-align: center;
 }
 .seat{
 color: green;
 font-weight: bold;
 text-align: center;
 width: 25px;
 }

.name {
font-size:2em;
color:maroon;
padding:20px;
padding-bottom: 2px;}
#menuItems {
  position:relative;
  left: 20px;
  top: 10px;
}

.detail {
  font-size: .75em
  color: black;}
  
.linkList {
  padding:20px;
  padding-top:1px;
}
 </style> <%
  if(resultSet.next()){%>
	  <div class="name">Admin Links</div>
<div class="linkList">
	  <ul>
	  

 <% 
 
 do{  %>
    
     <li><a href="<%=resultSet.getString("url")%>"><%=resultSet.getString("label")%></a></li>

  <%}while(resultSet.next());// while 
  }// if
  connection.close();
 }  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%></ul></div>
