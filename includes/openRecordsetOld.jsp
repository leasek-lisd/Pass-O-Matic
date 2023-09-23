<%





		try 
		  (Connection connection = DBUtil.getDataSource("passomatic",userName,password).getConnection();
		   Statement st = connection.createStatement();) {
		
			
			ResultSet resultSet = st.executeQuery(sql);
			
			%>