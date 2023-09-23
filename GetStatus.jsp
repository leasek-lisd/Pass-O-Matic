<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 

<%@ include file="includes/basicDBinfo.jsp" %> 
<%




String sql = "call PassHome () ";

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
 
if(resultSet.next()) {
  if(resultSet.getInt("StudentsOut") == 0 && resultSet.getInt("StartLimit")==0 && resultSet.getInt("EndLimit")==0 ){
    out.println("<center><img width=\"250px\" src=\"img\\rrGreen.png\"");}
  else {
    out.println("<center><img width=\"250px\" src=\"img\\Emergency.png\"");}
     
    
}
connection.close();

 }

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}


%>




?>


  


                                                                                                                                                                     