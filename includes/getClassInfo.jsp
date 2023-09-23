<%
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
 

 
 if(resultSet.next()){
	 
	 classID = resultSet.getString("classID");
	 periodNum = resultSet.getString("periodNum");
	 title = resultSet.getString("title");
	 teacherID = resultSet.getString("teacherID");
	 roomID = resultSet.getString("roomID");
	 classImage = resultSet.getString("classImage");
	 numEpasses = resultSet.getInt("numEpasses");
	 numClasses = resultSet.getInt("numClasses");
	
 } 
 
 connection.close();
 }  // try

catch (Exception e) 
{
out.println("oops");
e.printStackTrace();
out.println(e.toString());
}
 %>