<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%


if(request.getParameter("room")!=null){

String sql = "call getKioskDisplayJSON("+request.getParameter("room")+")";

//////////////////////////////////////////////////////////////////////////////////////////////////
%>
<%@ include file="includes/openRecordset.jsp" %>
 <%
if(resultSet.next()) {
  out.print(resultSet.getString("json"));
    
}
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}

}
else {out.print("{\"color\":\"red\",\"textColor\":\"White\",\"displayText\":\"Please Login\"");}
%>







  


                                                                                                                                                                     