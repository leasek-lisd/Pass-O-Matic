<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="claim.jsp" id="carform">
<input type="hidden" name="studentID" value="<%=request.getParameter("studentID")%>">
<select id="cars" name="carlist" form="carform">
  <option value="<%=session.getAttribute("firstPeriodClassID")%>">1 | <%=session.getAttribute("firstPeriodClassTitle")%> | <%=session.getAttribute("firstPeriodClassRoom")%></option>
  <option value="<%=session.getAttribute("secondPeriodClassID")%>">2 | <%=session.getAttribute("secondPeriodClassTitle")%> | <%=session.getAttribute("secondPeriodClassRoom")%></option>
  <option value="<%=session.getAttribute("thirdPeriodClassID")%>">3 | <%=session.getAttribute("thirdPeriodClassTitle")%> | <%=session.getAttribute("thirdPeriodClassRoom")%></option>
  <option value="<%=session.getAttribute("fourthPeriodClassID")%>">4 | <%=session.getAttribute("fourthPeriodClassTitle")%> | <%=session.getAttribute("fourthPeriodClassRoom")%></option>
</select>
</form>
</body>
</html>