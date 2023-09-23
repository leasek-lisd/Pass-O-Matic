<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<%@ page import = "java.io.*,java.util.*, javax.servlet.*,java.text.*" %>
<%

String driverNameCI = "com.mysql.jdbc.Driver";

////////////////////////////////////////////////////////////////////////////////////////////////////

////////   Database Connection Info ///////////////////////////////////////////////////////////////

 String connectionUrlCI = "jdbc:mysql://localhost:3306/";
 String dbNameCI = "passomatic"; 
 String userIdCI = "klease"; 
 String passwordCI = "123456";

////////////////////////////////////////////////////////////////////////////////////////////////////

////////   Database Connection Info ///////////////////////////////////////////////////////////////
String sqlCI = "call GetClassInfo2("+request.getParameter("period")+",1)";

// out.println(sqlCI);
//////////////////////////////////////////////////////////////////////////////////////////////////

try {
Class.forName(driverNameCI);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connectionCI = null;
Statement statementCI = null;
ResultSet resultSetCI = null;

try {
connectionCI = DriverManager.getConnection(
connectionUrlCI + dbNameCI, userIdCI, passwordCI);
statementCI = connectionCI.createStatement();


resultSetCI = statementCI.executeQuery(sqlCI);
Date dNow = new Date();
SimpleDateFormat ft = 
         new SimpleDateFormat ("EEEEEEEEEEE MMMMMMMMMMMMMM d, y");

if(resultSetCI.next()){%>

    <h2><%=resultSetCI.getString("@TeacherName")%><br>
    <%=resultSetCI.getString("@Title")%><br>
    <%=resultSetCI.getString("@RoomLabel")%> - Period: <%=request.getParameter("period")%><br>
    <%=ft.format(dNow)%>
    <br></h2>
    Change Period | <%

    do{ %>
      <a href="SeatingChart.jsp?mode=1&period=<%=resultSetCI.getString("PeriodNum")%>"><%=resultSetCI.getString("PeriodNum")%></a> |<%

    } while(resultSetCI.next());

    connectionCI.close();
    } // end if
} // end try

catch (Exception e) {
out.println("oops");
e.printStackTrace();
connection.close();
}


if(mode==1){
%> <a href="SeatingChart.jsp?mode=3&period=<%=request.getParameter("period")%>"><img src="img/exitsign.jpg" height = "20px">Exit Ticket Mode</a> <%}%>