<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%String pageTitle = "Teacher Pass Menu"; %>
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
String sql = "call getPassMenu ();";
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
<tr></tr>
  




<%


if(resultSet.next()){

int rows = resultSet.getInt("Rowz");
int cols = resultSet.getInt("Cols");

    for (int x = 1; x <= rows; x++) {
      out.println ("<tr><td>");
      for (int y = 1; y < cols; y++) {
        out.println("</td><td>");
        out.println("<!--"+x+","+y+" "+resultSet.getInt("RowNum")+"/"+resultSet.getInt("ColNum")+"-->");
        if(resultSet.getInt("RowNum") == x && resultSet.getInt("ColNum") == y   ){%>  
          <a href="CreateStudentPass.jsp?src=teacher&StuID=<%=request.getParameter("StuID")%>&PassType=<%=resultSet.getString("code")%>&Enroll=<%=request.getParameter("enrollID")%>">
          <img src="<%=resultSet.getString("Icon")%>"  width=auto height="100"><br>
          <%=resultSet.getString("label")%></a></td>
<%         resultSet.next();
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